#' Signals Captured Conditions
#'
#' Captured conditions that meet the `include` and `exclude`
#' requirements are signaled _in the order as they were captured_.
#'
#' @param future A resolved \link{Future}.
#'
#' @param include A character string of \link[base:conditions]{condition}
#' classes to signal.
#'
#' @param exclude A character string of \link[base:conditions]{condition}
#' classes _not_ to signal.
#'
#' @param resignal If TRUE, then already signaled conditions are signaled
#' again, otherwise not.
#'
#' @param \dots Not used.
#'
#' @return Returns the [Future] where conditioned that were signaled
#' have been flagged to have been signaled.
#'
#' @seealso
#' Conditions are signaled by
#' \code{\link[base:conditions]{signalCondition}()}.
#'
#' @keywords internal
signalConditions <- function(future, include = "condition", exclude = NULL, resignal = TRUE, ...) {
  ## Future is not yet launched
  if (!future$state %in% c("finished", "failed")) {
    stop(FutureError(
      sprintf(
        "Internal error: Cannot resignal future conditions. %s has not yet been resolved (state = %s)",
        class(future)[1], paste(sQuote(future$state), collapse = ", ")),
      future = future))
  }

  ## Nothing to do?
  if (length(include) == 0L) return(invisible(future))
  
  result <- result(future)
  stop_if_not(inherits(result, "FutureResult"))
  
  conditions <- result$conditions
  
  ## Nothing to do
  if (length(conditions) == 0) return(invisible(future))

  debug <- getOption("future.debug", FALSE)

  if (debug) {
    mdebug("signalConditions() ...")
    mdebug(" - include = ", paste(sQuote(include), collapse = ", "))
    mdebug(" - exclude = ", paste(sQuote(exclude), collapse = ", "))
    mdebug(" - resignal = ", resignal)
    mdebug(" - Number of conditions: ", length(conditions))
    on.exit(mdebug("signalConditions() ... done"))
  }


  ## Signal detected conditions one by one
  signaled <- logical(length(conditions))
  for (kk in seq_along(conditions)) {
    cond <- conditions[[kk]]

    ## Skip already signaled conditions?
    if (!resignal && !is.null(cond$signaled) && cond$signaled > 0L) next
    
    condition <- cond$condition

    ## Don't signal condition based on 'exclude'?
    if (length(exclude) > 0L && inherits(condition, exclude)) next
    
    ## Don't signal condition based on 'include'?
    if (length(include) > 0L && !inherits(condition, include)) next

    mdebugf(" - Condition #%d: %s", kk, paste(sQuote(class(condition)), collapse = ", "))

    ## Flag condition as signaled
    cond$signaled <- cond$signaled + 1L
    conditions[[kk]] <- cond
    
    if (inherits(condition, "error")) {
      ## Make sure to update 'signaled' information before we exit.
      ## Note, 'future' is an environment.
      result$conditions <- conditions
      future$result <- result
      
      ## SPECIAL: By default, don't add 'future.info' because it
      ## modifies the error object, which may break things.
      if (debug && !"future.info" %in% names(condition)) {
        ## Recreate the full call stack
        cond$calls <- c(future$calls, cond$calls)
        condition$future.info <- cond
      }
      stop(condition)
    } else if (inherits(condition, "warning")) {
      warning(condition)
    } else if (inherits(condition, "message")) {
      message(condition)
    } else if (inherits(condition, "condition")) {
      signalCondition(condition)
    } else {
      stop_if_not(inherits(condition, "condition"))
    }
    signaled[kk] <- TRUE
  }

  ## Drop captured and signalled conditions to save memory?
  if (isTRUE(attr(future$conditions, "drop"))) {
    conditions <- conditions[!signaled]
  }

  ## Make sure to update 'signaled' information on exit
  result$conditions <- conditions
  future$result <- result

  invisible(future)
}


signalImmediateConditions <- function(future, include = getOption("future.relay.immediate", "immediateCondition"), resignal = FALSE, ...) {
  if (length(include) == 0L) return(invisible(future))
  signalConditions(future, include = include, resignal = resignal, ...)
}


