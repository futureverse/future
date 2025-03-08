#' Create a cluster future whose value will be resolved asynchronously in a parallel process
#'
#' A cluster future is a future that uses cluster evaluation,
#' which means that its _value is computed and resolved in
#' parallel in another process_.
#'
#' @details
#' This function is _not_ meant to be called directly.  Instead, the
#' typical usages are:
#'
#' ```r
#' # Evaluate futures via a single background R process on the local machine
#' plan(cluster, workers = 1)
#'
#' # Evaluate futures via two background R processes on the local machine
#' plan(cluster, workers = 2)
#'
#' # Evaluate futures via a single R process on another machine on on the
#' # local area network (LAN)
#' plan(cluster, workers = "raspberry-pi")
#'
#' # Evaluate futures via a single R process running on a remote machine
#' plan(cluster, workers = "pi.example.org")
#'
#' # Evaluate futures via four R processes, one running on the local machine,
#' # two running on LAN machine 'n1' and one on a remote machine
#' plan(cluster, workers = c("localhost", "n1", "n1", "pi.example.org"))
#' ```
#'
#' @inheritParams Future-class
#' @inheritParams future
#'
#' @param workers A \code{\link[parallel:makeCluster]{cluster}} object,
#' a character vector of host names, a positive numeric scalar,
#' or a function.
#' If a character vector or a numeric scalar, a `cluster` object
#' is created using \code{\link[parallelly:makeClusterPSOCK]{makeClusterPSOCK}(workers)}.
#' If a function, it is called without arguments _when the future
#' is created_ and its value is used to configure the workers.
#' The function should return any of the above types.
#'
#' @param persistent If FALSE, the evaluation environment is cleared
#' from objects prior to the evaluation of the future.
#' 
#' @param \dots Additional named elements passed to [Future()].
#'
#' @return
#' A ClusterFuture.
#'
#' @example incl/cluster.R
#'
#' @export
cluster <- function(..., persistent = FALSE, workers = availableWorkers(), envir = parent.frame()) {
  f <- Future(..., envir = envir)
  f[["workers"]] <- workers
  f[["persistent"]] <- persistent
  class(f) <- c("ClusterFuture", "MultiprocessFuture", "Future")
  f
}
class(cluster) <- c("cluster", "multiprocess", "future", "function")
attr(cluster, "init") <- TRUE
attr(cluster, "cleanup") <- function() {
  ClusterRegistry(action = "stop")
}
attr(cluster, "tweakable") <- quote(c(makeClusterPSOCK_args(), "persistent"))
