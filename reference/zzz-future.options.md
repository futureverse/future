# Options used for futures

Below are the R options and environment variables that are used by the
future package and packages enhancing it.  
  
*WARNING: Note that the names and the default values of these options
may change in future versions of the package. Please use with care until
further notice.*

## Packages must not change future options

Just like for other R options, as a package developer you must *not*
change any of the below `future.*` options. Only the end-user should set
these. If you find yourself having to tweak one of the options, make
sure to undo your changes immediately afterward. For example, if you
want to bump up the `future.globals.maxSize` limit when creating a
future, use something like the following inside your function:

    oopts <- options(future.globals.maxSize = 1.0 * 1e9)  ## 1.0 GB
    on.exit(options(oopts))
    f <- future({ expr })  ## Launch a future with large objects

## Options for controlling futures

- future.plan::

  (character string or future function) Default future backend used
  unless otherwise specified via
  [`plan()`](https://future.futureverse.org/reference/plan.md). This
  will also be the future plan set when calling `plan("default")`. If
  not specified, this option may be set when the future package is
  *loaded* if command-line option `--parallel=ncores` (short
  `-p ncores`) is specified; if `ncores > 1`, then option future.plan is
  set to `multisession` otherwise `sequential` (in addition to option
  mc.cores being set to `ncores`, if `ncores >= 1`). (Default:
  `sequential`)

- future.globals.maxSize::

  (numeric) Maximum allowed total size (in bytes) of global variables
  identified. This is used to protect against exporting too large
  objects to parallel workers by mistake. Transferring large objects
  over a network, or over the internet, can be slow and therefore
  introduce a large bottleneck that increases the overall processing
  time. It can also result in large egress or ingress costs, which may
  exist on some systems. If set of `+Inf`, then the check for large
  globals is skipped. (Default: `500 * 1024 ^ 2` = 500 MiB)

- future.globals.onReference: (*beta feature - may change*):

  (character string) Controls whether the identified globals should be
  scanned for so called *references* (e.g. external pointers and
  connections) or not. It is unlikely that another R process ("worker")
  can use a global that uses a internal reference of the master R
  process—we call such objects *non-exportable globals*. If this option
  is `"error"`, an informative error message is produced if a
  non-exportable global is detected. If `"warning"`, a warning is
  produced, but the processing will continue; it is likely that the
  future will be resolved with a run-time error unless processed in the
  master R process (e.g. `plan(sequential)` and `plan(multicore)`). If
  `"ignore"`, no scan is performed. (Default: `"ignore"` but may change)

- future.resolve.recursive::

  (integer) An integer specifying the maximum recursive depth to which
  futures should be resolved. If negative, nothing is resolved. If `0`,
  only the future itself is resolved. If `1`, the future and any of its
  elements that are futures are resolved, and so on. If `+Inf`, infinite
  search depth is used. (Default: `0`)

- future.onFutureCondition.keepFuture::

  (logical) If `TRUE`, a `FutureCondition` keeps a copy of the `Future`
  object that triggered the condition. If `FALSE`, it is dropped.
  (Default: `TRUE`)

- future.wait.timeout::

  (numeric) Maximum waiting time (in seconds) for a future to resolve or
  for a free worker to become available before a timeout error is
  generated. (Default: `30 * 24 * 60 * 60` (= 30 days))

- future.wait.interval::

  (numeric) Initial interval (in seconds) between polls. This controls
  the polling frequency for finding an available worker when all workers
  are currently busy. It also controls the polling frequency of
  [`resolve()`](https://future.futureverse.org/reference/resolve.md).
  (Default: `0.01` = 1 ms)

- future.wait.alpha::

  (numeric) Positive scale factor used to increase the interval after
  each poll. (Default: `1.01`)

## Options for built-in sanity checks

Ideally, the evaluation of a future should have no side effects. To
protect against unexpected side effects, the future framework comes with
a set of built-in tools for checking against this. Below R options
control these built-in checks and what should happen if they fail. You
may modify them for troubleshooting purposes, but please refrain from
disabling these checks when there is an underlying problem that should
be fixed.

*Beta features: Please consider these checks to be "under
construction".*

- future.connections.onMisuse::

  (character string) A future must close any connections it opens and
  must not close connections it did not open itself. If such misuse is
  detected and this option is set to `"error"`, then an informative
  error is produced. If it is set to `"warning"`, a warning is produced.
  If`"ignore"`, no check is performed. (Default: `"warning"`)

- future.defaultDevice.onMisuse::

  (character string) A future must open graphics devices explicitly, if
  it creates new plots. It should not rely on the default graphics
  device that is given by R option `"default"`, because that rarely does
  what is intended. If such misuse is detected and this option is set to
  `"error"`, then an informative error is produced. If it is set to
  `"warning"`, a warning is produced. If`"ignore"`, no check is
  performed. (Default: `"warning"`)

- future.devices.onMisuse::

  (character string) A future must close any graphics devices it opens
  and must not close devices it did not open itself. If such misuse is
  detected and this option is set to `"error"`, then an informative
  error is produced. If it is set to `"warning"`, a warning is produced.
  If`"ignore"`, no check is performed. (Default: `"warning"`)

- future.globalenv.onMisuse::

  (character string) Assigning variables to the global environment for
  the purpose of using the variable at a later time makes no sense with
  futures, because the next the future may be evaluated in different R
  process. To protect against mistakes, the future framework attempts to
  detect when variables are added to the global environment. If this is
  detected, and this option is set to `"error"`, then an informative
  error is produced. If `"warning"`, then a warning is produced. If
  `"ignore"`, no check is performed. (Default: `"ignore"`)

- future.rng.onMisuse::

  (character string) If random numbers are used in futures, then
  parallel RNG should be *declared* in order to get statistical sound
  RNGs. You can declare this by specifying future argument
  `seed = TRUE`. The defaults in the future framework assume that *no*
  random number generation (RNG) is taken place in the future expression
  because L'Ecuyer-CMRG RNGs come with an unnecessary overhead if not
  needed. To protect against mistakes of not declaring use of the RNG,
  the future framework detects when random numbers were used despite not
  declaring such use. If this is detected, and this options is set
  `"error"`, then an informative error is produced. If `"warning"`, then
  a warning is produced. If `"ignore"`, no check is performed. (Default:
  `"warning"`)

## Options for debugging futures

- future.debug::

  (logical) If `TRUE`, extensive debug messages are generated. (Default:
  `FALSE`)

## Options for controlling package startup

- future.startup.script::

  (character vector or a logical) Specifies zero of more future startup
  scripts to be sourced when the future package is *attached*. It is
  only the first existing script that is sourced. If none of the
  specified files exist, nothing is sourced—there will be neither a
  warning nor an error. If this option is not specified, environment
  variable `R_FUTURE_STARTUP_SCRIPT` is considered, where multiple
  scripts may be separated by either a colon (`:`) or a semicolon (`;`).
  If neither is set, or either is set to `TRUE`, the default is to look
  for a `.future.R` script in the current directory and then in the
  user's home directory. To disable future startup scripts, set the
  option or the environment variable to `FALSE`. *Importantly*, this
  option is *always* set to `FALSE` if the future package is loaded as
  part of a future expression being evaluated, e.g. in a background
  process. In other words, they are sourced in the main R process but
  not in future processes. (Default: `TRUE` in main R process and
  `FALSE` in future processes / during future evaluation)

- future.cmdargs::

  (character vector) Overrides
  [`commandArgs()`](https://rdrr.io/r/base/commandArgs.html) when the
  future package is *loaded*.

## Options for configuring low-level system behaviors

- future.fork.multithreading.enable (*beta feature - may change*)::

  (logical) Enable or disable *multi-threading* while using *forked*
  parallel processing. If `FALSE`, different multi-thread library
  settings are overridden such that they run in single-thread mode.
  Specifically, multi-threading will be disabled for OpenMP (which
  requires the RhpcBLASctl package) and for **RcppParallel**. If `TRUE`,
  or not set (the default), multi-threading is allowed. Parallelization
  via multi-threaded processing (done in native code by some packages
  and external libraries) while at the same time using forked (aka
  "multicore") parallel processing is known to unstable. Note that this
  is not only true when using `plan(multicore)` but also when using, for
  instance, `mclapply()` of the parallel package. (Default: not set)

- future.output.windows.reencode::

  (logical) Enable or disable re-encoding of UTF-8 symbols that were
  incorrectly encoded while captured. In R (\< 4.2.0) and on older
  versions of MS Windows, R cannot capture UTF-8 symbols as-is when they
  are captured from the standard output. For examples, a UTF-8 check
  mark symbol (`"\u2713"`) would be relayed as `"<U+2713>"` (a string
  with eight ASCII characters). Setting this option to `TRUE` will cause
  [`value()`](https://future.futureverse.org/reference/value.md) to
  attempt to recover the intended UTF-8 symbols from `<U+nnnn>` string
  components, if, and only if, the string was captured by a future
  resolved on MS Windows. (Default: `TRUE`)

## Options for demos

- future.demo.mandelbrot.region::

  (integer) Either a named list of
  [`mandelbrot()`](https://future.futureverse.org/reference/mandelbrot.md)
  arguments or an integer in {1, 2, 3} specifying a predefined
  Mandelbrot region. (Default: `1L`)

- future.demo.mandelbrot.nrow::

  (integer) Number of rows and columns of tiles. (Default: `3L`)

## Deprecated or for internal prototyping

The following options exists only for troubleshooting purposes and must
not be used in production. If used, there is a risk that the results are
non-reproducible if processed elsewhere. To lower the risk of them being
used by mistake, they are marked as deprecated and will produce warnings
if set.

- future.globals.onMissing::

  (character string) Action to take when non-existing global variables
  ("globals" or "unknowns") are identified when the future is created.
  If `"error"`, an error is generated immediately. If `"ignore"`, no
  action is taken and an attempt to evaluate the future expression will
  be made. The latter is useful when there is a risk for false-positive
  globals being identified, e.g. when future expression contains
  non-standard evaluation (NSE). (Default: `"ignore"`)

- future.globals.method::

  (character string) Method used to identify globals. For details, see
  [`globalsOf()`](https://globals.futureverse.org/reference/globalsOf.html).
  (Default: `"ordered"`)

- future.globals.resolve::

  (logical) If `TRUE`, globals that are
  [`Future`](https://future.futureverse.org/reference/Future-class.md)
  objects (typically created as *explicit* futures) will be resolved and
  have their values (using
  [`value()`](https://future.futureverse.org/reference/value.md))
  collected. Because searching for unresolved futures among globals
  (including their content) can be expensive, the default is not to do
  it and instead leave it to the run-time checks that assert proper
  ownership when resolving futures and collecting their values.
  (Default: `FALSE`)

## Environment variables that set R options

All of the above R future.\* options can be set by corresponding
environment variable `R_FUTURE_*` *when the future package is loaded*.
This means that those environment variables must be set before the
future package is loaded in order to have an effect. For example, if
`R_FUTURE_RNG_ONMISUSE="ignore"`, then option future.rng.onMisuse is set
to `"ignore"` (character string). Similarly, if
`R_FUTURE_GLOBALS_MAXSIZE="50000000"`, then option
future.globals.maxSize is set to `50000000` (numeric).

## Options moved to the 'parallelly' package

Several functions have been moved to the parallelly package:

- [`parallelly::availableCores()`](https://parallelly.futureverse.org/reference/availableCores.html)

- [`parallelly::availableWorkers()`](https://parallelly.futureverse.org/reference/availableWorkers.html)

- [`parallelly::makeClusterMPI()`](https://parallelly.futureverse.org/reference/makeClusterMPI.html)

- [`parallelly::makeClusterPSOCK()`](https://parallelly.futureverse.org/reference/makeClusterPSOCK.html)

- [`parallelly::makeNodePSOCK()`](https://parallelly.futureverse.org/reference/makeClusterPSOCK.html)

- [`parallelly::supportsMulticore()`](https://parallelly.futureverse.org/reference/supportsMulticore.html)

The options and environment variables controlling those have been
adjusted accordingly to have different prefixes. For example, option
future.fork.enable has been renamed to parallelly.fork.enable and the
corresponding environment variable `R_FUTURE_FORK_ENABLE` has been
renamed to `R_PARALLELLY_FORK_ENABLE`. For backward compatibility
reasons, the parallelly package will support both versions for a long
foreseeable time. See the
[parallelly::parallelly.options](https://parallelly.futureverse.org/reference/zzz-parallelly.options.html)
page for the settings.

## See also

To set R options or environment variables when R starts (even before the
future package is loaded), see the
[Startup](https://rdrr.io/r/base/Startup.html) help page. The
[startup](https://cran.r-project.org/package=startup) package provides a
friendly mechanism for configurating R's startup process.

## Examples

``` r
# Allow at most 5 MB globals per futures
options(future.globals.maxSize = 5e6)

# Be strict; catch all RNG mistakes
options(future.rng.onMisuse = "error")

```
