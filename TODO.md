# TODO

- Look into making the root path used for `immediateCondition` RDS files
  (`immediateConditionsPath()`, which defaults to
  `file.path(tempdir(), ".future", "immediateConditions")`)
  configurable, e.g. via an R option, rather than hardcoded to
  [`tempdir()`](https://rdrr.io/r/base/tempfile.html) everywhere it’s
  called from `MulticoreFutureBackend`
  ([`readImmediateConditions()`](https://future.futureverse.org/reference/readImmediateConditions.md)
  /
  [`saveImmediateCondition()`](https://future.futureverse.org/reference/readImmediateConditions.md)).

- IDEA: Let an object/function carry its own forwarding hints via an
  attribute,
  e.g. `attr(fcn, "future_meta") <- list(packages = "somepkg", globals = c("extra_obj"), options = c("digits", "somepkg.verbose"))`.
  **Note (2026-10-12): this should probably be reconciled with, rather
  than compete with, the already-proposed `resources` mechanism** - see
  <https://www.futureverse.org/roadmap/resources.html> and
  <https://www.jottr.org/2026/08/11/roadmap-resources-memory/>.
  `resources<-()` already sets `attr(fcn, "resources")` on a function
  (even third-party code,
  e.g. `resources(cv.glmnet) <- function(x, ...) memory(4 * object.size(x))`),
  consulted automatically by `resources()`/`futurize()` at dispatch
  time - the identical architecture this `future_meta` idea
  independently arrived at, so far scoped to compute resources (memory
  now; walltime, scratch space, GPU cores/memory later) rather than
  packages/globals/options. Rather than a second, parallel attribute,
  extending `resources()` itself to also cover “what this function/call
  needs forwarded” is probably the better path - same
  `resources(fcn) <- function(...) ...` pattern, same consultation
  point, just a different payload than memory/walltime/GPU. Filed as a
  generalized idea (declaring soft/ indirect dependencies instead of
  inferring them via static analysis) at
  [future-ideas#1117](https://github.com/HenrikBengtsson/future-ideas/issues/1117),
  with this reconciliation noted as a follow-up comment there.

  - Package-level declarations (not just function-level): attach
    `resources` to the package’s **`.onLoad()`** function as the
    default, easiest-to-understand convention - no new API, just
    `resources<-()` applied to the one function every package can rely
    on as a stable, well-known, namespace-resident anchor
    (`asNamespace(pkg)$.onLoad`; a package without one can add a trivial
    `.onLoad()` purely to carry the attribute). This means inspecting it
    requires the package’s namespace to be loaded (harmlessly, since
    attributes don’t affect how a function is called) - fine in the
    common case where the package is already loaded for real reasons, a
    minor acceptable cost in the rarer fully-transitive case (inspecting
    a Suggests-of-a-Suggests that nothing has loaded yet). Ship *this*
    first, since it needs no new file format or build tooling. Two
    load-free optimizations can be layered on top later, for packages
    that specifically want to avoid the load: a `Config/<tool>/<field>`
    DESCRIPTION field (e.g. `Config/future/options: progressr.enable`,
    following the existing `Config/testthat/edition`-style convention)
    for simple name-only declarations; and, for declarations that need
    actual code (e.g. a memory-estimator closure), a sidecar file
    (`inst/resources.rds`, or an install-time-generated
    `Meta/resources.rds` alongside the `Meta/*.rds` files every
    installed package already has) storing deparsed source text, ideally
    auto-compiled from the same `.onLoad()`-attribute source at
    build/install time (the roxygen2-comments-to-`.Rd`-files pattern)
    rather than hand- maintained. See the follow-up comments on \#1117
    for the fuller writeup. Static-code inspection
    ([`globals::globalsOf()`](https://globals.futureverse.org/reference/globalsOf.html)
    et al., driving
    [`getGlobalsAndPackages()`](https://future.futureverse.org/reference/getGlobalsAndPackages.md))
    can miss globals/packages that are only referenced indirectly
    (e.g. via [`do.call()`](https://rdrr.io/r/base/do.call.html), NSE,
    or other non-lexical lookups) - `future_meta` would let the
    object/function author explicitly declare what must always be
    forwarded, regardless of what static analysis finds (or misses). The
    same attribute could also name R `options` that should travel with
    the object/function to the worker, which would double as one
    concrete, scoped answer to the general “pass
    [`options()`](https://rdrr.io/r/base/options.html) down to futures”
    problem in \#134/#480 (see below) - scoped to “this specific
    object/function needs these specific options”, rather than solving
    automatic/global options propagation for every future.

  - Relates to:
    [\#134](https://github.com/futureverse/future/issues/134) (“R
    options: [`options()`](https://rdrr.io/r/base/options.html) are not
    passed down to futures - should they?”) and
    [\#480](https://github.com/futureverse/future/issues/480) (“future()
    arguments for passing R options and environment variables”), which
    are about forwarding options at the
    [`future()`](https://future.futureverse.org/reference/future.md)/[`plan()`](https://future.futureverse.org/reference/plan.md)
    call site, not attached to a specific object.

  - Also somewhat adjacent to the `declare(prologue(...))`/
    `declare(epilogue(...))` idea in
    [future-ideas#1035](https://github.com/HenrikBengtsson/future-ideas/issues/1035),
    which annotates *expressions* passed to
    `futurize()`/[`future()`](https://future.futureverse.org/reference/future.md)
    rather than objects/functions themselves.

  - Open questions: where would `future_meta` be read from - only
    top-level globals, or also objects found while walking into
    packages/environments during
    [`getGlobalsAndPackages()`](https://future.futureverse.org/reference/getGlobalsAndPackages.md)?
    Would `options` listed this way need “value to forward” vs. just
    “name to forward” (cf. `future(..., options = c("foo", BAR = 42L))`
    in \#480)? How would conflicting `future_meta` from multiple objects
    in the same future be reconciled? Does this need to be an attribute
    specifically (surviving serialization, but easy to lose via
    copying/subsetting), or would a registry/S3-method-based declaration
    (e.g. `future_meta.my_class <- function(x) ...`) be more robust?

  - Concrete worked example, and the one that actually makes this useful
    rather than redundant: attach the metadata to **progressr**’s
    `progressor()` *generator function itself* (the function exported as
    [`progressr::progressor`](https://progressr.futureverse.org/reference/progressor.html)),
    not to the closure it returns. Whether progress reporting does
    anything depends on the `progressr.enable` option, which is *not*
    propagated to `multisession`/`cluster` workers today (that’s exactly
    the \#134 gap) - so a *fresh* `progressor()` call made inside
    worker-executed code (e.g. deep in a package’s call stack, or code
    injected by `progressify()`) resolves `enable` against the worker’s
    own, independent option default and doesn’t know the master already
    disabled progress, paying full overhead for updates nobody will see.

    The fix only works if the metadata sits on the generator, because
    only the generator is referenced by the future expression *before*
    the call happens - by the time a returned progressor object `p`
    exists, its no-op-ness is already permanently baked in, so attaching
    metadata there is too late to change anything. Attaching it to the
    generator also sidesteps the serialization question entirely:
    [`progressr::progressor`](https://progressr.futureverse.org/reference/progressor.html)
    is an exported, unchanged function living inside the `progressr`
    package namespace, so a `future_meta` attribute set on it once (as
    part of the installed package) is automatically present,
    identically, on every worker that loads `progressr` too - nothing
    about the attribute itself needs to be shipped across the wire. What
    *does* need forwarding is the current *value* of `progressr.enable`,
    read from the master session, and the trigger for forwarding it is
    exactly `future`’s existing globals/packages analysis noticing that
    the future expression references `progressor` (already needed today,
    to know the worker must have the `progressr` package attached). At
    that point `future` would snapshot `getOption("progressr.enable")`
    on the master and arrange for it to be set on the worker (e.g. via
    an auto-generated `options(progressr.enable = <value>)` prologue)
    before the expression runs - so that when `progressor()` executes
    fresh inside the worker, it resolves `enable` to the master’s actual
    value and correctly returns `void_progressor` there too.

  - Limitation: nested futures. The detection-and-forward trigger only
    sees whatever a *single* static analysis pass can find at the moment
    a given
    [`future()`](https://future.futureverse.org/reference/future.md)
    call is made. If an inner future’s body is written directly inside
    an outer future’s literal source (even several
    [`future()`](https://future.futureverse.org/reference/future.md)
    calls deep), the outer-level static walk of the full parse tree
    still finds a nested `progressor` reference fine - static analysis
    doesn’t stop at sub-call boundaries. But if the inner future is only
    created *dynamically*, at runtime, deep inside the outer future’s
    own execution (a data-dependent branch, a generic recursive
    dispatcher, an expression only constructed via
    [`do.call()`](https://rdrr.io/r/base/do.call.html)/NSE on the fly),
    there is nothing for *any* ancestor’s static analysis to find in
    advance, because the code that would contain the `progressor()`
    reference doesn’t exist yet when the check runs. Worse, even if
    detection is implemented generically (so every
    [`future()`](https://future.futureverse.org/reference/future.md)
    call, including ones made from inside a worker, re-runs its own
    check against its own current option value), the chain only
    propagates correctly if every ancestor level’s detection *already
    fired*: if the outermost (master) expression has no textual trace
    that triggers forwarding, worker-1 never receives the forwarded
    value, so even though worker-1’s *own* subsequent nested
    [`future()`](https://future.futureverse.org/reference/future.md)
    call will correctly detect `progressor` in whatever it dispatches
    next (that expression is concrete by the time it’s created, so
    detection there is trivial), it has only its own unforwarded,
    default `progressr.enable` to propagate onward - the chain breaks at
    the first invisible link, not just at the end.

  - Refinement: move the trigger from “is this *function* referenced in
    *this expression*” to “is this *package* currently loaded in *my
    session*” - a session-level fact, knowable the instant any
    [`future()`](https://future.futureverse.org/reference/future.md)
    call fires, at any nesting level, without needing to see what code
    will run. In practice a package is usually loaded once, early
    (e.g. [`library(progressr)`](https://progressr.futureverse.org) in
    the master, or
    [`requireNamespace("progressr")`](https://progressr.futureverse.org)/[`progressr::progressor()`](https://progressr.futureverse.org/reference/progressor.html)
    deep in worker code), so this is far more likely to already be true
    at every relevant nesting level than “does this specific
    sub-expression textually mention `progressor`.” This does *not* come
    for free from today’s existing package-to-worker forwarding, though:
    per `R/protected_api-globals.R` (around where `packagesOf(globals)`
    is computed and then filtered by
    `attachedPackages()`/[`search()`](https://rdrr.io/r/base/search.html)),
    which packages get attached to a worker is *already* derived from
    the same static per-expression globals detection, intersected with
    currently-attached packages used only as a filter - it is not a
    blanket “whatever’s loaded in my session also gets attached on the
    worker” rule. For this idea to actually deliver the improvement, the
    *new* options-forwarding check would need to be independent of that
    pipeline: at every
    [`future()`](https://future.futureverse.org/reference/future.md)
    call, separately ask “which packages are currently loaded, and does
    any of them declare a package-level `future_meta` object naming
    options to forward?” rather than reusing/being limited by
    `packagesOf(globals)`. Also, that check should be against
    [`loadedNamespaces()`](https://rdrr.io/r/base/ns-load.html), not
    [`search()`](https://rdrr.io/r/base/search.html) (which is what the
    existing `attachedPackages()` helper checks): idiomatic
    package-internal code calling another package’s export typically
    does so via `pkg::fcn()`
    (e.g. [`progressr::progressor()`](https://progressr.futureverse.org/reference/progressor.html),
    which is what `progressify()`-generated code would plausibly do)
    without ever attaching that package to the search path, so a
    [`search()`](https://rdrr.io/r/base/search.html)-based check would
    miss it entirely. Even with this refinement, the very first hop
    (master to its immediate worker) still needs *something* to
    establish that the package is relevant there at all; in the fully
    pathological case where the master’s own code has zero textual or
    loaded-namespace trace of `progressr` (unlikely in practice, since
    the master almost always already calls
    `with_progress()`/`handlers()` itself), even a
    [`loadedNamespaces()`](https://rdrr.io/r/base/ns-load.html)-based
    check has nothing to trigger on at that outermost hop - but that is
    a much narrower edge case than the per-function version had, and
    every hop after the first is fixed.
