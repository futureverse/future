FutureRegistry <- local({
  db <- list()

  indexOf <- function(futures, future) {
    for (ii in seq_along(futures)) {
      if (identical(future, futures[[ii]])) return(ii)
    }
    NA_integer_
  }

  collectValues <- function(where, futures, firstOnly = TRUE) {
    for (ii in seq_along(futures)) {
      future <- futures[[ii]]

      ## Is future even launched?
      if (future$state == "created") next

      ## NOTE: It is when calling resolved() on a future with
      ##       early signaling is enabled that conditioned
      ##       may be signaled.
      if (resolved(future, run = FALSE, .signalEarly = FALSE)) {
        ## (a) Let future cleanup after itself, iff needed.
        ##     This, this may result in a call to
        ##     FutureRegistry(..., action = "remove").
        tryCatch({
          value(future, stdout = FALSE, signal = FALSE)
        }, FutureError = function(ex) {
          mdebugf("Detected a %s while FutureRegistry collecting results:", class(ex)[1])
          mprint(ex)
        })

        ## (b) Make sure future is removed from registry, unless
        ##     already done via above value() call.
        futuresDB <- db[[where]]
        idx <- indexOf(futuresDB, future = future)
        if (!is.na(idx)) {
          futuresDB[[idx]] <- NULL
          db[[where]] <<- futuresDB
        }

        ## (c) Collect only the first resolved future?
        if (firstOnly) break
      }
    } ## for (ii ...)

    invisible(futures)
  } ## collectValues()


  function(where, action = c("add", "remove", "list", "contains", "collect-first", "collect-all", "reset"), future = NULL, earlySignal = TRUE, ...) {
    stop_if_not(length(where) == 1, nzchar(where))
    futures <- db[[where]]

    ## Automatically create?
    if (is.null(futures)) {
      futures <- list()
      db[[where]] <<- futures
    }

    if (action == "add") {
      idx <- indexOf(futures, future = future)
      if (!is.na(idx)) {
        msg <- sprintf("Cannot add to %s registry. %s is already registered.", sQuote(where), class(future)[1])
        mdebug("ERROR: ", msg)
        stop(FutureError(msg, future = future))
      }
      futures[[length(futures)+1L]] <- future
      db[[where]] <<- futures
    } else if (action == "contains") {
      idx <- indexOf(futures, future = future)
      return(!is.na(idx))
    } else if (action == "remove") {
      idx <- indexOf(futures, future = future)
      if (is.na(idx)) {
        msg <- sprintf("Cannot remove from %s registry. %s not registered.", sQuote(where), class(future)[1])
        mdebug("ERROR: ", msg)
        stop(FutureError(msg, future = future))
      }
      futures[[idx]] <- NULL
      db[[where]] <<- futures
    } else if (action == "collect-first") {
      collectValues(where, futures = futures, firstOnly = TRUE)
    } else if (action == "collect-all") {
      collectValues(where, futures = futures, firstOnly = FALSE)
    } else if (action == "reset") {
      db[[where]] <<- list()
    } else if (action == "list") {
    } else {
      msg <- sprintf("INTERNAL ERROR: Unknown action to %s registry: %s", sQuote(where), action)
      mdebug(msg)
      stop(FutureError(msg, future = future))
    }

    ## Early signaling of conditions?
    if (earlySignal && length(futures) > 0L) {
      ## Which futures have early signaling enabled?
      idxs <- lapply(futures, FUN = function(f) f$earlySignal)
      idxs <- which(unlist(idxs, use.names = FALSE))

      ## Any futures to be scanned for early signaling?
      if (length(idxs) > 0) {
        ## Collect values, which will trigger signaling during
        ## calls to resolved().
        collectValues(where, futures = futures[idxs], firstOnly = FALSE)
      }
    }

    futures
  }
})
