#' A MultisessionFutureBackend resolves futures in parallel using a PSOCK cluster on the current machine
#'
#' @inheritParams ClusterFutureBackend
#'
#' @details
#' The `MultisessionFutureBackend` backend is selected by
#' `plan(multisession, workers = workers)`.
#'
#' @keywords internal
#' @rdname FutureBackend
#' @export
MultisessionFutureBackend <- function(workers = availableCores(), ...) {
  default_workers <- missing(workers)
  if (is.function(workers)) workers <- workers()
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

  core <- ClusterFutureBackend(workers = workers, ...)
  core$futureClasses <- c("MultisessionFuture", core$futureClasses)
  core <- structure(core, class = c("MultisessionFutureBackend", class(core)))
  core
}
