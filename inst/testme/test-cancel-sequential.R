#' @tags cancel
#' @tags sequential

library(future)
options(future.debug = FALSE)

plan(sequential)

## A sequential future is resolved already when created, but canceling it
## still makes it invalid
for (interrupt in c(TRUE, FALSE)) {
  message(sprintf("interrupt = %s ...", interrupt))

  message("  Cancel a sequential future")
  f <- future(42)
  stopifnot(f[["state"]] == "finished", resolved(f))
  f <- cancel(f, interrupt = interrupt)
  stopifnot(f[["state"]] == "canceled", resolved(f))

  message("  value() on a canceled future signals an error")
  v <- tryCatch(value(f), error = identity)
  stopifnot(inherits(v, "FutureCanceledError"))

  message("  ... also the second time")
  v <- tryCatch(value(f), error = identity)
  stopifnot(inherits(v, "FutureCanceledError"))

  message("  Canceling a canceled future")
  f <- cancel(f, interrupt = interrupt)
  v <- tryCatch(value(f), error = identity)
  stopifnot(inherits(v, "FutureCanceledError"))

  message("  Cancel a sequential future that has already been collected")
  f <- future(42)
  stopifnot(value(f) == 42)
  f <- cancel(f, interrupt = interrupt)
  v <- tryCatch(value(f), error = identity)
  stopifnot(inherits(v, "FutureCanceledError"))

  message("  Cancel a sequential future that produced an error")
  f <- future(stop("boom"))
  f <- cancel(f, interrupt = interrupt)
  v <- tryCatch(value(f), error = identity)
  stopifnot(inherits(v, "FutureCanceledError"))

  message(sprintf("interrupt = %s ... done", interrupt))
}

message("Cancel a lazy future, which is then never launched")
f <- future(stop("Launched"), lazy = TRUE)
stopifnot(f[["state"]] == "created")
f <- cancel(f)
stopifnot(f[["state"]] == "canceled", resolved(f))
v <- tryCatch(value(f), error = identity)
stopifnot(inherits(v, "FutureCanceledError"))

message("Canceling a lazy future that is already canceled is harmless")
f <- cancel(f, interrupt = FALSE)
v <- tryCatch(value(f), error = identity)
stopifnot(inherits(v, "FutureCanceledError"))

message("A canceled lazy future can be reset and launched")
f <- reset(f)
v <- tryCatch(value(f), error = identity)
stopifnot(inherits(v, "simpleError"), conditionMessage(v) == "Launched")

message("Canceling a dropped future leaves it as dropped")
f <- future(42)
stopifnot(value(f, drop = TRUE) == 42)
f <- cancel(f)
v <- tryCatch(value(f), error = identity)
stopifnot(inherits(v, "FutureDroppedError"))

message("A canceled future can be reset and launched again")
f <- future(42)
f <- cancel(f)
f <- reset(f)
stopifnot(value(f) == 42)

message("A canceled future does not affect other futures")
f1 <- future(1)
f2 <- future(2)
cancel(f1)
stopifnot(value(f2) == 2)
