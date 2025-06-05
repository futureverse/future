#' Create a Future Cluster of Stateless Workers for Parallel Processing
#'
#' _WARNING: Please note that this sets up a stateless set of cluster nodes,
#' which means that `clusterEvalQ(cl, { a <- 3.14 })` will have no effect.
#' Consider this a first beta version and use it with great care,
#' particularly because of the stateless nature of the cluster.
#' For now, I recommend to manually validate that you can get identical
#' results using this cluster type with what you get from using the
#' classical `parallel::makeCluster()` cluster type._
#'
#'
#' @param specs Ignored.
#' If specified, the value should equal `nbrOfWorkers()` (default).
#' A missing value corresponds to specifying `nbrOfWorkers()`.
#' This argument exists only to support
#' `parallel::makeCluster(NA, type = future::FUTURE)`.
#'
#' @param \ldots Named arguments passed to [future::future()].
#'
#' @return
#' Returns a \pkg{parallel} `cluster` object of class `FutureCluster`.
#'
#' @examplesIf (getRversion() >= "4.4.0")
#' plan(multisession)
#' cl <- makeClusterFuture()
#'
#' parallel::clusterSetRNGStream(cl)
#'
#' y <- parallel::parLapply(cl, 11:13, function(x) {
#'   message("Process ID: ", Sys.getpid())
#'   mean(rnorm(n = x))
#' })
#' str(y)
#'
#' plan(sequential)
#'
#' @section Future Clusters are Stateless:
#' Traditionally, a cluster nodes has a one-to-one mapping to a cluster
#' worker process. For example, `cl <- makeCluster(2, type = "PSOCK")`
#' launches two parallel worker processes in the background, where
#' cluster node `cl[[1]]` maps to worker #1 and node `cl[[2]]` to
#' worker #2, and that never changes through the lifespan of these
#' workers. This one-to-one mapping allows for deterministic
#' configuration of workers. For examples, some code may assign globals
#' with values specific to each worker, e.g.
#' `clusterEvalQ(cl[1], { a <- 3.14 })` and
#' `clusterEvalQ(cl[2], { a <- 2.71 })`.
#'
#' In contrast, there is no one-to-one mapping between cluster nodes
#' and the parallel workers when using a future cluster. This is because
#' we cannot make assumptions on where are parallel task will be
#' processed. Where a parallel task is processes is up to the future
#' backend to decide - some backends do this deterministically, whereas
#' others other resolves task at the first available worker. Also, the
#' worker processes might be _transient_ for some future backends, i.e.
#' the only exist for the life-span of the parallel task and then
#' terminates.
#'
#' Because of this, one must not rely in node-specific behaviors,
#' because that concept does not make sense with a future cluster.
#' To protect against this, any attempt to address a subset of future
#' cluster nodes, results in an error, e.g. `clusterEvalQ(cl[1], ...)`,
#' `clusterEvalQ(cl[1:2], ...)`, and `clusterEvalQ(cl[2:1], ...)` in
#' the above example will all give an error.
#'
#' Exceptions to the latter limitation are `clusterSetRNGStream()`
#' and `clusterExport()`, which can be safely used with future clusters.
#' See below for more details.
#' If `clusterEvalQ()` is called, the call is ignored, and a warning
#' is produced.
#'
#' @section clusterSetRNGStream:
#' [parallel::clusterSetRNGStream()] distributes "L'Ecuyer-CMRG" RNG
#' streams to the cluster nodes, which record them such that the next
#' round of futures will use them. When used, the RNG state after the
#' futures are resolved are recorded accordingly, such that the next
#' round again of future will use those, and so on. This strategy
#' makes sure `clusterSetRNGStream()` has the expected effect although
#' futures are stateless.
#'
#' @section clusterExport:
#' [parallel::clusterExport()] assign values to the cluster nodes.
#' Specifically, these values are recorded and are used as globals
#' for all futures created there on.
#'
#' @aliases FUTURE
#' @keywords internal
#' 
#' @importFrom future nbrOfWorkers
#' @rawNamespace if (getRversion() >= "4.4") export(makeClusterFuture)
makeClusterFuture <- function(specs = nbrOfWorkers(), ...) {
  stop_if_not(length(specs) == 1L)

  backend <- plan("backend")
  n <- nbrOfWorkers(backend)
  if (is.na(specs)) specs <- n

  if (is.numeric(specs)) {
    if (specs <= 0) {
      stop("Argument 'specs' must be a positive integer: %s", specs)
    }
    if (specs != n) {
      stop(sprintf("Value of argument 'specs' does not match the number of workers in the registered future backend (%s:%s): %g != %g", class(backend)[1], backend[["uuid"]], specs, n))
    }
  } else {
    stop("Unknown type of argument 'specs': ", typeof(specs))
  }
  
  options <- list(...)
  if (length(options) > 0L) {
    names <- names(options)
    if (is.null(names) || !all(nzchar(names))) {
      stop("All arguments must be named")
    }
  }
  if (is.null(options[["globals"]])) {
    options[["globals"]] <- formals(future)[["globals"]]
  }

  env <- new.env(parent = emptyenv())
  env[["backend"]] <- backend
  
  cl <- vector("list", length = n)
  for (kk in seq_along(cl)) {
    node <- new.env(parent = emptyenv())
    node[["index"]] <- kk
    node[["options"]] <- options
    node[["backend"]] <- backend
    node[["cluster_env"]] <- env
    class(node) <- c("FutureNode")
    cl[[kk]] <- node
  }
  attr(cl, "cluster_env") <- env
  class(cl) <- c("FutureCluster", "cluster")
  env[["cluster"]] <- cl
  cl
}


