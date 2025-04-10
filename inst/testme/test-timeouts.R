#' @tags timeouts
#' @tags sequential multisession multicore

library(future)
options(future.debug = FALSE)

## Timeouts are only triggered after Sys.sleep() completes [1],
## so here we split up the sleep into multiple microsleeps
sleep <- function(duration) {
  until <- Sys.time() + duration
  while (Sys.time() < until) {
    Sys.sleep(0.01)
  }
}

strategies <- supportedStrategies()
strategies <- setdiff(strategies, "sequential")
for (strategy in strategies) {
  message(sprintf("plan('%s') ...", strategy))
  plan(strategy)

  n0 <- nbrOfFreeWorkers()
  message("Number of free workers: ", n0)

  message("Create a future that times out after 0.2 seconds into the evaluation")
  f <- future({
    setTimeLimit(elapsed = 0.2, transient = TRUE)
    sleep(1.0)
    42
  })
  
  n <- nbrOfFreeWorkers()
  message("Number of free workers (after interupt): ", n)
  
  message("Resolve future")
  f <- resolve(f)
  stopifnot(resolved(f))
  n <- nbrOfFreeWorkers()
  message("Number of free workers (after resolve): ", n)

  message("Get future results")
  r <- result(f)
  stopifnot(inherits(r, "FutureResult"))
  n <- nbrOfFreeWorkers()
  message("Number of free workers (after result): ", n)
  stopifnot(n == n0)

  message("Get the value, which triggers relay of timeout error")
  v <- tryCatch(value(f), error = identity)
  print(v)
  stopifnot(inherits(v, "error"))

  message("Create another future")
  f <- future(42)
  v <- value(f)
  n <- nbrOfFreeWorkers()
  message("Number of free workers (after result): ", n)
  stopifnot(n == n0)

  message(sprintf("plan('%s') .. done", strategy))
}

