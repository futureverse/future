#' @tags backend sequential multisession cluster
#' @tags detritus-connections

library(future)

SequentialFutureBackend <- future:::SequentialFutureBackend
MultisessionFutureBackend <- future:::MultisessionFutureBackend
ClusterFutureBackend <- future:::ClusterFutureBackend
MulticoreFutureBackend <- future:::MulticoreFutureBackend
stopWorkers <- future:::stopWorkers

## NOTE: A backend factory is reached via attr(<strategy>, "factory"), which
## holds the function object as it was when the package namespace was built.
## Calls made through that copy are not attributed to these functions, which
## is why the factories are called directly below.

message("*** SequentialFutureBackend() ...")

backend <- SequentialFutureBackend()
print(class(backend))
stopifnot(inherits(backend, "SequentialFutureBackend"),
          inherits(backend, "FutureBackend"))

## A sequential backend has a single worker, which is always free
stopifnot(nbrOfWorkers(backend) == 1L)
stopifnot(nbrOfFreeWorkers(backend) == 1L)

print(backend)

message("*** SequentialFutureBackend() ... DONE")


message("*** MultisessionFutureBackend() ...")

## 'workers' must be numeric
res <- tryCatch(MultisessionFutureBackend(workers = "two"), error = identity)
print(res)
stopifnot(inherits(res, "error"))

## ... and a single, finite value >= 1
res <- tryCatch(MultisessionFutureBackend(workers = c(1L, 2L)), error = identity)
print(res)
stopifnot(inherits(res, "error"))

res <- tryCatch(MultisessionFutureBackend(workers = 0L), error = identity)
print(res)
stopifnot(inherits(res, "error"))

## 'workers = 1' falls back to a sequential backend
backend <- MultisessionFutureBackend(workers = 1L)
print(class(backend))
stopifnot(inherits(backend, "SequentialFutureBackend"))

## ... which can be overridden with I(1)
backend <- MultisessionFutureBackend(workers = I(1L))
print(class(backend))
stopifnot(inherits(backend, "MultisessionFutureBackend"))
stopifnot(nbrOfWorkers(backend) == 1L)
stopWorkers(backend)

## 'workers' may be given as a function
backend <- MultisessionFutureBackend(workers = function() 2L)
print(class(backend))
stopifnot(inherits(backend, "MultisessionFutureBackend"),
          inherits(backend, "ClusterFutureBackend"))
stopifnot(nbrOfWorkers(backend) == 2L)
stopifnot(nbrOfFreeWorkers(backend) == 2L)

## A MultisessionFuture is what this backend produces
stopifnot("MultisessionFuture" %in% backend[["futureClasses"]])

print(backend)
stopWorkers(backend)

message("*** MultisessionFutureBackend() ... DONE")


message("*** ClusterFutureBackend() ...")

backend <- ClusterFutureBackend(workers = 2L)
print(class(backend))
stopifnot(inherits(backend, "ClusterFutureBackend"),
          inherits(backend, "FutureBackend"))
stopifnot(nbrOfWorkers(backend) == 2L)
stopifnot(nbrOfFreeWorkers(backend) == 2L)

print(backend)

## The backend can be shut down, and doing so is idempotent
stopifnot(isTRUE(stopWorkers(backend)))

message("*** ClusterFutureBackend() ... DONE")


message("*** listFutures() ...")

listFutures <- future:::listFutures

## A backend without a 'reg' element cannot list its futures
fake <- structure(list(), class = c("MultiprocessFutureBackend",
                                    "FutureBackend"))
res <- tryCatch(listFutures(fake), error = identity)
print(res)
stopifnot(inherits(res, "FutureError"),
          grepl("does not implement listFutures", conditionMessage(res)))

## nbrOfWorkers()/nbrOfFreeWorkers() are not implemented at this level either
res <- tryCatch(nbrOfWorkers(fake), error = identity)
print(res)
stopifnot(inherits(res, "error"), grepl("not implemented", conditionMessage(res)))

res <- tryCatch(nbrOfFreeWorkers(fake), error = identity)
print(res)
stopifnot(inherits(res, "error"), grepl("not implemented", conditionMessage(res)))

## A backend without any futures lists none
backend <- MultisessionFutureBackend(workers = 2L)
data <- listFutures(backend)
print(data)
stopifnot(is.data.frame(data), nrow(data) == 0L)
stopifnot(all(c("counter", "start", "label", "resolved") %in% names(data)))
stopWorkers(backend)

## With futures running, they are listed
plan(multisession, workers = 2L)
fs <- list(future({ Sys.sleep(0.5); 1L }, label = "one"),
           future({ Sys.sleep(0.5); 2L }, label = "two"))
data <- listFutures(plan("backend"), debug = TRUE)
print(data)
stopifnot(is.data.frame(data), nrow(data) == 2L)
stopifnot(all(c("one", "two") %in% data[["label"]]))
stopifnot(is.logical(data[["resolved"]]))

## Collect the values, so that no futures are left behind
stopifnot(identical(unlist(value(fs)), c(1L, 2L)))
plan(sequential)

message("*** listFutures() ... DONE")


message("*** MulticoreFutureBackend() ...")

## IMPORTANT: Skip when testing with 'covr', because forked workers do not
## write back their 'covr' traces, and may truncate them
if (!covr_testing && parallelly::supportsMulticore() &&
    availableCores("multicore") >= 2L) {
  backend <- MulticoreFutureBackend(workers = 2L)
  print(class(backend))
  stopifnot(inherits(backend, "MulticoreFutureBackend"))
  stopifnot(nbrOfWorkers(backend) == 2L)
  stopWorkers(backend)

  ## 'workers = 1' falls back to a sequential backend
  backend <- MulticoreFutureBackend(workers = 1L)
  print(class(backend))
  stopifnot(inherits(backend, "SequentialFutureBackend"))
} else {
  message("Skipping MulticoreFutureBackend() tests")
}

message("*** MulticoreFutureBackend() ... DONE")
