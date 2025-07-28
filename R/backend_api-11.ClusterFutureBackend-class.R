#' A ClusterFutureBackend resolves futures in parallel using any PSOCK cluster
#'
#' @inheritParams FutureBackend-class
#'
#' @param workers ...
#'
#' @param persistent (deprecated) ...
#'
#' @details
#' The `ClusterFutureBackend` is selected by
#' `plan(cluster, workers = workers)`.
#'
#' @keywords internal
#' @rdname FutureBackend-class
#'
#' @importFrom parallelly as.cluster availableWorkers
#' @export
ClusterFutureBackend <- local({
  getDefaultCluster <- import_parallel_fcn("getDefaultCluster")

  ## Most recent 'workers' set up
  last <- NULL

  function(workers = availableWorkers(constraints = "connections"), gc = TRUE, earlySignal = TRUE, interrupts = FALSE, persistent = FALSE, ...) {
    debug <- isTRUE(getOption("future.debug"))
    if (debug) {
      mdebugf_push("ClusterFutureBackend(..., persistent = %s, gc = %s, earlySignal = %s) ...", persistent, gc, earlySignal)
      on.exit(mdebugf_pop())
    }
    
    if (is.function(workers)) workers <- workers()
    if (is.null(workers)) {
      clusterRegistry$stopCluster(debug = debug)
      last <<- NULL
      workers <- getDefaultCluster()
      workers <- addCovrLibPath(workers)
    } else if (is.numeric(workers) || is.character(workers)) {
      if (is.numeric(workers)) {
        if (debug) mdebugf("workers: %g", workers)
        ## Preserve class attributes, especially "AsIs"
        clazz <- class(workers)
        workers <- as.integer(workers)
        class(workers) <- clazz
        stop_if_not(length(workers) == 1, is.finite(workers))
      } else {
        stop_if_not(length(workers) >= 1, !anyNA(workers))
        workers <- sort(workers)
        if (debug) mdebugf("workers: [n=%d] %s", length(workers), commaq(workers))
      }

      ## Already setup?
      cluster <- clusterRegistry$getCluster(debug = debug)
      if (is.null(cluster) || !identical(workers, last)) {
        clusterRegistry$stopCluster(debug = debug)
        last <<- NULL
        
        if (debug) mdebug_push("Starting new cluster ...")
        cluster <- clusterRegistry$startCluster(workers, makeCluster = .makeCluster, ..., debug = debug)
        if (debug) {
          mprint(cluster)
          mdebug_pop()
        }
        last <<- workers
      } else {
        if (debug) {
          mprint(cluster)
          mdebug("Cluster already existed")
        }
      }
      workers <- cluster
    } else {
      ## A pre-created cluster?
      ## FIXME: Don't stop it if already in place, or ...?
      clusterRegistry$stopCluster(debug = debug)
      last <<- NULL
      workers <- as.cluster(workers)
      workers <- addCovrLibPath(workers)
    }
    if (!inherits(workers, "cluster")) {
      stopf("Argument 'workers' is not of class 'cluster': %s", commaq(class(workers)))
    }
    if (debug) mdebugf("Number of workers: %d", length(workers))
    stop_if_not(length(workers) > 0)


    ## Attached workers' session information, unless already done.
    ## FIXME: We cannot do this here, because it introduces a race condition
    ## where multiple similar requests may appear at the same time bringing
    ## the send/receive data to be out of sync and therefore corrupt the
    ## futures' values.
    ##  workers <- add_cluster_session_info(workers)
  
    ## Attach name to cluster?
    name <- attr(workers, "name", exact = TRUE)
    if (is.null(name)) {
      name <- uuid(workers)
      stop_if_not(length(name) > 0, nzchar(name))
      attr(workers, "name") <- name
      if (debug) mdebug("Generated workers UUID")
    }
    if (debug) mdebugf("Workers UUID: %s", sQuote(name))
      
    ## Name of the FutureRegistry
    reg <- sprintf("workers-%s", name)
  
    core <- MultiprocessFutureBackend(
      workers = workers,
      reg = reg,
      earlySignal = earlySignal,
      interrupts = interrupts,
      persistent = persistent,
      ...
    )
    core[["futureClasses"]] <- c("ClusterFuture", core[["futureClasses"]])
    core <- structure(core, class = c("ClusterFutureBackend", class(core)))
    core
  }
})
tweakable(ClusterFutureBackend) <- list(MultiprocessFutureBackend, makeClusterPSOCK_args())

#' @importFrom parallelly isConnectionValid isNodeAlive
#' @importFrom utils capture.output
#' @export
print.ClusterFutureBackend <- function(x, details = c("workers"), validate = FALSE, ...) {
  backend <- NextMethod()
  workers <- backend[["workers"]]

  if ("workers" %in% details) {
    s <- character(0L)
    
    s <- c(s, sprintf("Workers of type %s:", class(workers)[1]))
    info <- capture.output(print(workers))
    info <- paste(info, collapse = "; ")
    s <- c(s, sprintf("- Summary: %s", info))
    cat(s, sep = "\n")
  
    ## Validate connections
    for (kk in seq_along(workers)) {
      node <- workers[[kk]]
      con <- node[["con"]]
  
      info <- capture.output(print(node))
      info <- paste(info, collapse = "; ")
      status <- " OK "
      details <- c()
      
      if (!is.null(con)) {
        isValid <- isConnectionValid(con)
        if (isValid) {
          details <- c(details, "valid connection")
        } else {
          details <- c(details, "invalid connection")
          status <- "FAIL"
        }
      }

      if (validate) {
        alive <- isNodeAlive(node)
        if (alive) {
          details <- c(details, "alive")
        } else {
          details <- c(details, "not alive")
          status <- "FAIL"
        }
      }

      details <- paste(details, collapse = ", ")    
      cat(sprintf("- [%s] Node %d/%d: %s [%s]\n", status, kk, length(workers), details, info))
    }
  } ## ("workers" %in% details)

  invisible(x)
}


