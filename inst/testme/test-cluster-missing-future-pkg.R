#' @tags worker-broken
#' @tags cluster

library(future)
options(future.debug = FALSE)

message("*** cluster() ...")

message("Library paths: ", commaq(.libPaths()))
message("Package path: ", sQuote(system.file(package = "future")))

types <- NULL
if (!covr_testing) types <- c(types, "PSOCK")
if (supportsMulticore()) types <- c(types, "FORK")

setupClusterWithoutPkgs <- function(type = "PSOCK", withouts = c("future"), debug = FALSE) {
  if (debug) {
    message("setupClusterWithoutPkgs() ...")
    on.exit(message("setupClusterWithoutPkgs() ... done"))
  }
  
  cl <- parallel::makeCluster(1L, type = type, timeout = 60)
  if (debug) print(cl)
  
  ## Emulate a worker that does not have 'future' installed.
  ## by setting a different user library path on the worker.
  libs <- parallel::clusterEvalQ(cl, .libPaths(tempdir()))[[1]]
  if (debug) message(sprintf(".libPaths()[1]: %s", commaq(libs)))

  ## Check whether 'future' is still available on the worker or not.
  ## It could be that it is installed in the system library path, which
  ## in case we cannot "hide" the future package from the worker.
  has_pkgs <- parallel::clusterCall(cl, fun = sapply, X = withouts,
                                    FUN = requireNamespace)[[1]]
  if (debug) print(has_pkgs)

  attr(cl, "libs") <- libs
  attr(cl, "has_pkgs") <- has_pkgs


  cl
}

cl <- NULL
for (type in types) {
  message(sprintf("Test set #1 with cluster type %s ...", sQuote(type)))

  message("* Assert that setupClusterWithoutPkgs() works ...")

  cl <- setupClusterWithoutPkgs(type, debug = TRUE)
  has_pkgs <- attr(cl, "has_pkgs")
  if (!all(has_pkgs)) {
    pkgs <- sprintf("%s=%s", names(has_pkgs), has_pkgs)
    message(sprintf(" - Packages exist: %s", pkgs))
    stopifnot(isFALSE(has_pkgs[["future"]]))
  }
  
  if (!all(has_pkgs)) {
    ## If worker does not have 'future' installed, then there will be an
    ## error already when plan() is called, because it will attempt to
    ## launch a quick future to validate that everything works.
        
    res <- tryCatch({
      plan(cluster, workers = cl)
      value(future(NA))
    }, error = identity)
    print(res)
    stopifnot(inherits(res, "FutureError"))
  }
  parallel::stopCluster(cl)

  message("* Assert that setupClusterWithoutPkgs() works ... DONE")

  message("* Use futures with setupClusterWithoutPkgs() ...")

  cl <- setupClusterWithoutPkgs(type)  
  has_pkgs <- attr(cl, "has_pkgs")
  if (!all(has_pkgs)) {
    pkgs <- sprintf("%s=%s", names(has_pkgs), has_pkgs)
    message(sprintf(" - Packages exist: %s", pkgs))
    stopifnot(isFALSE(has_pkgs[["future"]]))
    
    ## However, if we disable the quick future test, we should not get
    ## an error here.
    plan(cluster, workers = cl, .skip = FALSE, .init = FALSE)

    message(" - Create future #1")
    ## But we will get:
    ##   <FutureError: Internal error: Unexpected result retrieved for
    ##   ClusterFuture future ('<none>'): '42L'>
    ## if we try to resolve a future:
    f <- future(1L)

    backend <- f[["backend"]]
    reg <- backend[["reg"]]
    futures <- future:::FutureRegistry(reg, "list")
    stopifnot(length(futures) == 1L)
    
    res <- tryCatch({
      result(f)
    }, error = identity)
    message(sprintf(" - Result #1 of future #1: %s", class(res)[1]))
    print(res)
    stopifnot(inherits(res, "FutureError"))
    
    message(" - Assert #1 future was removed from registry")
    futures <- future:::FutureRegistry(reg, "list")
    if (length(futures) > 0L) {
      print(futures)
      print(ls.str(f))
      stop("Failed future was never removed from the FutureRegistry")
    }

    ## Assert that the "result" was recorded for future use and
    ## it was recorded as a FutureError.
    stopifnot(!is.null(f$result),
              inherits(f$result, "FutureError"))

    ## Any attempts to re-request the result / value for this future
    ## should from now on re-throw that recorded FutureError.
    stopifnot(!is.null(f$result))
    
    ## The main rationale for this is that we don't want result() to
    ## wait for ever from retrying to retrieve already retrieved results
    ## from worker.
    res <- tryCatch({
       result(f)
    }, error = identity)
    message(sprintf(" - Result #2 of future #2: %s", class(res)[1]))
    stopifnot(inherits(res, "FutureError"))

    ## ... and obviously the same for value().
    res <- tryCatch({
       value(f)
    }, error = identity)
    message(sprintf(" - Value #1 of future #2: %s", class(res)[1]))
    stopifnot(inherits(res, "FutureError"))

    message(" - Assert #2 future was removed from registry")
    futures <- future:::FutureRegistry(reg, "list")
    if (length(futures) > 0L) {
      print(futures)
      print(ls.str(f))
      stop("Failed future was never removed from the FutureRegistry")
    }

    message(" - Create future #2")
    ## Retrying with a new future should give the same failure as above.
    f <- future(2L)
    
    res <- tryCatch({
      result(f)
    }, error = identity)
    print(res)
    stopifnot(inherits(res, "FutureError"))
  }

  message("* Use futures with setupClusterWithoutPkgs() ... DONE")

  parallel::stopCluster(cl)
  cl <- NULL
  
  plan(sequential)
  
  message(sprintf("Test set #1 with cluster type %s ... DONE", sQuote(type)))
} ## for (type ...)

message("*** cluster() ... DONE")

