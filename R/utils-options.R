#' Options used for futures
#'
#' Below are the \R options and environment variables that are used by the
#' \pkg{future} package and packages enhancing it.\cr
#' \cr
#' _WARNING: Note that the names and the default values of these options may
#'  change in future versions of the package.  Please use with care until
#'  further notice._
#'
#' @section Packages must not change future options:
#'
#' Just like for other R options, as a package developer you must _not_ change
#' any of the below `future.*` options.  Only the end-user should set these.
#' If you find yourself having to tweak one of the options, make sure to
#' undo your changes immediately afterward.  For example, if you want to
#' bump up the `future.globals.maxSize` limit when creating a future,
#' use something like the following inside your function:
#'
#' ```r
#' oopts <- options(future.globals.maxSize = 1.0 * 1e9)  ## 1.0 GB
#' on.exit(options(oopts))
#' f <- future({ expr })  ## Launch a future with large objects
#' ```
#'
#' @section Options for controlling futures:
#' \describe{
#'  \item{\option{future.plan}:}{(character string or future function) Default future backend used unless otherwise specified via [plan()]. This will also be the future plan set when calling `plan("default")`.  If not specified, this option may be set when the \pkg{future} package is _loaded_ if command-line option `--parallel=ncores` (short `-p ncores`) is specified; if `ncores > 1`, then option \option{future.plan} is set to `multisession` otherwise `sequential` (in addition to option \option{mc.cores} being set to `ncores`, if `ncores >= 1`). (Default: `sequential`)}
#'
#'  \item{\option{future.globals.maxSize}:}{(numeric) Maximum allowed total size (in bytes) of global variables identified. This is used to protect against exporting too large objects to parallel workers by mistake. Transferring large objects over a network, or over the internet, can be slow and therefore introduce a large bottleneck that increases the overall processing time. It can also result in large egress or ingress costs, which may exist on some systems. If set of `+Inf`, then the check for large globals is skipped. (Default: `500 * 1024 ^ 2` = 500 MiB)}
#'
#'   \item{\option{future.globals.onReference}: (_beta feature - may change_)}{(character string) Controls whether the identified globals should be scanned for so called _references_ (e.g. external pointers and connections) or not.  It is unlikely that another \R process ("worker") can use a global that uses a internal reference of the master \R process---we call such objects _non-exportable globals_.
#'    If this option is `"error"`, an informative error message is produced if a non-exportable global is detected.
#'    If `"warning"`, a warning is produced, but the processing will continue; it is likely that the future will be resolved with a run-time error unless processed in the master \R process (e.g. `plan(sequential)` and `plan(multicore)`).
#'    If `"ignore"`, no scan is performed.
#'    (Default: `"ignore"` but may change)
#'  }
#'
#'  \item{\option{future.resolve.recursive}:}{(integer) An integer specifying the maximum recursive depth to which futures should be resolved. If negative, nothing is resolved.  If `0`, only the future itself is resolved.  If `1`, the future and any of its elements that are futures are resolved, and so on. If `+Inf`, infinite search depth is used. (Default: `0`)}
#'
### HIDDEN/SECRET FOR NOW:  \item{\option{future.resolved.timeout}:}{(numeric) The maximum time (in seconds) `resolved()` spends checking whether or not a future is resolved. If it takes longer, it will give up and return FALSE. (Default: `0.01` = 0.01 seconds)}
#'
#'  \item{\option{future.onFutureCondition.keepFuture}:}{(logical) If `TRUE`, a `FutureCondition` keeps a copy of the `Future` object that triggered the condition. If `FALSE`, it is dropped. (Default: `TRUE`)}
#'
#'  \item{\option{future.wait.timeout}:}{(numeric) Maximum waiting time (in seconds) for a future to resolve or for a free worker to become available before a timeout error is generated. (Default: `30 * 24 * 60 * 60` (= 30 days))}
#'
#'  \item{\option{future.wait.interval}:}{(numeric) Initial interval (in
#'  seconds) between polls. This controls the polling frequency for finding
#'  an available worker when all workers are currently busy. It also controls
#'  the polling frequency of `resolve()`. (Default: `0.01` = 1 ms)}
#'
#'  \item{\option{future.wait.alpha}:}{(numeric) Positive scale factor used to increase the interval after each poll. (Default: `1.01`)}
#' }
#'
#'
#' @section Options for built-in sanity checks:
#'
#' Ideally, the evaluation of a future should have no side effects. To
#' protect against unexpected side effects, the future framework comes
#' with a set of built-in tools for checking against this.
#' Below R options control these built-in checks and what should happen
#' if they fail. You may modify them for troubleshooting purposes, but
#' please refrain from disabling these checks when there is an underlying
#' problem that should be fixed.
#'
#' _Beta features: Please consider these checks to be "under construction"._
#'
#' \describe{
#'  \item{\option{future.connections.onMisuse}:}{(character string)
#'    A future must close any connections it opens and must not close
#'    connections it did not open itself.
#'    If such misuse is detected and this option is set to `"error"`,
#'    then an informative error is produced. If it is set to `"warning"`,
#'    a warning is produced. If`"ignore"`, no check is performed.
#'    (Default: `"warning"`)
#'  }
#'
#'  \item{\option{future.defaultDevice.onMisuse}:}{(character string)
#'    A future must open graphics devices explicitly, if it creates new
#'    plots. It should not rely on the default graphics device that
#'    is given by R option `"default"`, because that rarely does what
#'    is intended.
#'    If such misuse is detected and this option is set to `"error"`,
#'    then an informative error is produced. If it is set to `"warning"`,
#'    a warning is produced. If`"ignore"`, no check is performed.
#'    (Default: `"warning"`)
#'  }
#'
#'  \item{\option{future.devices.onMisuse}:}{(character string)
#'    A future must close any graphics devices it opens and must not close
#'    devices it did not open itself.
#'    If such misuse is detected and this option is set to `"error"`,
#'    then an informative error is produced. If it is set to `"warning"`,
#'    a warning is produced. If`"ignore"`, no check is performed.
#'    (Default: `"warning"`)
#'  }
#'
#'  \item{\option{future.globalenv.onMisuse}:}{(character string)
#'    Assigning variables to the global environment for the purpose of using
#'    the variable at a later time makes no sense with futures, because the
#'    next the future may be evaluated in different R process.
#'    To protect against mistakes, the future framework attempts to detect
#'    when variables are added to the global environment.
#'    If this is detected, and this option is set to `"error"`, then an
#'    informative error is produced. If `"warning"`, then a warning is
#'    produced. If `"ignore"`, no check is performed.
#'    (Default: `"ignore"`)
#'  }
#'
#'  \item{\option{future.rng.onMisuse}:}{(character string)
#'    If random numbers are used in futures, then parallel RNG should be
#'    _declared_ in order to get statistical sound RNGs. You can declare
#'    this by specifying future argument `seed = TRUE`. The defaults in the
#'    future framework assume that _no_ random number generation (RNG) is
#'    taken place in the future expression because L'Ecuyer-CMRG RNGs come
#'    with an unnecessary overhead if not needed.
#'    To protect against  mistakes of not declaring use of the RNG, the
#'    future framework detects when random numbers were used despite not
#'    declaring such use.
#'    If this is detected, and this options is set `"error"`, then an
#'    informative error is produced. If `"warning"`, then a warning is
#'    produced.  If `"ignore"`, no check is performed.
#'    (Default: `"warning"`)
#'  }
#' }
#'
#'
#' @section Options for debugging futures:
#' \describe{
#'  \item{\option{future.debug}:}{(logical) If `TRUE`, extensive debug messages are generated. (Default: `FALSE`)}
#' }
#'
#' @section Options for controlling package startup:
#' \describe{
#'  \item{\option{future.startup.script}:}{(character vector or a logical) Specifies zero of more future startup scripts to be sourced when the \pkg{future} package is _attached_. It is only the first existing script that is sourced. If none of the specified files exist, nothing is sourced---there will be neither a warning nor an error.
#'  If this option is not specified, environment variable \env{R_FUTURE_STARTUP_SCRIPT} is considered, where multiple scripts may be separated by either a colon (`:`) or a semicolon (`;`). If neither is set, or either is set to `TRUE`, the default is to look for a \file{.future.R} script in the current directory and then in the user's home directory.  To disable future startup scripts, set the option or the environment variable to `FALSE`.  _Importantly_, this option is _always_ set to `FALSE` if the \pkg{future} package is loaded as part of a future expression being evaluated, e.g. in a background process. In other words, they are sourced in the main \R process but not in future processes. (Default: `TRUE` in main \R process and `FALSE` in future processes / during future evaluation)}
#'
#'  \item{\option{future.cmdargs}:}{(character vector) Overrides \code{\link[base]{commandArgs}()} when the \pkg{future} package is _loaded_.}
#' }
#'
#' @section Options for configuring low-level system behaviors:
#'
#' \describe{
#'  \item{\option{future.fork.multithreading.enable} (_beta feature - may change_):}{(logical) Enable or disable _multi-threading_ while using _forked_ parallel processing.  If `FALSE`, different multi-thread library settings are overridden such that they run in single-thread mode. Specifically, multi-threading will be disabled for OpenMP (which requires the \pkg{RhpcBLASctl} package) and for **RcppParallel**. If `TRUE`, or not set (the default), multi-threading is allowed.  Parallelization via multi-threaded processing (done in native code by some packages and external libraries) while at the same time using forked (aka "multicore") parallel processing is known to unstable.  Note that this is not only true when using `plan(multicore)` but also when using, for instance, \code{\link[=mclapply]{mclapply}()} of the \pkg{parallel} package. (Default: not set)}
#'
#'  \item{\option{future.output.windows.reencode}:}{(logical) Enable or disable re-encoding of UTF-8 symbols that were incorrectly encoded while captured.  In R (< 4.2.0) and on older versions of MS Windows, R cannot capture UTF-8 symbols as-is when they are captured from the standard output.  For examples, a UTF-8 check mark symbol (`"\u2713"`) would be relayed as `"<U+2713>"` (a string with eight ASCII characters).  Setting this option to `TRUE` will cause `value()` to attempt to recover the intended UTF-8 symbols from `<U+nnnn>` string components, if, and only if, the string was captured by a future resolved on MS Windows. (Default: `TRUE`)}
#' }
#'
#'
#' @section Options for demos:
#' \describe{
#'  \item{\option{future.demo.mandelbrot.region}:}{(integer) Either a named list of [mandelbrot()] arguments or an integer in \{1, 2, 3\} specifying a predefined Mandelbrot region. (Default: `1L`)}
#'
#'  \item{\option{future.demo.mandelbrot.nrow}:}{(integer) Number of rows and columns of tiles. (Default: `3L`)}
#' }
#'
#'
#' @section Deprecated or for internal prototyping:
#'
#' The following options exists only for troubleshooting purposes and must not
#' be used in production.  If used, there is a risk that the results are
#' non-reproducible if processed elsewhere.  To lower the risk of them being
#' used by mistake, they are marked as deprecated and will produce warnings
#' if set.
#'
#' \describe{
#'  \item{\option{future.globals.onMissing}:}{(character string) Action to take when non-existing global variables ("globals" or "unknowns") are identified when the future is created.  If `"error"`, an error is generated immediately.  If `"ignore"`, no action is taken and an attempt to evaluate the future expression will be made.  The latter is useful when there is a risk for false-positive globals being identified, e.g. when future expression contains non-standard evaluation (NSE).  (Default: `"ignore"`)}
#'
#'  \item{\option{future.globals.method}:}{(character string) Method used to identify globals. For details, see \code{\link[globals]{globalsOf}()}. (Default: `"ordered"`)}
#'
#'  \item{\option{future.globals.resolve}:}{(logical) If `TRUE`, globals that are [`Future`] objects (typically created as _explicit_ futures) will be resolved and have their values (using `value()`) collected.  Because searching for unresolved futures among globals (including their content) can be expensive, the default is not to do it and instead leave it to the run-time checks that assert proper ownership when resolving futures and collecting their values. (Default: `FALSE`)}
#' }
#'
#' @section Environment variables that set R options:
#' All of the above \R \option{future.*} options can be set by corresponding
#' environment variable \env{R_FUTURE_*} _when the \pkg{future} package is
#' loaded_. This means that those environment variables must be set before
#' the \pkg{future} package is loaded in order to have an effect.
#' For example, if `R_FUTURE_RNG_ONMISUSE="ignore"`, then option
#' \option{future.rng.onMisuse} is set to `"ignore"` (character string).
#' Similarly, if `R_FUTURE_GLOBALS_MAXSIZE="50000000"`, then option
#' \option{future.globals.maxSize} is set to `50000000` (numeric).
#'
#'
#' @section Options moved to the 'parallelly' package:
#' Several functions have been moved to the \pkg{parallelly} package:
#'
#' * [parallelly::availableCores()]
#' * [parallelly::availableWorkers()]
#' * [parallelly::makeClusterMPI()]
#' * [parallelly::makeClusterPSOCK()]
#' * [parallelly::makeNodePSOCK()]
#' * [parallelly::supportsMulticore()]
#'
#' The options and environment variables controlling those have been adjusted
#' accordingly to have different prefixes.
#' For example, option \option{future.fork.enable} has been renamed to
#' \option{parallelly.fork.enable} and the corresponding environment variable
#' \env{R_FUTURE_FORK_ENABLE} has been renamed to
#' \env{R_PARALLELLY_FORK_ENABLE}.
#' For backward compatibility reasons, the \pkg{parallelly} package will
#' support both versions for a long foreseeable time.
#' See the [parallelly::parallelly.options] page for the settings.
#'
#'
#' @examples
#' # Allow at most 5 MB globals per futures
#' options(future.globals.maxSize = 5e6)
#'
#' # Be strict; catch all RNG mistakes
#' options(future.rng.onMisuse = "error")
#' 
#'
#' @seealso
#' To set \R options or environment variables when \R starts (even before the \pkg{future} package is loaded), see the \link[base]{Startup} help page.  The \href{https://cran.r-project.org/package=startup}{\pkg{startup}} package provides a friendly mechanism for configurating \R's startup process.
#'
#' @aliases
#' future.options 
#'
#' future.startup.script
#' future.debug
#' future.demo.mandelbrot.region
#' future.demo.mandelbrot.nrow
#' future.fork.multithreading.enable
#' future.globals.maxSize
#' future.globals.method
#' future.globals.onMissing
#' future.globals.resolve
#' future.globals.onReference
#' future.globals.onReference
#' future.plan
#' future.onFutureCondition.keepFuture
#' future.resolve.recursive
#' future.connections.onMisuse
#' future.defaultDevice.onMisuse
#' future.devices.onMisuse
#' future.globalenv.onMisuse
#' future.rng.onMisuse
#' future.wait.alpha
#' future.wait.interval
#' future.wait.timeout
#' future.output.windows.reencode
#' future.journal
#' future.globals.objectSize.method
#' future.ClusterFuture.clusterEvalQ
#'
#' R_FUTURE_STARTUP_SCRIPT
#' R_FUTURE_DEBUG
#' R_FUTURE_DEMO_MANDELBROT_REGION
#' R_FUTURE_DEMO_MANDELBROT_NROW
#' R_FUTURE_FORK_MULTITHREADING_ENABLE
#' R_FUTURE_GLOBALS_MAXSIZE
#' R_FUTURE_GLOBALS_METHOD
#' R_FUTURE_GLOBALS_ONMISSING
#' R_FUTURE_GLOBALS_RESOLVE
#' R_FUTURE_GLOBALS_ONREFERENCE
#' R_FUTURE_PLAN
#' R_FUTURE_ONFUTURECONDITION_KEEPFUTURE
#' R_FUTURE_RESOLVE_RECURSIVE
#' R_FUTURE_CONNECTIONS_ONMISUSE
#' R_FUTURE_DEVICES_ONMISUSE
#' R_FUTURE_DEFAULTDEVICE_ONMISUSE
#' R_FUTURE_GLOBALENV_ONMISUSE
#' R_FUTURE_RNG_ONMISUSE
#' R_FUTURE_WAIT_ALPHA
#' R_FUTURE_WAIT_INTERVAL
#' R_FUTURE_WAIT_TIMEOUT
#' R_FUTURE_RESOLVED_TIMEOUT
#' R_FUTURE_OUTPUT_WINDOWS_REENCODE
#' R_FUTURE_JOURNAL
#' R_FUTURE_GLOBALS_OBJECTSIZE_METHOD
#' R_FUTURE_CLUSTERFUTURE_CLUSTEREVALQ
#'
#' future.cmdargs 
#' .future.R
#'
#' @name zzz-future.options 
NULL


