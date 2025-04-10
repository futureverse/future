#' @tags worker-interrupt
#' @tags detritus-files
#' @tags multisession multicore

library(future)
options(future.debug = FALSE)

strategies <- supportedStrategies()

## Signalling SIGINT to an R future process might end up
## terminating the whole R process. Because of that, we
## might get a FutureError, because we can no longer
## communicate with the worker.
##
## Because of this, we skip interrupt testing 'sequential',
## because it might terminate the R process running this unit test.
## Comment: This has happend on win-devel, but also R 4.3.0 on Linux.
strategies <- setdiff(strategies, "sequential")

for (strategy in strategies) {
  message(sprintf("- plan('%s') ...", strategy))
  plan(strategy)

  f <- future({
    message("Hello world!")
    cat("Hi there\n")
    res <- tools::pskill(Sys.getpid(), signal = tools::SIGINT)
    cat(sprintf("tools::pskill() value: %s\n", res))
    42
  })
  r <- tryCatch({
    result(f)
  }, FutureError = identity)
  stopifnot(
    #  (i) Ideally, regular results, but ..
    inherits(r, "FutureResult") ||
    #  (ii) SIGINT might crash the R parallel worker
    inherits(r, "FutureError")
  )

  v <- tryCatch({
    value(f)
  }, FutureError = identity)
  print(v)

  ## A future interrupting itself is not supported on all backends
  stopifnot(
    #   (i) Ideally the SIGINT interrupt condition is caught, but ...
    inherits(v, "FutureInterruptError") ||
    #  (ii) it might crash the R parallel worker, e.g. communication
    #       channels are shutdown ...
    inherits(v, "FutureError") ||
    # (iii)  ... or have no effect at all
    v == 42
  )

  ## It should always be possible to reset
  f <- reset(f)
  print(f)
  stopifnot(
    f[["lazy"]],
    f[["state"]] == "created"
  )
}

