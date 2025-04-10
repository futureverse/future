#' @tags demo mandelbrot
#' @tags sequential cluster multisession multicore

library(future)

## Avoid 'Error: C stack usage  7971940 is too close to the limit'
## on R (< 4.1.0)
if (getRversion() < "4.1") options(future.debug = FALSE)

message("*** Mandelbrot demo of the 'future' package ...")
options(future.demo.mandelbrot.nrow = 2L)
options(future.demo.mandelbrot.resolution = 50L)
options(future.demo.mandelbrot.delay = FALSE)

for (cores in 1:availCores) {
  message(sprintf("Testing with %d cores ...", cores))
  options(mc.cores = cores)

  for (strategy in supportedStrategies(cores)) {
    message(sprintf("- plan('%s') ...", strategy))
    plan(strategy)
    demo("mandelbrot", package = "future", ask = FALSE)
    message(sprintf("- plan('%s') ... DONE", strategy))
  }

  message(sprintf("Testing with %d cores ... DONE", cores))
} ## for (cores ...)
message("*** Mandelbrot demo of the 'future' package ... DONE")