make_signalConditionsASAP <- function(nx, stdout = TRUE, signal = TRUE, force = FALSE, debug = getOption("future.debug", FALSE)) {
  relay <- (stdout || signal)
  if (!relay && !force) return(function(...) TRUE)

  relayed <- rep(FALSE, times = nx)
  queue <- vector("list", length = nx)
    
  function(obj = NULL, ..., resignal = FALSE, pos) {
    if (debug) {
      mdebugf("signalConditionsASAP(%s, pos=%d) ...", class(obj)[1], pos)
      mdebugf("- nx: %d", nx)
      mdebugf("- relay: %s", relay)
      mdebugf("- stdout: %s", stdout)
      mdebugf("- signal: %s", signal)
      mdebugf("- resignal: %s", resignal)
      mdebugf("- force: %s", force)
      mdebugf("- relayed: [n=%d] %s", length(relayed), paste(relayed, collapse = ", "))
      mdebugf("- queued futures: [n=%d] %s", length(queue), paste(vapply(queue, FUN = inherits, "Future", FUN.VALUE = FALSE), collapse = ", "))
      on.exit({
        mdebugf("- relayed: [n=%d] %s", length(relayed), paste(relayed, collapse = ", "))
        mdebugf("- queued futures: [n=%d] %s", length(queue), paste(vapply(queue, FUN = inherits, "Future", FUN.VALUE = FALSE), collapse = ", "))
        mdebugf("signalConditionsASAP(%s, pos=%d) ... done", class(obj)[1], pos)
      })
    }

    if (force) resignal <- TRUE
    
    ## Flush all?
    if (pos == 0L) {
      if (debug) message(" - flush all")
      for (ii in which(!relayed)) {
        if (relayed[ii]) next
        if (debug) mdebugf(" - relaying element #%d", ii)
        obj <- queue[[ii]]
        stop_if_not(inherits(obj, "Future"))
        if (stdout) value(obj, stdout = TRUE, signal = FALSE)
        if (signal) {
          ## Always signal immediateCondition:s and as soon as possible.
          ## They will always be signaled if they exist.
          signalImmediateConditions(obj)
    
          ## Signal all other types of condition
          signalConditions(obj, exclude = getOption("future.relay.immediate", "immediateCondition"), resignal = resignal, ...)
        }
        relayed[ii] <<- TRUE
      }
      ## Assert that everything has been relayed
      stop_if_not(all(relayed))
      return(TRUE)
    }
      
    stop_if_not(pos >= 1L, pos <= nx)

    ## Add to queue?
    if (inherits(obj, "Future")) {
      queue[[pos]] <<- obj
    } else {
      relayed[pos] <<- TRUE
    }
    
    ## How far may we flush the queue?
    until <- which(relayed)
    n <- length(until)
    until <- if (n == 0L) 1L else min(until[n] + 1L, length(queue))
    if (debug) mdebugf(" - until=%d", until)
    for (ii in seq_len(until)) {
      if (relayed[ii]) next
      if (debug) mdebugf(" - relaying element #%d", ii)
      obj <- queue[[ii]]
      if (inherits(obj, "Future")) {
        if (stdout) value(obj, stdout = TRUE, signal = FALSE)
        if (signal) {
          ## Always signal immediateCondition:s and as soon as possible.
          ## They will always be signaled if they exist.
          signalImmediateConditions(obj)
    
          ## Signal all other types of condition
          signalConditions(obj, exclude = getOption("future.relay.immediate", "immediateCondition"), resignal = resignal, ...)
        }
        relayed[ii] <<- TRUE
      }
    }

    ## Was the added object relayed?
    relayed[pos]
  }
} ## make_signalConditionsASAP()



muffleCondition <- function(cond, pattern = "^muffle") {
  inherits <- base::inherits
  invokeRestart <- base::invokeRestart
  is.null <- base::is.null

  muffled <- FALSE
  if (inherits(cond, "message")) {
    muffled <- grepl(pattern, "muffleMessage")
    if (muffled) invokeRestart("muffleMessage")
  } else if (inherits(cond, "warning")) {
    muffled <- grepl(pattern, "muffleWarning")
    if (muffled) invokeRestart("muffleWarning")
  } else if (inherits(cond, "condition")) {
    if (!is.null(pattern)) {
      computeRestarts <- base::computeRestarts
      grepl <- base::grepl
  
      ## If there is a "muffle" restart for this condition,
      ## then invoke that restart, i.e. "muffle" the condition
      restarts <- computeRestarts(cond)
      for (restart in restarts) {
        name <- restart$name
        if (is.null(name)) next
        if (!grepl(pattern, name)) next
        invokeRestart(restart)
        muffled <- TRUE
        break
      }
    }
  }

  invisible(muffled)
} ## muffleCondition()
