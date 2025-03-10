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
