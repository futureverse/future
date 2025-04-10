#' @tags reset
#' @tags sequential multisession multicore

library(future)
options(future.debug = FALSE)

## Like mean(), but fails 90% of the time
shaky_mean <- function(x) {
  if (as.double(Sys.time()) %% 1 < 0.90) stop("boom")
  mean(x)
}

x <- rnorm(100)


message("*** reset() ...")
for (strategy in supportedStrategies()) {
  message(sprintf("- plan('%s') ...", strategy))
  plan(strategy)

  ## Calculate the mean of 'x' with a risk of failing randomly
  f <- future({ shaky_mean(x) })
  
  ## Relaunch until success
  repeat({
    v <- tryCatch(value(f), error = identity)
    if (!inherits(v, "error")) break
    message("Resetting failed future, and retry in 0.1 seconds")
    f <- reset(f)
  })
  cat("mean:", v, "\n")

} ## for (strategy ...)

message("*** reset() ... DONE")

