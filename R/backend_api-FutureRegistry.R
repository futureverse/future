FutureRegistry <- local({
  db <- list()

  indexOf <- function(futures, future) {
    for (ii in seq_along(futures)) {
      if (identical(future, futures[[ii]])) return(ii)
    }
    NA_integer_
  }

  collectValues <- function(where, futures, firstOnly = TRUE, debug = FALSE) {
    if (debug) {
      mdebugf_push("collectValues('%s', firstOnly = %s) ...", where, firstOnly)
      on.exit(mdebugf_pop())
    }

    futuresDB <- db[[where]]
    drop <- integer(0L)

    on.exit({
      ## Clean out collected futures
      if (length(drop) > 0) {
        if (debug) {
          mdebug_push("Remove collected futures ...")
          mdebugf("Indices of futures to drop: [n=%d] %s", length(drop), commaq(drop))
        }
        futuresDB <- futuresDB[-drop]
        db[[where]] <<- futuresDB
        if (debug) mdebug_pop()
      } else {
        if (debug) mdebug("Indices of futures to drop: [n=0] <none>")
      }
    }, add = TRUE)

    if (debug) {
      on.exit(mdebugf_pop(), add = TRUE)
    }

    for (ii in seq_along(futures)) {
      future <- futures[[ii]]

      ## Is future even launched?
      if (future[["state"]] == "created") {
        if (debug) mdebugf("Skipping non-launched future at position #%d", ii)
        next
      }

      ## NOTE: It is when calling resolved() on a future with
      ##       early signaling is enabled that conditioned
      ##       may be signaled.
      if (resolved(future, run = FALSE, .signalEarly = FALSE)) {
        if (debug) mdebugf_push("Future at position #%d is resolved ...", ii)
        ## (a) Let future cleanup after itself, iff needed.
        ##     This, this may result in a call to
        ##     FutureRegistry(..., action = "remove").
        tryCatch({
          value(future, stdout = FALSE, signal = FALSE)
        }, FutureLaunchError = function(ex) {
          if (debug) mdebugf_pop()
          stop(ex)
        }, FutureInterruptError = function(ex) {
          if (debug) mdebugf_pop()
          ## At a minimum, reset the future
          future <- reset(future)
          msg <- sprintf("[FUTURE INTERRUPTED]: Caught %s with error message: %s", class(ex)[1], conditionMessage(ex))
          warning(msg, call. = TRUE, immediate. = TRUE)
        }, FutureError = function(ex) {
          if (debug) mdebugf_pop()
          ## At a minimum, reset the future
          future <- reset(future)
          ## It is not always possible to detect when a future fails to
          ## launch, e.g. there might be a broken Rprofile file that
          ## produces an error. Here we take a liberal approach an assume
          ## we can just drop the future with a warning.
          msg <- sprintf("[FUTURE BACKEND FAILURE]: Caught %s with error message: %s", class(ex)[1], conditionMessage(ex))
          warning(msg, call. = TRUE, immediate. = TRUE)
        })

        ## (b) Make sure future is removed from registry, unless
        ##     already done via above value() call.
        idx <- indexOf(futuresDB, future = future)
        if (!is.na(idx)) {
          drop <- c(drop, idx)

          ## Update backend
          backend <- future[["backend"]]
          if (!is.null(backend)) {
            ## Update counters
            counters <- backend[["counters"]]
            counters["finished"] <- counters["finished"] + 1L
            backend[["counters"]] <- counters
            
            ## Update total runtime 
            result <- future[["result"]]
            if (inherits(result, "FutureResult")) {
              times <- result[c("finished", "started")]
              if (length(times) == 2L) {
                dt <- times[["finished"]] - times[["started"]]
                runtime <- backend[["runtime"]]
                runtime <- runtime + dt
                backend[["runtime"]] <- runtime
              }
            }
          }
        } ## if (!is.na(idx))

        ## (c) Collect only the first resolved future?
        if (firstOnly) {
          if (debug) mdebugf_pop()
          break
        }
        if (debug) mdebugf_pop()
      } else {
        if (debug) mdebugf("Future at position #%d is not resolved", ii)
      }
    } ## for (ii ...)

    futures
  } ## collectValues()


  function(where, action = c("add", "remove", "list", "contains", "collect-first", "collect-all", "reset"), future = NULL, earlySignal = TRUE, ..., debug = FALSE) {
    stop_if_not(length(where) == 1, nzchar(where))

    if (debug) {
      mdebugf_push("FutureRegistry('%s', action = '%s', earlySignal = %d) ...", where, action, earlySignal)
      on.exit(mdebugf_pop())
    }

    futures <- db[[where]]

    ## Automatically create?
    if (is.null(futures)) {
      futures <- list()
      db[[where]] <<- futures
      if (debug) mdebugf("Created empty registry %s", sQuote(where))
    }

    if (action == "add") {
      idx <- indexOf(futures, future = future)
      if (!is.na(idx)) {
        msg <- sprintf("INTERNAL ERROR: Cannot add to %s registry. %s is already registered.", sQuote(where), class(future)[1])
        if (debug) mdebug(msg)
        stop(FutureError(msg, future = future))
      }
      futures[[length(futures)+1L]] <- future
      db[[where]] <<- futures
      if (debug) mdebugf("Appended future to position #%d", length(futures))

      ## Update counters
      backend <- future[["backend"]]
      if (!is.null(backend)) {
        counters <- backend[["counters"]]
        counters["launched"] <- counters["launched"] + 1L
        backend[["counters"]] <- counters
      }
    } else if (action == "contains") {
      idx <- indexOf(futures, future = future)
      if (debug) {
        if (is.na(idx)) {
          mdebug("Future does not exist")
        } else {
          mdebug("Future exists at position #%d", idx)
        }
      }
      return(!is.na(idx))
    } else if (action == "remove") {
      idx <- indexOf(futures, future = future)
      if (is.na(idx)) {
        msg <- sprintf("INTERNAL ERROR: Cannot remove from %s registry. %s not registered.", sQuote(where), class(future)[1])
        if (debug) mdebug(msg)
        stop(FutureError(msg, future = future))
      }
      futures[[idx]] <- NULL
      db[[where]] <<- futures
      if (debug) mdebugf("Removed future from position #%d", idx)
      ## Update counters
      backend <- future[["backend"]]
      if (!is.null(backend)) {
        counters <- backend[["counters"]]
        counters["finished"] <- counters["finished"] + 1L
        backend[["counters"]] <- counters

        ## Update total runtime 
        result <- future[["result"]]
        if (inherits(result, "FutureResult")) {
          times <- result[c("finished", "started")]
          if (length(times) == 2L) {
            dt <- times[["finished"]] - times[["started"]]
            runtime <- backend[["runtime"]]
            runtime <- runtime + dt
            backend[["runtime"]] <- runtime
          }
        }
      }
    } else if (action == "collect-first") {
      collectValues(where, futures = futures, firstOnly = TRUE, debug = debug)
    } else if (action == "collect-all") {
      collectValues(where, futures = futures, firstOnly = FALSE, debug = debug)
    } else if (action == "reset") {
      db[[where]] <<- list()
      if (debug) mdebug("Erased registry")
    } else if (action == "list") {
      if (debug) mdebug("Listing all futures")
    } else {
      msg <- sprintf("INTERNAL ERROR: Unknown action to %s registry: %s", sQuote(where), action)
      if (debug) mdebug(msg)
      stop(FutureError(msg, future = future))
    }

    ## Early signaling of conditions?
    if (earlySignal && length(futures) > 0L) {
      if (debug) mdebugf("Early signaling of %d future candidates ...", length(futures))
      ## Which futures have early signaling enabled?
      idxs <- lapply(futures, FUN = function(f) f[["earlySignal"]])
      idxs <- which(unlist(idxs, use.names = FALSE))

      if (debug) mdebugf("Number of futures with early signaling requested: %d", length(idxs))

      ## Any futures to be scanned for early signaling?
      if (length(idxs) > 0) {
        ## Collect values, which will trigger signaling during
        ## calls to resolved().
        collectValues(where, futures = futures[idxs], firstOnly = FALSE)
      }
      if (debug) mdebugf("Early signaling of %d future candidates ... done", length(futures))
    }

    if (debug) mdebugf("Number of registered futures: %d", length(futures))
    futures
  }
})
