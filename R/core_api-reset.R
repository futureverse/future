#' Reset a finished, failed, or interrupted future to a lazy future
#'
#' A future that has successfully completed, has been interrupted, or
#' failed due to an error, can be relaunched after resetting it.
#'
#' @param x A Future.
#'
#' @param \ldots Not used.
#'
#' @return
#' `reset()` returns a lazy, vanilla [Future] that can be relaunched.
#' Resetting a running future results in a [FutureError].
#'
#' @example incl/reset.R
#'
#' @export
reset <- function(x, ...) {
  UseMethod("reset")
}


#' @export
reset.default <- function(x, ...) {
  x
}

#' @export
reset.list <- function(x, ...) {
  lapply(x, FUN = reset, ...)
}


#' @export
reset.environment <- function(x, ...) {
  fs <- futures(x)
  names <- names(fs)
  fs <- as.list(fs)
  names(fs) <- names
  reset(fs, ...)
}


#' @export
reset.Future <- function(x, ...) {
  future <- x

  if (future[["state"]] == "running") {
    stop(FutureError("Cannot reset a running future", future = future))
  }
  
  core_fields <- c(
    "version",
    "expr",
    "envir",
    "stdout",
    "conditions",
    "globals",
    "packages",
    "seed",
    "lazy",
    "asynchronous",
    "local",
    "reset",
    "label",
    "earlySignal",
    "gc",
    "onReference",
    "calls",
    "state"
  )
  
  class(future) <- "Future"

  drop <- setdiff(names(future), core_fields)
  for (name in drop) {
    future[[name]] <- NULL
  }

  future[["state"]] <- "created"
  future[["lazy"]] <- TRUE
  
  future
} ## reset() for Future
