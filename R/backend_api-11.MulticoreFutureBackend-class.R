#' Get number of cores currently used
#'
#' Get number of children (and don't count the current process)
#' used by the current \R session.  The number of children
#' is the total number of subprocesses launched by this
#' process that are still running and whose values have yet
#' not been collected.
#'
#' @return A non-negative integer.
#'
#' @keywords internal
usedCores <- function() {
  ## If multicore processing is not supported, then there should be no
  ## multicore workers in use
  if (!supportsMulticore(warn = FALSE)) return(0L)
  
  ## Number of unresolved multicore futures
  reg <- sprintf("multicore-%s", session_uuid())
  futures <- FutureRegistry(reg, action = "list", earlySignal = TRUE)
  nfutures <- length(futures)
  ncores <- nfutures

  ## Total number of multicore processes
  ## To please R CMD check
  ns <- getNamespace("parallel")
  children <- get("children", envir = ns, mode = "function")
  nchildren <- length(children())

  ## Any multicore processes that are not futures?
  if (nchildren > nfutures) {
    ## The basic assumption is that any additional multicore
    ## processes have been launched by at least one of the
    ## multicore futures.  This means that as long as we
    ## wait for one of these futures to be resolved, then
    ## a CPU core will always be available at some point in
    ## the future.
    ## covr: skip=7
    ncores <- nchildren

    ## However, ...
    if (nfutures == 0L) {
      warnf("Hmm... %d active multicore processes were detected, but without any active multicore futures (it is not clear by what mechanism they were created). Because of this, the 'future' package do not know how to resolve/collect them and will therefore treat them as they do not exist", nchildren)
      ncores <- 0L
    }
  }

  ncores
}



#' Request a core for multicore processing
#'
#' If no cores are available, the current process
#' blocks until a core is available.
#'
#' @param await A function used to try to "collect"
#'        finished multicore subprocesses.
#'
#' @param workers Total number of workers available.
#'
#' @param timeout Maximum waiting time (in seconds) allowed
#'        before a timeout error is generated.
#'
#' @param delta Then base interval (in seconds) to wait
#'        between each try.
#'
#' @param alpha A multiplicative factor used to increase
#'        the wait interval after each try.
#'
#' @return Invisible TRUE. If no cores are available after
#'         extensive waiting, then a timeout error is thrown.
#'
#' @keywords internal
requestCore <- function(await, workers = availableCores(constraints = "multicore"), timeout, delta, alpha) {
  stop_if_not(length(workers) == 1L, is.numeric(workers), is.finite(workers), workers >= 1)
  stop_if_not(is.function(await))
  stop_if_not(is.finite(timeout), timeout >= 0)
  stop_if_not(is.finite(alpha), alpha > 0)

  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebugf_push("requestCore(..., workers = %d) ...", workers)
    on.exit(mdebugf_pop())
  }

  ## No additional cores available?
  if (workers == 0L) {
    stop("INTERNAL ERROR: requestCore() was asked to find a free core, but no cores are available (workers = 0)")
  }

  
  t0 <- Sys.time()
  dt <- 0
  iter <- 1L
  interval <- delta
  finished <- FALSE
  while (dt <= timeout) {
    ## Check for available cores
    used <- usedCores()
    finished <- (used < workers)
    if (finished) break

    if (debug) mdebugf("Poll #%d (%s): usedCores() = %d, workers = %d", iter, format(round(dt, digits = 2L)), used, workers)

    ## Wait
    Sys.sleep(interval)
    interval <- alpha * interval

    ## Finish/close cores, iff possible
    await()

    iter <- iter + 1L
    dt <- difftime(Sys.time(), t0)
  }

  if (!finished) {
    msg <- sprintf("TIMEOUT: All %d cores are still occupied after %s (polled %d times)", workers, format(round(dt, digits = 2L)), iter)
    if (debug) mdebug(msg)
    stop(msg)
  }

  unname(finished)
}