#' @export
launchFuture.ClusterFutureBackend <- function(backend, future, ...) {
  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebug_push("launchFuture() for ClusterFutureBackend ...")
    on.exit(mdebug_pop())
  }

  ## Record 'backend' in future for now
  future[["backend"]] <- backend

  workers <- backend[["workers"]]
  stop_if_not(inherits(workers, "cluster"))
  
  reg <- backend[["reg"]]
  stop_if_not(is.character(reg), length(reg) == 1L)
  
  if (debug) {
    mdebugf("Workers: [n=%d]", length(workers))
    mprint(workers)
    mdebug("FutureRegistry: ", sQuote(reg))
  }
  
  ## Next available cluster node
  t_start <- Sys.time()

  ## (1) Get a free worker. This will block until one is available
  if (debug) mdebug_push("requestWorker() ...")

  timeout <- backend[["wait.timeout"]]
  delta <- backend[["wait.interval"]]
  alpha <- backend[["wait.alpha"]]

  ## Get the index of a free cluster node, which has been validated to
  ## be functional. If the existing worker was found to be non-functional,
  ## it was re-launched by requestNode()
  ## FIXME: Is this wrong? Does it get the future-registry slot index
  ## rather than worker index? /HB 2025-07-04
  node_idx <- requestNode(await = function() {
    FutureRegistry(reg, action = "collect-first", earlySignal = TRUE, debug = debug)
  }, backend = backend, timeout = timeout, delta = delta, alpha = alpha)
  workers <- backend[["workers"]] ## Backend might have been updated
  future[["node"]] <- node_idx
  
  if (inherits(future[[".journal"]], "FutureJournal")) {
    appendToFutureJournal(future,
         event = "getWorker",
      category = "overhead",
        parent = "launch",
         start = t_start,
          stop = Sys.time()
    )
  }
  if (debug) mdebugf("cluster node index: %d", node_idx)

  cl <- workers[node_idx]
  stop_if_not(length(cl) == 1L, inherits(cl, "cluster"))
  node <- cl[[1]]
  
  ## Does the cluster node communicate with a connection?
  ## (if not, it's likely via MPI)
  stop_if_not(inherits(node, c("SOCK0node", "SOCKnode")))
  con <- node[["con"]]
  future[["nodeHasConnection"]] <- !is.null(con)

  if (debug) mdebug_pop()


  ## (2) Attach packages that needs to be attached
  ##     NOTE: Already take care of by evalFuture().
  ##     However, if we need to get an early error about missing packages,
  ##     we can get the error here before launching the future.
  if (future[["earlySignal"]]) {
    if (debug) mdebug_push("requirePackages() ...")
    
    packages <- future[["packages"]]
    if (debug) mdebug("packages: [n=%d] %s", length(packages), commaq(packages))
    
    ## Nothing to do?
    if (length(packages) > 0L) { 
      t_start <- Sys.time()
  
      ## (ii) Attach packages that needs to be attached
      ##      NOTE: Already take care of by evalFuture().
      ##      However, if we need to get an early error about missing packages,
      ##      we can get the error here before launching the future.
      if (debug) mdebug_push("Attaching packages on worker ...")
      ## Blocking cluster-node call
      cluster_call_blocking(cl, fun = function(pkgs) { requirePackages(pkgs); "future-requirePackages" }, packages, future = future, when = "call requirePackages() on", expected = "future-requirePackages")
      if (debug) mdebug_pop()
      
      ## Add event to future journal?
      if (inherits(future[[".journal"]], "FutureJournal")) {
        appendToFutureJournal(future,
             event = "attachPackages",
          category = "overhead",
            parent = "launch",
             start = t_start,
              stop = Sys.time()
        )
      }
    }
    
    if (debug) mdebug_pop()
  }

  ## (2) Reset global environment of cluster node such that
  ##     previous futures are not affecting this one, which
  ##     may happen even if the future is evaluated inside a
  ##     local, e.g. local({ a <<- 1 }).
  ##     If the persistent = TRUE, this will be skipped.
  persistent <- isTRUE(future[["persistent"]])
  if (!persistent) {
    if (debug) mdebug_push("eraseGlobalEnvironment() ...")
    
    t_start <- Sys.time()
    
    ## (i) Reset global environment of cluster node such that
    ##     previous futures are not affecting this one, which
    ##     may happen even if the future is evaluated inside a
    ##     local, e.g. local({ a <<- 1 }).
    ## Blocking cluster-node call
    cluster_call_blocking(cl, fun = grmall, future = future, when = "call grmall() on", expected = "future-grmall")

    ## Add event to future journal
    if (inherits(future[[".journal"]], "FutureJournal")) {
      appendToFutureJournal(future,
           event = "eraseWorker",
        category = "overhead",
          parent = "launch",
           start = t_start,
            stop = Sys.time()
      )
    }
    if (debug) mdebug_pop()
  }


  ## (3) Garbage collection
  ## FIXME: This is _before_, not _after_ as documented
  ##        Should use gc[1] for before and gc[2] for after
  if (isTRUE(future[["gc"]])) {
    cluster_call_blocking(cl, fun = function() { gc(); "future-gc" }, future = future, when = "call gc() on", expected = "future-gc")
  }


  ## (4) Launch future
  if (debug) mdebug_push("launchFuture() ...")
  worker <- future[["node"]]
  stop_if_not(
    length(worker) == 1L, is.integer(worker), !is.na(worker),
    worker >= 1L, worker <= length(workers)
  ) 
  if (debug) mdebugf("cluster node index: %d", worker)
  data <- getFutureData(future, mc.cores = 1L, debug = debug)
  node <- workers[[worker]]
  ## Non-blocking cluster-node call
  node_call_nonblocking(node, fun = evalFuture, args = list(data), future = future, when = "launch future on")
  FutureRegistry(reg, action = "add", future = future, earlySignal = FALSE, debug = debug)
  if (debug) mdebug_pop()

  future[["state"]] <- "running"

  if (debug) mdebugf("%s started", class(future)[1])
  
  future
}


#' @importFrom parallelly killNode
#' @export
interruptFuture.ClusterFutureBackend <- function(backend, future, ...) {
  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebugf_push("interruptFuture(<%s>, future = <%s>, ...) ...", class(backend)[1], class(future)[1])
    on.exit(mdebugf_pop())
  }
  
  ## Has interrupts been disabled by user?
  if (!backend[["interrupts"]]) {
    if (debug) mdebug("Skipping, because interrupts are disabled for this backend")
    return(future)
  }
  
  workers <- backend[["workers"]]
  node_idx <- future[["node"]]
  node <- workers[[node_idx]]
  local({
    if (debug) {
      mdebugf_push("parallelly::killNode(<%s>) ...", class(node)[1])
      on.exit(mdebugf_pop())
    }
    void <- suppressWarnings(killNode(node))
  })
  
  future[["state"]] <- "interrupted"
  
  future
}

#' @export
stopWorkers.ClusterFutureBackend <- function(backend, interrupt = TRUE, ...) {
  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebugf_push("stopWorkers() for %s ...", class(backend)[1])
    on.exit(mdebugf_pop())
  }  
  
  ## Interrupt all futures
  if (interrupt) {
    mdebugf_push("Interrupt active futures ...")
    futures <- listFutures(backend)[["future"]]
    mdebugf("Number of futures: %d", length(futures))
    futures <- lapply(futures, FUN = cancel, interrupt = interrupt, ...)
    mdebugf_pop()
  }

  ## Clear registry
  mdebugf_push("Clear future registry ...")
  reg <- backend[["reg"]]
  FutureRegistry(reg, action = "reset")
  ## Assert that reset worked
  ## FIXME: Remove this later; it should never fail
  futures <- listFutures(backend)[["future"]]
  if (length(futures) > 0L) {
    stop(FutureError(sprintf("Failed to erase futures for %s. There are still %d active futures", class(backend)[1], length(futures))))
  }
  mdebugf_pop()
  
  ## Stop workers
  mdebugf_push("Stop cluster workers ...")
  clusterRegistry$stopCluster(debug = debug)
  env <- environment(ClusterFutureBackend)
  env[["last"]] <- NULL
  mdebugf_pop()
  
  TRUE
}



#' @export
nbrOfWorkers.ClusterFutureBackend <- function(evaluator) {
  backend <- evaluator
  workers <- backend[["workers"]]
  stop_if_not(length(workers) > 0L, inherits(workers, "cluster"))
  workers <- length(workers)
  stop_if_not(length(workers) == 1L, !is.na(workers), workers >= 1L, is.finite(workers))
  workers
}


#' @export
nbrOfFreeWorkers.ClusterFutureBackend <- function(evaluator, ...) {
  debug <- isTRUE(getOption("future.debug"))
  backend <- evaluator
  workers <- backend[["workers"]]
  stop_if_not(length(workers) > 0L, inherits(workers, "cluster"))
  workers <- length(workers)
  reg <- backend[["reg"]]
  stop_if_not(length(reg) == 1L, is.character(reg), nzchar(reg))

  ## Number of unresolved cluster futures
  usedNodes <- length(FutureRegistry(reg, action = "list", earlySignal = FALSE, debug = debug))
  
  workers <- workers - usedNodes
  stop_if_not(length(workers) == 1L, !is.na(workers), workers >= 0L, is.finite(workers))
  
  workers
}