#' @rawNamespace if (getRversion() >= "4.4") S3method(print,FutureCluster)
print.FutureCluster <- function(x, ...) {
  cat(sprintf("A %s cluster with %d node\n", sQuote(class(x)[1]), length(x)))

  cluster_env <- attr(x, "cluster_env")
  exports <- cluster_env[["exports"]]
  names <- names(exports)
  types <- vapply(exports, FUN.VALUE = NA_character_, FUN = typeof)
  info <- sprintf("%s (%s)", names, types)
  cat(sprintf("Exports: [n=%d] %s\n", length(exports), comma(info)))

  clusterEvalQs <- cluster_env[["clusterEvalQs"]]
  n <- length(clusterEvalQs)
  if (n > 0) {
    cat(sprintf("clusterEvalQ() calls ignored: [n=%d]:\n", n))
    if (n > 3) clusterEvalQs <- clusterEvalQs[1:3]
    exprs <- lapply(clusterEvalQs, FUN = function(x) {
      expr <- x[["expression"]]
      attributes(expr) <- NULL
      expr
    })
    str(exprs)
  }

  backend <- cluster_env[["backend"]]
  print(backend)

  plan_backend <- plan("backend")
  if (!identical(plan_backend[["uuid"]], backend[["uuid"]])) {
    warning(FutureWarning(
      sprintf("This %s cluster was set up under a future backend (%s:%s) that is not compatible with the current future backend (%s:%s). Make sure that the backend was not re-configured since this cluster was created", class(x)[1], class(backend)[1], backend[["uuid"]], class(plan_backend)[1], plan_backend[["uuid"]])
    ), call. = FALSE, immediate. = TRUE)
  }
}


#' @export
`[.FutureCluster` <- function(x, ...) {
  ## Subset, but drop class to make sure it's not a valid 'cluster' object
  .subset(x, ...)
}

#' @export
`[[.FutureCluster` <- function(x, ...) {
  NextMethod()
}


