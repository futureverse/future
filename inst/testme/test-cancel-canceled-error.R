#' @tags cancel
#' @tags detritus-files
#' @tags detritus-connections
#' @tags multisession multicore

library(future)
options(future.debug = FALSE)

## A sequential future is resolved already when created, so there is
## nothing to cancel
strategies <- setdiff(supportedStrategies(), "sequential")

for (strategy in strategies) {
  message(sprintf("plan('%s') ...", strategy))
  plan(strategy)

  n0 <- nbrOfFreeWorkers()

  ## Cancel a running future
  f <- future({ Sys.sleep(1.0); 42 })
  stopifnot(!resolved(f))
  f <- cancel(f)

  ## Canceled futures always triggers a FutureCanceledError,
  ## regardless whether they were interrupted or not
  v <- tryCatch(value(f), error = identity)
  print(class(v))
  stopifnot(inherits(v, "FutureCanceledError"))

  ## Canceled futures always release their workers
  stopifnot(nbrOfFreeWorkers() == n0)

  message(sprintf("plan('%s') ... done", strategy))
}

message("Shut down future backend")
plan(sequential)
gc()
