#' Configure a backend that controls how and where futures are evaluated
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
#' @return
#' `FutureBackend()` returns a FutureBackend object, which inherits an
#' environment. Specific future backends are defined by subclasses
#' implementing the FutureBackend API.
#'
#' @section The FutureBackend API:
#' The `FutureBackend` class specifies FutureBackend API,
#' that all backends must implement and comply to. Specifically,
#'
#' @keywords internal
#' @export
FutureBackend <- function(..., earlySignal = FALSE, gc = FALSE, maxSizeOfObjects = getOption("future.globals.maxSize", 500 * 1024 ^ 2), hooks = FALSE) {
  core <- new.env(parent = emptyenv())

  if (!is.logical(gc)) {
    str(gc)
  }
  
  stop_if_not(length(earlySignal) == 1L, is.logical(earlySignal), !is.na(earlySignal))
  stop_if_not(length(gc) == 1L, is.logical(gc), !is.na(gc))
  stop_if_not(length(maxSizeOfObjects) == 1L, is.numeric(maxSizeOfObjects),
              !is.na(maxSizeOfObjects), maxSizeOfObjects >= 0)
  stop_if_not(length(hooks) == 1L, is.logical(hooks), !is.na(hooks))
  
  ## Record future plan tweaks, if any
  args <- list(..., earlySignal = earlySignal, maxSizeOfObjects = maxSizeOfObjects, gc = gc, hooks = hooks)
  for (name in names(args)) {
    core[[name]] <- args[[name]]
  }
  
  core[["futureClasses"]] <- c("Future")
  core <- structure(core, class = c("FutureBackend", class(core)))
  core
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
#' @rdname FutureBackend
#' @export
launchFuture <- function(backend, future, ...) {
  UseMethod("launchFuture")
}

#' @export
launchFuture.FutureBackend <- function(backend, future, ...) {
  stop(sprintf("No launchFuture() method implemented for %s", sQuote(class(backend)[1])))
}


makeFutureBackend <- function(evaluator, ...) {
  backend <- attr(evaluator, "backend")

  ## Old future strategies do not implement a FutureBackend
  if (is.null(backend)) return(NULL)
  
  stop_if_not(is.function(backend))

  ## Apply future plan tweaks
  args <- attr(evaluator, "tweaks")
  if (is.null(args)) args <- list()
  args2 <- formals(evaluator)
  args2[["..."]] <- NULL
  args2[["envir"]] <- NULL
  args2$lazy <- NULL         ## bc multisession; should be removed
  for (name in names(args2)) {
    args[[name]] <- args2[[name]]
  }

  backend <- do.call(backend, args = args)
  stop_if_not(inherits(backend, "FutureBackend"))

  backend
}


#' @export
getFutureBackendConfigs.Future <- function(future, ...) {
  list()
}
