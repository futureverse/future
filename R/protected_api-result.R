#' @export
#' @keywords internal
result <- function(future, ...) {
  ## Automatically update journal entries for Future object
  if (inherits(future, "Future") &&
      inherits(future[[".journal"]], "FutureJournal")) {
    start <- Sys.time()
    on.exit({
      appendToFutureJournal(future,
           event = "gather",
        category = "overhead",
           start = start,
            stop = Sys.time()
      )

      ## Signal FutureJournalCondition?
      if (!isTRUE(future[[".journal_signalled"]])) {
        journal <- journal(future)
        label <- sQuoteLabel(future)
        msg <- sprintf("A future (%s) of class %s was resolved", label, class(future)[1])
        cond <- FutureJournalCondition(message = msg, journal = journal) 
        signalCondition(cond)
        future[[".journal_signalled"]] <- TRUE
      }
    })
  }
  UseMethod("result")
}

#' Get the results of a resolved future
#'
#' @param future A \link{Future}.
#' @param \ldots Not used.
#'
#' @return The [FutureResult] object.
#' It may signal a [FutureError], if there is a significant orchestration
#' error. For example, if the parallel worker process terminated abruptly
#' ("crashed"), then a [FutureInterruptError] is signaled.
#'
#' @details
#' This function is only part of the _backend_ Future API.
#' This function is _not_ part of the frontend Future API.
#'
#' @aliases result
#' @rdname result
#' @export
#' @keywords internal
result.Future <- function(future, ...) {
  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebugf_push("result() for %s (%s) ...", sQuote(class(future)[1]), sQuoteLabel(future))
    mdebug("state: ", sQuote(future[["state"]]))
    on.exit(mdebugf_pop())
  }
  
  ## Has the result already been collected?
  result <- future[["result"]]
  if (!is.null(result)) {
    ## Assert result is for the expected future
    assertFutureResult(future)
    
    ## Always signal immediateCondition:s and as soon as possible.
    ## They will always be signaled if they exist.
    signalImmediateConditions(future)

    if (inherits(result, "FutureError")) stop(result)
    return(result)
  }

  future[["actions"]] <- c(future[["actions"]], "result")
  
  if (future[["state"]] == "created") {
    future <- run(future)
  }

  if (!future[["state"]] %in% c("finished", "failed", "canceled", "interrupted")) {
    ## BACKWARD COMPATIBILITY:
    ## For now, it is value() that collects the results.  Later we want
    ## all future backends to use result() to do it. /HB 2018-02-22
    value(future, stdout = FALSE, signal = FALSE)

    ## Always signal immediateCondition:s and as soon as possible.
    ## They will always be signaled if they exist.
    signalImmediateConditions(future)
  }

  result <- future[["result"]]
  if (inherits(result, "FutureResult")) {
    ## Assert result is for the expected future
    assertFutureResult(future)
    return(result)
  }

  ## BACKWARD COMPATIBILITY
  result <- future[["value"]]
  if (inherits(result, "FutureResult")) {
    ## Assert result is for the expected future
    assertFutureResult(future)
    return(result)
  }

  version <- future[["version"]]
  if (is.null(version)) {
    warning(FutureWarning("Future version was not set. Using default %s",
                          sQuote(version)))
  }

  ## Sanity check
  if (is.null(result) && version == "1.8") {
    if (inherits(future, "MulticoreFuture")) {
      label <- sQuoteLabel(future)
      msg <- sprintf("A future (%s) of class %s did not produce a FutureResult object but NULL. This suggests that the R worker terminated (crashed?) before the future expression was resolved.", label, class(future)[1])
      stop(FutureError(msg, future = future))
    }
  }

  .Defunct(msg = "Future objects with an internal version of 1.7 or earlier are defunct. This error is likely coming from a third-party package or other R code. Please report this to the maintainer of the 'future' package so this can be resolved.", package = .packageName)
}
