#' @tags cancel
#' @tags detritus-files
#' @tags detritus-connections
#' @tags multisession

library(future)

message("Relaunched cluster workers are shut down with the plan ...")

covr_testing <- ("covr" %in% loadedNamespaces())

## Terminated workers can leave truncated coverage traces.
if (!covr_testing) {
  n0 <- nrow(showConnections())

  plan(multisession, workers = I(1))

  ## Cancel a running future, which terminates its worker
  f <- future({ Sys.sleep(30); 42 })
  Sys.sleep(1.0)
  f <- cancel(f)

  ## The next future relaunches the terminated worker
  f2 <- future(42)
  stopifnot(value(f2) == 42)

  ## Keep a reference, so that garbage collection cannot hide the leak
  backend <- plan("backend")

  plan(sequential)

  ## The relaunched worker must be closed by plan(), not by garbage collection
  n <- nrow(showConnections())
  message("Connections: before = ", n0, ", after = ", n)
  stopifnot(n <= n0)
  rm(list = "backend")
  gc()
}

message("Relaunched cluster workers are shut down with the plan ... done")
