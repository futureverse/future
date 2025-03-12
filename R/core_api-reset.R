#' Reset an finished future to a lazy future
#'
#' A future that has successfully completed, has been interrupted, or
#' failed due to an error, can be relaunched by first resetting it.
#'
#' @param x A Future.
#'
#' @param \ldots All arguments used by the S3 methods.
#' @return
#' `reset()` returns a lazy, vanilla [Future] that can be relaunched.
#'
#' @example incl/reset.R
#'
#' @export
reset <- function(x, ...) {
  UseMethod("reset")
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