#' A MulticoreFutureBackend resolves futures in parallel using forked processing on the current machine
#'
#' @inheritParams ClusterFutureBackend
#'
#' @details
#' The `MulticoreFutureBackend` backend is selected by
#' `plan(multicore, workers = workers)`.
#'
#' @keywords internal
#' @rdname FutureBackend-class
#' @export
MulticoreFutureBackend <- function(workers = availableCores(constraints = "multicore"), maxSizeOfObjects = +Inf, ...) {
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

  core <- MultiprocessFutureBackend(
    workers = workers,
    reg = reg,
    ...,
    maxSizeOfObjects = maxSizeOfObjects
  )
  core[["futureClasses"]] <- c("MulticoreFuture", core[["futureClasses"]])
  core <- structure(core, class = c("MulticoreFutureBackend", class(core)))
  core
}
tweakable(MulticoreFutureBackend) <- MultiprocessFutureBackend


#' @export
launchFuture.MulticoreFutureBackend <- local({
  mcparallel <- import_parallel_fcn("mcparallel")
  
  function(backend, future, ...) {
    debug <- isTRUE(getOption("future.debug"))

    debug <- isTRUE(getOption("future.debug"))
    if (debug) {
      mdebug_push("launchFuture() for MulticoreFutureBackend ...")
      on.exit(mdebug_pop())
    }

    hooks <- backend[["hooks"]]
    if (hooks) {
       hook <- getHook("future::launchFuture::begin")
       hook(backend, future = future, ...)
    }

    data <- getFutureData(future, mc.cores = 1L, debug = debug)
  
    t_start <- Sys.time()
  
    workers <- backend[["workers"]]
    reg <- backend[["reg"]]
  
    timeout <- backend[["wait.timeout"]]
    delta <- backend[["wait.interval"]]
    alpha <- backend[["wait.alpha"]]
  
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
    
    future
  }
}) ## launchFuture()



#' @export
stopWorkers.MulticoreFutureBackend <- function(backend, interrupt = TRUE, ...) {
  ## Interrupt all futures
  if (interrupt) {
    futures <- listFutures(backend)
    futures <- lapply(futures, FUN = cancel, interrupt = interrupt, ...)
  }

  ## Clear registry
  reg <- backend[["reg"]]
  FutureRegistry(reg, action = "reset")
  
  TRUE
}



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



#' @section Behavior of multicore futures:
#' `resolved()` for `MulticoreFuture` may receive immediate condition objects, rather than a
#' [FutureResult], when polling the worker for results. In such cases, _all_ such condition
#' objects are collected, before considering the future non-resolved and FALSE being returned.
#' @rdname resolved
#' @export
resolved.MulticoreFuture <- local({
  selectChildren <- import_parallel_fcn("selectChildren")

  function(x, run = TRUE, timeout = NULL, ...) {
    ## A lazy future not even launched?
    if (x[["state"]] == "created") {
      if (run) {
        ## If free cores are available, then launch this lazy future
        if (x[["workers"]] > usedCores()) x <- run(x)
      }
      return(FALSE)
    }
  
    ## Is value already collected?
    if (!is.null(x[["result"]])) {
      ## Signal conditions early?
      signalEarly(x, ...)
      return(TRUE)
    }
  
    ## Assert that the process that created the future is
    ## also the one that evaluates/resolves/queries it.
    assertOwner(x)
  
    job <- x[["job"]]
    stop_if_not(inherits(job, "parallelJob"))

    if (is.null(timeout)) {
      timeout <- getOption("future.multicore.resolved.timeout")
      if (is.null(timeout)) timeout <- getOption("future.resolved.timeout", 0.01)
      if (timeout < 0) {
        warning("Secret option 'future.resolved.timeout' is negative, which causes resolved() to wait until the future is resolved. This feature is only used for testing purposes of the future framework and must not be used elsewhere", immediate. = TRUE)
        timeout <- NULL
      }
    }
  
    ## NOTE: We cannot use mcollect(job, wait = FALSE, timeout),
    ## because that will return NULL if there's a timeout, which is
    ## an ambigous value because the future expression may return NULL.
    ## WORKAROUND: Adopted from parallel::mccollect().
    ## FIXME: Can we use result() instead? /HB 2018-07-16
    pid <- selectChildren(children = job, timeout = timeout)
    res <- (is.integer(pid) || is.null(pid))
  
    ## Collect and relay immediateCondition if they exists
    conditions <- readImmediateConditions(signal = TRUE)
    ## Record conditions as signaled
    signaled <- c(x[[".signaledConditions"]], conditions)
    x[[".signaledConditions"]] <- signaled

    ## Signal conditions early? (happens only iff requested)
    if (res) signalEarly(x, ...)
  
    res
  }
})


