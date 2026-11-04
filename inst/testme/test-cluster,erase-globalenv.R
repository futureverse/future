#' @tags cluster
#' @tags globalenv

library(future)

## The test leaks variables into the global environment on purpose, so
## we need to disable the (default or 'R CMD check') misuse check
options(future.globalenv.onMisuse = "ignore")

message("*** cluster, erase global environment ...")
plan(cluster, workers = 1L)

## Try to "leak" objects into the global environment of the worker
f <- future({
  assign("..leak_assign..", 1, envir = globalenv())
  local({ ..leak_superassign.. <<- 2 })
  TRUE
})
stopifnot(value(f))

## The leaked objects must not be visible to the next future
f <- future(ls(envir = globalenv(), all.names = TRUE))
vars <- value(f)
print(vars)
stopifnot(!any(c("..leak_assign..", "..leak_superassign..") %in% vars))

## Objects already on the worker, e.g. exported before the first
## future, must not be visible to the future
cl <- parallel::makeCluster(1L)
parallel::clusterCall(cl, function() assign("..preexisting..", 1, envir = globalenv()))
plan(cluster, workers = cl)
f <- future(exists("..preexisting..", envir = globalenv(), inherits = FALSE))
stopifnot(!value(f))
plan(sequential)
parallel::stopCluster(cl)

message("*** cluster, erase global environment ... done")
