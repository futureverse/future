#' @tags invalid-owner
#' @tags detritus-files
#' @tags multisession

library(future)
options(future.debug = FALSE)

## Local functions
usedNodes <- function(future) {
  backend <- future[["backend"]]
  ## Number of unresolved cluster futures
  workers <- backend[["workers"]]
  reg <- backend[["reg"]]
  c(used = length(future:::FutureRegistry(reg, action = "list")), total = length(workers))
}

## This test requires at least two background processes
plan(multisession, workers = 2L)

message("*** future() - invalid ownership ...")

## This R process
session_uuid <- future:::session_uuid(attributes = TRUE)
cat(sprintf("Main R process: %s\n", session_uuid))

message("- Asserting ownership ...")

message("Creating future #1:")
f1 <- future({ future:::session_uuid(attributes = TRUE) })
stopifnot(inherits(f1, "MultisessionFuture"))
cat(sprintf("Future #1 session: %d\n", f1$node))
v1 <- value(f1)
cat(sprintf("Future #1 R process: %s\n", v1))
stopifnot(v1 != session_uuid)

message("Creating future #2:")
f2 <- future({ future:::session_uuid(attributes = TRUE) })
stopifnot(inherits(f2, "MultisessionFuture"))
cat(sprintf("Future #2 session: %d\n", f2$node))
v2 <- value(f2)
cat(sprintf("Future #2 R process: %s\n", v2))
stopifnot(v2 != session_uuid)

message("Creating future #3:")
f3 <- future({ f1$owner })
stopifnot(inherits(f3, "MultisessionFuture"))
cat(sprintf("Future #3 session: %d\n", f3$node))
v3 <- value(f3)
cat(sprintf("Future #3 owner: %s\n", v3))
stopifnot(v3 == session_uuid)

message("Creating future #4:")
f4 <- future({ f1$owner })
stopifnot(inherits(f4, "MultisessionFuture"))
cat(sprintf("Future #4 session: %d\n", f4$node))
v4 <- value(f4)
cat(sprintf("Future #4 owner: %s\n", v4))
stopifnot(v4 == session_uuid)

message("Creating future #5:")
f5 <- future({ stopifnot(f1$owner != future:::session_uuid(attributes = TRUE)); "not-owner" })
stopifnot(inherits(f5, "MultisessionFuture"))
v5 <- value(f5)
stopifnot(v5 == "not-owner")

message("- Asserting ownership ... DONE")


message("- Trying with invalid ownership ...")

message("Creating future #1:")
f1 <- future({ 42L })
## FIXME: print() calls resolved(), which triggers a result() collection,
## and future 'f1' to become resolved.  This means future 'f2' below
## may launch on the same worker as 'f1'.  So, don't resolve().
# print(f1)
cat(sprintf("Future #1 session: %d\n", f1$node))
stopifnot(identical(f1$owner, session_uuid))
print(usedNodes(f1))

message("Creating future #2:")
f2 <- future({ value(f1) })
print(f2)
cat(sprintf("Future #2 session: %d\n", f2$node))
stopifnot(identical(f2$owner, session_uuid))
print(usedNodes(f2))

message("Getting value of future #2:")
res <- tryCatch(value(f2), error = identity)
print(res)
stopifnot(inherits(res, "error"))

v1 <- value(f1)
print(v1)
stopifnot(v1 == 42L)

message("- Trying with invalid ownership ... DONE")

message("*** future() - invalid ownership ... DONE")