#' @export
result.MulticoreFuture <- local({
  pid_exists <- import_parallelly("pid_exists")
  mccollect <- import_parallel_fcn("mccollect")
  rmChild <- import_parallel_fcn("rmChild")
  
  function(future, ...) {
    debug <- isTRUE(getOption("future.debug"))
    if (debug) {
      mdebugf_push("result() for %s ...", class(future)[1])
      on.exit(mdebugf_pop())
    }
  
    ## Has the result already been collected?
    result <- future[["result"]]
    if (!is.null(result)) {
      if (inherits(result, "FutureError")) stop(result)
      return(result)
    }
  
    if (future[["state"]] == "created") {
      future <- run(future)
    }
  
    ## Assert that the process that created the future is
    ## also the one that evaluates/resolves/queries it.
    assertOwner(future)
  
    ## If not, wait for process to finish, and
    ## then collect and record the value
    job <- future[["job"]]
    stop_if_not(inherits(job, "parallelJob"))
  
    ## WORKAROUNDS for R (< 3.6.0):
    ##  1. Pass single job as list, cf.
    ##     https://bugs.r-project.org/bugzilla3/show_bug.cgi?id=17413
    jobs <- if (getRversion() >= "3.6.0") job else list(job)

    ## NOTE: mccollect() produces a "1 parallel job did not deliver a result"
    ## warning, if the parallel worker has been interrupted and terminated.
    if (future[["state"]] %in% c("canceled", "interrupted")) {
      result <- suppressWarnings(mccollect(jobs = jobs, wait = TRUE)[[1L]])
    } else {
      result <- mccollect(jobs = jobs, wait = TRUE)[[1L]]
    }
    
    ## NOTE: In Issue #218 it was suggested that parallel:::rmChild() could
    ## fix this, but there seems to be more to this story, because we still
    ## get some of those warning even after removing children here.
    rmChild(child = job)

    ## Sanity checks
    if (!inherits(result, "FutureResult")) {
      if (debug) {
        mdebugf_push("Detected non-FutureResult result ...")
        mstr(result)
        mdebugf("Future state: %s", sQuote(future[["state"]]))
      }

      alive <- NA
      pid <- job[["pid"]]
      if (is.numeric(pid)) {
        alive <- pid_exists(pid)
      }
      
      ## AD HOC: Record whether the forked process is alive or not
      job[["alive"]] <- alive
      future[["job"]] <- job

      ## SPECIAL: Check for fallback 'fatal error in wrapper code'
      ## try-error from parallel:::mcparallel().  If detected, then
      ## turn into an error with a more informative error message, cf.
      ## https://github.com/futureverse/future/issues/35
      if (is.null(result) || identical(result, structure("fatal error in wrapper code", class = "try-error"))) {
        label <- sQuoteLabel(future)

        ## HEURISTICS: If the forked process is no longer alive, assume it was interrupted
        if (is.numeric(pid) && !is.na(alive) && !alive) {
          future[["state"]] <- "interrupted"
        }

        if (future[["state"]] %in% c("canceled", "interrupted")) {
          if (debug) mdebugf("Detected interrupted %s whose result cannot be retrieved", sQuote(class(future)[1]))
          msg <- sprintf("A future (%s) of class %s was interrupted, while running on localhost (pid %d)", label, class(future)[1], pid)
          result <- FutureInterruptError(msg, future = future)
          future[["result"]] <- result

          ## Remove from backend
          backend <- future[["backend"]]
          reg <- backend[["reg"]]
          FutureRegistry(reg, action = "remove", future = future, earlySignal = FALSE)
          if (debug) {
            mdebug("Erased future from future backend")
            mdebugf_pop()
          }
          stop(result)
        }

        pid_info <- if (is.numeric(pid)) sprintf("PID %.0f", pid) else NULL
        info <- pid_info
        msg <- sprintf("Failed to retrieve the result of %s (%s) from the forked worker (on localhost; %s)", class(future)[1], label, info)
  
        if (identical(result, structure("fatal error in wrapper code", class = "try-error"))) {
          msg <- c(msg, sprintf("Error %s was reported by the 'parallel' package, which could be because the forked R process that evaluates the future was terminated before it was completed", sQuote(result)))
        }
  
        ## POST-MORTEM ANALYSIS:
        postmortem <- list()
        
        ## (a) Did the localhost worker process terminate?
        if (is.numeric(pid)) {
          if (is.na(alive)) {
            msg2 <- "Failed to determined whether a process with this PID exists or not, i.e. cannot infer whether the forked localhost worker is alive or not"
          } else if (alive) {
            msg2 <- "A process with this PID exists, which suggests that the forked localhost worker is still alive"
          } else {
            msg2 <- "No process exists with this PID, i.e. the forked localhost worker is no longer alive"
          }
          postmortem[["alive"]] <- msg2
        }
  
        ## (c) Any non-exportable globals?
        postmortem[["non_exportable"]] <- assert_no_references(future, action = "string")
  
        ## (d) Size of globals
        postmortem[["global_sizes"]] <- summarize_size_of_globals(future[["globals"]])

        postmortem <- unlist(postmortem, use.names = FALSE)
        if (!is.null(postmortem)) {
           postmortem <- sprintf("Post-mortem diagnostic: %s",
                                 paste(postmortem, collapse = ". "))
           msg <- c(msg, postmortem)
        }
        msg <- paste(msg, collapse = ". ")
        
        ex <- FutureError(msg, future = future) 
      } else if (inherits(result, "FutureInterruptError")) {
        ex <- result
        future[["state"]] <- "interrupted"
      } else if (inherits(result, "FutureLaunchError")) {
        ex <- result
        future[["state"]] <- "interrupted"
      } else if (inherits(result, "FutureError")) {
        ## FIXME: Add more details
        hint <- sprintf("parallel::mccollect() did return a FutureResult but a %s object: %s", sQuote(class(result)[1]), paste(deparse(result), collapse = "; "))
        ex <- UnexpectedFutureResultError(future, hint = hint)
        alive <- NA  ## For now, don't remove future when there's an unexpected error /HB 2023-04-19
      } else {
        ## FIXME: Add more details
        hint <- sprintf("parallel::mccollect() did not return a FutureResult object as expected. Received a %s object instead: %s", sQuote(class(result)[1]), paste(deparse(result), collapse = "; "))
        ex <- UnexpectedFutureResultError(future, hint = hint)
        alive <- NA  ## For now, don't remove future when there's an unexpected error /HB 2023-04-19
      }
      future[["result"]] <- ex

      ## Remove future from FutureRegistry?
      if (!is.na(alive) && !alive) {
        reg <- sprintf("multicore-%s", session_uuid())
        exists <- FutureRegistry(reg, action = "contains", future = future)
        if (exists) {
          if (debug) mdebugf("Removing %s from FutureRegistry (%s)", class(future)[1], reg)
          FutureRegistry(reg, action = "remove", future = future, earlySignal = TRUE)
        }
      }

      if (debug) mdebugf_pop()

      if (debug) mdebugf("Throwing %s: %s", class(ex)[1], conditionMessage(ex))

      stop(ex)
    }

    ## Collect and relay immediateCondition if they exists
    conditions <- readImmediateConditions()
    ## Record conditions as signaled
    signaled <- c(future[[".signaledConditions"]], conditions)
    future[[".signaledConditions"]] <- signaled
  
    ## Record conditions
    result[["conditions"]] <- c(result[["conditions"]], signaled)
    signaled <- NULL
    
    future[["result"]] <- result
  
    future[["state"]] <- "finished"
  
    ## Remove from registry
    reg <- sprintf("multicore-%s", session_uuid())
    FutureRegistry(reg, action = "remove", future = future, earlySignal = TRUE)

    ## Assert result is for the expected future
    assertFutureResult(future)

    ## Always signal immediateCondition:s and as soon as possible.
    ## They will always be signaled if they exist.
    signalImmediateConditions(future)
  
    result
  }
})


