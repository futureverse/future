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
#' @examplesIf (interactive() || .Platform[["OS.type"]] != "windows")
#' ## Set up two parallel workers
#' plan(multisession, workers = 2)
#' 
#' ## Launch two long running futures
#' fs <- lapply(c(1, 2), function(duration) {
#'   future({
#'     Sys.sleep(duration)
#'     42
#'   })
#' })
#' 
#' ## Wait until at least one of the futures is resolved
#' while (!any(resolved(fs))) Sys.sleep(0.1)
#' 
#' ## Cancel the future that is not yet resolved
#' r <- resolved(fs)
#' cancel(fs[!r])
#' 
#' ## Get the value of the resolved future
#' f <- fs[r]
#' v <- value(f)
#' message("Result: ", v)
#' 
#' ## The value of the canceled future is an error
#' try(v <- value(fs[!r]))
#' 
#' ## Shut down parallel workers
#' plan(sequential)
#'
#' @seealso
#' A canceled future can be [reset()] to a lazy, vanilla future
#' such that it can be relaunched, possibly on another future backend.
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

  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebugf_push("cancel(<%s>, interrupt = %s) ...", class(future)[1], interrupt)
    on.exit(mdebug_pop())
  }
  
  ## Only submitted or running futures can be canceled, ignore everything else
  if (!future[["state"]] %in% c("submitted", "running")) {
    if (debug) mdebug("Skipping, because not a submitted or a running future")
    return(invisible(future))
  }

  future[["actions"]] <- c(future[["actions"]], "cancel")

  if (interrupt) {
    backend <- future[["backend"]]
    if (is.null(backend)) {
      stop(FutureError(sprintf("Interruption of futures require a backend implementing the FutureBackend API: %s", sQuote(class(future)[1]))))
    }
    if (isTRUE(backend[["interrupts"]])) {
      future[["actions"]] <- c(future[["actions"]], "interrupt")
      local({
        if (debug) {
          mdebugf_push("interruptFuture(<%s>, future = <%s>, ...) ...", class(backend)[1], class(future)[1])
          on.exit(mdebug_pop())
        }
        interruptFuture(backend, future = future, ...)
      })
    } else {
      if (debug) mdebugf("Ignoring the interrupt request, because interrupts have been disabled for this backend")
    }
  }

  future[["state"]] <- "canceled"

  invisible(future)
}
