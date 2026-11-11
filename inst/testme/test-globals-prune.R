#' @tags skip_on_cran
library(future)
size_of <- function(x) length(serialize(x, NULL))
prune <- function(expr, envir = parent.frame(), ...) {
  options(future.disposable = structure(list(prune = TRUE), dispose = FALSE))
  on.exit(options(future.disposable = NULL))
  getGlobalsAndPackages(expr, envir = envir, globals = TRUE, ...)
}

make_fcn <- function() {
  unused <- numeric(1e6)
  used <- 1:10
  offset <- 3
  helper <- function(z) z + offset
  eps <- 2
  function(i) {
    eps <- eps * min(i)
    helper(i) + length(used) + eps
  }
}

plan(multisession, workers = 2L)

message("Not pruned unless requested")
FUN <- make_fcn()
gp <- getGlobalsAndPackages(quote(FUN(1:3)), globals = TRUE)
stopifnot(size_of(gp$globals) > 1e6)

message("Unused variables are dropped, used ones are kept (incl. use before assignment)")
gp <- prune(quote(FUN(1:3)))
stopifnot(size_of(gp$globals) < 1e4)
FUN_pruned <- gp$globals[["FUN"]]
stopifnot(identical(FUN_pruned(1:3), FUN(1:3)))

message("A pruned closure environment records that it has been pruned")
marker <- "...future.pruned"
env <- environment(FUN_pruned)
stopifnot(exists(marker, envir = env, inherits = FALSE))
stopifnot(identical(get(marker, envir = env, inherits = FALSE), "unused"))
stopifnot(!exists(marker, envir = environment(FUN), inherits = FALSE))
stopifnot(future:::isClosureEnvironmentPruned(FUN_pruned), !future:::isClosureEnvironmentPruned(FUN))

message("The hidden argument 'prune' of getGlobalsAndPackages()")
## It works without the 'future.disposable' option and takes precedence over it
gp <- getGlobalsAndPackages(quote(FUN(1:3)), globals = TRUE)
stopifnot(size_of(gp$globals) > 1e6)
gp <- getGlobalsAndPackages(quote(FUN(1:3)), globals = TRUE, prune = TRUE)
stopifnot(size_of(gp$globals) < 1e4)
options(future.disposable = structure(list(prune = TRUE), dispose = FALSE))
gp <- getGlobalsAndPackages(quote(FUN(1:3)), globals = TRUE, prune = FALSE)
options(future.disposable = NULL)
stopifnot(size_of(gp$globals) > 1e6)

## TRUE and "closure" are the same
gp <- getGlobalsAndPackages(quote(FUN(1:3)), globals = TRUE, prune = "closure")
stopifnot(size_of(gp$globals) < 1e4)

## Not pruned for sequential processing
plan(sequential)
gp <- getGlobalsAndPackages(quote(FUN(1:3)), globals = TRUE, prune = TRUE)
stopifnot(size_of(gp$globals) > 1e6)
plan(multisession, workers = 2L)

message("Parsing of what to prune")
parsePrune <- future:::parsePrune
stopifnot(identical(parsePrune(NULL), list()), identical(parsePrune(FALSE), list()), identical(parsePrune(character(0)), list()))
stopifnot(identical(parsePrune(TRUE), list(closure = TRUE)))
stopifnot(identical(parsePrune("closure"), list(closure = TRUE)))
## An explicit FALSE takes precedence over the option
options(future.disposable = structure(list(prune = "closure"), dispose = FALSE))
stopifnot(identical(parsePrune(NULL), list(closure = TRUE)), identical(parsePrune(FALSE), list()))
options(future.disposable = NULL)
## Invalid values
for (value in list("unguarded", "formula", "closure:guarded", "closure:unguarded", 42, NA_character_)) {
  res <- tryCatch(parsePrune(value), error = identity)
  stopifnot(inherits(res, "error"))
}

message("The record stays with the function when it is part of a list")
lst <- list(a = 1, nested = list(x = "x", fun = FUN_pruned))
stopifnot(future:::isClosureEnvironmentPruned(lst$nested$fun))

message("The record survives serialization")
fun_copy <- unserialize(serialize(FUN_pruned, NULL))
stopifnot(future:::isClosureEnvironmentPruned(fun_copy))
stopifnot(identical(get(marker, envir = environment(fun_copy), inherits = FALSE), "unused"))

message("Pruning a function that has been pruned is a no-op")
stopifnot(identical(future:::pruneClosureEnvironment(FUN_pruned), FUN_pruned))

message("Dropped variables produce an informative error if accessed")
res <- tryCatch(get("unused", envir = environment(FUN_pruned)), error = identity)
stopifnot(inherits(res, "error"), grepl("dropped", conditionMessage(res)))

message("The size check is applied to the pruned globals")
oopts <- options(future.globals.maxSize = 1e6)
res <- tryCatch(getGlobalsAndPackages(quote(FUN(1:3)), globals = TRUE), error = identity)
stopifnot(inherits(res, "error"))
gp <- prune(quote(FUN(1:3)))
options(oopts)

message("What was pruned is reported when debugging")
oopts <- options(future.debug = TRUE)
out <- capture.output(gp <- prune(quote(FUN(1:3))), type = "message")
options(oopts)
stopifnot(any(grepl("Pruned the closure environments", out)), any(grepl("unused", out)))

