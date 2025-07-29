#' A SequentialFutureBackend resolves futures sequentially in the current R session
#'
#' @inheritParams FutureBackend-class
#'
#' @details
#' The `SequentialFutureBackend` is selected by `plan(sequential)`.
#'
#' @seealso
#' For alternative future backends, see the 'A Future for R: Available Future
#' Backends' vignette and \url{https://www.futureverse.org/backends.html}.
#'
#' @keywords internal
#' @rdname FutureBackend-class
#' @export
SequentialFutureBackend <- function(..., maxSizeOfObjects = +Inf) {
  core <- FutureBackend(..., maxSizeOfObjects = maxSizeOfObjects, reg = "sequential")
  core[["futureClasses"]] <- c("SequentialFuture", "UniprocessFuture", core[["futureClasses"]])
  core <- structure(core, class = c("SequentialFutureBackend", class(core)))
  core
}
tweakable(SequentialFutureBackend) <- FutureBackend


#' @export
launchFuture.SequentialFutureBackend <- function(backend, future, ...) {
  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebugf_push("launchFuture() for %s ...", commaq(class(backend)))
    on.exit(mdebugf_pop())
  }

  hooks <- backend[["hooks"]]
  if (hooks) {
     hook <- getHook("future::launchFuture::begin")
     hook(backend, future = future, ...)
  }
  
  ## Get future
  data <- getFutureData(future, debug = debug)

  ## Apply backend tweaks
  split <- backend[["split"]]
  if (!is.null(split)) data[["capture"]][["split"]] <- split

  future[["backend"]] <- backend

  ## Inherit 'earlySignal' from backend?
  earlySignal <- backend[["earlySignal"]]
  if (!is.null(earlySignal)) future[["earlySignal"]] <- earlySignal

  ## Launch future
  future[["state"]] <- "running"
  future[["result"]] <- evalFuture(data)
  future[["state"]] <- "finished"

  ## Register run (used to collect statistics)
  reg <- backend[["reg"]]
  FutureRegistry(reg, action = "add", future = future, earlySignal = FALSE)
  FutureRegistry(reg, action = "remove", future = future, earlySignal = FALSE)
  if (debug) mdebugf("%s started (and completed)", class(future)[1])

  ## Assert result is for the expected future
  assertFutureResult(future)

  ## Always signal immediateCondition:s and as soon as possible.
  ## They will always be signaled if they exist.
  signalImmediateConditions(future)

  ## Signal conditions early, iff specified for the given future
  signalEarly(future, collect = FALSE)

  hooks <- backend[["hooks"]]
  if (hooks) {
     hook <- getHook("future::launchFuture::end")
     hook(backend, future = future, ...)
  }

  future
}



#' @export
listFutures.SequentialFutureBackend <- function(backend, ...) {
  data.frame(
    counter = integer(0L),
    start = proc.time()[[3]][integer(0L)],
    label = character(0L),
    resolved = logical(0L),
    future = list()[integer(0L)]
  )
}



#' @export
stopWorkers.SequentialFutureBackend <- function(backend, ...) {
  TRUE
}


#' @export
nbrOfWorkers.SequentialFutureBackend <- function(evaluator) {
  1L
}


#' @export


nbrOfFreeWorkers.SequentialFutureBackend <- function(evaluator, background = FALSE, ...) {
  assert_no_positional_args_but_first()
  if (isTRUE(background)) 0L else 1L
}


#' @export
getFutureBackendConfigs.UniprocessFuture <- function(future, ...) {
  conditionClasses <- future[["conditions"]]
  if (is.null(conditionClasses)) return(list())
  
  capture <- list(
    immediateConditionHandlers = list(
      immediateCondition = local({
        prev <- NULL
        function(condition) {  
          ## Avoid re-catching and re-signaling itself
          if (identical(condition, prev)) {
            prev <<- NULL
            muffleCondition(condition)
            return(FALSE)
          }
          prev <<- condition
          ## Resignal condition
          if (inherits(condition, "warning")) {
            warning(condition)
          } else if (inherits(condition, "message")) {
            message(condition)
          } else {
            signalCondition(condition)
          }
          TRUE
        }
      })
    )
  )

  list(
    capture = capture
  )
}



#' Create a sequential future whose value will be in the current \R session
#'
#' _WARNING: This function must never be called.
#'  It may only be used with [future::plan()]_
#'
#' A sequential future is a future that is evaluated sequentially in the
#' current \R session similarly to how \R expressions are evaluated in \R.
#' The only difference to \R itself is that globals are validated
#' by default just as for all other types of futures in this package.
#'
#' @details
#' This function is must _not_ be called directly.  Instead, the
#' typical usages are:
#'
#' ```r
#' # Evaluate futures sequentially in the current R process
#' plan(sequential)
#' ```
#'
#' @inheritParams future
#' @inheritParams Future-class
#' @inheritParams FutureBackend-class
#' 
#' @param \ldots Not used.
#'
#' @example incl/sequential.R
#'
#' @aliases uniprocess
#' @export
sequential <- function(..., envir = parent.frame()) {
  ## WORKAROUNDS:
  ## (1) fiery calls sequential() directly
  ##     https://github.com/thomasp85/fiery/issues/53
  if (!"fiery" %in% loadedNamespaces()) {
    stop("The future::sequential() function must never be called directly")
  }
  
  f <- Future(..., envir = envir)
  class(f) <- c("SequentialFuture", "UniprocessFuture", "Future")
  f  
}
class(sequential) <- c("sequential", "uniprocess", "future", "function")
attr(sequential, "init") <- TRUE
attr(sequential, "factory") <- SequentialFutureBackend
attr(sequential, "tweakable") <- tweakable(attr(sequential, "factory"))
