#' @tags futureOf
#' @tags listenv environment
#' @tags sequential

library(future)
library(listenv)

message("*** futureOf() ...")

a %<-% { 1 } %lazy% TRUE

f1 <- futureOf("a")
print(f1)
f2 <- futureOf(a)
print(f2)
stopifnot(identical(f2, f1))

## Get all futures in the current environment
fs <- futureOf(drop = TRUE)
print(fs)
stopifnot(
  is.list(fs),
  length(fs) == 3L,
  all(names(fs) %in% c("a", "f1", "f2"))
)

## Non-existing object
res <- tryCatch(futureOf("non-exiting-object", mustExist = TRUE), error = identity)
stopifnot(inherits(res, "error"))

message("*** futureOf() ... DONE")