#' @importFrom future future
#' @rawNamespace if (getRversion() >= "4.4") importFrom(parallel,sendData)
#' @rawNamespace if (getRversion() >= "4.4") S3method(sendData,FutureNode)
sendData.FutureNode <- function(node, data) {
  ## sendCall(con, fcn, args, return = TRUE, tag = NULL)
  ##  postNode(con, "EXEC", value = list(fun = fun, args = args, return = return, tag = tag), tag = NULL)
  ##   sendData(con, data = list(type = type, data = value, tag = tag))
  ##
  ## => sendData(con, data = list(type = "EXEC", data = list(fun = fun, args = args, return = TRUE), tag = NULL))
  
  index <- node[["index"]]
  
  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebugf_push("sendData() for %s #%d ...", class(node)[1], index)
    on.exit(mdebug_pop())
  }

  type <- data[["type"]]
  if (debug) mdebugf("| type: %s", sQuote(type))

  ## Assert that future backend has not changed
  backend <- node[["cluster_env"]][["backend"]]
  plan_backend <- plan("backend")
  if (!identical(plan_backend[["uuid"]], backend[["uuid"]])) {
    stop(FutureError(
      sprintf("This %s node was set up under a future backend (%s:%s) that is not compatible with the current future backend (%s:%s). Make sure that the backend was not re-configured since this cluster was created", class(node)[1], class(backend)[1], backend[["uuid"]], class(plan_backend)[1], plan_backend[["uuid"]])
    ))
  }

  if (type == "EXEC") {
    data <- data[["data"]]

    ## SPECIAL CASE #1: Called via clusterSetRNGStream()?
    if (called_via_clusterSetRNGStream()) {
      if (debug) mdebug("Detected: clusterSetRNGStream()")
      args <- data[["args"]]
      call <- args[[1]]
      seed <- call[[3]]
      if (debug) mdebugf("Seed recorded: (%s)", comma(seed))
      ns <- getNamespace("future")
      is_lecyer_cmrg_seed <- get("is_lecyer_cmrg_seed", mode = "function", envir = ns, inherits = FALSE)
      stopifnot(is_lecyer_cmrg_seed(seed))
      node[["seed"]] <- seed
      ConstantFuture <- get("ConstantFuture", mode = "function", envir = ns, inherits = FALSE)
      ## parallel:::recvResult() expects element 'value'
      node[["future"]] <- ConstantFuture(list(value = NULL), seed = seed, substitute = FALSE)
      return(invisible(node))
    } 

    ## SPECIAL CASE #2: Called via clusterExport()?
    if (called_via_clusterExport()) {
      if (debug) mdebug("Detected: clusterExport()")

      ## Only need to be handled once per cluster - not once per node
      if (index == 1L) {
        args <- data[["args"]]
        if (debug) mdebugf("Exports: [n=%d] %s", length(args), commaq(names(args)))
        cluster_env <- node[["cluster_env"]]
        exports <- cluster_env[["exports"]]
        if (is.null(exports)) exports <- list()
        ## Append <name>=<value> to 'exports'
        name <- args[[1]]
        value <- args[[2]]
        exports[[name]] <- value
        cluster_env[["exports"]] <- exports
      }

      ns <- getNamespace("future")
      ConstantFuture <- get("ConstantFuture", mode = "function", envir = ns, inherits = FALSE)
      ## parallel:::recvResult() expects element 'value'
      node[["future"]] <- ConstantFuture(list(value = NULL), substitute = FALSE)
      return(invisible(node))
    }

    ## SPECIAL CASE #3: Called via clusterEvalQ()?
    if (called_via_clusterEvalQ()) {
      if (debug) mdebug("Detected: clusterEvalQ()")

      ## Only need to be handled once per cluster - not once per node
      if (index == 1L) {
        args <- data[["args"]]
        expr <- args[[1]]
        calls <- sys.calls()
        if (debug) {
          mdebug("Expression:")
          mprint(expr)
        }
  
        cluster_env <- node[["cluster_env"]]
  
        ## Record ignored clusterEvalQ() expressions
        clusterEvalQs <- cluster_env[["clusterEvalQs"]]
        if (is.null(clusterEvalQs)) clusterEvalQs <- list()
        call <- list(expression = expr, calls = calls)
        clusterEvalQs <- c(clusterEvalQs, list(call))
        cluster_env[["clusterEvalQs"]] <- clusterEvalQs
  
        ## Warn about ignored clusterEvalQ() call?
        action <- getOption("future.ClusterFuture.clusterEvalQ", "warning")
        if (action != "ignore") {
          cluster <- cluster_env[["cluster"]]
          code <- deparse(expr)
          code <- paste(code, collapse = " ")
          code <- substring(code, first = 1L, last = 30L)
          code <- gsub(" +", " ", code)
          msg <- sprintf("parallel::clusterEvalQ() is not supported by %s clusters. Ignoring expression: %s", class(cluster)[[1]], code)
          if (action == "warning") {
            warning(FutureWarning(msg))
          } else if (action == "error") {
            stop(FutureError(msg))
          }
        }
      }
      
      node[["future"]] <- ConstantFuture(list(value = NULL), substitute = FALSE)
      return(invisible(node))
    }

    options <- node[["options"]]
    if ("seed" %in% names(node)) {
      options[["seed"]] <- node[["seed"]]
    }

    cluster_env <- node[["cluster_env"]]
    exports <- cluster_env[["exports"]]
    if (length(exports) > 0) {
      globals <- options[["globals"]]
      if (is.logical(globals)) {
        attr(globals, "add") <- c(exports, attr(globals, "add"))
      } else if (is.character(globals)) {
        attr(globals, "add") <- c(exports, attr(globals, "add"))
      } else if (is.list(globals)) {
        globals <- c(exports, globals)
      }
      options[["globals"]] <- globals
    }

    node[["future"]] <- local({
      if (debug) {
        mdebug_push("Create future ...")
        on.exit(mdebug_pop())
        mstr(list(data = data))
        mstr(list(options = options))
      }
      fun <- data[["fun"]]
      args <- data[["args"]]

      expr <- quote(do.call(fun, args = args))
      future_args <- list(expr = quote(expr), substitute = FALSE)
      future_args <- c(future_args, options)

      if (debug) mstr(list(future_args = future_args))
      do.call(future, args = future_args)
    })
  } else if (type == "DONE") {
    future <- node[["future"]]
    if (inherits(future, "Future")) {
      node[["future"]] <- local({
        if (debug) {
          mdebug_push("Canceling future ...")
          on.exit(mdebug_pop())
        }
        future <- cancel(future)
        tryCatch(resolve(future), error = identity)
        tryCatch(value(future), error = identity)
        NULL
      })
    }
  } else {
    stop(sprintf("sendData() for %s: type = %s is not supported", class(node)[1], sQuote(type)))
  }
  
  invisible(node)
}


