signalEarly <- function(future, collect = TRUE, .signalEarly = TRUE, ...) {
  ## Don't signal early?
  if (!isTRUE(future[["earlySignal"]])) return(future)

  ## Future is not yet launched
  if (future[["state"]] == "created") return(future)

  debug <- isTRUE(getOption("future.debug"))
  if (debug) mdebug_push("signalEarly() ...")

  ## Nothing to do?
  if (!collect && !resolved(future, .signalEarly = FALSE)) {
    if (debug) {
      mdebug("Future not resolved and collect = FALSE. Skipping")
      mdebug_pop()
    }
    return(future)
  }
  
  result <- result(future)
  stop_if_not(inherits(result, "FutureResult"))
  
  conditions <- result[["conditions"]]
  
  ## Nothing to do?
  if (!.signalEarly || length(conditions) == 0L) {
    if (debug) {
      if (!.signalEarly) mdebug("Skipping because .signalEarly = FALSE")
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