setOption <- function(name, value) {
  oldValue <- getOption(name)
  args <- list(value)
  names(args) <- name
  do.call(options, args = args)
  invisible(oldValue)
}


# Set an R option from an environment variable
update_package_option <- function(name, mode = "character", default = NULL, split = NULL, trim = TRUE, disallow = c("NA"), force = FALSE, debug = FALSE) {
  ## Nothing to do?
  value <- getOption(name)
  if (!force && !is.null(value)) return(getOption(name, default = default))

  ## name="future.plan.disallow" => env="R_FUTURE_PLAN_DISALLOW"
  env <- gsub(".", "_", toupper(name), fixed = TRUE)
  env <- paste("R_", env, sep = "")

  env_value <- value <- Sys.getenv(env, unset = NA_character_)
  ## Nothing to do?
  if (is.na(value)) {  
    if (debug) mdebugf("Environment variable %s not set", sQuote(env))
    if (!is.null(default)) setOption(name, default)
    return(getOption(name, default = default))
  }
  
  if (debug) mdebugf("%s=%s", env, sQuote(value))

  ## Trim?
  if (trim) value <- trim(value)

  ## Nothing to do?
  if (!nzchar(value)) {
    if (!is.null(default)) setOption(name, default)
    return(getOption(name, default = default))
  }

  ## Split?
  if (!is.null(split)) {
    value <- strsplit(value, split = split, fixed = TRUE)
    value <- unlist(value, use.names = FALSE)
    if (trim) value <- trim(value)
  }

  ## Coerce?
  mode0 <- storage.mode(value)
  if (mode0 != mode) {
    suppressWarnings({
      storage.mode(value) <- mode
    })
    if (debug) {
      mdebugf("Coercing from %s to %s: %s", mode0, mode, commaq(value))
    }
  }

  if (length(disallow) > 0) {
    if ("NA" %in% disallow) {
      if (anyNA(value)) {
        stopf("Coercing environment variable %s=%s to %s would result in missing values for option %s: %s", sQuote(env), sQuote(env_value), sQuote(mode), sQuote(name), commaq(value))
      }
    }
    if (is.numeric(value)) {
      if ("non-positive" %in% disallow) {
        if (any(value <= 0, na.rm = TRUE)) {
          stopf("Environment variable %s=%s specifies a non-positive value for option %s: %s", sQuote(env), sQuote(env_value), sQuote(name), commaq(value))
        }
      }
      if ("negative" %in% disallow) {
        if (any(value < 0, na.rm = TRUE)) {
          stopf("Environment variable %s=%s specifies a negative value for option %s: %s", sQuote(env), sQuote(env_value), sQuote(name), commaq(value))
        }
      }
    }
  }
  
  if (debug) {
    mdebugf("=> options(%s = %s) [n=%d, mode=%s]",
            dQuote(name), commaq(value),
            length(value), storage.mode(value))
  }

  setOption(name, value)
  
  getOption(name, default = default)
}


