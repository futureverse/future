#' Cancel a future
#'
#' Cancels futures, with the option to interrupt running ones.
#' A future can be canceled regardless of it is resolved or not.
#' Calling `value()` on a canceled future throws a [FutureInterruptError].
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
#' @examplesIf (interactive() || .Platform[["OS.type"]] != "windows")
#' ## Set up two parallel workers
#' plan(multisession, workers = 2)
#' 
#' ## Launch two long running future
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

  state <- future[["state"]]

  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebugf_push("cancel(<%s>, interrupt = %s) ...", class(future)[1], interrupt)
    mdebugf("State: %s", sQuote(state))
    mdebugf("interrupt: %s", sQuote(interrupt))
    on.exit(mdebug_pop())
  }

  ## Already canceled?
  if ("canceled" %in% future[["actions"]]) {
    if (debug) mdebug("Future has already been canceled")
    return(invisible(future))
  }

  future[["actions"]] <- c(future[["actions"]], "cancel")

  ## A non-submitted future?
  if (state %in% c("created")) {
    msg <- sprintf("Lazy future was canceled on host %s at %s", sQuote(Sys.info()[["nodename"]]), format(Sys.time()))
    error <- FutureCanceledError(msg, future = future, drop = TRUE)
    condition <- list(condition = error, signaled = 0L)
    result <- FutureResult(conditions = list(condition), uuid = future[["uuid"]])
    future[["result"]] <- result
    future[["state"]] <- "finished"
    future <- structure(future, class = c("ConstantFuture", class(future)))
    return(invisible(future))
  }

  ## Already interrupted?
  ## FIXME: Some backends does not support changing state to 'canceled' here,
  ## e.g. future.mirai
  if (state %in% c("interrupted")) {
    if (debug) mdebug("Future is interrupted, i.e. already canceled")
#    future[["state"]] <- "finished"
    return(invisible(future))
  }

  ## Is the future submitted or currently running?
  if (state %in% c("submitted", "running")) {
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
  }

  ## Cancelling an finished or a failed future
  result <- future[["result"]]
  if (is.null(result)) {
#    msg <- sprintf("Future in state %s was canceled", sQuote(state))
#    error <- FutureCanceledError(msg, future = future, drop = TRUE)
#    if (!inherits(future, c("MulticoreFuture", "MultisessionFuture"))) {
#    cat("**************************************\n")
#    str(class(future))
#    cat("**************************************\n")
#      future[["result"]] <- error
#    }
  } else {
    conditions <- result[["conditions"]]
    n <- length(conditions)
    if (n > 0) {
      condition <- conditions[[n]]
      cond <- condition[["condition"]]
    } else {
      cond <- NULL
    }
    if (!inherits(cond, "FutureInterruptError")) {
      msg <- sprintf("Future in state %s was canceled", sQuote(state))
      error <- FutureCanceledError(msg, future = future, drop = TRUE)
      condition <- list(condition = error, signaled = 0L)
      conditions[[n + 1]] <- condition
      result[["conditions"]] <- conditions
      if (!inherits(future, "MiraiFuture")) {
        future[["result"]] <- result
      }
    }
  }

  future[["state"]] <- "finished"
  invisible(future)
}
