if (getRversion() >= "4.4.0") {
  library(future)
  library(parallel)

  plan(sequential)
  cl <- makeCluster(1L, type = future::FUTURE)

  message("clusterCall(cl, identity, quote(y)) ...")
  arg <- quote(y)
  res <- clusterCall(cl, identity, arg)
  str(res)
  stopifnot(identical(res[[1]], arg))

  stopCluster(cl)
  plan(sequential)
}
