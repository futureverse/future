#' @tags cancel
#' @tags detritus-files
#' @tags detritus-connections
#' @tags sequential multisession multicore cluster

library(future)
options(future.debug = FALSE)

## Backends to test, including cluster with interrupts disabled
plans <- list()
for (strategy in supportedStrategies()) {
  plans[[strategy]] <- list(strategy = strategy)
}
if ("cluster" %in% supportedStrategies()) {
  plans[["cluster, interrupts = FALSE"]] <- list(
    strategy = "cluster", workers = 1L, interrupts = FALSE
  )
}

for (name in names(plans)) {
  message(sprintf("plan(%s) ...", sQuote(name)))
  args <- plans[[name]]
  do.call(plan, args)

  n0 <- nbrOfFreeWorkers()

  message("  Cancel a running future before it is resolved")
  f <- future({ Sys.sleep(2.0); 42 })

  ## A sequential future is resolved already when created
  if (!inherits(f, "SequentialFuture")) {
    stopifnot(!resolved(f))
    f <- cancel(f)

    message("  value() on a canceled future signals an error")
    v <- tryCatch(value(f), error = identity)
    stopifnot(inherits(v, "FutureInterruptError"))
  } else {
    f <- cancel(f)
    v <- tryCatch(value(f), error = identity)
    stopifnot(inherits(v, "FutureCanceledError"))
  }

  message("  Canceled future released its worker")
  stopifnot(nbrOfFreeWorkers() == n0)

  message("  Next future runs fine")
  f <- future(42)
  stopifnot(value(f) == 42)
  stopifnot(nbrOfFreeWorkers() == n0)

  message(sprintf("plan(%s) ... done", sQuote(name)))
}

message("Shut down future backend")
plan(sequential)
gc()
