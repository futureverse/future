#' Signals collected conditions for futures flagged for early signaling
#'
#' @param future A [Future] object.
#'
#' @param \ldots ... Not used.
#'
#' @return The `future` object.
#'
#' @details
#' This function returns immediately ("no-op"), if the future (i) is _not_
#' flagged for early signaling, or (ii) not resolved.
#' Otherwise, the future results are collected and any captured conditions
#' are signaled, unless they have been signaled previously.
#'
#' @noRd
signalEarly <- function(future, ...) {
  ## Don't signal early?
  if (!isTRUE(future[["earlySignal"]])) return(future)

  ## Future is not yet launched
  if (future[["state"]] == "created") return(future)

  debug <- isTRUE(getOption("future.debug"))
  if (debug) mdebug_push("signalEarly() ...")
  
  result <- result(future)
  stop_if_not(inherits(result, "FutureResult"))
  
  conditions <- result[["conditions"]]
  
  ## Nothing to do?
  if (length(conditions) == 0L) {
    if (debug) {
      if (length(conditions) == 0L) mdebug("No conditions to signal")
      mdebug_pop()
    }
    return(future)
  }
  
  if (debug) {
    conditionClasses <- vapply(conditions,
                               FUN = function(c) class(c[["condition"]])[1],
                               FUN.VALUE = NA_character_)
    mdebugf("signalEarly(): Condition classes = [n=%s] %s",
           length(conditionClasses), hpaste(sQuote(conditionClasses)))
  }

  signalConditions(future, resignal = FALSE)
  
  if (debug) mdebug_pop()

  future
}
