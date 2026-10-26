#' @tags interrupt lazy
#' @tags detritus-files
#' @tags multisession multicore

library(future)
options(future.debug = FALSE)

strategies <- supportedStrategies()
strategies <- setdiff(strategies, "sequential")

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

  n0 <- nbrOfFreeWorkers()

  for (inorder in c(TRUE, FALSE)) {
    message(sprintf("inorder = %s ...", inorder))

    ## A lazy future that fails to launch, because it is claimed to be
    ## owned by another R session
    f1 <- future(1, lazy = TRUE)
    f1[["owner"]] <- structure("not-my-session", source = list(pid = 1L, host = "nowhere"))

    ## A running future
    f2 <- future({ Sys.sleep(5); 99 })

    res <- tryCatch(value(list(f1, f2), inorder = inorder), error = identity)

    message("Assert the launch error is signaled")
    stopifnot(inherits(res, "error"))

    message("Assert the running future was canceled and resolved")
    stopifnot(resolved(f2))
    res2 <- tryCatch(value(f2), error = identity)
    stopifnot(inherits(res2, "FutureCanceledError"))

    message("Assert all workers are released")
    stopifnot(nbrOfFreeWorkers() == n0)

    message(sprintf("inorder = %s ... done", inorder))
  }

  message(sprintf("plan('%s') ... done", strategy))
}

message("Shut down future backend")
plan(sequential)
gc()
