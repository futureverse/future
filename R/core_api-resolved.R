#' Check whether a future is resolved or not
#'
#' @param x A \link{Future}, a list, or an environment (which also
#' includes \link[listenv:listenv]{list environment}).
#'
#' @param \ldots Not used.
#'
#' @return
#' A logical vector of the same length and dimensions as `x`.
#' Each element is TRUE unless the corresponding element is a
#' non-resolved future in case it is FALSE.
#' It never signals an error.
#'
#' @details
#' `resolved()` attempts to launch a lazy future, if there is an available
#' worker, otherwise not.
#'
#' `resolved()` methods must always return `TRUE` or `FALSE` values, must
#' always launch lazy futures, and must never block indefinitely. This is
#' because it should always be possible to poll futures until they are
#' resolved using `resolved()`, e.g.
#' `while (!all(resolved(futures))) Sys.sleep(5)`.
#'
#' Each future backend must implement a `resolved()` method. It should return
#' either TRUE or FALSE, or throw a [FutureError] (which indicate a
#' significant, often unrecoverable infrastructure problem, or an interrupt).
#'
#' @export
resolved <- function(x, ...) {
  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebug_push("resolved() ...")
    on.exit(mdebugf_pop())
  }
  
  ## Automatically update journal entries for Future object
  if (inherits(x, "Future") &&
      inherits(x[[".journal"]], "FutureJournal")) {
    start <- Sys.time()
    on.exit({
      appendToFutureJournal(x,
        event = "resolved",
        category = "querying",
        start = start,
        stop = Sys.time(),
        skip = FALSE
      )
    }, add = TRUE)
  }
  
  UseMethod("resolved")
}

#' @return
#' The default method always returns TRUE.
#'
#' @rdname resolved
#' @export
resolved.default <- function(x, ...) TRUE


#' @rdname resolved
#' @export
resolved.list <- function(x, ...) {
  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebugf_push("resolved() for %s ...", class(x)[1])
    if (debug) mdebugf("Number of elements: %d", length(x))
    on.exit(mdebugf_pop())
  }
  
  fs <- futures(x)
  n_fs <- length(fs)
  if (debug) mdebugf("Number of futures: %d", n_fs)
  
  ## Allocate results. Assume everything
  ## is resolved unless not.
  res <- rep(TRUE, times = n_fs)
  for (ii in seq_along(fs)) {
    f <- fs[[ii]]
    if (inherits(f, "Future")) res[[ii]] <- resolved(f, ...)
  }

  stop_if_not(length(res) == n_fs)

  dim <- dim(fs)
  if (!is.null(dim)) {
    dim(res) <- dim
    ## Preserve dimnames and names
    dimnames(res) <- dimnames(fs)
  }
  names(res) <- names(fs)

  stop_if_not(length(res) == n_fs)

  res
}


#' @rdname resolved
#' @export
resolved.environment <- function(x, ...) {
  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebugf_push("resolved() for %s ...", class(x)[1])
    on.exit(mdebugf_pop())
  }
  fs <- futures(x)
  n_fs <- length(fs)
  names <- names(fs)
  fs <- as.list(fs)
  names(fs) <- names
  stop_if_not(length(fs) == n_fs)
  fs <- resolved(fs, ...)
  stop_if_not(length(fs) == n_fs)
  fs
}


#' @rdname resolved
#' @export
resolved.Future <- function(x, ...) {
  future <- x
  args <- list(...)
  run <- args[["run"]]

  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebugf_push("resolved() for %s (%s) ...", class(future)[1], sQuoteLabel(future))
    on.exit(mdebug_pop())
    mdebug("state: ", sQuote(future[["state"]]))
    mdebug("run: ", deparse(run))
  }

  if (!is.null(run)) {
    deprecateArgument("resolved", "run", run)
  }

  ## A lazy future not even launched?
  if (future[["state"]] == "created") {
    if (isFALSE(run)) return(FALSE)
    if (debug) mdebug_push("run() ...")
    future <- run(future)
    if (debug) {
      mdebug_pop()
      mdebug_push("resolved() ...")
    }
    res <- resolved(future, ...)
    if (debug) {
      mdebug("resolved: ", res)
      mdebug_pop()
    }
    return(res)
  }

  ## Signal conditions early, iff specified for the given future
  ## Note, this will block, which is intentional
  signalEarly(future)

  if (debug) mdebug("result: ", sQuote(class(future[["result"]])[1]))
  if (inherits(future[["result"]], "FutureResult")) return(TRUE)
  
  res <- (future[["state"]] %in% c("finished", "failed", "canceled", "interrupted"))

  if (debug) mdebug("resolved: ", res)

  res
}
