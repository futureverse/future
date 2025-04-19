#' Cancel a future
#'
#' Cancels futures, with the option to interrupt running ones.
#'
#' @param x A Future.
#'
#' @param interrupt If TRUE, running futures are interrupted, if possible.
#'
#' @param \ldots All arguments used by the S3 methods.
#'
#' @return
#' `cancel()` returns the [Future] flagged as "cancelled".
#'
#' @export
cancel <- function(x, interrupt = TRUE, ...) {
  UseMethod("cancel")
}

#' @export
cancel.default <- function(x, ...) {
  x
}

#' @export
cancel.list <- function(x, ...) {
  lapply(x, FUN = cancel, ...)
}

#' @export
cancel.listenv <- cancel.list


#' @importFrom listenv as.listenv
#' @export
cancel.environment <- function(x, ...) {
  cancel(as.listenv(x), ...)
}


#' @export
cancel.Future <- function(x, interrupt = TRUE, ...) {
  future <- x

  if (interrupt) {
    future <- interrupt(future)
  }

  future
}