## Set future options based on environment variables
update_package_options <- function(debug = FALSE) {
  update_package_option("future.demo.mandelbrot.region", mode = "integer", debug = debug)
  
  update_package_option("future.demo.mandelbrot.nrow", mode = "integer", debug = debug)

  update_package_option("future.deprecated.ignore", split = ",", debug = debug)

  update_package_option("future.deprecated.defunct", mode = "character", split = ",", debug = debug)

  update_package_option("future.fork.multithreading.enable", mode = "logical", debug = debug)

  update_package_option("future.globals.maxSize", mode = "numeric", debug = debug)

  update_package_option("future.globals.onMissing", debug = debug)
  
  update_package_option("future.globals.onReference", debug = debug)

  update_package_option("future.globals.method", debug = debug)
  
  update_package_option("future.globals.resolve", mode = "logical", debug = debug)

  ## Introduced in future 1.22.0:
  update_package_option("future.lazy.assertOwner", mode = "logical", debug = debug)

  update_package_option("future.plan", debug = debug)

  update_package_option("future.plan.disallow", split = ",", debug = debug)

  ## future.plan.relay.immediate or future.psock.relay.immediate?!? /HB 2021-03-07
  update_package_option("future.psock.relay.immediate", mode = "logical", debug = debug)
  
  update_package_option("future.relay.immediate", mode = "logical", debug = debug)

  update_package_option("future.resolve.recursive", mode = "integer", debug = debug)

  ## Introduced in future 1.33.0:
  update_package_option("future.alive.timeout", mode = "numeric", debug = debug)

  ## Introduced in future 1.22.0:
  for (name in c("future.resolved.timeout", "future.cluster.resolved.timeout", "future.multicore.resolved.timeout")) {
    update_package_option(name, mode = "numeric", debug = debug)
  }

  ## Introduced in future 1.32.0:
  update_package_option("future.onFutureCondition.keepFuture", mode = "logical", debug = debug)

  update_package_option("future.rng.onMisuse", debug = debug)
  
  ## Prototyping in future 1.32.0:
  update_package_option("future.globalenv.onMisuse", debug = debug)

  update_package_option("future.wait.timeout", mode = "numeric", debug = debug)
  update_package_option("future.wait.interval", mode = "numeric", debug = debug)
  update_package_option("future.wait.alpha", mode = "numeric", debug = debug)

  ## Prototyping in future 1.22.0:
  ## https://github.com/futureverse/future/issues/515
  update_package_option("future.assign_globals.exclude", split = ",", debug = debug)

  ## Prototyping in future 1.23.0:
  update_package_option("future.output.windows.reencode", mode = "logical", debug = debug)

  ## Prototyping in future 1.26.0:
  update_package_option("future.globals.globalsOf.locals", mode = "logical", debug = debug)

  ## future 1.32.0:
  update_package_option("future.state.onInvalid", mode = "character", debug = debug)

  ## future 1.32.0:
  update_package_option("future.journal", mode = "logical", debug = debug)

  ## SETTINGS USED FOR DEPRECATING FEATURES
  ## future 1.22.0 & future 1.45.0 (new default keepWhere = TRUE)
  update_package_option("future.globals.keepWhere", mode = "logical", default = TRUE, debug = debug)

  ## future 1.34.0:
  update_package_option("future.globals.objectSize.method", mode = "character", debug = debug)

  ## future 1.40.0:
  update_package_option("future.connections.onMisuse", mode = "character", debug = debug)
  value <- getOption("future.connections.onMisuse")
  if (!is.null(value)) {
    pattern <- "[[]details=TRUE[]]$"
    if (grepl(pattern, value)) {
      value <- gsub(pattern, "", value)
      attr(value, "details") <- TRUE
      options(future.connections.onMisuse = value)
    }
  }

  update_package_option("future.devices.onMisuse", mode = "character", debug = debug)

  ## future 1.49.0:
  update_package_option("future.regression.note", mode = "logical", default = TRUE, debug = debug)
  update_package_option("future.globals.method.default", mode = "character", split = ",", default = c("ordered", "dfs"), debug = debug)

  update_package_option("future.debug.indent", mode = "character", default = " ", debug = debug)

  update_package_option("future.ClusterFuture.clusterEvalQ", mode = "character", default = "warning", debug = debug)
}
