#' @tags utils-internal import

library(future)

import_from <- future:::import_from
import_parallelly <- future:::import_parallelly
import_parallel <- future:::import_parallel
import_parallel_fcn <- future:::import_parallel_fcn

## NOTE: Only *exported* functions are used below, so that these tests do not
## depend on internals of other packages

message("*** import_from() ...")

## An existing function is returned
fcn <- import_from("makeClusterPSOCK", package = "parallelly")
stopifnot(is.function(fcn))
stopifnot(identical(fcn, parallelly::makeClusterPSOCK))

## Other modes work too
obj <- import_from("letters", mode = "any", package = "base")
stopifnot(identical(obj, letters))

## A missing name with a default gives the default
stopifnot(identical(
  import_from("<no such function>", default = 42L, package = "parallelly"),
  42L
))

## A missing name without a default is an error
res <- tryCatch(import_from("<no such function>", package = "parallelly"),
                error = identity)
print(res)
stopifnot(inherits(res, "error"))
stopifnot(grepl("<no such function>", conditionMessage(res), fixed = TRUE))

message("*** import_from() ... DONE")


message("*** import_parallelly() and import_parallel() ...")

stopifnot(is.function(import_parallelly("makeClusterPSOCK")))
stopifnot(is.function(import_parallel("makeCluster")))

res <- tryCatch(import_parallelly("<no such function>"), error = identity)
stopifnot(inherits(res, "error"))

message("*** import_parallelly() and import_parallel() ... DONE")


message("*** import_parallel_fcn() ...")

## An existing function is returned as is
stopifnot(is.function(import_parallel_fcn("makeCluster")))

## A missing one falls back to a stub that errors when called
stub <- import_parallel_fcn("<no such function>")
stopifnot(is.function(stub))
res <- tryCatch(stub(), error = identity)
print(res)
stopifnot(inherits(res, "error"))
stopifnot(grepl("<no such function>", conditionMessage(res), fixed = TRUE))

message("*** import_parallel_fcn() ... DONE")
