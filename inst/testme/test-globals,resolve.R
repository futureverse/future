#' @tags globals resolve
#' @tags listenv
#' @tags multisession
#' @tags skip_on_cran

library(future)
library(listenv)

## Make sure futures are automatically resolved
oopts <- c(oopts, options(future.globals.resolve = TRUE))
setTimeLimit(cpu = 10, elapsed = 10, transient = TRUE)

message("*** Tricky use cases related to globals (part 2) ...")

## Allow for two background processes
plan(multisession, workers = 2L)

env <- new.env()

## Create future #1 (consumes background process #1)
env$a %<-% { 5 }

## Create future #2 (consumes background process #2)
b %<-% { "a" }

## Resolve future #2 (frees up background process #2)
message(sprintf("b = %s\n", sQuote(b)))

## Create future #3 (consumes background process #2)
## THIS IS THE TRICKY PART:
## Two globals are identified `env` and `b` and both are resolved.
## However, object `env[[b]]` (here element `a` of environment `env`)
## is not touched and therefore not resolved (since it is a future)
## unless environment `env` is resolved recursively. (Issue #49)
y %<-% { env[[b]] }

## Resolve future #3
message(sprintf("y = %s\n", y))

## Resolve future #1 if not already done
str(as.list(env))

## Create future #4
## Since future #1 is resolved it will work at this point
y %<-% { env[[b]] }
## Resolve future #4
message(sprintf("y = %s\n", y))

## Create future #5
f <- future(42)
g <- future({ value(f) }, lazy = TRUE)
## Assert that global 'f' of future 'g' is resolved
stopifnot(
  inherits(g[["globals"]][["f"]], "Future"),
  inherits(g[["globals"]][["f"]], "ConstantFuture")
)

message("*** Tricky use cases related to globals (part 2) ... DONE")

## Cleanup
setTimeLimit()
