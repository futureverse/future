#' @tags utils-internal cluster

library(future)

registerClusterTypes <- future:::registerClusterTypes
makeClusterPSOCK_args <- future:::makeClusterPSOCK_args

message("*** registerClusterTypes() ...")

## The 'FUTURE' cluster type is registered when the package is loaded
stopifnot(identical(future:::FUTURE, "future::FUTURE"))

env <- environment(registerClusterTypes)

## On R (>= 4.5.0) the type is registered with parallel
if (exists("registerClusterType", envir = getNamespace("parallel"))) {
  ## Calling it again is a no-op, because it has already been done
  stopifnot(isTRUE(env[["done"]]))
  stopifnot(is.null(registerClusterTypes()))
  
  ## Force it to run its body once more, which must be idempotent
  env[["done"]] <- FALSE
  registerClusterTypes()
  stopifnot(isTRUE(env[["done"]]) ||
            !exists("registerClusterType", envir = getNamespace("parallel")))

  stopifnot(isTRUE(env[["done"]]))
} else {
  ## On older R, registerClusterTypes() returns before setting 'done'
  stopifnot(isFALSE(env[["done"]]))
  env[["done"]] <- TRUE
}

message("*** registerClusterTypes() ... DONE")


message("*** makeClusterPSOCK_args() ...")

args <- makeClusterPSOCK_args()
print(args)
stopifnot(is.character(args), length(args) > 0L)

## '...' is never among the reported arguments
stopifnot(!("..." %in% args))

## The arguments are unique
stopifnot(!anyDuplicated(args))

## Arguments of both makeClusterPSOCK() and makeNodePSOCK() are included
stopifnot("workers" %in% args)

## The result is memoized, so a second call gives the same thing
stopifnot(identical(makeClusterPSOCK_args(), args))

## ... and recomputing from scratch gives the same result
env <- environment(makeClusterPSOCK_args)
env[[".args"]] <- NULL
stopifnot(identical(makeClusterPSOCK_args(), args))

message("*** makeClusterPSOCK_args() ... DONE")
