#' @importFrom parallel stopCluster
ClusterRegistry <- local({
  last <- NULL
  cluster <- NULL

  function(action = c("get", "start", "stop"), workers = NULL, makeCluster = .makeCluster, ...) {
    action <- match.arg(action, choices = c("get", "start", "stop"))

    if (is.null(workers)) {
    } else if (is.numeric(workers)) {
      ## Preserve class attributes, especially "AsIs"
      clazz <- class(workers)
      workers <- as.integer(workers)
      class(workers) <- clazz
      stop_if_not(length(workers) == 1, is.finite(workers))
    } else if (is.character(workers)) {
      stop_if_not(length(workers) >= 1, !anyNA(workers))
      workers <- sort(workers)
    } else {
      stopf("Unknown mode of argument 'workers': %s", mode(workers))
    }

    if (length(cluster) == 0L && action != "stop") {
      cluster <<- makeCluster(workers, ...)
      last <<- workers
    }

    if (action == "get") {
      return(cluster)
    } else if (action == "start") {
      ## Already setup?
      if (!identical(workers, last)) {
        ClusterRegistry(action = "stop")
        cluster <<- makeCluster(workers, ...)
        last <<- workers
      }
    } else if (action == "stop") {
      if (length(cluster) > 0L) try(stopCluster(cluster), silent = TRUE)
      cluster <<- NULL
      last <<- NULL
    }

    invisible(cluster)
  }
}) ## ClusterRegistry()


.makeCluster <- function(workers, ...) {
  if (length(workers) == 0L) return(NULL)
  cl <- makeClusterPSOCK(workers, ...)
  cl <- addCovrLibPath(cl)
  cl
} ## .makeCluster()


#' @importFrom parallel clusterCall
addCovrLibPath <- function(cl) {
  if (!is.element("covr", loadedNamespaces())) return(cl)
  debug <- getOption("future.debug", FALSE)
  
  ## WORKAROUND: When running covr::package_coverage(), the
  ## package being tested may actually not be installed in
  ## library path used by covr.  We here add that path iff
  ## covr is being used. /HB 2016-01-15
  if (debug) mdebug("covr::package_coverage() workaround ...")
  libPath <- .libPaths()[1]
  clusterCall(cl, fun = function() .libPaths(c(libPath, .libPaths())))
  if (debug) mdebug("covr::package_coverage() workaround ... DONE")

  cl
}