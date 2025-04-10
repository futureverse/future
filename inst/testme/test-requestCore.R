#' @tags requestCore
#' @tags multicore

library(future)

message("*** requestCore() ...")

message("*** requestCore() - exceptions ...")

## There are no cores to choose from
res <- try(requestCore(function() {}, workers = 0), silent = TRUE)
stopifnot(inherits(res, "try-error"))

res <- try(requestCore(function() {}, timeout = -1.0), silent = TRUE)
stopifnot(inherits(res, "try-error"))

res <- try(requestCore(function() {}, alpha = 0.0), silent = TRUE)
stopifnot(inherits(res, "try-error"))

message("*** requestCore() - exceptions ... DONE")


if (supportsMulticore()) {
  message("*** requestCore() - timeout ...")
  
  plan(multicore, workers = 2L)
  a %<-% { Sys.sleep(0.2); 1 }
  
  ## Fake single-worker multicore by using workers = 1L
  res <- try(requestCore(function() {}, workers = 1L, timeout = 0.5, delta = 0.1))
  stopifnot(inherits(res, "try-error"))
  stopifnot(a == 1)
  
  message("*** requestCore() - timeout ... DONE")
}

message("*** requestCore() ... DONE")

