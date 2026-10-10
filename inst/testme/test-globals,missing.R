#' @tags globals
#' @tags sequential multisession multicore

library(future)

message("*** Forwarding missing arguments as globals ...")

consume <- function(x, y, z) {
  if (!missing(y)) x <- x + y
  if (!missing(z)) x <- x + z
  x
}

forward <- function(x, y, z) {
  future(consume(x = x, y = y, z = z))
}

forward_default <- function(x, y = 2) {
  future(consume(x = x, y = y))
}

for (strategy in supportedStrategies()) {
  message(sprintf("- Strategy: %s ...", strategy))
  plan(strategy)

  f <- forward(1)
  stopifnot(identical(value(f), 1))

  f <- forward(1, 2)
  stopifnot(identical(value(f), 3))

  f <- forward(1, 2, 4)
  stopifnot(identical(value(f), 7))

  ## A missing argument with a default forwards its default value.
  f <- forward_default(1)
  stopifnot(identical(value(f), 3))

  plan(sequential)
  message(sprintf("- Strategy: %s ... DONE", strategy))
}

message("*** Forwarding missing arguments as globals ... DONE")
