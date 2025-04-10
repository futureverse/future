#' @tags relaying
#' @tags sequential

library(future)

options(future.debug = FALSE)

message("*** withRestart() and muffling ...")

## https://github.com/futureverse/future/issues/485
fcn <- function(...) {
  withRestarts({
    cond <- simpleCondition("boom")
    class(cond) <- c("not_me", class(cond))
    signalCondition(cond)
    "success"
  }, muffleSomething = function() {
    message("Condition muffled")
    "weird"
  })
}

message(" - split = TRUE")
## Splitting output works
f <- future(fcn(), split = TRUE)
v <- value(f)
message("RESULT: ", v)
stopifnot(v == "success")

message(" - muffleInclude = '^$'")
f <- future(fcn(), conditions = structure("condition", muffleInclude = "^$"))
v <- value(f)
message("RESULT: ", v)
stopifnot(v == "success")

message(" - FIXME")
## FIXME: Ignoring specific condition class 'not_me' does not work
f <- future(fcn(), conditions = structure("condition", exclude = "not_me"))
v <- value(f)
message("RESULT: ", v)
if (isTRUE(as.logical(Sys.getenv("R_CHECK_IDEAL")))) {
  stopifnot(v == "success")
}

## FIXME: Deprecate 'conditions = NULL' /HB 2025-02-16
message(" - conditions = NULL (not recommended)")
## Disabling relaying conditions works
f <- future(fcn(), conditions = NULL)
v <- value(f)
message("RESULT: ", v)
stopifnot(v == "success")

message("*** withRestart() and muffling ... DONE")

