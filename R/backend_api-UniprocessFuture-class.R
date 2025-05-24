#' An uniprocess future is a future whose value will be resolved synchronously in the current process
#'
#' @inheritParams Future-class
#' 
#' @param \ldots Additional named elements passed to [Future()].
#'
#' @return
#' `UniprocessFuture()` returns an object of class `UniprocessFuture`.
#'
#' @export
#' @name UniprocessFuture-class
#' @keywords internal
UniprocessFuture <- function(expr = NULL, substitute = TRUE, envir = parent.frame(), ...) {
  if (substitute) expr <- substitute(expr)

  future <- Future(expr = expr, substitute = FALSE, envir = envir, asynchronous = FALSE, ...)
  future <- structure(future, class = c("UniprocessFuture", class(future)))
  future
}


#' @export
run.UniprocessFuture <- function(future, ...) {
  debug <- isTRUE(getOption("future.debug"))
   
  if (future[["state"]] != 'created') {
    label <- sQuoteLabel(future)
    stop(FutureError(sprintf("A future (%s) can only be launched once", label), future = future))
  }

  ## Assert that the process that created the future is
  ## also the one that evaluates/resolves/queries it.
  assertOwner(future)

  ## Run future
  future[["state"]] <- 'running'
  data <- getFutureData(future, debug = debug)
  future[["result"]] <- evalFuture(data)
  future[["state"]] <- 'finished'

  if (debug) mdebugf("%s started (and completed)", class(future)[1])

  ## Always signal immediateCondition:s and as soon as possible.
  ## They will always be signaled if they exist.
  signalImmediateConditions(future)

  ## Signal conditions early, iff specified for the given future
  signalEarly(future, collect = FALSE)

  future
}


#' @export
result.UniprocessFuture <- function(future, ...) {
  ## Has the result already been collected?
  result <- future[["result"]]
  if (!is.null(result)) {
    if (inherits(result, "FutureError")) stop(result)
    return(result)
  }
  
  if (future[["state"]] == "created") {
    ## Make sure that run() does not signal errors
    earlySignal <- future[["earlySignal"]]
    future[["earlySignal"]] <- FALSE
    run(future)
    future[["earlySignal"]] <- earlySignal
  }

  result <- future[["result"]]
  if (inherits(result, "FutureResult")) {
    ## Assert result is for the expected future
    assertFutureResult(future)
    return(result)
  }

  ex <- UnexpectedFutureResultError(future)
  future[["result"]] <- ex
  stop(ex)
}


#' @export
resolved.UniprocessFuture <- function(x, ...) {
  if (x[["lazy"]]) {
    ## resolved() for lazy uniprocess futures must force result()
    ## such that the future gets resolved.  The reason for this
    ## is so that polling is always possible, e.g.
    ## while(!resolved(f)) Sys.sleep(5);
    result(x)
  }
  NextMethod()
}
