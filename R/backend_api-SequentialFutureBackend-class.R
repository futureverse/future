#' A SequentialFutureBackend resolves futures sequentially in the current R session
#'
#' @inheritParams FutureBackend
#'
#' @details
#' The `SequentialFutureBackend` is selected by `plan(sequential)`.
#'
#' @keywords internal
#' @rdname FutureBackend
#' @export
SequentialFutureBackend <- function(...) {
  core <- FutureBackend(...)
  core[["futureClasses"]] <- c("SequentialFuture", "UniprocessFuture", core[["futureClasses"]])
  core <- structure(core, class = c("SequentialFutureBackend", class(core)))
  core
}


#' @export
launchFuture.SequentialFutureBackend <- function(backend, future, ...) {
  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebugf("launchFuture() for %s ...", commaq(class(backend)))
    on.exit(mdebugf("launchFuture() for %s ... DONE", commaq(class(backend))))
  }

  ## Get future
  data <- getFutureData(future, debug = debug)

  ## Apply backend tweaks
  split <- backend[["split"]]
  if (!is.null(split)) data[["capture"]][["split"]] <- split

  ## Launch future
  future[["state"]] <- "running"
  future[["result"]] <- evalFuture(data)
  future[["state"]] <- "finished"

  if (debug) mdebugf("%s started (and completed)", class(future)[1])

  ## Always signal immediateCondition:s and as soon as possible.
  ## They will always be signaled if they exist.
  signalImmediateConditions(future)

  ## Signal conditions early, iff specified for the given future
  signalEarly(future, collect = FALSE)

  future
}
