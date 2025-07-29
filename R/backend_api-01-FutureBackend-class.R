#' Configure a backend that controls how and where futures are evaluated
#'
#' @description
#' _This functionality is only for developers who wish to implement their
#' own future backend.  End-users and package developers use futureverse,
#' does not need to know about these functions._
#'
#' If you are looking for available future backends to choose from, please
#' see the 'A Future for R: Available Future Backends' vignette and
#' \url{https://www.futureverse.org/backends.html}.
#'
#' @param \ldots (optional) Backend-specific named arguments.
#'
#' @param earlySignal Overrides the default behavior on whether futures
#' should resignal ("relay") conditions captured as soon as possible, or
#' delayed, for instance, until [value()] is called on the future.
#' (Default: `FALSE`)
#'
#' @param gc Overrides the default behavior of whether futures should trigger
#' garbage collection via [gc()] on the parallel worker after the value has 
#' been collected from the worker.
#' This can help to release memory sooner than letting R itself on the parallel
#' worker decided when it is needed. Releasing memory sooner can help to fit
#' more parallel workers on a machine with limited amount of total memory.
#' (Default: `FALSE`)
#'
#' @param maxSizeOfObjects The maximum allowed total size, in bytes, of all
#' objects to and from the parallel worker allows.
#' This can help to protect against unexpectedly large data transfers between
#' the parent process and the parallel workers - data that is often transferred
#' over the network, which sometimes also includes the internet. For instance,
#' if you sit at home and have set up a future backend with workers running
#' remotely at your university or company, then you might want to use this
#' protection to avoid transferring giga- or terabytes of data without noticing.
#' (Default: \eqn{500 \cdot 1024^2} bytes = 500 MiB, unless overridden by a
#'  FutureBackend subclass, or by R option [future.globals.maxSize] (sic!))
#'
#' @param interrupts If FALSE, attempts to interrupt futures will not take
#' place on this backend, even if the backend supports it. This is useful
#' when, for instance, it takes a long time to interrupt a future.
#'
#' @return
#' `FutureBackend()` returns a FutureBackend object, which inherits an
#' environment. Specific future backends are defined by subclasses
#' implementing the FutureBackend API.
#'
#' @section The FutureBackend API:
#' The `FutureBackend` class specifies FutureBackend API,
#' that all backends must implement and comply to. Specifically,
#'
#' @name FutureBackend-class
#' @keywords internal
#' @export
FutureBackend <- function(..., earlySignal = FALSE, gc = FALSE, maxSizeOfObjects = getOption("future.globals.maxSize", +Inf), interrupts = TRUE, hooks = FALSE) {
  core <- new.env(parent = emptyenv())

  if (!is.logical(gc)) {
    str(gc)
  }
  
  stop_if_not(length(earlySignal) == 1L, is.logical(earlySignal), !is.na(earlySignal))
  stop_if_not(length(gc) == 1L, is.logical(gc), !is.na(gc))
  stop_if_not(length(maxSizeOfObjects) == 1L, is.numeric(maxSizeOfObjects),
              !is.na(maxSizeOfObjects), maxSizeOfObjects >= 0)
  stop_if_not(length(interrupts) == 1L, is.logical(interrupts), !is.na(interrupts))
  stop_if_not(length(hooks) == 1L, is.logical(hooks), !is.na(hooks))
  
  ## Record future plan tweaks, if any
  counters <- c(created = 0L, launched = 0L, finished = 0L)
  args <- list(..., earlySignal = earlySignal, maxSizeOfObjects = maxSizeOfObjects, gc = gc, interrupts = interrupts, hooks = hooks, uuid = uuid(proc.time()), counters = counters, runtime = 0.0)
  for (name in names(args)) {
    core[[name]] <- args[[name]]
  }
  
  core[["futureClasses"]] <- c("Future")
  core <- structure(core, class = c("FutureBackend", class(core)))
  core
}
attr(FutureBackend, "tweakable") <- setdiff(names(formals(FutureBackend)), "...")