#' @importFrom parallel clusterCall clusterEvalQ
.makeCluster <- function(workers, ...) {
  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebug_push(".makeCluster() ...")
    mdebug("workers: ", commaq(workers))
    on.exit(mdebug_pop())
  }
  
  if (length(workers) == 0L) return(NULL)
  oenv <- Sys.getenv("R_FUTURE_PLAN", NA_character_)
  if (debug) mdebug("R_FUTURE_PLAN: ", oenv)
  Sys.unsetenv("R_FUTURE_PLAN")
  on.exit({
    if (!is.na(oenv)) Sys.setenv(R_FUTURE_PLAN = oenv)
  })
  
  args <- list(...)
  
  ## Ignore non-recognized arguments
  keep <- intersect(names(args), makeClusterPSOCK_args())
  args <- args[keep]

  args <- c(list(workers), args)
  if (debug) {
    mdebug("parallelly::makeClusterPSOCK() arguments:")
    mstr(args)
  }
  
  cl <- do.call(makeClusterPSOCK, args = args, quote = TRUE)
  cl <- addCovrLibPath(cl)

  ## Pre-load 'future' package
  works <- clusterCall(cl = cl, fun = requireNamespace, "future", quietly = TRUE)
  works <- unlist(works, use.names = FALSE)
  
  ## Pre-load 'RhpcBLASctl' package, if available
  void <- clusterCall(cl = cl[works], fun = requireNamespace, "RhpcBLASctl", quietly = TRUE)

  ## Pre-calculate parallelly::availableCores()
  void <- clusterEvalQ(cl = cl[works], parallelly::availableCores())

  cl
} ## .makeCluster()


#' @importFrom parallel clusterCall
addCovrLibPath <- local({
  is_covr <- NULL
  
  function(cl) {
    if (!is.null(is_covr)) {
      if (!is_covr) return(cl)
    } else {
      is_covr <<- is.element("covr", loadedNamespaces())
      if (!is_covr) return(cl)
    }
    debug <- isTRUE(getOption("future.debug"))
    
    ## WORKAROUND: When running covr::package_coverage(), the
    ## package being tested may actually not be installed in
    ## library path used by covr.  We here add that path iff
    ## covr is being used. /HB 2016-01-15
    if (debug) mdebug_push("covr::package_coverage() workaround ...")
    libPath <- .libPaths()[1]
    clusterCall(cl, fun = function() .libPaths(c(libPath, .libPaths())))
    if (debug) mdebug_pop()
  
    cl
  }
})


getSocketSelectTimeout <- function(future, timeout = NULL) {
  if (!is.null(timeout)) return(timeout)
  
  ## FIXME: This should be memoized per plan, when setting up
  ## the plan /HB 2025-02-18
  timeout <- future[["resolved.timeout"]]
  if (!is.null(timeout)) return(timeout)

  timeout <- getOption("future.cluster.resolved.timeout")
  if (is.null(timeout)) {
    if (is.null(timeout)) {
      timeout <- getOption("future.resolved.timeout")
      if (is.null(timeout)) {
        timeout <- 0.01
      }
    }
      
    if (timeout < 0) {
      warning("Secret option 'future.resolved.timeout' is negative, which causes resolved() to wait until the future is resolved. This feature is only used for testing purposes of the future framework and must not be used elsewhere", immediate. = TRUE)
      timeout <- NULL
    }
  }

  ## WORKAROUND: Non-integer timeouts (at least < 2.0 seconds) may result
  ## in infinite waiting (PR17203).  Fixed in R devel r73470 (2017-10-05)
  ## and R 3.4.3
  ## Source: https://github.com/HenrikBengtsson/Wishlist-for-R/issues/35
  if (.Platform[["OS.type"]] != "windows" && getRversion() < "3.4.3") {
    timeout <- round(timeout, digits = 0L)
  }
  attr(timeout, "validated") <- TRUE
    
  ## Memoize 'timeout' in Future object
  if (!is.null(timeout)) {
    future[["resolved.timeout"]] <- timeout
  }

  timeout
} ## getSocketSelectTimeout()


#' @param timeout (numeric) The maximum time (in seconds) for polling the worker
#' for a response. If no response is available within this time limit, FALSE is
#' returned assuming the future is still being processed.
#' If NULL, the value defaults to `getOption("future.<type>.resolved.timeout")`,
#' then `getOption("future.resolved.timeout")`, and finally 0.01 (seconds),
#' where `<type>` corresponds to the type of future, e.g. `cluster` and `multicore`.
#'
#' @section Behavior of cluster and multisession futures:
#' If all worker slots are occupied, `resolved()` for `ClusterFuture` and
#' `MultisessionFuture` will attempt to free one up by checking whether
#' one of the futures is _resolved_. If there is one, then its result is
#' collected in order to free up one worker slot.
#'
#' `resolved()` for `ClusterFuture` may receive immediate condition objects, rather
#' than a [FutureResult], when polling the worker for results. In such cases, the
#' condition object is collected and another poll it performed. Up to 100 immediate
#' conditions may be collected this way per `resolved()` call, before considering
#' the future non-resolved and FALSE being returned.
#'
#' @rdname resolved
#' @importFrom parallelly connectionId isConnectionValid
#' @export
resolved.ClusterFuture <- function(x, run = TRUE, timeout = NULL, ...) {
  debug <- isTRUE(getOption("future.debug"))
  
  future <- x
  backend <- future[["backend"]]
  stop_if_not(inherits(backend, "FutureBackend"))
  workers <- backend[["workers"]]
  reg <- backend[["reg"]]
  
  ## A lazy future not even launched?
  if (future[["state"]] == "created") {
    if (run) {
      nworkers <- length(workers)
      
      ## Collect one resolved future, if one exists
      FutureRegistry(reg, action = "collect-first", earlySignal = TRUE, debug = debug)
      
      ## Are there available worker slots?
      avail <- rep(TRUE, times = length(workers))
      futures <- FutureRegistry(reg, action = "list", earlySignal = FALSE, debug = debug)
      nodes <- unlist(lapply(futures, FUN = function(f) f[["node"]]), use.names = FALSE)
      stop_if_not(
        length(nodes) == length(futures),
        is.numeric(nodes), all(is.finite(nodes)),
        all(nodes >= 1), all(nodes <= length(workers)),
        length(unique(nodes)) == length(nodes)
      )
      avail[nodes] <- FALSE
      if (debug) mdebugf("avail: [n=%d] %s", length(avail), commaq(which(avail)))

      ## 4. Launch this lazy future
      if (any(avail)) future <- run(future)
    } ## if (run)

    ## Consider future non-resolved
    return(FALSE)
  }

  ## Is value already collected?
  if (!is.null(future[["result"]])) {
    ## Signal conditions early?
    signalEarly(future, ...)
    return(TRUE)
  }

  ## Assert that the process that created the future is
  ## also the one that evaluates/resolves/queries it.
  assertOwner(future)

  if (debug) mdebugf_push("resolved() for %s (%s) ...", class(future)[1], sQuoteLabel(future))

  node_idx <- future[["node"]]
  cl <- workers[node_idx]
  node <- cl[[1]]

  
  ## Check if workers socket connection is available for reading
  if (!is.null(con <- node[["con"]])) {
    ## AD HOC/SPECIAL CASE: Skip if connection has been serialized and lacks
    ## internal representation. /HB 2018-10-27
    connId <- connectionId(con)
    if (debug) mdebugf("Cluster node socket connection: index=%d, id=%d", con, connId)
    if (!is.na(connId) && connId < 0L) return(FALSE)

    ## Broken connection due to interruption?
    isValid <- isConnectionValid(con)
    if (!isValid && future[["state"]] %in% c("canceled", "interrupted", "running")) {
      ## Did it fail because we interrupted a future, which resulted in the
      ## worker also shutting done? If so, turn the error into a run-time
      ## FutureInterruptError and revive the worker
      future <- handleInterruptedFuture(backend, future = future)
      return(TRUE)
    }
    
    assertValidConnection(future)

    if (is.null(timeout)) {
      timeout <- getSocketSelectTimeout(future, timeout = timeout)
    } else {
      ## WORKAROUND: Non-integer timeouts (at least < 2.0 seconds) may result
      ## n infinite waiting (PR17203).  Fixed in R devel r73470 (2017-10-05)
      ## and R 3.4.3
      ## Source: https://github.com/HenrikBengtsson/Wishlist-for-R/issues/35
      if (!isTRUE(attr(timeout, "validated", exact = TRUE)) && .Platform[["OS.type"]] != "windows" && getRversion() < "3.4.3") {
        timeout <- round(timeout, digits = 0L)
      }
    }

    ## Number of non-FutureResult objects to receive, before giving up
    maxCount <- 100L

    count <- 0L
    while (count < maxCount) {
      ## Is there a message from the worker waiting?
      res <- socketSelect(list(con), timeout = timeout, write = FALSE)
      if (!res) {
        if (debug) mdebugf("socketSelect(list(<connection #%d (id=%d)>), timeout = %g, write = FALSE) returned %s; not resolved", con, connId, timeout, res)
        break
      }

      ## Receive it
      msg <- receiveMessageFromWorker(future, debug = debug)

      ## If the message contains a FutureResult, then the future is resolved
      ## and we are done here
      res <- inherits(msg, "FutureResult")
      if (res) {
        if (debug) mdebugf("receiveMessageFromWorker() returned object of class %s; resolved", class(msg)[1])
        break
      }

      ## If the message contains a FutureInterruptError, then the future
      ## was interrupted and we are done here. Consider future resolved,
      ## an let relaying of errors take care of this later.
      res <- inherits(msg, "FutureInterruptError")
      if (res) {
        if (debug) mdebugf("receiveMessageFromWorker() returned object of class %s; resolved", class(msg)[1])
        break
      }
      
      ## If the message contains a FutureError, e.g. FutureLaunchError, then
      ## there's nothing more we can do here. Consider future resolved,
      ## an let relaying of errors take care of this later.
      res <- inherits(msg, "FutureError")
      if (res) {
        if (debug) mdebugf("receiveMessageFromWorker() returned object of class %s; non-fixable state", class(msg)[1])
        break
      }

      msg <- NULL

      ## If not, we received a condition that has already been signaled
      ## by receiveMessageFromWorker().  However, it could be that there is
      ## another condition messages available, so lets check again
      count <- count + 1L
    } ## while()
  } else if (inherits(node, "MPInode")) {
    res <- resolveMPI(future)
  } else {
    warnf("resolved() is not yet implemented for workers of class %s. Will use value() instead and return TRUE", sQuote(class(node)[1]))
    value(future, stdout = FALSE, signal = FALSE)
    res <- TRUE
  }

  if (debug) mdebug_pop()

  if (res) {
    ## Assert result is for the expected future
    assertFutureResult(future, debug = debug)

    ## Signal conditions early? (happens only iff requested)
    signalEarly(future, ...)
  }

  res
}


