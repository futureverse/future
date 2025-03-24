#' @tags interrupt
#' @tags detritus-files
#' @tags sequential multisession multicore

library(future)
options(future.debug = FALSE)

strategies <- supportedStrategies()
strategies <- setdiff(strategies, "sequential")

for (strategy in strategies) {
  message(sprintf("plan('%s') ...", strategy))
  plan(strategy)

  n0 <- nbrOfFreeWorkers()
  message("Number of free workers: ", n0)

  message("Create a future")
  f <- future({ Sys.sleep(1.0); 42 })
  stopifnot(
     f[["state"]] == "running" ||
    (f[["state"]] == "finished" && inherits(f, "SequentialFuture"))
  )
  stopifnot(
    !resolved(f) || 
    (resolved(f) && f[["state"]] == "finished")
  )

  message("Interrupt future")
  f <- interrupt(f)
  stopifnot({
     f[["state"]] == "interrupted" ||
    (f[["state"]] == "finished" && inherits(f, "SequentialFuture"))
  })
  
  n <- nbrOfFreeWorkers()
  message("Number of free workers (after interupt): ", n)
  
  message("Check if interrupted future is resolved")
  f <- resolve(f)
  stopifnot(resolved(f))
  stopifnot({
     f[["state"]] == "interrupted" ||
    (f[["state"]] == "finished" && inherits(f, "SequentialFuture"))
  })
  
  n <- nbrOfFreeWorkers()
  message("Number of free workers (after resolve): ", n)
  
  message("Force collect of interrupted future (to free up worker)")
  ## Force collection of the future
  r <- tryCatch(result(f), error = identity)
  n <- nbrOfFreeWorkers()
  message("Number of free workers (after result): ", n)
  stopifnot(n == n0)

  message("An interrupt the same future multiple times")
  for (kk in 1:10) {
    f <- interrupt(f)
  }

  message("Create another future")
  ## Create another future
  f <- future(42)
  v <- value(f)
  n <- nbrOfFreeWorkers()
  message("Number of free workers (after result): ", n)
  stopifnot(n == n0)
  
  message(sprintf("plan('%s') .. done", strategy))
}

