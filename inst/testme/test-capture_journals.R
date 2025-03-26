#' @tags journals
#' @tags multisession

library(future)

capture_journals <- future:::capture_journals

message("*** capture_journals() ...")

slow_fcn <- function(x) {
  Sys.sleep(0.01 * (1 + 1/x))
}

plan(multisession, workers = 2)
js <- capture_journals({
  fs <- lapply(3:1, FUN = function(x) future(slow_fcn(x)))
  vs <- value(fs)
})
print(js)
stopifnot(
  is.list(js),
  all(vapply(js, FUN = is.data.frame, FUN.VALUE = NA))
)
  
## Shut down parallel workers
plan(sequential)

message("*** capture_journals() ... done")


message("*** summary() of FutureJournal ...")

js <- do.call(rbind, js)
print(js)

stats <- summary(js)
print(stats)

message("*** summary() of FutureJournal ... done")