#' @importFrom parallelly isConnectionValid 
#' @export
result.ClusterFuture <- function(future, ...) {
  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebug_push("result() for ClusterFuture ...")
    on.exit(mdebug_pop())
  }

  ## Has the result already been collected?
  result <- future[["result"]]
  if (!is.null(result)) { 
    if (debug) mdebugf("result already collected: %s", class(result)[1])
    
    if (inherits(result, "FutureError")) {
      stop(result)
    }

    return(result)
  }

  ## Assert that the process that created the future is
  ## also the one that evaluates/resolves/queries it.
  assertOwner(future)

  backend <- future[["backend"]]  
  workers <- backend[["workers"]]  
  worker <- future[["node"]]
  node <- workers[[worker]]
  if (!is.null(con <- node[["con"]])) {
    ## Broken connection due to interruption?
    isValid <- isConnectionValid(con)
    if (!isValid && future[["state"]] %in% c("canceled", "interrupted", "running")) {
      ## Did it fail because we interrupted a future, which resulted in the
      ## worker also shutting done? If so, turn the error into a run-time
      ## FutureInterruptError and revive the worker
      future <- handleInterruptedFuture(backend, future = future)
      return(future)
    }
    assertValidConnection(future)
  }

  repeat({
    result <- receiveMessageFromWorker(future, debug = debug)
    if (inherits(result, "FutureResult")) {
      ## Assert result is for the expected future
      assertFutureResult(future)
      return(result)
    } else if (inherits(result, "FutureInterruptError")) {
      stop(result)
    } else if (inherits(result, "FutureLaunchError")) {
      future[["result"]] <- result
      ## Assert result is for the expected future
      assertFutureResult(future)
      ## Remove future from registry
      backend <- future[["backend"]]
      reg <- backend[["reg"]]
      FutureRegistry(reg, action = "remove", future = future, earlySignal = FALSE, debug = debug)
      stop(result)
    }
  })
}



