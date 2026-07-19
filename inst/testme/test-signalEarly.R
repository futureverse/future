#' @tags utils-internal early-signaling sequential
#' @tags deprecated
## plan(..., earlySignal = TRUE) is deprecated as of future (> 1.68.0)

library(future)

signalEarly <- future:::signalEarly

message("*** signalEarly() - no early signaling ...")

plan(sequential)

## A future that is not flagged for early signaling is a no-op
f <- future(42L)
v <- value(f)
stopifnot(isFALSE(f[["earlySignal"]]))
res <- signalEarly(f)
stopifnot(inherits(res, "Future"))

message("*** signalEarly() - no early signaling ... DONE")


## Skip the remaining tests if option 'future.plan.earlySignal' is "defunct",
## because plan(..., earlySignal = TRUE) then produces an error rather than
## a deprecation warning
if (!identical(getOption("future.plan.earlySignal"), "defunct")) {

  message("*** signalEarly() - early signaling ...")

  ## NOTE: 'earlySignal' is set when the future is launched, which is why it is
  ## requested via plan() here. On a lazy, not-yet-launched future the field is
  ## still NULL, so such a future takes the "not flagged" shortcut instead
  suppressWarnings(plan(sequential, earlySignal = TRUE))

  ## A future that has not been launched yet is a no-op
  f <- future(42L, lazy = TRUE)
  stopifnot(identical(f[["state"]], "created"))
  res <- signalEarly(f)
  stopifnot(inherits(res, "Future"), identical(res[["state"]], "created"))

  ## A resolved future without conditions has nothing to signal
  f <- future(42L)
  v <- value(f)
  stopifnot(isTRUE(f[["earlySignal"]]))
  res <- signalEarly(f)
  stopifnot(inherits(res, "Future"))

  ## A resolved future that captured conditions takes the signalling path.
  ## NOTE: signalConditions(resignal = FALSE) only signals conditions that have
  ## not been signalled before, so a condition already relayed while the result
  ## was collected is not signalled again here
  f <- future({ warning("early warning"); 42L })
  res <- withCallingHandlers({
    signalEarly(f)
  }, warning = function(c) invokeRestart("muffleWarning"))
  stopifnot(inherits(res, "Future"))
  stopifnot(length(result(f)[["conditions"]]) > 0L)

  message("*** signalEarly() - early signaling ... DONE")


  message("*** signalEarly() - with debug output ...")

  local({
    oopts <- options(future.debug = TRUE)
    on.exit(options(oopts))

    ## Nothing to signal
    f <- future(42L)
    v <- value(f)
    stopifnot(inherits(signalEarly(f), "Future"))

    ## Something to signal
    f <- future({ message("early message"); 42L })
    res <- withCallingHandlers({
      signalEarly(f)
    }, message = function(c) invokeRestart("muffleMessage"))
    stopifnot(inherits(res, "Future"))
  })

  message("*** signalEarly() - with debug output ... DONE")
}

plan(sequential)
