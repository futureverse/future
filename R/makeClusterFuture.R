#' Create a Future Cluster of Stateless Workers for Parallel Processing
#'
#' @param \ldots Named arguments passed to [future::future()].
#'
#' @return
#' Returns a \pkg{parallel} `cluster` object of class `FutureCluster`.
#'
#' @examples
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
#' configuration of workers. For examples, some code make assign globals
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
#' That said, there will be no error produced when calling
#' `clusterEvalQ(cl, { a <- 42 })`, but we can still not rely on
#' variable `a` being available in following parallel tasks. Again,
#' this is because each parallel task, including the above ones, may
#' be processes on random or transient parallel workers.
#'
#' One exception to the latter limitation is `clusterSetRNGStream()`,
#' which can be safely used with future clusters. See below for more
#' details.
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
#' @importFrom future nbrOfWorkers
#' @export
makeClusterFuture <- function(...) {
  options <- list(...)
  if (length(options) > 0L) {
    names <- names(options)
    if (is.null(names) || !all(nzchar(names))) {
      stop("All arguments must be named")
    }
  }
  
  cl <- vector("list", length = nbrOfWorkers())
  for (kk in seq_along(cl)) {
    node <- new.env(parent = emptyenv())
    node[["options"]] <- options
    class(node) <- c("FutureNode")
    cl[[kk]] <- node
  }
  class(cl) <- c("FutureCluster", "cluster")
  cl
}


#' @export
`[.FutureCluster` <- function(x, ...) {
  .subset(x, ...)
}

#' @export
`[[.FutureCluster` <- function(x, ...) {
  NextMethod()
}


#' @importFrom utils capture.output str
#' @importFrom future future
#' @exportS3Method sendData FutureNode
sendData.FutureNode <- function(node, data) {
  ## sendCall(con, fcn, args, return = TRUE, tag = NULL)
  ##  postNode(con, "EXEC", value = list(fun = fun, args = args, return = return, tag = tag), tag = NULL)
  ##   sendData(con, data = list(type = type, data = value, tag = tag))
  ##
  ## => sendData(con, data = list(type = "EXEC", data = list(fun = fun, args = args, return = TRUE), tag = NULL))
  
  debug <- isTRUE(getOption("parallel.future.debug"))
  if (debug) {
    message(sprintf("sendData() for %s ...", class(node)[1]))
    on.exit(message(sprintf("sendData() for %s ... done", class(node)[1])))
  }

  type <- data[["type"]]
  if (debug) message(sprintf("| type: %s", sQuote(type)))
  
  if (type == "EXEC") {
    data <- data[["data"]]

    ## SPECIAL CASE #1: Called via clusterSetRNGStream()?
    if (called_via_clusterSetRNGStream()) {
      if (debug) message("Detected: clusterSetRNGStream()")
      args <- data[["args"]]
      call <- args[[1]]
      seed <- call[[3]]
      if (debug) message(sprintf("Seed recorded: (%s)", paste(seed, collapse = ", ")))
      ns <- getNamespace("future")
      is_lecyer_cmrg_seed <- get("is_lecyer_cmrg_seed", mode = "function", envir = ns, inherits = FALSE)
      stopifnot(is_lecyer_cmrg_seed(seed))
      node[["seed"]] <- seed
      ConstantFuture <- get("ConstantFuture", mode = "function", envir = ns, inherits = FALSE)
      node[["future"]] <- ConstantFuture(list(value = NULL, seed = seed), substitute = FALSE)
      return(invisible(node))
    }

    options <- node[["options"]]
    if ("seed" %in% names(node)) {
      options[["seed"]] <- node[["seed"]]
    }
    
    node[["future"]] <- local({
      if (debug) {
        message("| Create future ...")
        on.exit(message("| Create future ... done"))
        
        out <- capture.output(str(list(data = data)))
        out <- sprintf("| : %s", out)
        out <- paste(out, collapse = "\n")
        message(out)

        out <- capture.output(str(list(options = options)))
        out <- sprintf("| : %s", out)
        out <- paste(out, collapse = "\n")
        message(out)
      }
      fun <- data[["fun"]]
      args <- data[["args"]]
      expr <- quote(list(
        value = do.call(fun, args = args),
         seed = globalenv()[[".Random.seed"]]
      ))
      future_args <- list(expr = quote(expr), substitute = FALSE)
      future_args <- c(future_args, options)
      if (debug) {
        out <- capture.output(str(list(args = future_args)))
        out <- sprintf("| : %s", out)
        out <- paste(out, collapse = "\n")
        message(out)
      }
      do.call(future, args = future_args)
    })
  } else if (type == "DONE") {
    future <- node[["future"]]
    if (inherits(future, "Future")) {
      node[["future"]] <- local({
        if (debug) {
          message("| Canceling future ...")
          on.exit(message("| Canceling future ... done"))
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
#' @exportS3Method recvData FutureNode
recvData.FutureNode <- function(node) {
  debug <- isTRUE(getOption("parallel.future.debug"))
  if (debug) {
    message(sprintf("recvData() for %s ...", class(node)[1]))
    on.exit(message(sprintf("recvData() for %s ... done", class(node)[1])))
  }

  future <- node[["future"]]
  if (!inherits(future, "Future")) {
    stop(sprintf("%s does not have a future associated with it", class(node)[1]))
  }
  res <- value(future)
  
  value <- res[["value"]]
  
  if ("seed" %in% names(node)) {
    node[["seed"]] <- res[["seed"]]
  }
  
  list(value = value)
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
}
