#' Cancel one or more futures
#'
#' Cancels futures, with the option to interrupt running ones.
#' A canceled future is invalid, e.g. calling [value()] on it produces
#' an error. `cancel()` is vectorized, i.e. accepts a set of futures to
#' be canceled.
#'
#' @param x A [Future], a list, an environment, or a list environment
#' (\link[listenv:listenv]{listenv}). Lists and environments may hold
#' a mix of futures and non-future elements, and may be nested, e.g.
#' a list of lists of futures; every future found, at any depth, is
#' canceled.
#'
#' @param interrupt If TRUE, running futures are interrupted, if the
#' future backend supports it.
#'
#' @param \ldots All arguments used by the S3 methods.
#'
#' @return
#' `cancel()` returns (invisibly) `x` after canceling every [Future]
#' therein, that is, after flagging each one as "canceled" and
#' possibly interrupting it as well. If `x` is not a future, or holds
#' non-futures, such elements are unaffected.
#'
#' @details
#' A canceled future is invalid. Calling [value()] on it produces a
#' [FutureCanceledError], which inherits from [FutureInterruptError].
#' A [FutureInterruptError] can happen also for external reasons. The
#' cancelation error is signaled regardless of:
#'
#'  * `interrupt`, that is, also when `interrupt = FALSE`, or when the
#'    future backend does not support interrupts;
#'
#'  * the state of the future, that is, if it is non-launched, running,
#'    finished;
#'
#'  * the future would have produced a value or an error or not.
#'
#' If the future is not interrupted, its parallel worker keeps processing
#' it until it is done, when the result is collected and immediately
#' discarded.
#'
#' To keep the value of a future that is already resolved, which still
#' canceling others, use something like `cancel(fs[!resolved(fs)])`.
#'
#' Canceling an already canceled future, or an interrupted one has no
#' effect. Neither has canceling a future that was dropped using
#' `value(..., drop = TRUE)`.
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
#' ## Cancel futures that are not yet resolved
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
  
  ## Ignore canceled, interrupted, or dropped futures
  state <- future[["state"]]
  if (!state %in% c("created", "submitted", "running", "finished", "failed") ||
      inherits(future, "DroppedFuture")) {
    if (debug) mdebug("Skipping, because a canceled, interrupted, or dropped future")
    return(invisible(future))
  }

  future[["actions"]] <- c(future[["actions"]], "cancel")

  ## Cancel also lazy futures
  if (state == "created") {
    canceledFutureError(future)
    return(invisible(future))
  }

  ## Only futures that are still active can be interrupted
  active <- state %in% c("submitted", "running")
  if (interrupt && active) {
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
