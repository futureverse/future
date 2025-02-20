#' A backend that controls how futures are launched on parallel workers
#'
#' @param \ldots (optional) arguments.
#'
#' @return
#' `FutureBackend()` returns a `FutureBackend` that inherits an
#' environment.
#'
#' @keywords internal
#' @export
FutureBackend <- function(...) {
  core <- new.env(parent = emptyenv())

  ## Record future plan tweaks, if any
  args <- list(...)
  for (name in names(args)) {
    core[[name]] <- args[[name]]
  }
  
  core[["futureClasses"]] <- c("Future")
  core <- structure(core, class = c("FutureBackend", class(core)))
  core
}



#' `launchFuture()` launches a future on the backend.
#'
#' @param backend a [FutureBackend].
#'
#' @param future a [Future] to be launched on the backend.
#'
#' @param \ldots (optional) not used.
#'
#' @return
#' `launchFuture()` returns a the launched `Future` object.
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
