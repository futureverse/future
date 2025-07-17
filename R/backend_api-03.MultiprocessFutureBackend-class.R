#' @inheritParams FutureBackend-class
#'
#' @param wait.timeout Number of seconds before timing out.
#'
#' @param wait.interval Baseline number of seconds between retries.
#'
#' @param wait.alpha Scale factor increasing waiting interval after each
#' attempt.
#'
#' @keywords internal
#' @rdname FutureBackend-class
#'
#' @export
MultiprocessFutureBackend <- function(..., wait.timeout = getOption("future.wait.timeout", 24 * 60 * 60), wait.interval = getOption("future.wait.interval", 0.01), wait.alpha = getOption("future.wait.alpha", 1.01)) {
  core <- FutureBackend(
    ...,
    wait.timeout = wait.timeout,
    wait.interval = wait.interval,
    wait.alpha = wait.alpha
  )
  core[["futureClasses"]] <- c("MultiprocessFuture", core[["futureClasses"]])
  core <- structure(core, class = c("MultiprocessFutureBackend", class(core)))
  core
}
tweakable(MultiprocessFutureBackend) <- FutureBackend


#' @export
launchFuture.MultiprocessFutureBackend <- function(backend, future, ...) {
  stopf("launchFuture() is not implemented for this type of future backend (please contacts the maintainer of that backend): %s", commaq(class(backend)))
}


#' @export
listFutures.MultiprocessFutureBackend <- function(backend, ..., debug = FALSE) {
  if (debug) {
    mdebugf_push("listFutures() for %s ...", class(backend)[1])
    on.exit(mdebugf_pop())
  }

  reg <- backend[["reg"]]
  if (is.null(reg)) {
    stop(FutureError(sprintf("%s does not implement listFutures(), and it does not have a 'reg' element, so cannot fallback to the built-in implementation", class(backend)[1])))
  }
  
  futures <- FutureRegistry(reg, "list", earlySignal = FALSE)
  if (debug) mdebug("Number of futures: ", length(futures))

  if (length(futures) == 0) {
    data <- data.frame(
      counter = integer(0L),
      start = proc.time()[[3]][integer(0L)],
      label = character(0L),
      resolved = logical(0L)
    )
  } else {
    data <- lapply(futures, FUN = function(future) {
      label <- future[["label"]]
      if (is.null(label)) label <- NA_character_
      counter <- as.integer(future[["uuid"]][2])
      start <- future[["start"]]
      if (is.null(start)) start <- NA_real_ ## happens if future is reset
      resolved <- resolved(future, run = FALSE)
      data.frame(
        counter = counter,
        start = start,
        label = label,
        resolved = resolved
      )
    })
    data <- do.call(rbind, data)
  }
  data[["future"]] <- lapply(futures, FUN = list)
  data
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



D#' A multiprocess future is a future whose value will be resolved asynchronously in a parallel process
#'
#' @inheritParams Future-class
#' 
#' @param \ldots Additional named elements passed to [Future()].
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
