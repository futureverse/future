#' @export
launchFuture.MultiprocessFutureBackend <- function(backend, future, ...) {
  stopf("launchFuture() is not implemented for this type of future backend (please contacts the maintainer of that backend): %s", commaq(class(backend)))
}


#' @export
nbrOfWorkers.MultiprocessFutureBackend <- function(evaluator) {
  assert_no_positional_args_but_first()
  backend <- evaluator
  stopf("nbrOfWorkers() is not implemented for this type of future backend (please contacts the maintainer of that backend): %s", commaq(class(backend)))
}


#' @export
nbrOfFreeWorkers.MultiprocessFutureBackend <- function(evaluator, background = FALSE, ...) {
  assert_no_positional_args_but_first()
  backend <- evaluator
  stopf("nbrOfFreeWorkers() is not implemented for this type of future backend (please contacts the maintainer of that backend): %s", commaq(class(backend)))
}



#' A multiprocess future is a future whose value will be resolved asynchronously in a parallel process
#'
#' @inheritParams Future-class
#' 
#' @param \dots Additional named elements passed to [Future()].
#'
#' @return
#' `MultiprocessFuture()` returns an object of class `MultiprocessFuture`.
#'
#' @export
#' @name MultiprocessFuture-class
#' @keywords internal
MultiprocessFuture <- function(expr = NULL, substitute = TRUE, envir = parent.frame(), ...) {
  if (substitute) expr <- substitute(expr)

  future <- Future(expr = expr, envir = envir, substitute = FALSE, ...)
  future <- structure(future, class = c("MultiprocessFuture", class(future)))
  future
}
