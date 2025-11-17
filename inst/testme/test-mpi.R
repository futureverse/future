#' @tags mpi
#' @tags cluster
#' @tags skip_on_cran

library(future)
stopCluster <- parallel::stopCluster
makeClusterMPI <- parallelly::makeClusterMPI

message("*** MPI ...")

pkg <- "Rmpi"
if (requireNamespace(pkg, quietly = TRUE)) {
  cl <- makeClusterMPI(availableCores())
  str(cl)
  
  plan(cluster, workers = cl)

  xs <- seq_len(nbrOfWorkers() + 1)
  fs <- lapply(xs, FUN = function(x) future({
    printf("Hostname: %s\n", Sys.info()[["nodename"]])
    printf("PID: %d\n", Sys.getpid())
    Sys.sleep(0.5)
    -x
  }))
  print(fs)
  vs <- value(fs)
  print(vs)
  stopifnot(all(unlist(vs) == -xs))

  stopCluster(cl)
  str(cl)
}

message("*** MPI ... DONE")