#' @export
getFutureBackendConfigs.MulticoreFuture <- function(future, ..., debug = isTRUE(getOption("future.debug"))) {
  conditionClasses <- future[["conditions"]]
  if (is.null(conditionClasses)) {
    capture <- list()
  } else {
    path <- immediateConditionsPath(rootPath = tempdir())
    capture <- list(
      immediateConditionHandlers = list(
        immediateCondition = function(cond) {
          fileImmediateConditionHandler(cond, path = path)
        }
      )
    )
  }

  ## Disable multi-threading in futures?
  threads <- NA_integer_
  multithreading <- getOption("future.fork.multithreading.enable")
  if (isFALSE(multithreading)) {
    if (supports_omp_threads(assert = TRUE, debug = debug)) {
      threads <- 1L
      if (debug) mdebugf("Force single-threaded (OpenMP and RcppParallel) processing in %s", class(future)[1])
    } else {
      warning(FutureWarning("It is not possible to disable OpenMP multi-threading on this systems", future = future))
    }
  }

  context <- list(
    threads = threads
  )

  list(
    capture = capture,
    context = context
  )
}



#' @importFrom parallelly killNode
#' @export
interruptFuture.MulticoreFutureBackend <- function(backend, future, ...) {
  ## Has interrupts been disabled by user?
  if (!backend[["interrupts"]]) return(future)
  
  job <- future[["job"]]
  pid <- job[["pid"]]
  void <- tools::pskill(pid)
  future[["state"]] <- "interrupted"
  
  future
}



