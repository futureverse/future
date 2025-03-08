#' A ClusterFutureBackend resolves futures in parallel using any PSOCK cluster
#'
#' @inheritParams FutureBackend
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
#' @rdname FutureBackend
#' @export
ClusterFutureBackend <- local({
  getDefaultCluster <- import_parallel_fcn("getDefaultCluster")
  
    function(workers = availableWorkers(), persistent = FALSE, earlySignal = TRUE, gc = FALSE, ...) {
    if (is.function(workers)) workers <- workers()
    if (is.null(workers)) {
      workers <- getDefaultCluster()
      workers <- addCovrLibPath(workers)
    } else if (is.character(workers) || is.numeric(workers)) {
      ## Which '...' arguments should be passed to Future() and 
      ## which should be passed to makeClusterPSOCK()?
      workers <- ClusterRegistry("start", workers = workers, ...)
    } else {
      workers <- as.cluster(workers)
      workers <- addCovrLibPath(workers)
    }
    if (!inherits(workers, "cluster")) {
      stopf("Argument 'workers' is not of class 'cluster': %s", commaq(class(workers)))
    }
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
      name <- digest(workers)
      stop_if_not(length(name) > 0, nzchar(name))
      attr(workers, "name") <- name
    }
  
    ## Name of the FutureRegistry
    reg <- sprintf("workers-%s", name)
  
    core <- FutureBackend(
      workers = workers,
      persistent = persistent,
      reg = reg,
      earlySignal = earlySignal,
      gc = gc,
      future.wait.timeout = getOption("future.wait.timeout", 30 * 24 * 60 * 60),
      future.wait.interval = getOption("future.wait.interval", 0.01),
      future.wait.alpha = getOption("future.wait.alpha", 1.01),
      ...
    )
    core[["futureClasses"]] <- c("ClusterFuture", core[["futureClasses"]])
    core <- structure(core, class = c("ClusterFutureBackend", "FutureBackend", class(core)))
    core
  }
})


#' @export
launchFuture.ClusterFutureBackend <- function(backend, future, ...) {
  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebug("launchFuture() for ClusterFutureBackend ...")
    on.exit(mdebug("launchFuture() for ClusterFutureBackend ... done"))
  }

  ## Record 'backend' in future for now
  future[["backend"]] <- backend

  workers <- backend[["workers"]]
  stop_if_not(inherits(workers, "cluster"))
  
  reg <- backend[["reg"]]
  stop_if_not(is.character(reg), length(reg) == 1L)
  
  if (debug) {
    mdebug("Workers:")
    mstr(workers)
    mdebug("FutureRegistry: ", sQuote(reg))
  }
  
  ## Next available cluster node
  t_start <- Sys.time()

  ## (1) Get a free worker. This will block until one is available
  if (debug) mdebug("requestWorker() ...")

  timeout <- backend[["future.wait.timeout"]]
  delta <- backend[["future.wait.interval"]]
  alpha <- backend[["future.wait.alpha"]]

  node_idx <- requestNode(await = function() {
    FutureRegistry(reg, action = "collect-first", earlySignal = TRUE)
  }, workers = workers, timeout = timeout, delta = delta, alpha = alpha)
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

  if (debug) mdebugf(" - cluster node index: %d", node_idx)
  if (debug) mdebug("requestWorker() ... done")

  ## (2) Attach packages that needs to be attached
  ##     NOTE: Already take care of by evalFuture().
  ##     However, if we need to get an early error about missing packages,
  ##     we can get the error here before launching the future.
  if (future[["earlySignal"]]) {
    if (debug) mdebug("requirePackages() ...")
    
    packages <- future[["packages"]]
    if (debug) mdebug(" - packages: [n=%d] %s", length(packages), commaq(packages))
    
    ## Nothing to do?
    if (length(packages) > 0L) { 
      t_start <- Sys.time()
  
      ## (ii) Attach packages that needs to be attached
      ##      NOTE: Already take care of by evalFuture().
      ##      However, if we need to get an early error about missing packages,
      ##      we can get the error here before launching the future.
      cl <- workers[node_idx]
      if (debug) mdebug("Attaching packages on worker ...")
      ## Blocking cluster-node call
      cluster_call_blocking(cl, fun = requirePackages, packages, future = future, when = "call requirePackages() on")
      if (debug) mdebug("Attaching packages on worker ... done")
      
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
    
    if (debug) mdebug("requirePackages() ... done")
  }

  ## (2) Reset global environment of cluster node such that
  ##     previous futures are not affecting this one, which
  ##     may happen even if the future is evaluated inside a
  ##     local, e.g. local({ a <<- 1 }).
  ##     If the persistent = TRUE, this will be skipped.
  persistent <- isTRUE(future[["persistent"]])
  if (!persistent) {
    if (debug) mdebug("eraseGlobalEnvironment() ...")
    
    t_start <- Sys.time()
    
    ## (i) Reset global environment of cluster node such that
    ##     previous futures are not affecting this one, which
    ##     may happen even if the future is evaluated inside a
    ##     local, e.g. local({ a <<- 1 }).
    cl <- workers[node_idx]
    ## Blocking cluster-node call
    cluster_call_blocking(cl, fun = grmall, future = future, when = "call grmall() on")

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
    if (debug) mdebug("eraseGlobalEnvironment() ... done")
  }


  ## (3) Garbage collection
  if (isTRUE(backend[["gc"]])) {
    cluster_call_blocking(cl, fun = gc, future = future, when = "call gc() on")
  }
  

  ## (4) Launch future
  if (debug) mdebug("launchFuture() ...")
  worker <- future[["node"]]
  stop_if_not(
    length(worker) == 1L, is.integer(worker), !is.na(worker),
    worker >= 1L, worker <= length(workers)
  ) 
  if (debug) mdebugf(" - cluster node index: %d", worker)
  future[["workers"]] <- workers  ## FIXME
  data <- getFutureData(future, debug = debug)
  node <- workers[[worker]]
  ## Non-blocking cluster-node call
  node_call_nonblocking(node, fun = evalFuture, args = list(data), future = future, when = "launch future on")
  FutureRegistry(reg, action = "add", future = future, earlySignal = FALSE)
  if (debug) mdebug("launchFuture() ... done")

  future[["state"]] <- "running"

  if (debug) mdebugf("%s started", class(future)[1])
  
  invisible(future)
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
  backend <- evaluator
  workers <- backend[["workers"]]
  stop_if_not(length(workers) > 0L, inherits(workers, "cluster"))
  workers <- length(workers)
  reg <- backend[["reg"]]
  stop_if_not(length(reg) == 1L, is.character(reg), nzchar(reg))

  ## Number of unresolved cluster futures
  usedNodes <- length(FutureRegistry(reg, action = "list", earlySignal = FALSE))
  
  workers <- workers - usedNodes
  stop_if_not(length(workers) == 1L, !is.na(workers), workers >= 0L, is.finite(workers))
  
  workers
}
