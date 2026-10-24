#' @tags value
#' @tags list listenv environment
#' @tags sequential multisession multicore

library(future)
library(listenv)
options(future.debug = FALSE)

## https://stat.ethz.ch/pipermail/r-devel/2025-March/083892.html
## Fixed in R-devel (>= 4.6.0) /HB 2025-03-23
attr_on_primitive_is_error <- local({
  res <- NA
  function() {
    if (is.na(res)) {
      test <- tryCatch(structure(`+`, abc = TRUE), error = identity)
      res <<- inherits(test, "error")
      ## Undo
      if (!res) structure(`+`, abc = NULL)
    }
    res
  }
})
        
sleep <- function(n) Sys.sleep(0.01*n)

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
    message(sprintf("  Container %s ...", container))
    
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
      message(sprintf("    lazy = %s ...", lazy))
      
      message(sprintf("      Future: resolve with value"))
      f <- future({
        truth
      }, lazy = lazy)
      v <- value(f)
      stopifnot(identical(v, truth))
  
      message(sprintf("      Future: resolve with an error"))
      f <- future({
        stop("Nah!")
      }, lazy = lazy)
      res <- value(f, signal = FALSE)
      stopifnot(inherits(res, "error"))
      res <- tryCatch(value(f), error = identity)
      stopifnot(inherits(res, "error"))

      message(sprintf("      Future: resolve with value and drop"))
      truth <- 42
      f <- future(42, lazy = TRUE)
      y <- value(f, drop = TRUE)
      stopifnot(equals(y, truth))
      res <- tryCatch(value(f), error = identity)
      stopifnot(
        inherits(res, "error"),
        inherits(res, "FutureError"),
        inherits(res, "FutureDroppedError")
      )

      message(sprintf("      Containers: an empty %s", container))
      truth <- list()
      x <- coerce(truth)
      y <- value(x)
      stopifnot(equals(y, truth))

      message(sprintf("      Containers: a named %s", container))
      truth <- list(a = 1, b = 2, c = 3)
      x <- coerce(truth)
      y <- value(x)
      stopifnot(equals(y, truth))

      message(sprintf("      Containers: reducing a named %s", container))
      truth <- list(a = 1, b = 2, c = 3)
      x <- coerce(truth)
      truth <- do.call(sum, args = truth)
      y <- value(x, reduce = `+`)
      stopifnot(equals(y, truth))

      message(sprintf("      Containers: a named %s mixed with values and futures", container))
      truth <- list(a = 1, b = 2, c = 3, d = 3, e = 42)
      x <- list(
        a = future({ sleep(1); 1 }, lazy = lazy),
        b = future(2, lazy = lazy),
        c = future(3, lazy = lazy),
        d = 3,
        e = 42
      )
      x <- coerce(x)
      y <- value(x)
      stopifnot(equals(y, truth))

      message(sprintf("      Containers: reducing a named %s mixed with values and futures", container))
      truth <- list(a = 1, b = 2, c = 3, d = 3, e = 42)
      x <- list(
        a = future({ sleep(1); 1 }, lazy = lazy),
        b = future(2, lazy = lazy),
        c = future(3, lazy = lazy),
        d = 3,
        e = 42
      )
      x <- coerce(x)
      truth <- do.call(sum, args = c(list(pi), truth))
      y <- value(x, reduce = structure(function(...) `+`(...), init = pi))
      stopifnot(equals(y, truth))

      message(sprintf("      Containers: reducing a named %s with 'init' attribute on primary function is an error", container))
      truth <- list(a = 1, b = 2, c = 3)
      x <- coerce(truth)
      y <- tryCatch({
        value(x, reduce = structure(`+`, init = 42))
      }, error = identity)
      stopifnot(inherits(y, "error"))
      if (!attr_on_primitive_is_error()) {
        void <- structure(`+`, init = NULL)  ## undo
      }

      message(sprintf("      Containers: workaround for reducing a named %s with 'init' attribute on primary function", container))
      truth <- list(a = 1, b = 2, c = 3)
      x <- coerce(truth)
      truth <- do.call(sum, args = c(list(pi), truth))
      y <- value(x, reduce = structure("+", init = pi))
      stopifnot(equals(y, truth))

      message(sprintf("      Containers: a named %s mixed with values and futures out of order", container))
      truth <- list(a = 3, b = 2, c = 1, d = data.frame(a = 1, b = 2), e = 42)
      x <- list(
        a = future({ sleep(2); 3 }, lazy = lazy),
        b = future({ sleep(1); 2 }, lazy = lazy),
        c = future({           1 }, lazy = lazy),
        d = data.frame(a = 1, b = 2),
        e = 42
      )
      x <- coerce(x)
      y <- value(x, inorder = FALSE)
      stopifnot(equals(y, truth))

      message(sprintf("      Containers: a named %s mixed with values and futures dropped", container))
      truth <- list(a = 3, b = 2, c = 1, d = data.frame(a = 1, b = 2), e = 42)
      x <- list(
        a = future({ sleep(2); 3 }, lazy = lazy),
        b = future({ sleep(1); 2 }, lazy = lazy),
        c = future({           1 }, lazy = lazy),
        d = data.frame(a = 1, b = 2),
        e = 42
      )
      x <- coerce(x)
      y <- value(x, drop = TRUE)
      stopifnot(equals(y, truth))

      message(sprintf("      Containers: reducing a named %s mixed with values and futures dropped out of order", container))
      truth <- list(a = 1, b = 2, c = 3, d = 3, e = 42)
      x <- list(
        a = future({ sleep(2); 3 }, lazy = lazy),
        b = future({ sleep(1); 2 }, lazy = lazy),
        c = future({           1 }, lazy = lazy),
        d = 3,
        e = 42
      )
      x <- coerce(x)
      truth <- do.call(sum, args = truth)
      y <- value(x, reduce = `+`, inorder = FALSE, drop = TRUE)
      stopifnot(equals(y, truth))

      res <- tryCatch(value(x), error = identity)
      stopifnot(
        inherits(res, "error"),
        inherits(res, "FutureError"),
        inherits(res, "FutureDroppedError")
      )

      message(sprintf("      Containers: reducing a named %s mixed with values and futures out of order with 'init' attribute", container))
      truth <- list(a = 1, b = 2, c = 3, d = 3, e = 42)
      x <- list(
        a = future({ sleep(2); 3 }, lazy = lazy),
        b = future({ sleep(1); 2 }, lazy = lazy),
        c = future({           1 }, lazy = lazy),
        d = 3,
        e = 42
      )
      x <- coerce(x)
      truth <- do.call(sum, args = c(list(pi), truth))
      y <- value(x, reduce = structure(function(...) `+`(...), init = pi), inorder = FALSE)
      stopifnot(equals(y, truth))

      message(sprintf("    lazy = %s ... DONE", lazy))
    } ## for (lazy ...)
    message(sprintf("  Container %s ... DONE", container))
  } ## for (container ...)
} ## for (strategy ...)