#' Create a multicore future whose value will be resolved asynchronously in a forked parallel process
#'
#' _WARNING: This function must never be called.
#'  It may only be used with [future::plan()]_
#'
#' A multicore future is a future that uses multicore evaluation,
#' which means that its _value is computed and resolved in
#' parallel in another process_.
#'
#' @details
#' This function is must _not_ be called directly.  Instead, the
#' typical usages are:
#'
#' ```r
#' # Evaluate futures in parallel on the local machine via as many forked
#' # processes as available to the current R process
#' plan(multicore)
#'
#' # Evaluate futures in parallel on the local machine via two forked processes
#' plan(multicore, workers = 2)
#' ```
#'
#' @inheritParams future
#' @inheritParams Future-class
#' @inheritParams FutureBackend-class
#'
#' @param workers The number of parallel processes to use.
#' If a function, it is called without arguments _when the future
#' is created_ and its value is used to configure the workers.
#' If `workers == 1`, then all processing using done in the
#' current/main \R session and we therefore fall back to using a
#' sequential future. To override this fallback, use `workers = I(1)`.
#'
#' @param \ldots Not used.
#'
#' @example incl/multicore.R
#'
#' @section Support for forked ("multicore") processing:
#' Not all operating systems support process forking and thereby not multicore
#' futures.  For instance, forking is not supported on Microsoft Windows.
#' Moreover, process forking may break some R environments such as RStudio.
#' Because of this, the future package disables process forking also in
#' such cases.  See [parallelly::supportsMulticore()] for details.
#' Trying to create multicore futures on non-supported systems or when
#' forking is disabled will result in multicore futures falling back to
#' becoming [sequential] futures.  If used in RStudio, there will be an
#' informative warning:
#'
#' ```r
#' > plan(multicore)
#' Warning message:
#' In supportsMulticoreAndRStudio(...) :
#'   [ONE-TIME WARNING] Forked processing ('multicore') is not supported when
#' running R from RStudio because it is considered unstable. For more details,
#' how to control forked processing or not, and how to silence this warning in
#' future R sessions, see ?parallelly::supportsMulticore
#' ```
#'
#' @seealso
#' For processing in multiple background \R sessions, see
#' [multisession] futures.
#'
#' For alternative future backends, see the 'A Future for R: Available Future
#' Backends' vignette and \url{https://www.futureverse.org/backends.html}.
#'
#' Use [parallelly::availableCores()] to see the total number of
#' cores that are available for the current \R session.
#' Use \code{\link[parallelly:availableCores]{availableCores}("multicore") > 1L} to check
#' whether multicore futures are supported or not on the current
#' system.
#'
#' @aliases MulticoreFuture
#' @export
multicore <- function(..., workers = availableCores(constraints = "multicore")) {
  stop("INTERNAL ERROR: The future::multicore() function must never be called directly")
}
class(multicore) <- c("multicore", "multiprocess", "future", "function")
attr(multicore, "init") <- TRUE
attr(multicore, "factory") <- MulticoreFutureBackend
attr(multicore, "tweakable") <- tweakable(attr(multicore, "factory"))
