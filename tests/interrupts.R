source("incl/start.R")
options(future.debug = FALSE)

for (strategy in supportedStrategies()) {
  message(sprintf("- plan('%s') ...", strategy))
  plan(strategy)

  f <- future({
    message("Hello world!")
    cat("Hi there\n")
    tools::pskill(Sys.getpid(), signal = tools::SIGINT)
    42
  })
  r <- result(f)
  v <- value(f)
  print(v)

  ## Interruptiing the evaluation of itself is not supported
  ## on all backends
  stopifnot(is.null(v) || v == 42)
}

source("incl/end.R")
