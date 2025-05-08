#' @tags mpi
#' @tags cluster
#' @tags skip_on_cran

library(future)
stopCluster <- parallel::stopCluster

message("*** MPI ...")

pkg <- "Rmpi"
if (fullTest && requireNamespace(pkg, quietly = TRUE)) {
  cl <- makeClusterMPI(availableCores())
  str(cl)
  
  plan(cluster, workers = cl)

  fs <- lapply(1:2, FUN = function(x) future({
    printf("Hostname: %s\n", Sys.info()[["nodename"]])
    printf("PID: %d\n", Sys.getpid())
    Sys.sleep(0.5)
    x^2
  }))
  print(fs)
  vs <- value(fs)
  print(vs)
  stopifnot(all(unlist(vs) == c(1, 4)))

  stopCluster(cl)
  str(cl)
}

message("*** MPI ... DONE")

