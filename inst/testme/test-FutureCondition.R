#' @tags FutureCondition conditions sequential

library(future)

plan(sequential)

message("*** FutureCondition() ...")

## A plain message
c1 <- FutureCondition("some message")
stopifnot(inherits(c1, "FutureCondition"), inherits(c1, "condition"))
stopifnot(grepl("some message", conditionMessage(c1), fixed = TRUE))

## An existing condition keeps its own classes
base_cond <- simpleWarning("wrapped message")
c2 <- FutureCondition(base_cond)
stopifnot(inherits(c2, "FutureCondition"), inherits(c2, "simpleWarning"))
stopifnot(grepl("wrapped message", conditionMessage(c2), fixed = TRUE))

## A NULL message is an internal error
res <- tryCatch(FutureCondition(NULL), error = identity)
print(res)
stopifnot(inherits(res, "error"))

## Metadata is carried on the condition
c3 <- FutureCondition("msg", uuid = "abc-123", label = "mylabel")
stopifnot(identical(attr(c3, "uuid"), "abc-123"))
stopifnot(identical(attr(c3, "label"), "mylabel"))
msg <- conditionMessage(c3)
stopifnot(grepl("abc-123", msg, fixed = TRUE), grepl("mylabel", msg, fixed = TRUE))

## Without a label, an '<unnamed-...>' label is used instead
msg <- conditionMessage(FutureCondition("msg", uuid = "xyz", label = NULL))
stopifnot(grepl("unnamed", msg, fixed = TRUE))

## A 'when' timestamp is reported
msg <- conditionMessage(FutureCondition("msg", when = "2026-01-01", by = NULL))
stopifnot(grepl("2026-01-01", msg, fixed = TRUE))

message("*** FutureCondition() ... DONE")


message("*** FutureCondition() - attached future ...")

f <- future(42L)
v <- value(f)

c4 <- FutureCondition("msg", future = f)
stopifnot(inherits(attr(c4, "future"), "Future"))

## The future is dropped when requested and the option allows it
local({
  oopts <- options(future.onFutureCondition.keepFuture = FALSE)
  on.exit(options(oopts))
  c5 <- FutureCondition("msg", future = f, drop = TRUE)
  stopifnot(is.null(attr(c5, "future")))
})

## ... but kept by default
local({
  oopts <- options(future.onFutureCondition.keepFuture = TRUE)
  on.exit(options(oopts))
  c6 <- FutureCondition("msg", future = f, drop = TRUE)
  stopifnot(inherits(attr(c6, "future"), "Future"))
})

## A non-Future is rejected
res <- tryCatch(FutureCondition("msg", future = 42L), error = identity)
print(res)
stopifnot(inherits(res, "error"))

message("*** FutureCondition() - attached future ... DONE")


message("*** print() for FutureCondition ...")

## Printing works with and without the various pieces of metadata
for (cond in list(
  FutureCondition("msg"),
  FutureCondition("msg", by = NULL, when = NULL),
  FutureCondition("msg", by = NULL, when = "2026-01-01"),
  FutureCondition("msg", uuid = NULL, label = NULL),
  FutureCondition("msg", future = f)
)) {
  out <- capture.output(res <- print(cond))
  stopifnot(inherits(res, "FutureCondition"))
  stopifnot(length(out) > 0L)
}

message("*** print() for FutureCondition ... DONE")


message("*** FutureMessage(), FutureWarning(), FutureError() ...")

cm <- FutureMessage("a message")
stopifnot(inherits(cm, "FutureMessage"), inherits(cm, "FutureCondition"),
          inherits(cm, "message"), inherits(cm, "condition"))

cw <- FutureWarning("a warning")
stopifnot(inherits(cw, "FutureWarning"), inherits(cw, "FutureCondition"),
          inherits(cw, "warning"))

ce <- FutureError("an error")
stopifnot(inherits(ce, "FutureError"), inherits(ce, "FutureCondition"),
          inherits(ce, "error"))

## They can be signalled
res <- tryCatch(stop(FutureError("boom")), error = identity)
stopifnot(inherits(res, "FutureError"))
res <- tryCatch(warning(FutureWarning("careful")), warning = identity)
stopifnot(inherits(res, "FutureWarning"))

message("*** FutureMessage(), FutureWarning(), FutureError() ... DONE")


message("*** RngFutureCondition() and friends ...")

rc <- RngFutureCondition()
stopifnot(inherits(rc, "RngFutureCondition"), inherits(rc, "FutureCondition"))
## A default message is generated when none is given
stopifnot(nchar(conditionMessage(rc)) > 0L)

rc2 <- RngFutureCondition("custom rng message")
stopifnot(grepl("custom rng message", conditionMessage(rc2), fixed = TRUE))

rw <- RngFutureWarning()
stopifnot(inherits(rw, "RngFutureWarning"), inherits(rw, "warning"))

re <- RngFutureError()
stopifnot(inherits(re, "RngFutureError"), inherits(re, "error"))

message("*** RngFutureCondition() and friends ... DONE")


message("*** misuse conditions ...")

for (fcns in list(
  list(GlobalEnvMisuseFutureCondition, GlobalEnvMisuseFutureWarning, GlobalEnvMisuseFutureError),
  list(ConnectionMisuseFutureCondition, ConnectionMisuseFutureWarning, ConnectionMisuseFutureError),
  list(DeviceMisuseFutureCondition, DeviceMisuseFutureWarning, DeviceMisuseFutureError)
)) {
  cond <- fcns[[1]]()
  stopifnot(inherits(cond, "FutureCondition"))
  stopifnot(nchar(conditionMessage(cond)) > 0L)

  w <- fcns[[2]]()
  stopifnot(inherits(w, "warning"), inherits(w, "FutureCondition"))

  e <- fcns[[3]]()
  stopifnot(inherits(e, "error"), inherits(e, "FutureCondition"))
}

## Differences are reported in the message
cond <- GlobalEnvMisuseFutureCondition(differences = list(added = c(a = 1)))
stopifnot(inherits(cond, "FutureCondition"))
print(cond)

cond <- DefaultDeviceMisuseFutureCondition(incidents = list(x = 1))
stopifnot(inherits(cond, "FutureCondition"))
print(cond)

message("*** misuse conditions ... DONE")


message("*** UnexpectedFutureResultError() ...")

e <- UnexpectedFutureResultError(f)
stopifnot(inherits(e, "UnexpectedFutureResultError"), inherits(e, "FutureError"))
stopifnot(nchar(conditionMessage(e)) > 0L)

e <- UnexpectedFutureResultError(f, hint = "a helpful hint")
stopifnot(grepl("a helpful hint", conditionMessage(e), fixed = TRUE))

message("*** UnexpectedFutureResultError() ... DONE")
