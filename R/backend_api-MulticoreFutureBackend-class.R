#' A MulticoreFutureBackend resolves futures in parallel using forked processing on the current machine
#'
#' @inheritParams ClusterFutureBackend
#'
#' @details
#' The `MulticoreFutureBackend` backend is selected by
#' `plan(multicore, workers = workers)`.
#'
#' @keywords internal
#' @rdname FutureBackend
#' @export
MulticoreFutureBackend <- function(workers = availableCores(constraints = "multicore"), ...) {
  default_workers <- missing(workers)
  if (is.function(workers)) workers <- workers()
  stop_if_not(is.numeric(workers))
  workers <- structure(as.integer(workers), class = class(workers))
  stop_if_not(length(workers) == 1, is.finite(workers), workers >= 1)
  
  ## Fall back to sequential futures if only a single additional R process
  ## can be spawned off, i.e. then use the current main R process.
  ## Sequential futures best reflect how multicore futures handle globals.
  if ((workers == 1L && !inherits(workers, "AsIs")) ||
      !supportsMulticore(warn = TRUE)) {
    ## AD HOC: Make sure plan(multicore) also produces a warning, if needed
    if (default_workers) supportsMulticore(warn = TRUE)
    ## covr: skip=1
    return(SequentialFutureBackend(...))
  }

  reg <- sprintf("multicore-%s", session_uuid())

  core <- FutureBackend(
    workers = workers,
    reg = reg,
    future.wait.timeout = getOption("future.wait.timeout", 30 * 24 * 60 * 60),
    future.wait.interval = getOption("future.wait.interval", 0.01),
    future.wait.alpha = getOption("future.wait.alpha", 1.01),
    ...
  )
  core[["futureClasses"]] <- c("MulticoreFuture", "MultiprocessFuture", core[["futureClasses"]])
  core <- structure(core, class = c("MulticoreFutureBackend", "FutureBackend", class(core)))
  core
}


#' @export
launchFuture.MulticoreFutureBackend <- local({
  mcparallel <- import_parallel_fcn("mcparallel")
  
  function(backend, future, ...) {
    debug <- isTRUE(getOption("future.debug"))
  
    data <- getFutureData(future, debug = debug)
  
    t_start <- Sys.time()
  
    workers <- backend[["workers"]]
    reg <- backend[["reg"]]
  
    timeout <- backend[["future.wait.timeout"]]
    delta <- backend[["future.wait.interval"]]
    alpha <- backend[["future.wait.alpha"]]
  
    ## Get a free worker
    requestCore(await = function() {
      FutureRegistry(reg, action = "collect-first", earlySignal = TRUE)
    }, workers = workers, timeout = timeout, delta = delta, alpha = alpha)
  
    if (inherits(future[[".journal"]], "FutureJournal")) {
      appendToFutureJournal(future,
           event = "getWorker",
        category = "other",
          parent = "launch",
           start = t_start,
            stop = Sys.time()
      )
    }
  
    ## Add to registry
    FutureRegistry(reg, action = "add", future = future, earlySignal = TRUE)
  
    job <- local({
      oopts <- options(mc.cores = NULL)
      on.exit(options(oopts))
      mcparallel(evalFuture(data))
    })
  
    future[["job"]] <- job
    future[["state"]] <- "running"
  
    if (debug) mdebugf("%s started", class(future)[1])
    
    invisible(future)
  }
})


#' @export
nbrOfWorkers.MulticoreFutureBackend <- function(evaluator) {
  assert_no_positional_args_but_first()
  backend <- evaluator
  workers <- backend[["workers"]]
  stop_if_not(length(workers) == 1L, !is.na(workers), workers >= 1L, is.finite(workers))
  workers
}


#' @export
nbrOfFreeWorkers.MulticoreFutureBackend <- function(evaluator, background = FALSE, ...) {
  assert_no_positional_args_but_first()
  backend <- evaluator
  workers <- backend[["workers"]]
  workers <- workers - usedCores()
  stop_if_not(length(workers) == 1L, !is.na(workers), workers >= 0L, is.finite(workers))
  workers
}

