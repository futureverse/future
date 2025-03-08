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
