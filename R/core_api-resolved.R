#' Check whether a future is resolved or not
#'
#' @param x A \link{Future}, a list, or an environment (which also
#' includes \link[listenv:listenv]{list environment}).
#'
#' @param run (logical) If TRUE, any lazy futures is launched,
#' otherwise not.
#'
#' @param \ldots Not used.
#'
#' @return
#' A logical vector of the same length and dimensions as `x`.
#' Each element is TRUE unless the corresponding element is a
#' non-resolved future in case it is FALSE.
#'
#' @details
#' `resolved(..., run = TRUE)` attempts to launch a lazy future, if there is
#' an available worker, otherwise not.
#'
#' `resolved()` methods must always return `TRUE` or `FALSE` values, must
#' always launch lazy futures by default (`run = TRUE`), and must never block
#' indefinitely. This is because it should always be possible to poll futures
#' until they are resolved using `resolved()`, e.g.
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
