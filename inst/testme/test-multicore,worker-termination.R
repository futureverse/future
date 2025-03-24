#' @tags worker-killed
#' @tags multicore
#'
library(future)

message("*** multicore() - terminating workers ...")

if (supportsMulticore() && availableCores("multicore") >= 2L) {
  plan(multicore, workers = 2L)

  all <- nbrOfWorkers()
  free <- nbrOfFreeWorkers()
  stopifnot(
    nbrOfWorkers() == 2L,
    nbrOfFreeWorkers() == 2L
  )
  
  ## Force R worker to quit
  f <- future({ tools::pskill(pid = Sys.getpid()) })
  res <- tryCatch(value(f), error = identity)
  print(res)
  print(conditionMessage(res))
  stopifnot(inherits(res, "FutureError"))

  stopifnot(nbrOfWorkers() == all)
  ## Assert that the worker slot was released? Not always possible
  str(f$job)
  cat(sprintf("nbrOfFreeWorkers(): %d\n", nbrOfFreeWorkers()))
  if (!is.na(f$job$alive) && !f$job$alive) {
    stopifnot(nbrOfFreeWorkers() == free)
  } else {
    stopifnot(nbrOfFreeWorkers() <= free)
  }
}

message("*** multicore() - terminating workers ... DONE")

