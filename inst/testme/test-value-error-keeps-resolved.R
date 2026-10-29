#' @tags interrupt
#' @tags detritus-files
#' @tags sequential multisession multicore

library(future)
options(future.debug = FALSE)

strategies <- supportedStrategies()

## IMPORTANT: Skip when testing with 'covr', because value() cancels the
## still-running futures when one of them fails, which terminates their
## workers. See 'test-value-error-cancels-set.R' for details
if (covr_testing) {
  message("Skipping, because covr is used for testing")
  strategies <- character(0L)
}

for (strategy in strategies) {
  message(sprintf("plan('%s') ...", strategy))
  plan(strategy)

  for (inorder in c(TRUE, FALSE)) {
    message(sprintf("inorder = %s ...", inorder))

    f1 <- future(stop("boom"))
    f2 <- future(2)
    f3 <- future(3, lazy = TRUE)
    fs <- list(f1, f2, f3)

    res <- tryCatch(value(fs, inorder = inorder), error = identity)
    stopifnot(inherits(res, "error"), conditionMessage(res) == "boom")

    message("Assert the failed future still has its original error")
    res1 <- tryCatch(value(f1), error = identity)
    stopifnot(inherits(res1, "error"), !inherits(res1, "FutureCanceledError"),
              conditionMessage(res1) == "boom")

    message("Assert an already resolved future still has its value")
    stopifnot(identical(value(f2), 2))

    message("Assert the lazy future was canceled")
    res3 <- tryCatch(value(f3), error = identity)
    stopifnot(inherits(res3, "FutureCanceledError"))

    message(sprintf("inorder = %s ... done", inorder))
  }

  message(sprintf("plan('%s') ... done", strategy))
}

message("Shut down future backend")
plan(sequential)
gc()