#' @importFrom parallelly isNodeAlive
receiveMessageFromWorker <- local({
  recvData <- import_parallel_fcn("recvData")
  
  closeNode <- import_parallel("closeNode", default = function(node) {
    con <- node[["con"]]
    if (inherits(con, "connection")) close(con)
  })
  
  function(future, debug = FALSE, ...) {
    if (debug) {
      mdebug_push("receiveMessageFromWorker() for ClusterFuture ...")
      on.exit(mdebug_pop())
    }
    
    if (future[["state"]] == "created") {
      if (debug) mdebug("starting non-launched future")
      future <- run(future)
    }
  
    backend <- future[["backend"]]
    if (!inherits(backend, "FutureBackend") && !is.list(backend)) {
      stop(sprintf("[INTERNAL ERROR] receiveMessageFromWorker(): the 'backend' element of the %s object is neither a FutureBackend object nor a list: %s", class(future)[1], class(backend)[1]))
    }
    workers <- backend[["workers"]]
    reg <- backend[["reg"]]
  
    node_idx <- future[["node"]]
    if (debug) mdebugf("cluster node index: %d", node_idx)
    cl <- workers[node_idx]
    node <- cl[[1]]
  
    t_start <- Sys.time()

    ## If not, wait for process to finish, and
    ## then collect and record the value
    msg <- NULL
    ack <- tryCatch({
      data <- recvData(node)
      TRUE    
    }, error = function(ex) ex)
    if (debug) mprint(ack)
  
    if (inherits(ack, "error")) {
      if (debug) mdebugf("- parallel::recvData() produced an error: %s", conditionMessage(ack))

      ## Did it fail because we interrupted a future, which resulted in the worker
      ## also shutting done? If so, turn the error into a run-time FutureInterruptError
      ## and revive the worker
      if (future[["state"]] %in% c("canceled", "interrupted", "running")) {
        future <- handleInterruptedFuture(backend, future = future)
        return(future[["result"]])
      }

      msg <- post_mortem_cluster_failure(ack, when = "receive message results from", node = node, future = future)
      ex <- FutureError(msg, call = ack[["call"]], future = future)
      future[["result"]] <- ex
      stop(ex)          
    } ## if (inherits(ack, "error"))
    
    stop_if_not(isTRUE(ack))
    if (debug) {
      mdebug("Received data:")
      mstr(data)
    }

    msg <- data[["value"]]

    ## Non-expected message from worker?
    if (!inherits(msg, "FutureResult") && !inherits(msg, "condition")) {
      ## If parallel:::slaveLoop() ends up capturing the error, which should
      ## not happen unless there is a critical error, then it'll be of captured
      ## by try().
      if (inherits(msg, "try-error")) {
        ex <- FutureError(msg, future = future)
        future[["result"]] <- ex
        stop(ex)
      }

      node_info <- sprintf("%s #%d", sQuote(class(node)[1]), node_idx)
      if (inherits(node, "RichSOCKnode")) {
        specs <- summary(node)
        alive <- isNodeAlive(node)
        if (is.na(alive)) {
          alive <- "unknown if it is alive"
        } else if (alive) {
          alive <- "alive"
        } else {
          alive <- "not alive"
        }
        node_info <- sprintf("%s (PID %s; %s) on host %s (%s, platform %s)",
                             node_info,
                             specs[["pid"]], alive, sQuote(specs[["host"]]),
                             specs[["r_version"]], specs[["platform"]])
      }
      
      hint <- sprintf("This suggests that the communication with %s is out of sync.", node_info)
      ex <- UnexpectedFutureResultError(future, hint = hint)
      future[["result"]] <- ex
      stop(ex)
    }
  
    if (inherits(msg, "FutureResult")) {
      result <- msg
      if (debug) mdebug("Received FutureResult")
  
      if (inherits(future[[".journal"]], "FutureJournal")) {
        appendToFutureJournal(future,
             event = "receiveResult",
          category = "overhead",
            parent = "gather",
             start = t_start,
              stop = Sys.time()
        )
      }
  
      ## Add back already signaled and muffled conditions so that also
      ## they will be resignaled each time value() is called.
      signaled <- future[[".signaledConditions"]]
      if (length(signaled) > 0) {
        if (debug) {
          mdebug("Appending already signaled conditions:")
          mstr(signaled)
        }
        result[["conditions"]] <- c(future[[".signaledConditions"]], result[["conditions"]])
        future[[".signaledConditions"]] <- NULL
      }
  
      future[["result"]] <- result
      future[["state"]] <- "finished"
      if (debug) mprint(result)
    
      ## Remove from backend
      FutureRegistry(reg, action = "remove", future = future, earlySignal = FALSE, debug = debug)
      if (debug) mdebug("Erased future from future backend")
  
      ## Always signal immediateCondition:s and as soon as possible.
      ## They will always be signaled if they exist.
      signalImmediateConditions(future)

      ## Garbage collect cluster worker?
      if (future[["gc"]]) {
        if (debug) mdebug_push("Garbage collecting worker ...")
        ## Cleanup global environment while at it
        if (!isTRUE(future[["persistent"]])) {
          ## Blocking cluster-node call
          cluster_call_blocking(cl[1], fun = grmall, future = future, when = "call grmall() on", expected = "future-grmall")
        }
        
        ## WORKAROUND: Need to clear cluster worker before garbage collection.
        ## This is needed for workers running R (<= 3.3.1). It will create
        ## another teeny, dummy object on the worker allowing any previous
        ## objects to be garbage collected.  For more details, see
        ## https://github.com/HenrikBengtsson/Wishlist-for-R/issues/27.
        ## (We return a value identifiable for troubleshooting purposes)
        ## Blocking cluster-node call
        cluster_call_blocking(cl[1], function() "future-clearing-cluster-worker", future = future, when = "call dummy() on", expected = "future-clearing-cluster-worker")
        
        ## Blocking cluster-node call
        cluster_call_blocking(cl[1], function() { gc(); "future-gc" }, verbose = FALSE, reset = FALSE, future = future, when = "call gc() on", expected = "future-gc")
        if (debug) mdebug_pop()
      }

      msg <- result
    } else if (inherits(msg, "FutureLaunchError")) {
      if (debug) mdebugf("Received %s", class(msg)[1])
      future[["result"]] <- msg
      future[["state"]] <- "failed"
    } else if (inherits(msg, "condition")) {
      condition <- msg
      
      if (debug) {
        mdebug("Received condition:")
        mstr(condition)
      }
  
      ## Sanity check
      if (inherits(condition, "error")) {
        future[["result"]] <- msg
        future[["state"]] <- "failed"
        label <- sQuoteLabel(future)
        stop(FutureError(sprintf("Received a %s condition from the %s worker for future (%s), which is not possible to relay because that would break the internal state of the future-worker communication. The condition message was: %s", class(condition)[1], class(future)[1], label, sQuote(conditionMessage(condition))), future = future))
      }

      if (debug) mdebug("Signaling condition")

      ## Resignal condition
      if (inherits(condition, "warning")) {
        warning(condition)
      } else if (inherits(condition, "message")) {
        message(condition)
      } else {
        signalCondition(condition)
      }

      if (debug) mdebug("Recording signaled condition")

      ## Increment signal count
      cond <- list(
        condition = condition,
        signaled = 1L
      )
      
      ## Record condition as signaled
      signaled <- future[[".signaledConditions"]]
      if (is.null(signaled)) signaled <- list()
      signaled <- c(signaled, list(cond))
      future[[".signaledConditions"]] <- signaled
      if (debug) mstr(signaled)
    } 
  
    msg
  }
}) ## receiveMessageFromWorker()


