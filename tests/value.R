source("incl/start.R")
library(listenv)
options(future.debug = FALSE)

identical_envs <- function(x, y) {
  if (length(x) > 1) x <- x[order(names(x))]
  if (length(y) > 1) y <- y[order(names(y))]
  identical(x, y)
}

message("*** value() ...")

strategies <- supportedStrategies(cores = 2L)
for (strategy in strategies) {
  message(sprintf("- plan('%s') ...", strategy))
  plan(strategy)

  truth <- list(a = 1, b = 42L)


  for (container in c("list", "listenv", "environment")) {
    message(sprintf("Containers - an empty %s", container))
    coerce <- switch(container,
             list = as.list,
          listenv = as.listenv,
      environment = as.environment
    )
    equals <- switch(container,
             list = identical,
          listenv = identical,
      environment = identical_envs
    )
      
    for (lazy in c(FALSE, TRUE)) {
      message("Straightforward future")  
      f <- future({
        truth
      }, lazy = lazy)
      v <- value(f)
      stopifnot(identical(v, truth))
  
      message("A future with an error")
      f <- future({
        stop("Nah!")
      }, lazy = lazy)
      res <- value(f, signal = FALSE)
      stopifnot(inherits(res, "error"))
      res <- tryCatch(value(f), error = identity)
      stopifnot(inherits(res, "error"))
    
      message(sprintf("Containers - an empty %s", container))
      truth <- list()
      x <- coerce(truth)
      y <- value(x)
      stopifnot(equals(y, truth))

      message(sprintf("Containers - a named %s", container))
      truth <- list(a = 1, b = 2, c = 3)
      x <- coerce(truth)
      y <- value(x)
      stopifnot(equals(y, truth))

      message(sprintf("Containers - reducing a named %s", container))
      truth <- list(a = 1, b = 2, c = 3)
      x <- coerce(truth)
      truth <- do.call(sum, args = truth)
      y <- value(x, reduce = `+`)
      stopifnot(equals(y, truth))

      message(sprintf("Containers - a named %s mixed with values and futures", container))
      truth <- list(a = 1, b = 2, c = 3, d = 3, e = 42)
      x <- list(
        a = future({ Sys.sleep(0.5); 1 }, lazy = lazy),
        b = future(2, lazy = lazy),
        c = future(3, lazy = lazy),
        d = 3,
        e = 42
      )
      x <- coerce(x)
      y <- value(x)
      stopifnot(equals(y, truth))

      message(sprintf("Containers - reducing a named %s mixed with values and futures", container))
      truth <- list(a = 1, b = 2, c = 3, d = 3, e = 42)
      x <- list(
        a = future({ Sys.sleep(0.5); 1 }, lazy = lazy),
        b = future(2, lazy = lazy),
        c = future(3, lazy = lazy),
        d = 3,
        e = 42
      )
      x <- coerce(x)
      truth <- do.call(sum, args = c(list(pi), truth))
      y <- value(x, reduce = structure(function(...) `+`(...), init = pi))
      stopifnot(equals(y, truth))

      message(sprintf("Containers - reducing a named %s with 'init' attribute on primary function is an error", container))
      ## https://stat.ethz.ch/pipermail/r-devel/2025-March/083892.html
      truth <- list(a = 1, b = 2, c = 3)
      x <- coerce(truth)
      y <- tryCatch({
        value(x, reduce = structure(`+`, init = 42))
      }, error = identity)
      stopifnot(inherits(y, "error"))
      void <- structure(`+`, init = NULL)  ## undo

      message(sprintf("Containers - workaround for reducing a named %s with 'init' attribute on primary function", container))
      truth <- list(a = 1, b = 2, c = 3)
      x <- coerce(truth)
      truth <- do.call(sum, args = c(list(pi), truth))
      y <- value(x, reduce = structure("+", init = pi))
      stopifnot(equals(y, truth))
} ## for (lazy ...)
  } ## for (container ...)
} ## for (strategy ...)

message("*** value() ... DONE")

source("incl/end.R")
