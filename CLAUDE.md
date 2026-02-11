# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working
with code in this repository.

## Package Overview

The `future` package provides a unified Future API for sequential and
parallel processing of R expressions. The simplest usage is
`x %<-% { expression }` with `plan(multisession)`. It implements
sequential, multicore, multisession, and cluster backends. Extensions
(future.callr, future.mirai, future.batchtools) add additional backends.

## Build & Check Commands

``` bash
# Build package tarball
R CMD build .

# Build without vignettes (faster)
R CMD build --no-build-vignettes --no-manual .

# Install from tarball
R CMD INSTALL future_*.tar.gz

# Full CRAN check
R CMD check --as-cran future_*.tar.gz

# Regenerate roxygen2 docs (NAMESPACE + man/*.Rd)
Rscript -e "roxygen2::roxygenize()"

# Spell check
make spelling
```

## Testing

Tests use a custom `testme` framework. Real test implementations live in
`inst/testme/test-*.R`. The files in `tests/test-*.R` are auto-generated
thin wrappers (do not edit them directly); regenerate with
`Rscript inst/testme/deploy.R`.

``` bash
# Run a single test by name (e.g. "future", "plan", "globals")
Rscript inst/testme/run.R --name=future

# Run a single test by file path
Rscript inst/testme/run.R inst/testme/test-future.R

# Run with NOT_CRAN=true (enables additional tests)
Rscript inst/testme/run.R --name=future --not-cran

# Run with code coverage report
Rscript inst/testme/run.R inst/testme/test-future.R --coverage=report

# Run future.tests backend validation suite
Rscript -e "future.tests::check" --args --test-plan=sequential
Rscript -e "future.tests::check" --args --test-plan=multisession

# Makefile shortcuts for backend test suites
make future.tests_built_in              # sequential, multicore, multisession, cluster
make future.tests_future.callr          # future.callr backend
make future.tests_future.mirai          # future.mirai backend
make future.tests_future.batchtools     # future.batchtools backend
```

## Source Code Architecture

Source files in `R/` follow a strict naming convention reflecting the
API layer. The Collate field in DESCRIPTION enforces load order.

### API Layers (in load order)

- **`000.*` / `009.*` / `010.*`** — Bootstrap: imports, re-exports,
  deprecation helpers, tweakable infrastructure
- **`backend_api-*`** — Backend class hierarchy and evaluation engine:
  - `FutureBackend` → `MultiprocessFutureBackend` →
    `ClusterFutureBackend`, `MulticoreFutureBackend`,
    `MultisessionFutureBackend`
  - `Future` class (base), `UniprocessFuture`, `ConstantFuture`
  - `FutureRegistry` — tracks active futures per backend
  - `evalFuture` — core evaluation engine that launches and manages
    future execution
- **`core_api-*`** — User-facing functions:
  [`future()`](https://future.futureverse.org/reference/future.md),
  [`value()`](https://future.futureverse.org/reference/value.md),
  [`resolved()`](https://future.futureverse.org/reference/resolved.md),
  [`cancel()`](https://future.futureverse.org/reference/cancel.md),
  [`reset()`](https://future.futureverse.org/reference/reset.md)
- **`delayed_api-*`** — Implicit futures:
  [`futureAssign()`](https://future.futureverse.org/reference/futureAssign.md)
  (powers `%<-%`),
  [`futureOf()`](https://future.futureverse.org/reference/futureOf.md)
- **`infix_api-*`** — Operators: `%<-%`, `%->%`, `%globals%`,
  `%packages%`, `%seed%`, `%stdout%`, `%conditions%`, `%lazy%`,
  `%label%`, `%plan%`, `%tweak%`
- **`protected_api-*`** — Internal infrastructure: `FutureCondition`,
  `FutureGlobals`, `FutureResult`, globals identification, condition
  signaling, journal tracking, promise resolution
- **`utils_api-*`** — Public utilities:
  [`plan()`](https://future.futureverse.org/reference/plan.md),
  [`tweak()`](https://future.futureverse.org/reference/plan.md),
  [`nbrOfWorkers()`](https://future.futureverse.org/reference/nbrOfWorkers.md),
  [`futureCall()`](https://future.futureverse.org/reference/future.md),
  [`makeClusterFuture()`](https://future.futureverse.org/reference/makeClusterFuture.md),
  [`futureSessionInfo()`](https://future.futureverse.org/reference/futureSessionInfo.md),
  [`backtrace()`](https://future.futureverse.org/reference/backtrace.md)
- **`utils-*`** — Internal utilities (RNG, options, object size,
  marshalling, debug, etc.)
- **`zzz.R`** — `.onLoad()` / `.onAttach()` lifecycle hooks

### Key Design Patterns

- **S3 class system** throughout — backends, futures, conditions, and
  results are all S3 classes with method dispatch
- **Backend abstraction** — all backends implement the same interface;
  [`plan()`](https://future.futureverse.org/reference/plan.md) switches
  between them transparently
- **Automatic globals detection** — uses the `globals` package to
  identify and export variables/functions needed by future expressions
- **Condition relaying** — stdout, messages, warnings, and errors from
  worker processes are captured and re-signaled in the main process

## Git Workflow

- Uses **Git Flow**: `develop` for active development, `master` for CRAN
  releases
- PRs should target `develop`
- Must pass `R CMD check --as-cran`

## Key Environment Variables

- `R_FUTURE_PLAN` — default future plan/backend
- `R_FUTURE_GLOBALS_ONREFERENCE` — behavior on global variable
  references (e.g. “warning”)
- `R_FUTURE_RNG_ONMISUSE` — RNG misuse handling (e.g. “error”)
- `R_FUTURE_FORK_ENABLE` — enable/disable forked processing
- `NOT_CRAN` — when “true”, enables extended tests

## Dependencies

Core: `globals` (\>= 0.18.0), `listenv` (\>= 0.8.0), `parallelly` (\>=
1.44.0), `digest`, `parallel`, `utils`
