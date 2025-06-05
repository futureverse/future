#' @tags requestNode
#' @tags cluster
#' @tags skip_on_cran

library(future)

message("*** requestNode() ...")

message("*** requestNode() - exceptions ...")

workers <- makeClusterPSOCK(2L)
print(workers)

res <- tryCatch({
  requestNode(function() {}, workers = workers, timeout = -1.0)
}, error = identity)
stopifnot(inherits(res, "error"))

res <- tryCatch({
  requestNode(function() {}, workers = workers, alpha = 0)
}, error = identity)
stopifnot(inherits(res, "error"))

parallel::stopCluster(workers)

message("*** requestNode() - exceptions ... DONE")

message("*** requestNode() - timeout ...")

plan(cluster, workers = "localhost")
f <- future({ Sys.sleep(0.2); 1 })

res <- tryCatch({
  requestNode(function() { }, workers = f$workers, timeout = 0.5, delta = 0.1)
}, error = identity)
stopifnot(inherits(res, "error"))

v <- value(f)
print(v)
stopifnot(v == 1L)

plan(sequential)

message("*** requestNode() - timeout ... DONE")

message("*** requestNode() ... DONE")
