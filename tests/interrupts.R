source("incl/start.R")
options(future.debug = FALSE)

strategies <- supportedStrategies()

## For unknown reasons, SIGINT interrupts is not caught by the
## future in R (<= 4.3.3), leading to R being terminated
if (getRversion() < "4.4") strategies <- setdiff(strategies, "sequential")

for (strategy in strategies) {
  message(sprintf("- plan('%s') ...", strategy))
  plan(strategy)

  f <- future({
    message("Hello world!")
    cat("Hi there\n")
    tools::pskill(Sys.getpid(), signal = tools::SIGINT)
    42
  })
  r <- result(f)
  res <- tryCatch({
    value(f)
  }, FutureInterruptError = identity)
  print(res)

  ## A future interrupting itself is not supported on all backends
  stopifnot(inherits(res, "FutureInterruptError") || res == 42)
}

source("incl/end.R")
