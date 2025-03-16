source("incl/start.R")
options(future.debug = FALSE)

strategies <- supportedStrategies()
strategies <- setdiff(strategies, "sequential")

for (strategy in strategies) {
  message(sprintf("- plan('%s') ...", strategy))
  plan(strategy)

  n0 <- nbrOfFreeWorkers()
  message("Number of free workers: ", n0)
  
  f <- future({ Sys.sleep(1.0); 42 })
  stopifnot(f[["state"]] == "running")
  stopifnot(!resolved(f))
  f <- interrupt(f)
  stopifnot(f[["state"]] == "interrupted")
  
  n <- nbrOfFreeWorkers()
  message("Number of free workers (after interupt): ", n)
  
  f <- resolve(f)
  stopifnot(resolved(f))
  stopifnot(f[["state"]] == "interrupted")
  
  n <- nbrOfFreeWorkers()
  message("Number of free workers (after resolve): ", n)
  
  ## Force collection of the future
  r <- tryCatch(result(f), error = identity)
  n <- nbrOfFreeWorkers()
  message("Number of free workers (after result): ", n)
  stopifnot(n == n0)
}

source("incl/end.R")
