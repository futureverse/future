#' Cancel a future
#'
#' Cancels futures, with the option to interrupt running ones.
#'
#' @param x A Future.
#'
#' @param interrupt If TRUE, running futures are interrupted, if the
#' future backend supports it.
#'
#' @param \ldots All arguments used by the S3 methods.
#'
#' @return
#' `cancel()` returns (invisibly) the canceled [Future]s after
#' flagging them as "canceled" and possibly interrupting them as well.
#'
#' Canceling a lazy or a finished future has no effect.
#'
#' @example incl/cancel.R
#'
#' @seealso
#' A canceled future can be [reset()] to a lazy, vanilla future
#' such that it can be relaunched, possible on another future backend.
#'
#' @export
cancel <- function(x, interrupt = TRUE, ...) {
  UseMethod("cancel")
}

#' @export
cancel.default <- function(x, ...) {
  invisible(x)
}

#' @export
cancel.list <- function(x, ...) {
  invisible(lapply(x, FUN = cancel, ...))
}

#' @export
cancel.listenv <- cancel.list


#' @importFrom listenv as.listenv
#' @export
cancel.environment <- function(x, ...) {
  invisible(cancel(as.listenv(x), ...))
}


#' @export
cancel.Future <- function(x, interrupt = TRUE, ...) {
  future <- x

  ## Only running futures can be canceled, ignore everything else
  if (future[["state"]] != "running") {
    return(future)
  }

  if (interrupt) {
    backend <- future[["backend"]]
    if (is.null(backend)) {
      stop(FutureError("Interruption of futures require a backend implementing the FutureBackend API: ", sQuote(class(future)[1])))
    }
    interruptFuture(backend, future = future, ...)
  }

  future[["state"]] <- "canceled"

  invisible(future)
}
