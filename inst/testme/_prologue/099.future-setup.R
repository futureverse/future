## Use sequential futures by default
oplan <- local({
  oopts <- options(future.debug = FALSE)
  on.exit(options(oopts))
  future::plan(future::sequential)
})

supportedStrategies <- function(cores = NA_integer_, excl = "cluster", ...) {
  strategies <- future:::supportedStrategies(...)
  strategies <- setdiff(strategies, excl)
  
  if (!is.na(cores)) {
    if (cores == 1L) {
      strategies <- setdiff(strategies, c("multicore", "multisession"))
    } else if (cores > 1L) {
      strategies <- setdiff(strategies, "sequential")
    }
  }
  
  strategies
}

availCores <- min(2L, future::availableCores())