message("Pruned globals can be used in futures")
options(future.disposable = structure(list(prune = TRUE), dispose = FALSE))
f <- future(FUN(1:3))
options(future.disposable = NULL)
stopifnot(identical(value(f), FUN(1:3)))

message("Pruning is unguarded: dynamic variable lookups are not detected")
make_fcn_dynamic <- function() {
  secret <- 100
  unused <- numeric(1e6)
  function(i) get("secret") + i
}
FUN <- make_fcn_dynamic()
gp <- prune(quote(FUN(1)))
stopifnot(size_of(gp$globals) < 1e4)
res <- tryCatch(gp$globals[["FUN"]](1), error = identity)
stopifnot(inherits(res, "error"), grepl("dropped", conditionMessage(res)))

message("Dynamic lookups in functions that are not pruned do not matter")
## The worker function calls a function in the global environment that uses
## do.call(), which does not affect the environment of the worker function
helper_global <- function(x) do.call("c", x)
make_fcn_global <- function() {
  unused <- numeric(1e6)
  function(i) helper_global(list(i, i))
}
FUN <- make_fcn_global()
gp <- prune(quote(FUN(1)))
stopifnot(size_of(gp$globals) < 1e4)
stopifnot(identical(gp$globals[["FUN"]](1), FUN(1)))

message("get() with an explicit environment in the closure works")
make_fcn_explicit <- function() {
  aux <- new.env(parent = emptyenv())
  assign("v", 2, envir = aux)
  unused <- numeric(1e6)
  function(i) get("v", aux) + i
}
FUN <- make_fcn_explicit()
gp <- prune(quote(FUN(1)))
stopifnot(size_of(gp$globals) < 1e4)
stopifnot(identical(gp$globals[["FUN"]](1), FUN(1)))

message("Nothing is done if there are no unused variables to drop")
make_all_used <- function(...) {
  a <- 1
  b <- 2
  function(i) i + a + b
}
FUN <- make_all_used(42)
gp <- prune(quote(FUN(1)))
stopifnot(identical(environment(gp$globals[["FUN"]]), environment(FUN)))
stopifnot(!future:::isClosureEnvironmentPruned(gp$globals[["FUN"]]))
## A function that was left as-is is current with respect to itself
stopifnot(isTRUE(future:::isPrunedClosureEnvironmentCurrent(FUN, FUN)))

message("Nested frames are pruned, and functions in all frames are repointed")
make_nested <- function() {
  unused_outer <- numeric(1e6)
  scale <- 2
  helper <- function(z) z * scale
  local({
    unused_inner <- numeric(1e6)
    offset <- 1
    inner_helper <- function(z) z + offset
    function(i) inner_helper(helper(i))
  })
}
FUN <- make_nested()
gp <- prune(quote(FUN(3)))
stopifnot(size_of(gp$globals) < 1e4)
stopifnot(identical(gp$globals[["FUN"]](3), FUN(3)))

message("A frame pruned before keeps its dropped variables dropped")
FUN <- make_fcn()
FUN_pruned <- prune(quote(FUN(1:3)))$globals[["FUN"]]
## A function whose enclosing frame is the pruned frame
g <- evalq(function(i) used[i], new.env(parent = environment(FUN_pruned)))
gp <- prune(quote(g(2)))
g_pruned <- gp$globals[["g"]]
stopifnot(identical(g_pruned(2), 2L))
res <- tryCatch(get("unused", envir = parent.env(environment(g_pruned))), error = identity)
stopifnot(inherits(res, "error"), grepl("dropped", conditionMessage(res)))

message("Active bindings")
make_active <- function() {
  k <- 0
  unused <- numeric(1e6)
  makeActiveBinding("counter", function() { k <<- k + 1; k }, environment())
  makeActiveBinding("boom", function() stop("must not be evaluated"), environment())
  function(i) c(counter, counter)
}
FUN <- make_active()
gp <- prune(quote(FUN(1)))
if (getRversion() >= "4.4.0") {
  FUN_pruned <- gp$globals[["FUN"]]
  stopifnot(size_of(gp$globals) < 1e4)
  ## A used active binding stays active
  env <- environment(FUN_pruned)
  stopifnot(bindingIsActive("counter", env))
  y <- FUN_pruned(1)
  stopifnot(y[2] == y[1] + 1)
  ## An unused active binding is dropped without being evaluated
  res <- tryCatch(get("boom", envir = env), error = identity)
  stopifnot(inherits(res, "error"), grepl("dropped", conditionMessage(res)))
  ## Checking the cache does not evaluate active bindings
  FUN <- make_active()
  FUN_pruned <- prune(quote(FUN(1)))$globals[["FUN"]]
  k0 <- get("k", envir = environment(FUN))
  stopifnot(isTRUE(future:::isPrunedClosureEnvironmentCurrent(FUN, FUN_pruned)))
  stopifnot(identical(get("k", envir = environment(FUN)), k0))
} else {
  ## Not pruned, because active bindings cannot be copied in R (< 4.4.0)
  stopifnot(size_of(gp$globals) > 1e6)
}

message("Not pruned for sequential and multicore processing")
FUN <- make_fcn()
plan(sequential)
gp <- prune(quote(FUN(1:3)))
stopifnot(size_of(gp$globals) > 1e6)
