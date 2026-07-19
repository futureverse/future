#' @tags FutureResult FutureGlobals FutureCondition sequential

library(future)

plan(sequential)

assertFutureResult <- future:::assertFutureResult
UnexpectedFutureResultError <- future:::UnexpectedFutureResultError
DeviceMisuseFutureCondition <- future:::DeviceMisuseFutureCondition
FutureLaunchError <- future:::FutureLaunchError

message("*** FutureResult ...")

r <- FutureResult(value = 42L, version = "1.8")
print(class(r))
stopifnot(inherits(r, "FutureResult"))

## as.character() summarises the result
s <- as.character(r)
print(s)
stopifnot(is.character(s), length(s) == 1L)

## Long values are truncated in the summary
r2 <- FutureResult(value = paste(rep("x", times = 100L), collapse = ""),
                   stdout = paste(rep("y", times = 100L), collapse = ""),
                   version = "1.8")
s2 <- as.character(r2)
print(s2)
stopifnot(is.character(s2), grepl("...", s2, fixed = TRUE))

## NULL and zero-length fields are summarised too
r3 <- FutureResult(value = NULL, stdout = character(0L), version = "1.8")
s3 <- as.character(r3)
print(s3)
stopifnot(is.character(s3), grepl("NULL", s3, fixed = TRUE))

message("*** FutureResult ... DONE")


message("*** assertFutureResult() ...")

f <- future(42L, lazy = TRUE)

## A result without a uuid is accepted
f[["result"]] <- FutureResult(value = 42L, version = "1.8")
stopifnot(is.null(assertFutureResult(f)))
stopifnot(is.null(assertFutureResult(f, debug = TRUE)))

## A result whose uuid matches is accepted
f[["result"]][["uuid"]] <- f[["uuid"]]
stopifnot(is.null(assertFutureResult(f)))
stopifnot(is.null(assertFutureResult(f, debug = TRUE)))

## A result from another future is rejected, and the reported message
## identifies the mismatching UUIDs
f[["result"]][["uuid"]] <- c("some-other-uuid", "2")
res <- tryCatch(assertFutureResult(f), error = identity)
print(res)
stopifnot(inherits(res, "UnexpectedFutureResultError"),
          inherits(res, "FutureError"))
msg <- conditionMessage(res)
stopifnot(grepl("is from another future", msg),
          grepl("some-other-uuid", msg))

message("*** assertFutureResult() ... DONE")


message("*** FutureGlobals ...")

## A FutureGlobals object wraps a 'Globals' object, which requires a
## 'where' attribute naming the environment each global came from
mkglobals <- function(names, values, size, resolved = TRUE) {
  where <- rep(list(globalenv()), times = length(names))
  names(where) <- names
  values <- as.list(values)
  names(values) <- names
  obj <- structure(values, class = "Globals", where = where)
  FutureGlobals(obj, resolved = resolved, total_size = size)
}

g1 <- mkglobals("a", 1, size = 10)
g2 <- mkglobals("b", 2, size = 20)
g3 <- mkglobals("c", 3, size = 30, resolved = FALSE)

## Concatenating with nothing returns the object as-is
stopifnot(identical(c(g1), g1))

## Sizes and 'resolved' flags are combined
g <- c(g1, g2)
print(names(g))
stopifnot(inherits(g, "FutureGlobals"), length(g) == 2L)
stopifnot(isTRUE(attr(g, "resolved")))
stopifnot(identical(attr(g, "total_size"), 30))

## An unresolved input makes the result unresolved
g <- c(g1, g3)
stopifnot(!isTRUE(attr(g, "resolved")))

## unique() keeps the attributes
g <- unique(c(g1, g2))
stopifnot(inherits(g, "FutureGlobals"), length(g) == 2L)
stopifnot(isTRUE(attr(g, "resolved")))

## unique() of an empty set is a no-op
g0 <- mkglobals(character(0L), list(), size = 0)
stopifnot(length(unique(g0)) == 0L)

## resolve() on globals
g <- resolve(g1)
stopifnot(inherits(g, "FutureGlobals"))

message("*** FutureGlobals ... DONE")


message("*** FutureCondition constructors ...")

f <- future(42L, lazy = TRUE)

## UnexpectedFutureResultError
c1 <- UnexpectedFutureResultError(f)
print(class(c1))
stopifnot(inherits(c1, "FutureError"), inherits(c1, "condition"))

c1 <- UnexpectedFutureResultError(f, hint = "a hint")
stopifnot(inherits(c1, "FutureError"),
          grepl("a hint", conditionMessage(c1)))

## DeviceMisuseFutureCondition and its Default* variants
c2 <- DeviceMisuseFutureCondition(message = "device misuse", future = f)
print(class(c2))
stopifnot(inherits(c2, "DeviceMisuseFutureCondition"))

c3 <- DefaultDeviceMisuseFutureWarning(message = "default device misuse",
                                       future = f)
print(class(c3))
stopifnot(inherits(c3, "DefaultDeviceMisuseFutureWarning"),
          inherits(c3, "warning"))

c4 <- DefaultDeviceMisuseFutureError(message = "default device misuse",
                                     future = f)
print(class(c4))
stopifnot(inherits(c4, "DefaultDeviceMisuseFutureError"),
          inherits(c4, "error"))

## FutureLaunchError
c5 <- FutureLaunchError(message = "could not launch", future = f)
print(class(c5))
stopifnot(inherits(c5, "FutureError"), inherits(c5, "error"))

message("*** FutureCondition constructors ... DONE")

plan(sequential)
