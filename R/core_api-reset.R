#' Reset a finished, failed, canceled, or interrupted future to a lazy future
#'
#' A future that has successfully completed, [canceled][cancel], interrupted,
#' or has failed due to an error, can be relaunched after resetting it.
#'
#' @param x A Future.
#'
#' @param \ldots Not used.
#'
#' @return
#' `reset()` returns a lazy, vanilla [Future] that can be relaunched.
#' Resetting a running future results in a [FutureError].
#'
#' @details
#' A lazy, vanilla [Future] can be reused in another R session. For
#' instance, if we do:
#'
#' ```
#' library(future)
#' a <- 2
#' f <- future(42 * a, lazy = TRUE)
#' saveRDS(f, "myfuture.rds")
#' ```
#'
#' Then we can read and evaluate the future in another R session using:
#'
#' ```
#' library(future)
#' f <- readRDS("myfuture.rds")
#' v <- value(f)
#' print(v)
#' #> [1] 84
#' ```
#'
#' @example incl/reset.R
#'
#' @export
reset <- function(x, ...) {
  UseMethod("reset")
}


#' @export
reset.default <- function(x, ...) {
  x
}

#' @export
reset.list <- function(x, ...) {
  lapply(x, FUN = reset, ...)
}


#' @export
reset.environment <- function(x, ...) {
  fs <- futures(x)
  names <- names(fs)
  fs <- as.list(fs)
  names(fs) <- names
  reset(fs, ...)
}


#' @export
reset.Future <- function(x, ...) {
  future <- x

  if (future[["state"]] == "running") {
    backend <- future[["backend"]]
    if (!inherits(backend, "FutureBackend")) {
      warning(FutureWarning("Cannot reset a running future", future = future))
      return(future)
    }
    stop(FutureError("Cannot reset a running future", future = future))
  }
  
  core_fields <- c(
    "version",
    "expr",
    "envir",
    "stdout",
    "conditions",
    "globals",
    "packages",
    "seed",
    "lazy",
    "asynchronous",
    "local",
    "reset",
    "label",
    "earlySignal",
    "gc",
    "onReference",
    "calls",
    "state"
  )
  
  class(future) <- "Future"

  drop <- setdiff(names(future), core_fields)
  for (name in drop) {
    future[[name]] <- NULL
  }

  future[["owner"]] <- session_uuid()
  counter <- .package[["futureCounter"]] <- .package[["futureCounter"]] + 1L
  future[["uuid"]] <- future_uuid(owner = future[["owner"]], counter = counter)

  future[["state"]] <- "created"
  future[["lazy"]] <- TRUE
  
  future
} ## reset() for Future
