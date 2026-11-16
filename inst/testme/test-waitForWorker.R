#' @tags waitForWorker
#' @tags FutureRegistry
#' @tags sequential

library(future)

waitForWorker <- future:::waitForWorker

message("*** waitForWorker() ...")

reg <- sprintf("waitForWorker-test-%s", future:::session_uuid())
backend <- list(reg = reg, timeout = 0.5, delta = 0.01, alpha = 1.01)

message("- returns immediately when no worker is occupied")
dt <- system.time(waitForWorker(backend, workers = 1L))[["elapsed"]]
print(dt)
stopifnot(dt < 0.5)

message("- returns immediately when there are infinitely many workers")
f <- future(1, lazy = TRUE)
FutureRegistry(reg, action = "add", future = f, earlySignal = FALSE)
stopifnot(length(FutureRegistry(reg, action = "list", earlySignal = FALSE)) == 1L)
waitForWorker(backend, workers = Inf)

message("- times out when all workers remain occupied")
## A lazy future is never launched, so it occupies its worker forever
res <- tryCatch(waitForWorker(backend, workers = 1L), error = identity)
print(res)
stopifnot(
  inherits(res, "FutureError"),
  grepl("TIMEOUT", conditionMessage(res))
)

message("- the 'timeout' argument overrides the backend field")
res <- tryCatch(waitForWorker(backend, workers = 1L, timeout = 0), error = identity)
stopifnot(inherits(res, "FutureError"))
FutureRegistry(reg, action = "reset")

message("- returns when a resolved future is collected")
f <- future(2)
FutureRegistry(reg, action = "add", future = f, earlySignal = FALSE)
waitForWorker(backend, workers = 1L, debug = TRUE)
stopifnot(length(FutureRegistry(reg, action = "list", earlySignal = FALSE)) == 0L)

message("- polls the registry given by argument 'registry'")
## A fake registry, which reports one occupied worker until a future
## has been collected
calls <- character(0L)
collected <- FALSE
fake_registry <- function(where, action, ...) {
  stopifnot(identical(where, reg))
  calls <<- c(calls, action)
  if (action == "list") {
    if (collected) list() else list(NULL)
  } else if (action == "collect-first") {
    collected <<- TRUE
    invisible(NULL)
  }
}
waitForWorker(backend, workers = 1L, registry = fake_registry)
print(calls)
stopifnot(identical(calls, c("list", "collect-first", "list")))
## The registry in 'future' was not touched
stopifnot(length(FutureRegistry(reg, action = "list", earlySignal = FALSE)) == 0L)

message("- falls back to the 'wait.*' fields of the backend")
backend2 <- list(reg = reg, wait.timeout = 0.5, wait.interval = 0.01, wait.alpha = 1.01)
waitForWorker(backend2, workers = 1L)
f <- future(1, lazy = TRUE)
FutureRegistry(reg, action = "add", future = f, earlySignal = FALSE)
dt <- system.time({
  res <- tryCatch(waitForWorker(backend2, workers = 1L), error = identity)
})[["elapsed"]]
print(res)
print(dt)
stopifnot(
  inherits(res, "FutureError"),
  grepl("TIMEOUT", conditionMessage(res)),
  dt < 10
)
FutureRegistry(reg, action = "reset")

message("- the 'wait.*' fields take precedence over 'timeout', 'delta', and 'alpha'")
## E.g. a cluster backend, where 'timeout' is the makeClusterPSOCK() timeout
backend3 <- list(reg = reg, timeout = 3600, wait.timeout = 0.5, wait.interval = 0.01, wait.alpha = 1.01)
f <- future(1, lazy = TRUE)
FutureRegistry(reg, action = "add", future = f, earlySignal = FALSE)
dt <- system.time({
  res <- tryCatch(waitForWorker(backend3, workers = 1L), error = identity)
})[["elapsed"]]
print(dt)
stopifnot(inherits(res, "FutureError"), dt < 10)
FutureRegistry(reg, action = "reset")

if (parallelly::supportsMulticore() && availableCores() >= 2L) {
  message("- works with the built-in multicore backend")
  plan(multicore, workers = 2L)
  waitForWorker(plan("backend"))
  plan(sequential)
}

message("- invalid arguments")
res <- tryCatch(waitForWorker(backend, workers = 0L), error = identity)
stopifnot(inherits(res, "error"))
res <- tryCatch(waitForWorker(backend, workers = 1L, delta = 0), error = identity)
stopifnot(inherits(res, "error"))
res <- tryCatch(waitForWorker(backend, workers = 1L, registry = reg), error = identity)
stopifnot(inherits(res, "error"))

FutureRegistry(reg, action = "reset")

message("*** waitForWorker() ... DONE")