#' @importFrom parallelly availableCores
#' @export
print.FutureBackend <- function(x, ...) {
  backend <- x

  done <- character(0L)
  
  classes <- setdiff(class(backend), "environment")
  s <- sprintf("%s:", classes[1])
  s <- c(s, sprintf("Inherits: %s", paste(classes[-1], collapse = ", ")))

  s <- c(s, sprintf("UUID: %s", backend[["uuid"]]))

  ## Summary of workers
  s <- c(s, sprintf("Number of workers: %g", nbrOfWorkers(backend)))
  s <- c(s, sprintf("Number of free workers: %g", nbrOfFreeWorkers(backend)))
  s <- c(s, sprintf("Available cores: %d", availableCores()))
  done <- c(done, "workers")

  ## Settings
  s <- c(s, sprintf("Automatic garbage collection: %s", backend[["gc"]]))
  done <- c(done, "gc")
  s <- c(s, sprintf("Early signaling: %s", backend[["earlySignal"]]))
  done <- c(done, "earlySignal")
  s <- c(s, sprintf("Interrupts are enabled: %s", backend[["interrupts"]]))
  done <- c(done, "interrupts")
  max <- backend[["maxSizeOfObjects"]]
  done <- c(done, "maxSizeOfObjects")
  max <- rep(max, length.out = 2L)
  max <- vapply(max, FUN.VALUE = NA_character_, FUN = function(x) {
    if (is.finite(x)) asIEC(x) else "+Inf"
  })
  s <- c(s, sprintf("Maximum total size of globals: %s", max[1]))
  s <- c(s, sprintf("Maximum total size of value: %s", max[2]))

  fields <- tweakable(attr(backend, "factory"))
  fields <- setdiff(fields, done)
  for (name in fields) {
    s <- c(s, sprintf("Argument %s: %s", sQuote(name), paste(deparse(backend[[name]]), collapse = "") ))
  }

  ## Active futures
  resolved <- NULL ## To please R CMD check
  data <- listFutures(backend)
  stop_if_not(is.data.frame(data))
  if (nrow(data) == 0L) {
    s <- c(s, "Number of active futures: 0")
  } else {
    resolved <- data[["resolved"]]
    s <- c(s, sprintf("Number of active futures: %d (%d resolved, %d unresolved)", length(resolved), sum(resolved), sum(!resolved)))
    if (!all(resolved)) {
      ## Current processing times for the non-resolved futures
      duration <- proc.time()[[3]] - data[!resolved, "start"]
      stats <- summary(duration)
      names(stats) <- c("min", "25%", "50%", "mean", "75%", "max")
      stats <- sprintf("%s: %.1gs", names(stats), stats)
      stats <- paste(stats, collapse = ", ")
      s <- c(s, sprintf("Non-resolved future running times: %s", stats))
    }
  }

  counters <- backend[["counters"]]
  names <- names(counters)
  info <- sprintf("%s %s", counters, names)
  info <- paste(info, collapse = ", ")
  s <- c(s, sprintf("Number of futures since start: %d (%s)", counters[["created"]], info))

  ## Total runtime in seconds
  runtime <- backend[["runtime"]]    ## 'difftime' (or seconds)

  ## Turn into a 'difftime' object, if not already done
  if (!inherits(runtime, "difftime")) {
    origin <- as.POSIXct(0.0, origin = "1970-01-01") ## for R (< 4.3.0)
    if (!inherits(runtime, "POSIXct")) {
      runtime <- as.POSIXct(runtime, origin = origin)
    }
    runtime <- difftime(runtime, origin)  ## automatically choose 'units'
  }
  
  s <- c(s, sprintf("Total runtime of futures: %s (%s/finished future)", format(runtime), format(runtime/counters[["finished"]])))

  cat(s, sep = "\n")
  invisible(x)
}


#' `launchFuture()` runs a future on the backend.
#'
#' @param backend a [FutureBackend].
#'
#' @param future a [Future] to be started.
#'
#' @param \ldots (optional) not used.
#'
#' @return
#' `launchFuture()` returns the launched `Future` object.
#'
#' @rdname FutureBackend-class
#' @export
launchFuture <- function(backend, future, ...) {
  UseMethod("launchFuture")
}

#' @export
launchFuture.FutureBackend <- function(backend, future, ...) {
  stop(sprintf("No launchFuture() method implemented for %s", sQuote(class(backend)[1])))
}


#'
#' @rdname FutureBackend-class
#' @export
listFutures <- function(backend, ...) {
  UseMethod("listFutures")
}

#' @export
listFutures.FutureBackend <- function(backend, ...) {
  stop(sprintf("No listFutures() method implemented for %s", sQuote(class(backend)[1])))
}


#' `interruptFuture()` interrupts a future on the backend.
#'
#' @param backend a [FutureBackend].
#'
#' @param future a [Future] to be started.
#'
#' @param \ldots (optional) not used.
#'
#' @return
#' `interruptFuture()` returns the interrupted `Future` object,
#' if supported, other the unmodified future.
#'
#' @rdname FutureBackend-class
#' @export
interruptFuture <- function(backend, future, ...) {
  UseMethod("interruptFuture")
}

#' @export
interruptFuture.FutureBackend <- function(backend, future, ...) {
  ## Default is to ignore interrupt requests
  future
}