#' @importFrom future value
#' @rawNamespace if (getRversion() >= "4.4") importFrom(parallel,recvData)
#' @rawNamespace if (getRversion() >= "4.4") S3method(recvData,FutureNode)
recvData.FutureNode <- function(node) {
  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebugf_push("recvData() for %s ...", class(node)[1])
    on.exit(mdebug_pop())
  }

  future <- node[["future"]]
  if (!inherits(future, "Future")) {
    stop(sprintf("%s does not have a future associated with it", class(node)[1]))
  }
  result <- result(future)
  if (debug) mprint(result)
  
  if ("seed" %in% names(node) && !is.null(result[["seed"]])) {
    if (debug) mdebug("Updating the node's RNG state")
    node[["seed"]] <- result[["seed"]]
  }

  ## parallel:::recvResult() expects element 'value'
  list(value = value(future))
}


called_via_clusterSetRNGStream <- function(calls = sys.calls()) {
  finds <- c("sendData", "postNode", "sendCall")
  nfinds <- length(finds)
  ncalls <- length(calls)
  
  ## Not possible?
  if (ncalls <= nfinds + 1L) return(FALSE)
  
  ii <- 1L
  find <- as.symbol(finds[ii])
  
  found <- FALSE
  for (jj in ncalls:1) {
    call <- calls[[jj]][[1]]

    if (identical(call, find)) {
      if (ii == nfinds) {
        ## First passage done
        found <- TRUE
        break
      }
      ii <- ii + 1L
      find <- as.symbol(finds[ii])
    } else if (ii > 1L) {
      return(FALSE)
    }
  }
  if (!found) return(FALSE)
  jj <- jj - 1L

  call <- calls[[jj]][[1]]
  if (identical(call, as.symbol("clusterSetRNGStream"))) {
    return(TRUE)
  }
  if (identical(call, quote(parallel::clusterSetRNGStream))) {
    return(TRUE)
  }
  FALSE
} ## called_via_clusterSetRNGStream()




