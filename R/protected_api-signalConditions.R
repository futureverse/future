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
#' @param \ldots Not used.
#'
#' @return Returns the [Future] where conditioned that were signaled
#' have been flagged to have been signaled.
#'
#' @seealso
#' Conditions are signaled by
#' \code{\link[base:conditions]{signalCondition}()}.
#'
#' @importFrom utils capture.output str
#' @keywords internal
signalConditions <- function(future, include = "condition", exclude = NULL, resignal = TRUE, ...) {
  ## Nothing to do?
  if (length(include) == 0L) return(future)

  ## Future is not yet launched
  if (!future[["state"]] %in% c("finished", "failed", "interrupted", "canceled")) {
    stop(FutureError(
      sprintf(
        "Internal error: Cannot resignal future conditions. %s has not yet been resolved (state = %s)",
        class(future)[1], paste(sQuote(future[["state"]]), collapse = ", ")),
      future = future))
  }

  result <- result(future)
  stop_if_not(inherits(result, "FutureResult"))

  conditions <- result[["conditions"]]

  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebug_push("signalConditions() ...")
    mdebug("include = ", paste(sQuote(include), collapse = ", "))
    mdebug("exclude = ", paste(sQuote(exclude), collapse = ", "))
    mdebug("resignal = ", resignal)
    mdebug("Number of conditions: ", length(conditions))
    mstr(length(conditions))
    on.exit(mdebug_pop())
  }

  ## Nothing to do
  if (length(conditions) == 0) return(future)

  ## Signal detected conditions one by one
  signaled <- logical(length(conditions))
  for (kk in seq_along(conditions)) {
    cond <- conditions[[kk]]
    condition <- cond[["condition"]]
    if (debug) mdebugf("Condition #%d (class: %s):", kk, commaq(class(condition)))

    if (is.null(condition)) {
      msg <- sprintf("[INTERNAL ERROR]: Unexpected structure for condition set element %d:\n%s", kk, paste(capture.output(str(cond)), collapse = "\n"))
      stop(FutureError(msg))
    }

    ## Skip already signaled conditions?
    if (!resignal && !is.null(cond[["signaled"]]) && cond[["signaled"]] > 0L) {
      if (debug) mdebug("already signaled, skipping")
      next
    }

    ## Don't signal condition based on 'exclude'?
    if (length(exclude) > 0L && inherits(condition, exclude)) next
    
    ## Don't signal condition based on 'include'?
    if (length(include) > 0L && !inherits(condition, include)) next

    if (debug) mdebugf("Condition #%d: %s", kk, paste(sQuote(class(condition)), collapse = ", "))

    ## Flag condition as signaled
    cond[["signaled"]] <- cond[["signaled"]] + 1L
    conditions[[kk]] <- cond

    if (inherits(condition, "error")) {
      ## Make sure to update 'signaled' information before we exit.
      ## Note, 'future' is an environment.
      result[["conditions"]] <- conditions
      future[["result"]] <- result
      
      ## SPECIAL: By default, don't add 'future.info' because it
      ## modifies the error object, which may break things.
      if (debug && !"future.info" %in% names(condition)) {
        ## Recreate the full call stack
        cond[["calls"]] <- c(future[["calls"]], cond[["calls"]])
        condition[["future.info"]] <- cond
      }
      stop(condition)
    } else if (inherits(condition, "interrupt")) {
      future[["state"]] <- "interrupted"
      label <- sQuoteLabel(future)
      result <- future[["result"]]
      when <- result[["finished"]]
      session_uuid <- result[["session_uuid"]]
      source <- attr(session_uuid, "source")
      host <- source[["host"]]
      pid <- source[["pid"]]
      msg <- sprintf("A future (%s) of class %s was interrupted at %s, while running on %s (pid %s)", label, class(future)[1], format(when, format = "%FT%T"), sQuote(host), pid)
      stop(FutureInterruptError(msg, future = future))
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

  ## Drop captured and signaled conditions to save memory?
  if (isTRUE(attr(future[["conditions"]], "drop"))) {
    if (debug) mdebugf("Drop signaled conditions: %d", sum(signaled))
    conditions <- conditions[!signaled]
  }
  
  ## Make sure to update 'signaled' information on exit
  result[["conditions"]] <- conditions
  future[["result"]] <- result

  future
}


signalImmediateConditions <- function(future, include = NULL, resignal = FALSE, ...) {
  if (is.null(include)) {
    conditions <- future[["conditions"]]
    if (is.null(conditions)) {
      include <- NULL
    } else {
      include <- attr(conditions, "immediateConditionClasses", exact = TRUE)
      if (is.null(include)) include <- "immediateCondition"
    }
  }
  if (length(include) == 0L) return(future)
  signalConditions(future, include = include, resignal = resignal, ...)
}


make_signalConditionsASAP <- function(nx, stdout = TRUE, signal = TRUE, force = FALSE, debug = FALSE) {
  relay <- (stdout || signal)
  if (!relay && !force) return(function(...) TRUE)

  relayed <- rep(FALSE, times = nx)
  queue <- vector("list", length = nx)
    
  function(obj = NULL, ..., exclude = NULL, resignal = FALSE, pos) {
    if (inherits(obj, "DroppedFuture")) return(TRUE)
    
    if (debug) {
      mdebugf_push("signalConditionsASAP(%s, pos=%d) ...", class(obj)[1], pos)
      mdebugf("nx: %d", nx)
      mdebugf("relay: %s", relay)
      mdebugf("stdout: %s", stdout)
      mdebugf("signal: %s", signal)
      mdebugf("resignal: %s", resignal)
      mdebugf("force: %s", force)
      mdebugf("relayed: [n=%d] %s", length(relayed), paste(relayed, collapse = ", "))
      mdebugf("queued futures: [n=%d] %s", length(queue), paste(vapply(queue, FUN = inherits, "Future", FUN.VALUE = FALSE), collapse = ", "))
      on.exit({
        mdebugf("relayed: [n=%d] %s", length(relayed), paste(relayed, collapse = ", "))
        mdebugf("queued futures: [n=%d] %s", length(queue), paste(vapply(queue, FUN = inherits, "Future", FUN.VALUE = FALSE), collapse = ", "))
        mdebug_pop()
      })
    }

    if (force) resignal <- TRUE
    
    ## Flush all?
    if (pos == 0L) {
      if (debug) message(" - flush all")
      for (ii in which(!relayed)) {
        if (relayed[ii]) next
        if (debug) mdebugf("relaying element #%d", ii)
        obj <- queue[[ii]]
        if (is.null(obj) || is.atomic(obj)) {
          relayed[ii] <- TRUE
          next
        }

        stop_if_not(inherits(obj, "Future"))
        if (stdout) value(obj, stdout = TRUE, signal = FALSE)
        if (signal) {
          conditionClasses <- obj[["conditions"]]
          if (is.null(conditionClasses)) {
             immediateConditionClasses <- NULL
          } else {
            immediateConditionClasses <- attr(conditionClasses, "immediateConditionClasses", exact = TRUE)
            if (is.null(immediateConditionClasses)) {
              immediateConditionClasses <- "immediateCondition"
            }
          }

          ## Always signal immediateCondition:s and as soon as possible.
          ## They will always be signaled if they exist.
          signalImmediateConditions(obj, include = immediateConditionClasses)
    
          ## Signal all other types of condition
          signalConditions(obj, exclude = c(exclude, immediateConditionClasses), resignal = resignal, ...)
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
      if (inherits(obj, "DroppedFuture")) {
        relayed[pos] <<- TRUE
      } else {
        queue[[pos]] <<- obj
      }
    } else {
      relayed[pos] <<- TRUE
    }
    
    ## How far may we flush the queue?
    until <- which(relayed)
    n <- length(until)
    until <- if (n == 0L) 1L else min(until[n] + 1L, length(queue))
    if (debug) mdebugf("until=%d", until)
    for (ii in seq_len(until)) {
      if (relayed[ii]) next
      if (debug) mdebugf("relaying element #%d", ii)
      obj <- queue[[ii]]
      if (inherits(obj, "Future") && !inherits(obj, "DroppedFuture")) {
        if (stdout) value(obj, stdout = TRUE, signal = FALSE)
        if (signal) {
          conditionClasses <- obj[["conditions"]]
          if (is.null(conditionClasses)) {
             immediateConditionClasses <- NULL
          } else {
            immediateConditionClasses <- attr(conditionClasses, "immediateConditionClasses", exact = TRUE)
            if (is.null(immediateConditionClasses)) {
              immediateConditionClasses <- "immediateCondition"
            }
          }

          ## Always signal immediateCondition:s and as soon as possible.
          ## They will always be signaled if they exist.
          signalImmediateConditions(obj, include = immediateConditionClasses)
    
          ## Signal all other types of condition
          signalConditions(obj, exclude = c(exclude, immediateConditionClasses), resignal = resignal, ...)
        }
        relayed[ii] <<- TRUE
      }
    }

    ## Was the added object relayed?
    relayed[pos]
  }
} ## make_signalConditionsASAP()



muffleCondition <- function(cond, pattern = "^muffle") {
  muffled <- FALSE
  if (inherits(cond, "message")) {
    muffled <- grepl(pattern, "muffleMessage")
    if (muffled) invokeRestart("muffleMessage")
  } else if (inherits(cond, "warning")) {
    muffled <- grepl(pattern, "muffleWarning")
    if (muffled) invokeRestart("muffleWarning")
  } else if (inherits(cond, "condition")) {
    if (!is.null(pattern)) {
      ## If there is a "muffle" restart for this condition,
      ## then invoke that restart, i.e. "muffle" the condition
      restarts <- computeRestarts(cond)
      for (restart in restarts) {
        name <- restart[["name"]]
        if (is.null(name)) next
        if (!grepl(pattern, name)) next
        invokeRestart(restart)
        muffled <- TRUE
        break
      }
    }
  }

  muffled
} ## muffleCondition()
