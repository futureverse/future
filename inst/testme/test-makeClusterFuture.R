if (getRversion() >= "4.4.0") {
  library(future)
  library(parallel)

  a <- 42

  FUN <- function(x) {
    message("Process ID: ", Sys.getpid())
    list(a = a, mean = mean(rnorm(n = x)))
  }
  
  message("makeCluster():")
  plan(multisession)
  cl <- makeCluster(2)
  set.seed(42)
  clusterSetRNGStream(cl)
  clusterExport(cl, "a")
  y <- list()
  for (kk in 1:3) y[[kk]] <- parLapply(cl, 11:13, FUN)
  str(y)
  stopCluster(cl)
  y_truth <- y
  
  message("makeClusterFuture():")
  plan(multisession, workers = 2)
  cl <- makeClusterFuture()
  set.seed(42)
  clusterSetRNGStream(cl)
  clusterExport(cl, "a")
  y <- list()
  for (kk in 1:3) y[[kk]] <- parLapply(cl, 11:13, FUN)
  str(y)
  plan(sequential)
  
  stopifnot(identical(y, y_truth))
}
