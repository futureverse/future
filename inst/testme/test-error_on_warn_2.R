#' @tags warn2
#' @tags error
#' @tags future
#' @tags sequential multisession multicore

library(future)

message("*** options(warn = 2) relays an error ...")

for (strategy in supportedStrategies()) {
  message("Type of future: ", strategy)
  plan(strategy)

  f <- future({
    stopifnot(getOption("warn") == 0)
    oopts <- options(warn = 2)
    on.exit(options(oopts))
    log(-1)
    42L
  })

  r <- result(f)
  
  y <- tryCatch(value(f), error = identity)
  print(y)
  stopifnot(inherits(y, "error"))
} ## for (strategy ...)

message("*** options(warn = 2) relays an error ... done")
