#' @tags relaying immediateConditions
#' @tags cluster

library(future)
options(future.debug = FALSE)

message("*** immediateCondition:s without a relay handler ...")

## Disable the PSOCK immediateCondition relay handler. This mimics
## backends that cannot relay immediateCondition:s as soon as possible,
## e.g. future.mirai::mirai_cluster and MPI clusters. Such conditions
## must still be relayed by value(), but only once.
oopts <- options(future.psock.relay.immediate = FALSE)

cond <- structure(
  class = c("myImmediateCondition", "immediateCondition", "condition"),
  list(message = "hello", call = NULL)
)

plan(cluster, workers = 1L)

count <- 0L
f <- withCallingHandlers({
  future({ signalCondition(cond); 42L })
}, myImmediateCondition = function(c) count <<- count + 1L)

withCallingHandlers({
  v <- value(f)
}, myImmediateCondition = function(c) count <<- count + 1L)
message(sprintf("count after first value(): %d", count))
stopifnot(identical(v, 42L), count == 1L)

## Querying again must not re-signal
withCallingHandlers({
  r <- resolved(f)
  v <- value(f)
}, myImmediateCondition = function(c) count <<- count + 1L)
message(sprintf("count after second value(): %d", count))
stopifnot(identical(v, 42L), count == 1L)

## A cluster node that evaluates in the current R process must not
## relay the same immediateCondition twice
if ("makeClusterSequential" %in% getNamespaceExports("parallelly")) {
  plan(cluster, workers = parallelly::makeClusterSequential())
  count <- 0L
  withCallingHandlers({
    f <- future({ signalCondition(cond); 42L })
    v <- value(f)
    v <- value(f)
  }, myImmediateCondition = function(c) count <<- count + 1L)
  message(sprintf("count with in-process cluster node: %d", count))
  stopifnot(identical(v, 42L), count == 1L)
}

plan(sequential)
options(oopts)

message("*** immediateCondition:s without a relay handler ... DONE")
