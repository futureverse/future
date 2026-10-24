#' @tags interrupt
#' @tags detritus-files
#' @tags multisession multicore

library(future)
options(future.debug = FALSE)

strategies <- supportedStrategies()
strategies <- setdiff(strategies, "sequential")

## IMPORTANT: Skip when testing with 'covr', because value() cancels the
## still-running futures when one of them produces an error, which terminates
## their workers. A terminated worker may leave a truncated, or empty, 'covr'
## trace file behind, which in turn breaks the coverage merge at the end
if (covr_testing) {
  message("Skipping, because covr is used for testing")
  strategies <- character(0L)
}

for (strategy in strategies) {
  message(sprintf("plan('%s') ...", strategy))
  plan(strategy)

  n0 <- nbrOfFreeWorkers()
  message("Number of free workers: ", n0)

  for (inorder in c(TRUE, FALSE)) {
    message(sprintf("inorder = %s ...", inorder))

    message("Create four futures, where one produces an error")
    fs <- lapply(c(4, 1, 2, 3), function(x) future({
      Sys.sleep(x/4)
      if (x == 1) stop("boom")
      x
    }))

    rs <- resolved(fs)
    print(rs)

    message("Assert there is an error")
    vs <- tryCatch(value(fs, inorder = inorder), error = identity)

    ## Assert that value() returned the 'boom' error, and not
    ## a FutureError, e.g. FutureInterruptError
    print(vs)
    stopifnot(
      inherits(vs, "error"),
      !inherits(vs, "FutureError"),
      conditionMessage(vs) == "boom"
    )

    ## Assert that value(fs) resolves all futures before returning,
    ## regardless of the backend supporting interrupting futures or not.
    message("Assert that all futures are resolved by value()")
    rs <- resolved(fs)
    print(rs)
    stopifnot(all(rs))

    message(sprintf("inorder = %s ... done", inorder))
  }

  message("Assert that lazy futures are not launched when another errors")
  f1 <- future(stop("boom"))
  invisible(resolve(f1))
  f2 <- future(42, lazy = TRUE)
  fs <- list(f1, f2)

  vs <- tryCatch(value(fs), error = identity)
  print(vs)
  stopifnot(inherits(vs, "error"), conditionMessage(vs) == "boom")

  ## Assert that value(fs) did not launch the lazy future
  print(f2[["state"]])
  stopifnot(f2[["state"]] == "created")

  message(sprintf("plan('%s') .. done", strategy))
}

message("Shut down future backend")
plan(sequential)
gc()
