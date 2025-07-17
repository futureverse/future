#' A MultisessionFutureBackend resolves futures in parallel using a PSOCK cluster on the current machine
#'
#' @inheritParams ClusterFutureBackend
#'
#' @details
#' The `MultisessionFutureBackend` backend is selected by
#' `plan(multisession, workers = workers)`.
#'
#' @seealso
#' For alternative future backends, see the 'A Future for R: Available Future
#' Backends' vignette and \url{https://www.futureverse.org/backends.html}.
#'
#' @keywords internal
#' @rdname FutureBackend-class
#' @export
MultisessionFutureBackend <- function(workers = availableCores(constraints = "connections-16"), rscript_libs = .libPaths(), interrupts = TRUE, gc = FALSE, earlySignal = FALSE, ...) {
  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebugf_push("MultisessionFutureBackend(workers = <workers>, interrupts = %s, ...) ...", interrupts)
    mdebug("Arguments:")
    mstr(list(workers = workers, rscript_libs = rscript_libs, interrupts = interrupts, gc = gc, earlySignal = earlySignal, ...))
    on.exit(mdebugf_pop())
  }
  
  default_workers <- missing(workers)
  if (is.function(workers)) workers <- workers()
  stop_if_not(is.numeric(workers))
  workers <- structure(as.integer(workers), class = class(workers))
  stop_if_not(length(workers) == 1, is.finite(workers), workers >= 1)
  
  ## Fall back to sequential futures if only a single additional R process
  ## can be spawned off, i.e. then use the current main R process.
  ## Sequential futures best reflect how multicore futures handle globals.
  if (workers == 1L && !inherits(workers, "AsIs")) {
    ## AD HOC: Make sure plan(multicore) also produces a warning, if needed
    if (default_workers) supportsMulticore(warn = TRUE)
    ## covr: skip=1
    return(SequentialFutureBackend(...))
  }

  core <- ClusterFutureBackend(
    workers = workers,
    rscript_libs = rscript_libs,
    interrupts = interrupts,
    gc = gc,
    earlySignal = earlySignal,
    ...
  )
  core[["futureClasses"]] <- c("MultisessionFuture", core[["futureClasses"]])
  core <- structure(core, class = c("MultisessionFutureBackend", class(core)))
  core
}
tweakable(MultisessionFutureBackend) <- ClusterFutureBackend


#' @export
print.MultisessionFutureBackend <- function(x, validate = TRUE, ...) {
  backend <- NextMethod(validate = validate)
}


#' Create a multisession future whose value will be resolved asynchronously in a parallel \R session
#'
#' _WARNING: This function must never be called.
#'  It may only be used with [future::plan()]_
#'
#' A multisession future is a future that uses multisession evaluation,
#' which means that its _value is computed and resolved in
#' parallel in another \R session_.
#'
#' @details
#' This function is must _not_ be called directly.  Instead, the
#' typical usages are:
#'
#' ```r
#' # Evaluate futures in parallel on the local machine via as many background
#' # processes as available to the current R process
#' plan(multisession)
#'
#' # Evaluate futures in parallel on the local machine via two background
#' # processes
#' plan(multisession, workers = 2)
#' ```
#'
#' @inheritParams multicore
#' @inheritParams cluster
#' 
#' @param \ldots Additional arguments passed to [Future()].
#'
#' @param rscript_libs A character vector of \R package library folders that
#' the workers should use.  The default is `.libPaths()` so that multisession
#' workers inherits the same library path as the main \R session.
#' To avoid this, use `plan(multisession, ..., rscript_libs = NULL)`.
#' _Important: Note that the library path is set on the workers when they are
#' created, i.e. when `plan(multisession)` is called.  Any changes to
#' `.libPaths()` in the main R session after the workers have been created
#' will have no effect._
#' This is passed down as-is to [parallelly::makeClusterPSOCK()].
#'
#' @return
#' A MultisessionFuture.
#' If `workers == 1`, then all processing is done in the
#' current/main \R session and we therefore fall back to using a
#' lazy future.  To override this fallback, use `workers = I(1)`.
#'
## FIXME: It seem that multisession futures in examples gives errors
##        with R CMD check, e.g. "cannot open file 'future-Ex.Rout':
##        Permission denied".  Because of this we use \donttest{}.
#'@example incl/multisession.R
#'
#' @details
#' The background \R sessions (the "workers") are created using
#' [makeClusterPSOCK()].
#' 
#' For the total number of
#' \R sessions available including the current/main \R process, see
#' [parallelly::availableCores()].
#'
#' A multisession future is a special type of cluster future.
#'
#' @seealso
#' For processing in multiple forked \R sessions, see
#' [multicore] futures.
#'
#' Use [parallelly::availableCores()] to see the total number of
#' cores that are available for the current \R session.
#'
#' @aliases MultisessionFuture
#' @export
multisession <- function(..., workers = availableCores(constraints = "connections-16"), rscript_libs = .libPaths()) {
  stop("INTERNAL ERROR: The future::multisession() must never be called directly")
}
class(multisession) <- c("multisession", "cluster", "multiprocess", "future", "function")
attr(multisession, "init") <- TRUE
attr(multisession, "factory") <- MultisessionFutureBackend
attr(multisession, "tweakable") <- tweakable(attr(multisession, "factory"))
attr(multisession, "untweakable") <- c("persistent")
