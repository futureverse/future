#' Create a future
#'
## Rescaled to 120x138: convert -geometry 28.7% future-logo.png logo.png
#' \if{html}{\figure{logo.png}{options: style='float: right;' alt='logo' width='120'}}
#' Creates a future that evaluates an \R expression or
#' a future that calls an \R function with a set of arguments.
#' How, when, and where these futures are evaluated can be configured
#' using [plan()] such that it is evaluated in parallel on,
#' for instance, the current machine, on a remote machine, or via a
#' job queue on a compute cluster.
#' Importantly, any \R code using futures remains the same regardless
#' on these settings and there is no need to modify the code when
#' switching from, say, sequential to parallel processing.
#'
#' @inheritParams Future-class
#' 
#' @param expr An \R \link[base]{expression}.
#'
#' @param \ldots Additional arguments passed to [Future()].
#'
#' @return
#' `future()` returns [Future] that evaluates expression `expr`.
#'
#' @details
#' The state of a future is either unresolved or resolved.
#' The value of a future can be retrieved using \code{v <- \link{value}(f)}.
#' Querying the value of a non-resolved future will _block_ the call
#' until the future is resolved.
#' It is possible to check whether a future is resolved or not
#' without blocking by using \code{\link{resolved}(f)}.
#' It is possible to [cancel()] a future that is being resolved.
#' Failed, canceled, and interrupted futures can be [reset()] to a
#' lazy, vanilla future that can be relaunched.
#'
#' @section Eager or lazy evaluation:
#' By default, a future is resolved using _eager_ evaluation
#' (`lazy = FALSE`).  This means that the expression starts to
#' be evaluated as soon as the future is created.
#'
#' As an alternative, the future can be resolved using _lazy_
#' evaluation (`lazy = TRUE`).  This means that the expression
#' will only be evaluated when the value of the future is requested.
#' _Note that this means that the expression may not be evaluated
#' at all - it is guaranteed to be evaluated if the value is requested_.
#'
#'
#' @section Globals used by future expressions:
#' Global objects (short _globals_) are objects (e.g. variables and
#' functions) that are needed in order for the future expression to be
#' evaluated while not being local objects that are defined by the future
#' expression. For example, in
#' \preformatted{
#'   a <- 42
#'   f <- future({ b <- 2; a * b })
#' }
#' variable `a` is a global of future assignment `f` whereas
#' `b` is a local variable.
#' In order for the future to be resolved successfully (and correctly),
#' all globals need to be gathered when the future is created such that
#' they are available whenever and wherever the future is resolved.
#'
#' The default behavior (`globals = TRUE`),
#' is that globals are automatically identified and gathered.
#' More precisely, globals are identified via code inspection of the
#' future expression `expr` and their values are retrieved with
#' environment `envir` as the starting point (basically via
#' `get(global, envir = envir, inherits = TRUE)`).
#' _In most cases, such automatic collection of globals is sufficient
#' and less tedious and error prone than if they are manually specified_.
#'
#' However, for full control, it is also possible to explicitly specify
#' exactly which the globals are by providing their names as a character
#' vector.
#' In the above example, we could use
#' \preformatted{
#'   a <- 42
#'   f <- future({ b <- 2; a * b }, globals = "a")
#' }
#'
#' Yet another alternative is to explicitly specify also their values
#' using a named list as in
#' \preformatted{
#'   a <- 42
#'   f <- future({ b <- 2; a * b }, globals = list(a = a))
#' }
#' or
#' \preformatted{
#'   f <- future({ b <- 2; a * b }, globals = list(a = 42))
#' }
#'
#' Specifying globals explicitly avoids the overhead added from
#' automatically identifying the globals and gathering their values.
#' Furthermore, if we know that the future expression does not make use
#' of any global variables, we can disable the automatic search for
#' globals by using
#' \preformatted{
#'   f <- future({ a <- 42; b <- 2; a * b }, globals = FALSE)
#' }
#'
#' Future expressions often make use of functions from one or more packages.
#' As long as these functions are part of the set of globals, the future
#' package will make sure that those packages are attached when the future
#' is resolved.  Because there is no need for such globals to be frozen
#' or exported, the future package will not export them, which reduces
#' the amount of transferred objects.
#' For example, in
#' \preformatted{
#'   x <- rnorm(1000)
#'   f <- future({ median(x) })
#' }
#' variable `x` and `median()` are globals, but only `x`
#' is exported whereas `median()`, which is part of the \pkg{stats}
#' package, is not exported.  Instead it is made sure that the \pkg{stats}
#' package is on the search path when the future expression is evaluated.
#' Effectively, the above becomes
#' \preformatted{
#'   x <- rnorm(1000)
#'   f <- future({
#'     library(stats)
#'     median(x)
#'   })
#' }
#' To manually specify this, one can either do
#' \preformatted{
#'   x <- rnorm(1000)
#'   f <- future({
#'     median(x)
#'   }, globals = list(x = x, median = stats::median)
#' }
#' or
#' \preformatted{
#'   x <- rnorm(1000)
#'   f <- future({
#'     library(stats)
#'     median(x)
#'   }, globals = list(x = x))
#' }
#' Both are effectively the same.
#'
#'
#' Although rarely needed, a combination of automatic identification and manual
#' specification of globals is supported via attributes `add` (to add
#' false negatives) and `ignore` (to ignore false positives) on value
#' `TRUE`.  For example, with
#' `globals = structure(TRUE, ignore = "b", add = "a")` any globals
#' automatically identified, except `b`, will be used, in addition to
#' global `a`.
#'
#' @example incl/future.R
#'
#' @author
#' The future logo was designed by Dan LaBar and tweaked by Henrik Bengtsson.
#'
#' @seealso
#' How, when and where futures are resolved is given by the
#' _future backend_, which can be set by the end user using the
#' [plan()] function.
#'
#' @name future
#' @aliases futureCall
#' @rdname future
#' @export
future <- function(expr, envir = parent.frame(), substitute = TRUE, lazy = FALSE, seed = FALSE, globals = TRUE, packages = NULL, stdout = TRUE, conditions = "condition", label = NULL, gc = FALSE, earlySignal = FALSE, ...) {
  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebugf_push("future(..., label = %s) ...", sQuoteLabel(label))
    mdebugf("lazy: %s", lazy)
    mdebugf("stdout: %s", stdout)
    mdebugf("conditions: [n=%d] %s", length(conditions), commaq(conditions))
    mdebugf("gc: %s", gc)
    mdebugf("earlySignal: %s", earlySignal)
    on.exit(mdebugf_pop())
  }
  
  if (substitute) expr <- substitute(expr)
  t_start <- Sys.time()

  onReference <- getOption("future.globals.onReference")
  if (is.null(onReference)) onReference <- "ignore"

  if (!is.null(globals)) {
    gp <- getGlobalsAndPackages(expr, envir = envir, tweak = tweakExpression, globals = globals, onReference = onReference, maxSize = +Inf)
    expr <- gp[["expr"]]
    globals <- gp[["globals"]]
    ## Record packages?
    if (length(packages) > 0 || length(gp[["packages"]]) > 0) {
      packages <- c(gp[["packages"]], packages)
    }
    gp <- NULL
    attr(globals, "already-done") <- TRUE
  }

  future <- Future(expr, substitute = FALSE,
                   envir = envir,
                   lazy = TRUE,
                   seed = seed,
                   globals = globals,
                   packages = packages,
                   stdout = stdout,
                   conditions = conditions,
                   earlySignal = earlySignal,
                   label = label,
                   gc = gc,
                   onReference = onReference,
                   ...)

  ## WORKAROUND: Was argument 'local' specified?
  ## Comment: Only allowed for persistent 'cluster' futures
  future[[".defaultLocal"]] <- !is.element("local", names(list(...)))

  ## Enable journaling?
  if (isTRUE(getOption("future.journal"))) {
    future <- makeFutureJournal(future, event = "create", category = "overhead", start = t_start)
  }

  if (!lazy) {
    future <- run(future)
    future[["lazy"]] <- FALSE
    ## Assert that a future was returned
    stop_if_not(inherits(future, "Future"), !future[["lazy"]])
  }
  
  future
}

## Arguments to 'future' strategies that must not be tweaked
attr(future, "untweakable") <- c(
  "asynchronous",  ## reserved
  "conditions",
  "envir",
  "expr",
  "globals",
  "lazy",
  "local",
  "packages",
  "seed",
  "stdout",
  "substitute",
  "version"        ## for internal backend use
)

## Hidden arguments to 'future' strategy that my also be tweaked
attr(future, "tweakable") <- c("earlySignal", "split", "maxSizeOfObjects")