makeFutureBackend <- function(evaluator, ..., debug = FALSE) {
  if (debug) {
    mdebugf_push("makeFutureBackend(<%s>) ...", class(evaluator)[1])
    on.exit(mdebugf_pop())
  }
  
  ## Already created?
  backend <- attr(evaluator, "backend")
  if (!is.null(backend)) {
    if (debug) mdebugf("Already created: <%s>", commaq(class(backend)))
    return(backend)
  }
  
  mdebugf("Backend function: <%s>", commaq(class(backend)))
  
  factory <- attr(evaluator, "factory")
  if (is.null(factory)) {
    ## Old future strategies do not implement a FutureBackend
    if (debug) mdebugf("A legacy non-FutureBackend backend: <%s>", commaq(class(evaluator)))
    return(NULL)
  }

  stop_if_not(is.function(factory))

  ## Apply future plan tweaks
  args <- attr(evaluator, "tweaks")
  if (is.null(args)) args <- list()

  if (debug) {
    mdebugf("Evaluator tweak arguments: [n=%d]", length(args))
    mstr(args)
  }

  args2 <- formals(evaluator)
  args2[["..."]] <- NULL
  args2$lazy <- NULL         ## bc multisession; should be removed
  names2 <- names(args2)
  if ("envir" %in% names2) {
    args2[["envir"]] <- NULL
    names2 <- names(args2)
  }
  if (debug) {
    mdebugf("Evaluator formal arguments: [n=%d]", length(args2))
    mstr(args)
  }
  for (name in names2) {
    args[[name]] <- args2[[name]]
  }

  if (debug) {
    mdebugf("Backend factory arguments: [n=%d]", length(args2))
    mstr(args2)
  }
  backend <- do.call(factory, args = args, envir = environment(factory))
  if (debug) mdebugf("Backend: <%s>", commaq(class(backend)))
  stop_if_not(inherits(backend, "FutureBackend"))
  
  ## Record factory function as an attribute; needed by tweak()
  attr(backend, "factory") <- factory

  backend
}



#' @rdname FutureBackend-class
#' @export
validateFutureGlobals <- function(backend, future, ...) {
  UseMethod("validateFutureGlobals")
}

#' @export
validateFutureGlobals.FutureBackend <- function(backend, future, ..., debug = FALSE) {
  if (debug) {
    mdebugf_push("validateFutureGlobals(<%s>) ...", class(backend)[1])
    on.exit(mdebugf_pop())
  }

  ## Maximum allowed total size of globals
  maxSizeOfObjects <- backend[["maxSizeOfObjects"]]
  if (debug) mdebugf("Total size of globals allowed: %.2g bytes", maxSizeOfObjects)
  if (is.infinite(maxSizeOfObjects)) {
    if (debug) mdebug("There is no upper size limit. Skipping")
    return(future)
  }

  globals <- future[["globals"]]
  ## Nothing to do?
  if (length(globals) == 0) {
    if (debug) mdebug("There are no globals. Skipping")
    return(future)
  }
  
  if (debug) {
    mdebug_push("Checking size limitations of globals ...")
    on.exit(mdebug_pop(), add = TRUE)
  }
      
  ## Calculate the total size of globals, unless already done
  total_size <- attr(globals, "total_size")
  if (is.na(total_size)) {
    sizes <- lapply(globals, FUN = objectSize)
    sizes <- unlist(sizes, use.names = TRUE)
    total_size <- sum(sizes, na.rm = TRUE)
    attr(globals, "total_size") <- total_size
    future[["globals"]] <- globals
  }
  if (debug) mdebugf("Total size of globals: %s", asIEC(total_size))

  ## Assert that the total size is within limits
  if (is.na(total_size) || total_size <= maxSizeOfObjects) {
    return(future)
  }
  
  sizes <- lapply(globals, FUN = objectSize)
  sizes <- unlist(sizes, use.names = TRUE)
  msg <- summarize_size_of_globals(globals,
                                   sizes = sizes,
                                   maxSize = maxSizeOfObjects,
                                   exprOrg = future[["expr"]],
                                   debug = debug)
  msg <- sprintf("Will not launch future due to the size of the globals %s exceeds %s. %s", asIEC(total_size), asIEC(maxSizeOfObjects), msg)
  if (debug) mdebug(msg)
  stop(FutureError(msg, future = future))

  future
} ## validateFutureGlobals()



#' @export
getFutureBackendConfigs.Future <- function(future, ...) {
  list()
}



#' `stopWorkers()` stops backend workers
#'
#' @param backend a [FutureBackend].
#'
#' @param \ldots (optional) not used.
#'
#' @return
#' `stopWorkers()` returns TRUE if the workers were shut down,
#' otherwise FALSE.
#'
#' @rdname FutureBackend-class
#' @export
stopWorkers <- function(backend, ...) {
  UseMethod("stopWorkers")
}

#' @export
stopWorkers.FutureBackend <- function(backend, interrupt = TRUE, ...) {
  ## Interrupt all futures
  if (interrupt) {
    futures <- listFutures(backend)
    void <- lapply(futures, FUN = cancel, interrupt = interrupt, ...)
  }
  warning(FutureWarning(sprintf("%s does not implement stopWorkers()", sQuote(class(backend)[1]))))
}
