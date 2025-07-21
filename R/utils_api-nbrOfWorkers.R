#' Get the number of workers available
#'
#' @param evaluator A future evaluator function.
#' If NULL (default), the current evaluator as returned
#' by [plan()] is used.
#'
#' @return
#' `nbrOfWorkers()` returns a positive number in \eqn{{1, 2, 3, ...}}, which
#' for some future backends may also be `+Inf`.
#'
#' @example incl/nbrOfWorkers.R
#'
#' @export
nbrOfWorkers <- function(evaluator = NULL) {
  UseMethod("nbrOfWorkers")
}


#' @export
nbrOfWorkers.multiprocess <- function(evaluator) {
  assert_no_positional_args_but_first()
  
  backend <- makeFutureBackend(evaluator)
  if (inherits(backend, "FutureBackend")) {
    return(nbrOfWorkers(backend))
  }  

  ## Legacy, non-FutureBackend backends
  expr <- formals(evaluator)[["workers"]]
  workers <- eval(expr, enclos = baseenv())
  if (is.function(workers)) workers <- workers()
  if (is.numeric(workers)) {
  } else {
    stopf("Unsupported type of 'workers' for evaluator of class %s: %s", commaq(class(evaluator)), class(workers)[1])
  }
  stop_if_not(length(workers) == 1L, !is.na(workers), workers >= 1L, is.finite(workers))

  workers
}


#' @export
nbrOfWorkers.future <- function(evaluator) {
  assert_no_positional_args_but_first()

  backend <- makeFutureBackend(evaluator)
  if (inherits(backend, "FutureBackend")) {
    return(nbrOfWorkers(backend))
  }  
  
  expr <- formals(evaluator)[["workers"]]
  workers <- eval(expr, enclos = baseenv())
  if (is.function(workers)) workers <- workers()
  if (is.numeric(workers)) {
  } else if (is.null(workers)) {
    workers <- Inf
  } else {
    stopf("Unsupported type of 'workers' for evaluator of class %s: %s", commaq(class(evaluator)), class(workers)[1])
  }
  stop_if_not(length(workers) == 1L, !is.na(workers), workers >= 1L)

  workers
}

#' @importFrom utils tail
#' @export
nbrOfWorkers.NULL <- function(evaluator) {
  assert_no_positional_args_but_first()
  res <- NA_integer_
  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebug_push("nbrOfWorkers(NULL) ...")
    mstr(tail(sys.calls(), n = 4L))
    on.exit({
      mdebugf("Number of workers: %d", res)
      mdebug_pop()
    })
  }
  backend <- plan("backend")
  if (!inherits(backend, "FutureBackend")) backend <- plan("next")
  res <- nbrOfWorkers(backend)
  res
}



#' @param background If TRUE, only workers that can process a future in the
#' background are considered.  If FALSE, also workers running in the main \R
#' process are considered, e.g. when using the 'sequential' backend.
#'
#' @param \ldots Not used; reserved for future use.
#'
#' @return
#' `nbrOfFreeWorkers()` returns a non-negative number in
#' \eqn{{0, 1, 2, 3, ...}} which is less than or equal to `nbrOfWorkers()`.
#'
#' @rdname nbrOfWorkers
#' @export
nbrOfFreeWorkers <- function(evaluator = NULL, background = FALSE, ...) {
  UseMethod("nbrOfFreeWorkers")
}



#' @export
nbrOfFreeWorkers.multiprocess <- function(evaluator, background = FALSE, ...) {
  assert_no_positional_args_but_first()
  backend <- makeFutureBackend(evaluator)
  if (inherits(backend, "FutureBackend")) {
    return(nbrOfFreeWorkers(backend, background = background, ...))
  }  
  stopf("nbrOfFreeWorkers() is not implemented for this type of future backend (please contacts the maintainer of that backend): %s", commaq(class(evaluator)))
}


#' @export
nbrOfFreeWorkers.future <- function(evaluator, background = FALSE, ...) {
  assert_no_positional_args_but_first()

  backend <- makeFutureBackend(evaluator)
  if (inherits(backend, "FutureBackend")) {
    return(nbrOfFreeWorkers(backend, background = background, ...))
  }  

  workers <- nbrOfWorkers(evaluator)
  if (is.infinite(workers)) return(workers)

  stopf("nbrOfFreeWorkers() is not implemented for this type of future backend (please contacts the maintainer of that backend): %s", commaq(class(evaluator)))
}


#' @importFrom utils tail
#' @export
nbrOfFreeWorkers.NULL <- function(evaluator, background = FALSE, ...) {
  assert_no_positional_args_but_first()
  res <- NA_integer_
  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebug_push("nbrOfFreeWorkers(NULL) ...")
    mstr(tail(sys.calls(), n = 4L))
    on.exit({
      mdebugf("Number of free workers: %d", res)
      mdebug_pop()
    })
  }
  backend <- plan("backend")
  if (!inherits(backend, "FutureBackend")) backend <- plan("next")
  nbrOfFreeWorkers(backend, background = background, ...)
}


#' @export
nbrOfFreeWorkers.logical <- function(evaluator, background = FALSE, ...) {
  assert_no_positional_args_but_first()
  if (missing(background)) {
    stop("Arguments 'background' of nbrOfFreeWorkers() must be named, if used")
  }
  nbrOfFreeWorkers(NULL, background = force(background), ...)
}