## Returns the index of an available cluster node among the
## backend[["workers"]] nodes. It validates that the node is
## functional, by to a quick parallel::clusterCall(). If that
## fails, it re-launches the cluster node and re-assigns it
## to backend[["workers"]], before returning.
#' @importFrom parallelly isConnectionValid isNodeAlive cloneNode
#' @importFrom parallel clusterCall
requestNode <- function(await, backend, timeout, delta, alpha, validateWorker = TRUE) {
  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebug_push("requestNode() ...")
    on.exit(mdebug_pop(), add = TRUE)
  }

  stop_if_not(inherits(backend, "FutureBackend"))
  workers <- backend[["workers"]]
  stop_if_not(inherits(workers, "cluster"))
  stop_if_not(is.function(await))
  stop_if_not(is.finite(timeout), timeout >= 0)
  stop_if_not(is.finite(alpha), alpha > 0)

  ## Maximum number of nodes available
  total <- length(workers)
  if (debug) mdebugf("Number of workers: %d", total)

  ## FutureRegistry to use
  name <- attr(workers, "name", exact = TRUE)
  stop_if_not(is.character(name), length(name) == 1L)
  reg <- sprintf("workers-%s", name)
  
  usedNodes <- function() {
    ## Number of unresolved cluster futures
    length(FutureRegistry(reg, action = "list", earlySignal = FALSE, debug = debug))
  }

  if (debug) mdebug_push("Polling for a free worker ...")
  t0 <- Sys.time()
  dt <- 0
  iter <- 1L
  interval <- delta
  finished <- FALSE
  while (dt <= timeout) {
    ## Check for available nodes
    used <- usedNodes()
    finished <- (used < total)
    if (finished) break

    if (debug) mdebugf("Poll #%d (%s): usedNodes() = %d, workers = %d", iter, format(round(dt, digits = 2L)), used, total)

    ## Wait
    Sys.sleep(interval)
    interval <- alpha * interval
    
    ## Finish/close workers, iff possible
    await()

    iter <- iter + 1L
    dt <- difftime(Sys.time(), t0)
  }
  if (debug) {
    mdebugf("Total time: %s", dt)
    mdebug_pop()
  }

  if (!finished) {
    msg <- sprintf("TIMEOUT: All %d cluster nodes are still occupied after %s (polled %d times)", total, format(round(dt, digits = 2L)), iter)
    if (debug) mdebug(msg)
    ex <- FutureError(msg, future = future)
    stop(ex)
  }

  ## Find which node is available
  avail <- rep(TRUE, times = length(workers))
  futures <- FutureRegistry(reg, action = "list", earlySignal = FALSE, debug = debug)
  if (length(futures) > 0) {
    ## Get indices for all busy cluster nodes
    nodes <- unlist(lapply(futures, FUN = function(f) f[["node"]]), use.names = FALSE)
    stop_if_not(
      length(nodes) == length(futures),
      is.numeric(nodes), all(is.finite(nodes)),
      all(nodes >= 1), all(nodes <= length(workers)),
      length(unique(nodes)) == length(nodes)
    )
    avail[nodes] <- FALSE
  }

  ## Sanity check
  stop_if_not(any(avail))

  if (debug) mdebugf("avail: [n=%d] %s", length(avail), commaq(which(avail)))

  node_idx <- which(avail)[1L]
  stop_if_not(is.numeric(node_idx), is.finite(node_idx), node_idx >= 1, node_idx <= length(workers))
  if (debug) mdebugf("Index of first available worker: %d", node_idx)
  
  ## Validate that the cluster node is working - if not, relaunch it
  if (validateWorker) {
    if (debug) mdebug_push("Validate that the worker is functional ...")
    cl <- workers[node_idx]
    stop_if_not(length(cl) == 1L, inherits(cl, "cluster"))
  
    truth <- "future:::requestNode() validation call"
    
    maxTries <- 3L
    for (kk in maxTries:1) {
      okay <- TRUE
      res <- tryCatch({
        suppressWarnings({
          clusterCall(cl = cl, identity, truth)[[1]]
        })
      }, error = identity)
      
      ## If not working, investigate why, and relaunch a new worker
      if (inherits(res, "error") || !identical(res, truth)) {
        if (debug) {
          mdebug("Worker is non-functional")
          if (inherits(res, "error")) {
            mdebug("Error received: ", conditionMessage(res))
          } else {
            mdebug("Result received: ", sQuote(res))
          }
        }
        okay <- FALSE
    
        ## Is the connection working?
        node <- cl[[1]]
        con <- node[["con"]]
        connectionOkay <- NA
        if (inherits(con, "connection")) {
          connectionOkay <- isConnectionValid(con)
          if (debug) mdebug("Connection is valid: ", connectionOkay)
        }
    
        if (is.na(connectionOkay) || connectionOkay) {
          ## If the node does not use a connection, or the connection is working,
          ## we can only assume the worker is also alive. If so, we should try to
          ## kill the worker.
          res <- suppressWarnings(killNode(node))
          if (debug) mdebugf("Killed %s: %s", class(node)[1], res)
        } else {
          ## If connection is not working, we could assume the worker is no longer
          ## alive, but it could also be a network issues. In either case, we
          ## should try to kill it, just in case.
          res <- suppressWarnings(killNode(node))
          if (debug) mdebugf("Killed %s: %s", class(node)[1], res)
        }
        if (kk == 1L) {
          stop(FutureError(sprintf("Failed to find a functional cluster worker, after attempting to relaunch the parallel worker %d times", maxTries)))
        }
      } else {
        if (debug) mdebug("Worker is functional")
        break
      }
      
      ## Relaunch worker?
      if (!okay) {
        if (debug) mdebugf_push("Restarting non-alive cluster node %d ...", node_idx)
        node2 <- tryCatch({
          cloneNode(node)
        }, error = identity)
        if (inherits(node2, "error")) {
          msg <- sprintf("One of the future workers of class %s, part of a cluster of class %s, was interrupted and attempts to relaunch it failed", sQuote(class(node)[1]), sQuote(class(cl)[1]))
          if (inherits(node, c("SOCKnode", "SOCK0node")) &&
              !inherits(node, c("RichSOCKnode"))) {
            msg <- sprintf("%s. If you created your cluster with parallel::makeCluster(), try with parallelly::makeClusterPSOCK() instead", msg)
          }
          msg <- sprintf("%s. The reported reason was: %s", msg, conditionMessage(node2))
          stop(FutureError(msg))
        } else {
          node <- node2
        }
        
        cl[[1]] <- node
        
        workers[[node_idx]] <- node
        backend[["workers"]] <- workers
        
        if (debug) {
          mdebug("Re-launched cluster node:")
          mprint(node)
          mdebugf_pop()
        }
      }
  
      ## Try again
      Sys.sleep(0.1)
    } ##  for (kk in maxTries:1)
  } ## if (validateWorker)

  ## Assert that there is no other registered future that is using
  ## the found node
  futures <- FutureRegistry(reg, action = "list", earlySignal = FALSE, debug = debug)
  for (kk in seq_along(futures)) {
    future <- futures[[kk]]
    if (node_idx == future[["node"]]) {
      stop(FutureError(sprintf("[INTERNAL ERROR]: requestNode() found node #%d to be free, but it is used by future #%d (%s)", node_idx, kk, sQuoteLabel(future))))
    }
  }

  if (debug) mdebug_pop()
  
  node_idx
} ## requestNode()



node_call_nonblocking <- local({
  sendCall <- import_parallel_fcn("sendCall")
  
  function(node, ..., when = "send call to", future) {
    tryCatch({
      suppressWarnings({
        sendCall(node, ...)
      })
    }, error = function(ex) {
      msg <- post_mortem_cluster_failure(ex, when = when, node = node, future = future)
      ex <- FutureError(msg, future = future)
      stop(ex)          
    })
  }
})

#' @importFrom parallel clusterCall
cluster_call_blocking <- function(cl, ..., when = "call function on", future, expected = NULL) {
  stop_if_not(inherits(cl, "cluster"), length(cl) == 1L)
  stop_if_not(inherits(future, "Future"))
  
  ans <- tryCatch({
    suppressWarnings({
      clusterCall(cl = cl, ...)
    })
  }, error = function(ex) {
    msg <- post_mortem_cluster_failure(ex, when = when, node = cl[[1]], future = future)
    ex <- FutureError(msg, future = future)
    future[["result"]] <- ex
    stop(ex)          
  })

  with_assert({
    stop_if_not(length(ans) == 1L, is.list(ans))
    if (!is.null(expected)) {
      value <- ans[[1]]
      if (length(value) != 1L || !is.character(value) || 
          is.na(value) || value != "future-grmall") {
        utils::str(list(ans = ans, expected = expected))
        stop(sprintf("parallel::clusterCall() did not return string %s as expected. Received a %s object instead: %s", sQuote(expected), class(value)[1], paste(deparse(value), collapse = "; ")))
      }
    }
  })
} ## cluster_call_blocking()


