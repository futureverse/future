## This test asserts that two R connections part of PSOCK cluster nodes
## are identified as different, although they share the same connection
## index. This is required in order to work around a bug in R [1]
## [1] https://github.com/HenrikBengtsson/Wishlist-for-R/issues/81
library(future)

message("all.equal() for connection ...")
con1 <- rawConnection(raw())
close(con1)

con2 <- rawConnection(raw())
close(con2)

stopifnot(!isTRUE(all.equal(con1, con2)))
message("all.equal() for connection ... done")


message("all.equal() for cluster backend ...")

for (kk in 1:3) {
  message("Iteration #", kk)
  cl <- parallel::makeCluster(1)
  plan(cluster, workers = cl)
  
  fs <- lapply(1:2, FUN = future)
  
  vs <- value(fs)
  parallel::stopCluster(cl)
}

plan(sequential)

message("all.equal() for cluster backend ... done")
