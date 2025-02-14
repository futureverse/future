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
#' plan(cluster, workers = c("localhost", "n1", "n1", "pi.example.org")
#' ```
#'
#' @inheritParams ClusterFuture-class
#' @inheritParams Future-class
#' @inheritParams future
#'
#' @param \dots Additional named elements passed to [ClusterFuture()].
#'
#' @return
#' A \link{ClusterFuture}.
#'
#' @example incl/cluster.R
#'
#' @export
cluster <- function(..., persistent = FALSE, workers = availableWorkers(), envir = parent.frame()) {
  future <- ClusterFuture(..., persistent = persistent, workers = workers, envir = envir)
  if (!future$lazy) future <- run(future)
  invisible(future)
}
class(cluster) <- c("cluster", "multiprocess", "future", "function")
attr(cluster, "init") <- TRUE
attr(cluster, "cleanup") <- function() {
  ClusterRegistry(action = "stop")
}
attr(cluster, "tweakable") <- quote(c(makeClusterPSOCK_args(), "persistent"))