#' @importFrom parallelly isNodeAlive
post_mortem_cluster_failure <- local({
  pid_exists <- import_parallelly("pid_exists")
  
  function(ex, when, node, future) {
    stop_if_not(inherits(ex, "error"))
    stop_if_not(length(when) == 1L, is.character(when))
    stop_if_not(inherits(future, "Future"))
    
    node_idx <- future[["node"]]
    if (is.null(node_idx)) {
      node_idx <- NA_integer_
    } else {
      stop_if_not(length(node_idx) == 1L, is.numeric(node_idx))
      node_idx <- as.integer(node_idx)
    }
    
    ## (1) Trimmed error message
    reason <- conditionMessage(ex)
  
    ## (2) Information on the cluster node
    
    ## (a) Process information on the worker, if available
    pid <- node[["session_info"]][["process"]][["pid"]]
    pid_info <- if (is.numeric(pid)) sprintf("PID %.0f", pid) else NULL
  
    ## (b) Host information on the worker, if available
    ##     AD HOC: This assumes that the worker has a hostname, which is not
    ##     the case for MPI workers. /HB 2017-03-07
    host <- node[["host"]]
    localhost <- isTRUE(attr(host, "localhost", exact = TRUE))
    host_info <- if (!is.null(host)) {
      sprintf("on %s%s", if (localhost) "localhost " else "", sQuote(host))
    } else NULL
    
    node_info <- sprintf("cluster %s #%d (%s)",
                         class(node)[1], node_idx,
                         paste(c(pid_info, host_info), collapse = " "))
    stop_if_not(length(node_info) == 1L)
    
    ## (3) Information on the future
    label <- sQuoteLabel(future)
  
    ## (4) POST-MORTEM ANALYSIS:
    postmortem <- list()
  
    ## (a) Inspect the 'reason' for known clues
    if (grepl("ignoring SIGPIPE signal", reason)) {
      postmortem[["sigpipe"]] <- "The SIGPIPE error suggests that the R socket connection to the parallel worker broke, which can happen for different reasons, e.g. the parallel worker crashed"
    }
  
    ## (a) Did the worker process terminate?
    if (!is.null(host) && is.numeric(pid)) {
      if (localhost) {
        alive <- pid_exists(pid)
        if (is.na(alive)) {
          msg2 <- "Failed to determined whether a process with this PID exists or not, i.e. cannot infer whether localhost worker is alive or not"
        } else if (alive) {
          msg2 <- "A process with this PID exists, which suggests that the localhost worker is still alive"
        } else {
          msg2 <- "No process exists with this PID, i.e. the localhost worker is no longer alive"
        }
      } else {
        ## Checking remote workers on hosts requires parallelly (>= 1.36.0)
        alive <- isNodeAlive(node, timeout = getOption("future.alive.timeout", 30.0))
        if (is.na(alive)) {
          msg2 <- "Failed to determined whether the process with this PID exists or not on the remote host, i.e. cannot infer whether remote worker is alive or not"
        } else if (alive) {
          msg2 <- "A process with this PID exists on the remote host, which suggests that the remote worker is still alive"
        } else {
          msg2 <- "No process exists with this PID on the remote host, i.e. the remote worker is no longer alive"
        }
      }
      postmortem[["alive"]] <- msg2
    }
  
    ## (b) Did the worker use a connection that changed?
    if (inherits(node[["con"]], "connection")) {
      postmortem[["connection"]] <- check_connection_details(node, future = future)
    }
  
    ## (c) Any non-exportable globals?
    globals <- future[["globals"]]
    postmortem[["non_exportable"]] <- assert_no_references(globals, action = "string")
  
    ## (d) Size of globals
    postmortem[["global_sizes"]] <- summarize_size_of_globals(globals)
  
    ## (5) The final error message
    msg <- sprintf("%s (%s) failed to %s %s. The reason reported was %s",
                   class(future)[1], label, when, node_info, sQuote(reason))
    stop_if_not(length(msg) == 1L)
    if (length(postmortem) > 0) {
      postmortem <- unlist(postmortem, use.names = FALSE)
      msg <- sprintf("%s. Post-mortem diagnostic: %s",
                     msg, paste(postmortem, collapse = ". "))
      stop_if_not(length(msg) == 1L)
    }
  
    msg
  } # post_mortem_cluster_failure()
})



getPsockImmediateConditionHandler <- local({
  sendCondition <- NULL

  function(frame = 1L) {
    if (is.function(sendCondition)) return(sendCondition)

    ns <- getNamespace("parallel")
    if (exists("sendData", mode = "function", envir = ns)) {
      parallel_sendData <- get("sendData", mode = "function", envir = ns)

      ## Find the 'master' argument of the worker's {slave,work}Loop()
      envir <- sys.frame(frame)
      master <- NULL
      while (!identical(envir, .GlobalEnv) && !identical(envir, emptyenv())) {
        if (exists("master", mode = "list", envir = envir, inherits = FALSE)) {
          master <- get("master", mode = "list", envir = envir, inherits = FALSE)
          if (inherits(master, c("SOCKnode", "SOCK0node"))) {
            sendCondition <<- function(cond) {
              data <- list(type = "VALUE", value = cond, success = TRUE)
              parallel_sendData(master, data)
            }
            return(sendCondition)
          }
        }
        frame <- frame + 1L
        envir <- sys.frame(frame)
      }
    }  

    ## Failed to locate 'master' or 'parallel:::sendData()',
    ## so just ignore immedicate conditions
    sendCondition <<- function(cond) NULL
  }
}) ## getPsockImmediateConditionHandler()


psockImmediateConditionHandler <- function(cond) {
  handler <- getPsockImmediateConditionHandler()
  handler(cond)
}


#' @importFrom parallelly connectionId isConnectionValid
assertValidConnection <- function(future) {
  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebug_push("assertValidConnection() ...")
    on.exit(mdebug_pop())
  }

  backend <- future[["backend"]]

  node_idx <- future[["node"]]
  if (debug) mdebugf("cluster node index: %d", node_idx)

  cl <- backend[["workers"]][node_idx]
  node <- cl[[1]]

  ## Nothing to do?
  if (is.null(con <- node[["con"]])) return()

  ## AD HOC/SPECIAL CASE: Skip if connection has been serialized and lacks internal representation. /HB 2018-10-27
  connId <- connectionId(con)
  if (!is.na(connId) && connId < 0L) return()

  isValid <- isConnectionValid(con)
  if (!isValid) {
    ex <- simpleError("Connection to the worker is corrupt")
    msg <- post_mortem_cluster_failure(ex, when = "receiving message from", node = node, future = future)
    stop(FutureError(msg, future = future))
  }
} ## assertValidConnection()



#' @export
getFutureBackendConfigs.ClusterFuture <- function(future, ..., debug = isTRUE(getOption("future.debug"))) {
  resignalImmediateConditions <- getOption("future.psock.relay.immediate")
  if (isFALSE(resignalImmediateConditions)) return(list())

  conditionClasses <- future[["conditions"]]
  if (is.null(conditionClasses)) return(list())
  
  immediateConditionClasses <- attr(conditionClasses, "immediateConditionClasses", exact = TRUE)
  if (is.null(immediateConditionClasses)) {
    immediateConditionClasses <- "immediateCondition"
  } else if (length(immediateConditionClasses) == 0L) {
    return(list())
  }
  
  ## Does the cluster node communicate with a connection?
  ## (if not, it's via MPI)
  if (!future[["nodeHasConnection"]]) return(list())

  capture <- list(
    immediateConditionHandlers = list(
      immediateCondition = psockImmediateConditionHandler
    )
  )

  list(
    capture = capture
  )
}





