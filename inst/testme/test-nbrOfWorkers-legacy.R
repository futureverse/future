#' @tags nbrOfWorkers sequential

library(future)

plan(sequential)

## A "legacy" evaluator is one that does not provide a FutureBackend
## factory, in which case nbrOfWorkers() falls back to inspecting the
## 'workers' formal of the evaluator itself
legacy <- function(classes, workers) {
  fcn <- eval(bquote(function(..., workers = .(workers)) {
    stop("INTERNAL ERROR: This evaluator must never be called")
  }))
  class(fcn) <- c(classes, "future", "function")
  fcn
}

message("*** nbrOfWorkers() - legacy multiprocess evaluators ...")

## A constant number of workers
stopifnot(nbrOfWorkers(legacy("multiprocess", 4L)) == 4L)

## 'workers' given as a function
stopifnot(nbrOfWorkers(legacy("multiprocess", quote(function() 3L))) == 3L)

## An unsupported type of 'workers'
res <- tryCatch(nbrOfWorkers(legacy("multiprocess", "many")), error = identity)
print(res)
stopifnot(inherits(res, "error"),
          grepl("Unsupported type of 'workers'", conditionMessage(res)))

## 'workers' must be a single, finite value >= 1
for (workers in list(c(1L, 2L), NA_integer_, 0L, Inf)) {
  res <- tryCatch(nbrOfWorkers(legacy("multiprocess", workers)),
                  error = identity)
  print(res)
  stopifnot(inherits(res, "error"))
}

message("*** nbrOfWorkers() - legacy multiprocess evaluators ... DONE")


message("*** nbrOfWorkers() - legacy future evaluators ...")

stopifnot(nbrOfWorkers(legacy(character(0), 2L)) == 2L)
stopifnot(nbrOfWorkers(legacy(character(0), quote(function() 5L))) == 5L)

## For a plain 'future' evaluator, workers = NULL means "unlimited"
stopifnot(is.infinite(nbrOfWorkers(legacy(character(0), NULL))))

res <- tryCatch(nbrOfWorkers(legacy(character(0), "many")), error = identity)
print(res)
stopifnot(inherits(res, "error"),
          grepl("Unsupported type of 'workers'", conditionMessage(res)))

res <- tryCatch(nbrOfWorkers(legacy(character(0), 0L)), error = identity)
print(res)
stopifnot(inherits(res, "error"))

message("*** nbrOfWorkers() - legacy future evaluators ... DONE")


message("*** nbrOfFreeWorkers() - legacy evaluators ...")

## Not implemented for legacy multiprocess backends
res <- tryCatch(nbrOfFreeWorkers(legacy("multiprocess", 2L)), error = identity)
print(res)
stopifnot(inherits(res, "error"),
          grepl("not implemented", conditionMessage(res)))

## An unlimited number of workers is reported as such
stopifnot(is.infinite(nbrOfFreeWorkers(legacy(character(0), NULL))))

## ... otherwise it is not implemented either
res <- tryCatch(nbrOfFreeWorkers(legacy(character(0), 2L)), error = identity)
print(res)
stopifnot(inherits(res, "error"),
          grepl("not implemented", conditionMessage(res)))

message("*** nbrOfFreeWorkers() - legacy evaluators ... DONE")


message("*** nbrOfWorkers()/nbrOfFreeWorkers() - NULL evaluator ...")

stopifnot(nbrOfWorkers(NULL) == 1L)
stopifnot(nbrOfFreeWorkers(NULL) == 1L)

## The same, with debug output enabled
local({
  oopts <- options(future.debug = TRUE)
  on.exit(options(oopts))
  stopifnot(nbrOfWorkers(NULL) == 1L)
  stopifnot(nbrOfFreeWorkers(NULL) == 1L)
})

message("*** nbrOfWorkers()/nbrOfFreeWorkers() - NULL evaluator ... DONE")


message("*** nbrOfFreeWorkers() - logical evaluator ...")

## 'background' must be passed by name
res <- tryCatch(nbrOfFreeWorkers(TRUE), error = identity)
print(res)
stopifnot(inherits(res, "error"),
          grepl("must be named", conditionMessage(res)))

## When named, it is forwarded to the NULL method
stopifnot(nbrOfFreeWorkers(TRUE, background = FALSE) == 1L)

message("*** nbrOfFreeWorkers() - logical evaluator ... DONE")

plan(sequential)
