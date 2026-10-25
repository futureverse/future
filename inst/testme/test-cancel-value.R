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
  if (!inherits(f, "UniprocessFuture")) {
    stopifnot(!resolved(f))
  }
  f <- cancel(f)

  message("  value() on a canceled future signals an error")
  v <- tryCatch(value(f), error = identity)
  stopifnot(inherits(v, "FutureCanceledError"))

  message("  Canceled future released its worker")
  stopifnot(nbrOfFreeWorkers() == n0)

  message("  Cancel a running future without interrupting it")
  f <- future({ Sys.sleep(0.5); 42 })
  f <- cancel(f, interrupt = FALSE)
  v <- tryCatch(value(f), error = identity)
  stopifnot(inherits(v, "FutureCanceledError"))
  stopifnot(nbrOfFreeWorkers() == n0)

  message("  Cancel a future that is resolved, but not yet collected")
  f <- future({ Sys.sleep(0.2); 42 })
  while (!resolved(f)) Sys.sleep(0.05)
  f <- cancel(f)
  v <- tryCatch(value(f), error = identity)
  stopifnot(inherits(v, "FutureCanceledError"))

  message("  Cancel a future that has already been collected")
  f <- future({ Sys.sleep(0.2); 42 })
  stopifnot(value(f) == 42)
  f <- cancel(f)
  v <- tryCatch(value(f), error = identity)
  stopifnot(inherits(v, "FutureCanceledError"))
  stopifnot(nbrOfFreeWorkers() == n0)

  message("  Canceling a dropped future leaves it as dropped")
  f <- future(42)
  stopifnot(value(f, drop = TRUE) == 42)
  f <- cancel(f)
  v <- tryCatch(value(f), error = identity)
  stopifnot(inherits(v, "FutureDroppedError"))

  message("  Cancel a lazy future, which is then never launched")
  f <- future(stop("Launched"), lazy = TRUE)
  f <- cancel(f)
  stopifnot(resolved(f))
  v <- tryCatch(value(f), error = identity)
  stopifnot(inherits(v, "FutureCanceledError"))
  stopifnot(nbrOfFreeWorkers() == n0)

  message("  A canceled lazy future can be reset and launched")
  f <- reset(f)
  v <- tryCatch(value(f), error = identity)
  stopifnot(inherits(v, "simpleError"), conditionMessage(v) == "Launched")

  message("  Next future runs fine")
  f <- future(42)
  stopifnot(value(f) == 42)
  stopifnot(nbrOfFreeWorkers() == n0)

  message(sprintf("plan(%s) ... done", sQuote(name)))
}

message("Shut down future backend")
plan(sequential)
gc()