# Dotted pair list of 6
#  $ : language clusterExport(cl, varlist = c("a", "b"))
#  $ : language clusterCall(cl, gets, name, get(name, envir = envir))
#  $ : language sendCall(cl[[i]], fun, list(...))
#  $ : language postNode(con, "EXEC", list(fun = fun, args = args, return = return, tag = tag))
#  $ : language sendData(con, list(type = type, data = value, tag = tag))
#  $ : language sendData.FutureNode(con, list(type = type, data = value, tag = tag))
called_via_clusterExport <- function(calls = sys.calls()) {
  finds <- c("sendData", "postNode", "sendCall", "clusterCall")
  nfinds <- length(finds)
  ncalls <- length(calls)
  
  ## Not possible?
  if (ncalls <= nfinds + 1L) return(FALSE)

  ii <- 1L
  find <- as.symbol(finds[ii])
  
  found <- FALSE
  for (jj in ncalls:1) {
    call <- calls[[jj]][[1]]

    if (identical(call, find)) {
      if (ii == nfinds) {
        ## First passage done
        found <- TRUE
        break
      }
      ii <- ii + 1L
      find <- as.symbol(finds[ii])
    } else if (ii > 1L) {
      return(FALSE)
    }
  }
  if (!found) return(FALSE)
  jj <- jj - 1L

  call <- calls[[jj]][[1]]
  if (identical(call, as.symbol("clusterExport"))) {
    return(TRUE)
  }
  if (identical(call, quote(parallel::clusterExport))) {
    return(TRUE)
  }
  FALSE
} ## called_via_clusterExport()


# Dotted pair list of 6
#  $ : language clusterEvalQ(cl, 42)
#  $ : language clusterCall(cl, eval, substitute(expr), envir = .GlobalEnv)
#  $ : language sendCall(cl[[i]], fun, list(...))
#  $ : language postNode(con, "EXEC", list(fun = fun, args = args, return = return, tag = tag))
#  $ : language sendData(con, list(type = type, data = value, tag = tag))
#  $ : language sendData.FutureNode(con, list(type = type, data = value, tag = tag))
called_via_clusterEvalQ <- function(calls = sys.calls()) {
  finds <- c("sendData", "postNode", "sendCall", "clusterCall")
  nfinds <- length(finds)
  ncalls <- length(calls)
  
  ## Not possible?
  if (ncalls <= nfinds + 1L) return(FALSE)

  ii <- 1L
  find <- as.symbol(finds[ii])
  
  found <- FALSE
  for (jj in ncalls:1) {
    call <- calls[[jj]][[1]]

    if (identical(call, find)) {
      if (ii == nfinds) {
        ## First passage done
        found <- TRUE
        break
      }
      ii <- ii + 1L
      find <- as.symbol(finds[ii])
    } else if (ii > 1L) {
      return(FALSE)
    }
  }
  if (!found) return(FALSE)
  jj <- jj - 1L

  call <- calls[[jj]][[1]]
  if (identical(call, as.symbol("clusterEvalQ"))) {
    return(TRUE)
  }
  if (identical(call, quote(parallel::clusterEvalQ))) {
    return(TRUE)
  }
  FALSE
} ## called_via_clusterEvalQ()
