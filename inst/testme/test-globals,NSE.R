#' @tags globals
#' @tags nse
#' @tags listenv
#' @tags nested-futures
#' @tags sequential multisession multicore

library(future)
library(listenv)
options(future.debug = FALSE)

message("*** Globals w/ non-standard evaluation (NSE) ...")

data <- data.frame(x = 1:5, y = 1:5)
v0 <- subset(data, x < 3)$y

for (strategy in supportedStrategies()) {
  message(sprintf("- Strategy: %s ...", strategy))
  
  plan(strategy)

  ## Assert option is passed on to future
  options(future.globals.onMissing = "error")
  opt1 %<-% getOption("future.globals.onMissing")
  stopifnot(identical(opt1, "error"))

  options(future.globals.onMissing = "ignore")
  opt2 %<-% getOption("future.globals.onMissing")
  stopifnot(identical(opt2, "ignore"))

  options(future.globals.onMissing = "error")
  res <- try({ v1 %<-% subset(data, x < 3)$y }, silent = TRUE)
  stopifnot(inherits(res, "try-error"))

  options(future.globals.onMissing = "ignore")
  v2 %<-% subset(data, x < 3)$y
  stopifnot(identical(v2, v0))

  plan(sequential)


  ## Nested futures (requires option is passed on to future)
  plan(list(sequential, strategy))
  options(future.globals.onMissing = "ignore")
  v3 %<-% {
    a %<-% subset(data, x < 3)$y
    a
  } %lazy% TRUE
  stopifnot(identical(v3, v0))

  options(future.globals.onMissing = NULL)

  
  ## Shut down nested backend
  local({
    ## FIXME: plan() should do this for us /HB 2025-03-28a
    oopts <- options(future.connections.onMisuse = "warning")
    on.exit(options(oopts))
    void %<-% { plan(sequential); TRUE }
    stopifnot(isTRUE(void))
  })
  
  plan(sequential)

  message(sprintf("- Strategy: %s ... DONE", strategy))
}


message("*** Globals w/ non-standard evaluation (NSE) ... DONE")
