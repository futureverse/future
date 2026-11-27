#' @tags multisession cluster
#' @tags detritus-files

library(future)
options(future.debug = FALSE)

plan(multisession, workers = min(2L, availableCores()))
n0 <- nbrOfFreeWorkers()
stopifnot(n0 >= 1L)

message("* Case 1: resolved() polled before value() on FutureLaunchError")
f1 <- future(42L, packages = "non_existing_package_xyz")
while (!resolved(f1)) Sys.sleep(0.05)
res1 <- tryCatch(value(f1), error = identity)
stopifnot(
  inherits(res1, "FutureLaunchError"),
  nbrOfFreeWorkers() == n0
)

message("* Case 2: value(list(f)) on FutureLaunchError")
f2 <- future(42L, packages = "non_existing_package_xyz")
res2 <- tryCatch(value(list(f2)), error = identity)
stopifnot(
  inherits(res2, "FutureLaunchError"),
  nbrOfFreeWorkers() == n0
)

message("* Case 3: direct result() on FutureLaunchError")
f3 <- future(42L, packages = "non_existing_package_xyz")
res3 <- tryCatch(result(f3), error = identity)
stopifnot(
  inherits(res3, "FutureLaunchError"),
  nbrOfFreeWorkers() == n0
)

message("* Case 4: subsequent futures succeed without stale launch error")
vals <- value(lapply(seq_len(n0 + 1L), function(i) future(i)))
stopifnot(
  identical(vals, as.list(seq_len(n0 + 1L))),
  nbrOfFreeWorkers() == n0
)

plan(sequential)
