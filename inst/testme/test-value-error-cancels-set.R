#' @tags interrupt
#' @tags detritus-files
#' @tags detritus-connections
#' @tags multisession multicore

library(future)
options(future.debug = FALSE)

strategies <- supportedStrategies()
strategies <- setdiff(strategies, "sequential")

for (strategy in strategies) {
  message(sprintf("plan('%s') ...", strategy))
  plan(strategy)

  n0 <- nbrOfFreeWorkers()
  message("Number of free workers: ", n0)

  message("Create four futures, where one produces an error")
  fs <- lapply(c(4, 1, 2, 3), function(x) future({
    Sys.sleep(x/4)
    if (x == 1) stop("boom")
    x
  }))

  rs <- resolved(fs)
  print(rs)

  message("Assert there is an error")
  vs <- tryCatch(value(fs), error = identity)

  ## Assert that value() returned the 'boom' error, and not
  ## a FutureError, e.g. FutureInterruptError
  print(vs)
  stopifnot(
    inherits(vs, "error"),
    !inherits(vs, "FutureError"),
    conditionMessage(vs) == "boom"
  )
    
  ## Assert that value(fs) resolves all futures before returning,
  ## regardless of the backend supporting interrupting futures or not.
  message("Assert that all futures are resolved by value()")
  rs <- resolved(fs)
  print(rs)
  stopifnot(all(rs))

  message(sprintf("plan('%s') .. done", strategy))
}

message("Shut down future backend")
plan(sequential)
gc()
