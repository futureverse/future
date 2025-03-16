#' Interrupts a running future
#'
#' Attempts to interrupt a running future. If the backend does
#' not support interrupting futures, nothing is done.
#'
#' @param x A Future.
#'
#' @param \ldots All arguments used by the S3 methods.
#'
#' @return
#' `interrupt()` returns the [Future] flagged as "interrupted",
#' if the backend supports interrupting futures.
#'
#' @export
interrupt <- function(x, ...) {
  UseMethod("interrupt")
}


#' @export
interrupt.Future <- function(x, ...) {
  future <- x

  ## Nothing to do?
  if (future[["state"]] != "running") {
    return(future)
  }

  backend <- future[["backend"]]
  if (is.null(backend)) {
    stop(FutureError("Interruption of futures require a backend implementing the FutureBackend API: ", sQuote(class(x)[1])))
  }

  interruptFuture(backend, future = future, ...)
} ## interrupt() for Future