#' @importFrom parallelly cloneNode isNodeAlive
handleInterruptedFuture <- local({
  closeNode <- import_parallel("closeNode", default = function(node) {
    con <- node[["con"]]
    if (inherits(con, "connection")) close(con)
  })
  
  function(backend, future, relaunchWorker = TRUE, ...) {
    debug <- isTRUE(getOption("future.debug"))
    if (debug) {
      mdebug_push("handleInterruptedFuture() for ClusterFutureBackend ...")
      on.exit(mdebug_pop())
    }

    state <- future[["state"]]
    stop_if_not(state %in% c("canceled", "interrupted", "running"))
  
    label <- sQuoteLabel(future)
    workers <- backend[["workers"]]
    node_idx <- future[["node"]]
    cl <- workers[node_idx]
    node <- cl[[1]]
    host <- node[["host"]]
    event <- if (state %in% "running") {
      event <- sprintf("failed for unknown reason while %s", state)
      future[["state"]] <- "interrupted"
    } else {
      event <- sprintf("was %s", state)
    }
    msg <- sprintf("Future (%s) of class %s %s, while running on %s", label, class(future)[1], event, sQuote(host))
    if (inherits(node, "RichSOCKnode")) {
      pid <- node[["session_info"]][["process"]][["pid"]]
      if (!is.null(pid)) msg <- sprintf("%s (pid %s)", msg, pid)
    }
    result <- FutureInterruptError(msg, future = future)
    future[["result"]] <- result
  
    ## Remove from backend
    reg <- backend[["reg"]]
    exists <- FutureRegistry(reg, action = "contains", future = future, debug = debug)
    if (exists) {
      FutureRegistry(reg, action = "remove", future = future, earlySignal = FALSE, debug = debug)
      if (debug) mdebug("Erased future from future backend")
    }
  
    ## Try to relaunch worker, if it is no longer running?
    if (relaunchWorker) {
      alive <- isNodeAlive(node)
      if (debug) mdebugf("cluster node is alive: %s", alive)
      ## It is not possible to check if a node is alive on all types of clusters.
      ## If that is the case, the best we can do is to assume it is alive
      if (!is.na(alive) && !alive) {
        ## Launch a new cluster node, by cloning the old one
        node2 <- cloneNode(node)
        
        ## Add to cluster
        workers[[node_idx]] <- node2
    
        ## Update backend
        backend[["workers"]] <- workers
        
        ## Make sure to close the old cluster node (including any connection)
        tryCatch(closeNode(node), error = identity)
      }
    } ## if (relaunchWorker)
  
    future
  } ## handleInterruptedFuture()
})



#' Create a cluster future whose value will be resolved asynchronously in a parallel process
#'
#' _WARNING: This function must never be called.
#'  It may only be used with [future::plan()]_
#'
#' A cluster future is a future that uses cluster evaluation,
#' which means that its _value is computed and resolved in
#' parallel in another process_.
#'
#' @details
#' This function is must _not_ be called directly.  Instead, the
#' typical usages are:
#'
#' ```r
#' # Evaluate futures via a single background R process on the local machine
#' plan(cluster, workers = I(1))
#'
#' # Evaluate futures via two background R processes on the local machine
#' plan(cluster, workers = 2)
#'
#' # Evaluate futures via a single R process on another machine on on the
#' # local area network (LAN)
#' plan(cluster, workers = "raspberry-pi")
#'
#' # Evaluate futures via a single R process running on a remote machine
#' plan(cluster, workers = "pi.example.org")
#'
#' # Evaluate futures via four R processes, one running on the local machine,
#' # two running on LAN machine 'n1' and one on a remote machine
#' plan(cluster, workers = c("localhost", "n1", "n1", "pi.example.org"))
#' ```
#'
#' @inheritParams Future-class
#' @inheritParams future
#' @inheritParams FutureBackend-class
#'
#' @param workers A \code{\link[parallel:makeCluster]{cluster}} object,
#' a character vector of host names, a positive numeric scalar,
#' or a function.
#' If a character vector or a numeric scalar, a `cluster` object
#' is created using \code{\link[parallelly:makeClusterPSOCK]{makeClusterPSOCK}(workers)}.
#' If a function, it is called without arguments _when the future
#' is created_ and its value is used to configure the workers.
#' The function should return any of the above types.
#' If `workers == 1`, then all processing using done in the
#' current/main \R session and we therefore fall back to using a
#' sequential future. To override this fallback, use `workers = I(1)`.
#'
#' @param persistent If FALSE, the evaluation environment is cleared
#' from objects prior to the evaluation of the future.
#' 
#' @param \ldots Not used.
#'
#' @example incl/cluster.R
#'
#' @seealso
#' For alternative future backends, see the 'A Future for R: Available Future
#' Backends' vignette and \url{https://www.futureverse.org/backends.html}.
#'
#' @export
cluster <- function(..., workers = availableWorkers(constraints = "connections"), persistent = FALSE) {
  stop("INTERNAL ERROR: The future::cluster() function must never be called directly")
}
class(cluster) <- c("cluster", "multiprocess", "future", "function")
attr(cluster, "init") <- TRUE
attr(cluster, "factory") <- ClusterFutureBackend
attr(cluster, "tweakable") <- tweakable(attr(cluster, "factory"))


## NOTE, we must not memoize the cluster as part of the ClusterFutureBackend
## function, because that function is set as attribute "factory" of the
## 'cluster' function, which will be passed along to parallel workers
## as part of plan("tail").
#' @importFrom parallel stopCluster
#' @importFrom parallelly isConnectionValid
clusterRegistry <- local({
  ## We only allow one parallel 'cluster' per session
  cluster <- NULL

  getCluster <- function(..., debug = FALSE) {
    if (debug) {
      mdebug_push("getCluster() ...")
      mdebug_pop()
    }
    cluster
  }

  startCluster <- function(workers, makeCluster, ..., debug = FALSE) {
    if (debug) {
      mdebug_push("makeCluster(workers, ...) ...")
      on.exit(mdebug_pop())
      mdebug("Arguments:")
      mstr(list(workers, ...))
    }
    
    cl <- makeCluster(workers, ...)
    
    ## Attach name to cluster?
    name <- attr(cl, "name", exact = TRUE)
    if (is.null(name)) {
      name <- uuid(cl)
      stop_if_not(length(name) > 0, nzchar(name))
      attr(cl, "name") <- name
      if (debug) mdebug("Generated cluster UUID")
    }
    if (debug) {
      mdebugf("Cluster UUID: %s", sQuote(name))
      mprint(cl)
    }

    ## Memoize
    cluster <<- cl

    cluster
  } ## startCluster()

  stopCluster <- function(debug = FALSE) {
    if (debug) {
      mdebug_push("Stopping existing cluster ...")
      on.exit(mdebug_pop())
    }
    ## Nothing to do?
    if (is.null(cluster)) {
      if (debug) mdebug("No pre-existing cluster. Skipping")
      return(NULL)
    }

    ## ROBUSTNESS:
    ## Clear memoization of cluster, regardless of success or failure
    on.exit({
      cluster <<- NULL
    }, add = TRUE)

    if (debug) {
      mdebug("Cluster to shut down:")
      mprint(cluster)
    }

    ## (i) Try to shut down all of them at once
    tryCatch({ parallel::stopCluster(cluster) }, error = identity)

    ## (ii) As a backup, shut down workers one-by-one, because if one
    ## of them has already been interupted/terminated, that will trigger
    ## an error
    res <- rep(FALSE, times = length(cluster))
    for (kk in seq_along(cluster)) {
      cl <- cluster[kk]
      tryCatch({ parallel::stopCluster(cl) }, error = identity)
      res[kk] <- TRUE
      cl <- NULL
    }
    if (debug) mdebugf("Stopped cluster: %s", commaq(deparse(res)))

    ## (iii) As a final effort, make sure any PSOCK connections have
    ## been closed. This will prevent leaving behind stray connections
    ## in case parallel::stopCluster() failed
    for (kk in seq_along(cluster)) {
      node <- cluster[[kk]]
      con <- node$con
      if (inherits(con, "connection") && isConnectionValid(con)) {
        tryCatch(close(con), error = identity)
      }
    }

    ## (iv) Let the garbage collector clean out other, stray connections
    gc()
    
    NULL
  } ## stopCluster()

  list(
      getCluster = getCluster,
    startCluster = startCluster,
     stopCluster = stopCluster
  )
}) ## clusterRegistry()
