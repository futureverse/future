#' @tags interrupt
#' @tags detritus-files
#' @tags multisession

library(future)
options(future.debug = FALSE)

plan(multisession, workers = 2)

for (inorder in c(TRUE, FALSE)) {
  message(sprintf("inorder = %s ...", inorder))

  ## Create two futures, where the first is emulated to be interrupted
  ## Future 1
  f1 <- future(42)
  v1 <- value(f1)
  r1 <- f1[["result"]]
  cond <- structure(
    class = c("interrupt", "condition"),
    list(message = "fake interrupt", call = NULL)
  )
  r1[["conditions"]] <- c(r1[["conditions"]], list(list(condition = cond, signaled = 0L)))
  f1[["result"]] <- r1

  ## Future 2
  f2 <- future({ Sys.sleep(3); 99 })

  fs <- list(f1, f2)

  message(sprintf("Calling value(fs, inorder = %s) ...", inorder))
  vs <- tryCatch(value(fs, inorder = inorder), error = identity)
  print(vs)
  stopifnot(inherits(vs, "FutureInterruptError"))

  message("Assert that all futures are resolved by value()")
  rs <- resolved(fs)
  print(rs)
  stopifnot(all(rs))

  message(sprintf("inorder = %s ... done", inorder))
}

message("Shut down future backend")
plan(sequential)