message("- value(<list>): a future that legitimately returns an error object ...")
plan(sequential)

f <- future(simpleError("boom"))
v1 <- value(f)
stopifnot(identical(class(v1), c("simpleError", "error", "condition")))

for (inorder in c(TRUE, FALSE)) {
  for (drop in c(FALSE, TRUE)) {
    message(sprintf("  inorder = %s, drop = %s ...", inorder, drop))
    f2 <- future(simpleError("boom"))
    v2 <- value(list(f2), inorder = inorder, drop = drop)
    stopifnot(identical(v2[[1]], v1))
    message(sprintf("  inorder = %s, drop = %s ... DONE", inorder, drop))
  }
}

message("- value(<list>): a future that legitimately returns an error object ... DONE")

message("- value(<list>): an error signaled by value(<Future>) itself is thrown ...")
plan(sequential)

## The RNG misuse error is signaled by value(), not captured in the result
oopts <- options(future.rng.onMisuse = "error")

f <- future(sample(0:3, size = 1L), seed = FALSE)
e1 <- tryCatch(value(f), error = identity)
stopifnot(inherits(e1, "RngFutureError"))

for (inorder in c(TRUE, FALSE)) {
  for (drop in c(FALSE, TRUE)) {
    ## Not yet supported: the error is returned, not thrown
    if (!inorder && drop) next
    message(sprintf("  inorder = %s, drop = %s ...", inorder, drop))
    f2 <- future(sample(0:3, size = 1L), seed = FALSE)
    e2 <- tryCatch(value(list(f2), inorder = inorder, drop = drop), error = identity)
    stopifnot(inherits(e2, "RngFutureError"))
    message(sprintf("  inorder = %s, drop = %s ... DONE", inorder, drop))
  }
}

options(oopts)
message("- value(<list>): an error signaled by value(<Future>) itself is thrown ... DONE")

message("- value(<list>, drop = TRUE): output and conditions are relayed in order ...")
plan(multisession, workers = 2L)
for (drop in c(FALSE, TRUE)) {
  message(sprintf("  drop = %s ...", drop))
  fs <- list(
    future({ Sys.sleep(1.0); cat("out-a\n"); message("msg-a"); 1 }),
    future({                 cat("out-b\n"); message("msg-b"); 2 })
  )
  msgs <- character(0L)
  out <- utils::capture.output({
    v <- withCallingHandlers({
      value(fs, drop = drop)
    }, message = function(m) {
      msgs <<- c(msgs, conditionMessage(m))
      invokeRestart("muffleMessage")
    })
  })
  print(out)
  print(msgs)
  stopifnot(
    identical(v, list(1, 2)),
    identical(out, c("out-a", "out-b")),
    identical(msgs, c("msg-a\n", "msg-b\n"))
  )
  message(sprintf("  drop = %s ... DONE", drop))
}
plan(sequential)
message("- value(<list>, drop = TRUE): output and conditions are relayed in order ... DONE")

message("*** value() ... DONE")
