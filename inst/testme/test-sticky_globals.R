#' @tags utils-internal sticky-globals cluster

library(future)

sticky_globals <- future:::sticky_globals
clusterExportSticky <- future:::clusterExportSticky

name <- "future:sticky_globals"

## Always leave the search path the way we found it
on.exit({
  if (name %in% search()) sticky_globals(pos = 0L)
})

message("*** sticky_globals() ...")

stopifnot(!(name %in% search()))

## Attach immediately after the global environment
env <- sticky_globals()
stopifnot(is.environment(env), name %in% search(), search()[2] == name)

## Calling it again returns the same environment, keeping its content
env[["a"]] <- 42
env2 <- sticky_globals()
stopifnot(is.environment(env2), search()[2] == name, identical(env2[["a"]], 42))

message("*** sticky_globals() ... DONE")


message("*** sticky_globals(erase = TRUE) ...")

env3 <- sticky_globals(erase = TRUE)
stopifnot(is.environment(env3), search()[2] == name, is.null(env3[["a"]]))

message("*** sticky_globals(erase = TRUE) ... DONE")


message("*** sticky_globals(pos = 0L) ...")

## Detach
res <- sticky_globals(pos = 0L)
stopifnot(!(name %in% search()))

## Detaching when not attached does nothing
stopifnot(is.null(sticky_globals(pos = 0L)))
stopifnot(!(name %in% search()))

message("*** sticky_globals(pos = 0L) ... DONE")


message("*** sticky_globals() - invalid positions ...")

## Position 1 is the global environment, which cannot be used
res <- tryCatch(sticky_globals(pos = 1L), error = identity)
print(res)
stopifnot(inherits(res, "error"))

## The position must be on the search path
res <- tryCatch(sticky_globals(pos = length(search()) + 1L), error = identity)
print(res)
stopifnot(inherits(res, "error"))

stopifnot(!(name %in% search()))

message("*** sticky_globals() - invalid positions ... DONE")


message("*** clusterExportSticky() ...")

## The first argument must be a cluster
res <- tryCatch(clusterExportSticky(NULL, globals = list(a = 1)), error = identity)
print(res)
stopifnot(inherits(res, "error"))

cl <- parallelly::makeClusterPSOCK(1L)

## Read back the sticky globals of the cluster node
sticky_on_node <- function(cl) {
  parallel::clusterCall(cl, fun = function() {
    ns <- getNamespace("future")
    sticky_globals <- get("sticky_globals", mode = "function", envir = ns)
    env <- sticky_globals()
    mget(ls(envir = env, all.names = TRUE), envir = env)
  })[[1]]
}

## Nothing to export
res <- clusterExportSticky(cl, globals = list())
stopifnot(inherits(res, "cluster"))

## Export a named list of globals
res <- clusterExportSticky(cl, globals = list(a = 3.14, b = 1:3))
stopifnot(inherits(res, "cluster"))
got <- sticky_on_node(cl)
stopifnot(identical(got[["a"]], 3.14), identical(got[["b"]], 1:3))

## Sticky globals stay on the node across calls
res <- clusterExportSticky(cl, globals = list(c = "hello"))
got <- sticky_on_node(cl)
stopifnot(identical(got[["a"]], 3.14), identical(got[["c"]], "hello"))

## Globals may also be given by name, in which case their values are looked up
## IMPORTANT: Skip when testing with 'covr', because the names are resolved by
## get() from the calling frame, which does not reach the variables of a test
## script that 'covr' evaluates in an environment of its own
if (!covr_testing) {
  sticky_d <- list(1, 2, 3)
  res <- clusterExportSticky(cl, globals = "sticky_d")
  stopifnot(inherits(res, "cluster"))
  got <- sticky_on_node(cl)
  stopifnot(identical(got[["sticky_d"]], sticky_d))
}

## An unnamed list of globals is not allowed
res <- tryCatch(clusterExportSticky(cl, globals = list(1, 2)), error = identity)
print(res)
stopifnot(inherits(res, "error"))

## Globals that are not a list must be a character vector of names
res <- tryCatch(clusterExportSticky(cl, globals = 42), error = identity)
print(res)
stopifnot(inherits(res, "error"))

parallel::stopCluster(cl)

message("*** clusterExportSticky() ... DONE")
