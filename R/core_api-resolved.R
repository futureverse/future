#' Check whether a future is resolved or not
#'
#' @param x A \link{Future}, a list, or an environment (which also
#' includes \link[listenv:listenv]{list environment}).
#'
#' @param \ldots Not used.
#'
#' @return A logical of the same length and dimensions as `x`.
#' Each element is TRUE unless the corresponding element is a
#' non-resolved future in case it is FALSE.
#'
#' @details
#' This method needs to be implemented by the class that implement
#' the Future API.  The implementation should return either TRUE or FALSE
#' and must never throw an error (except for [FutureError]:s which indicate
#' significant, often unrecoverable infrastructure problems).
#' It should also be possible to use the method for polling the
#' future until it is resolved (without having to wait infinitely long),
#' e.g. `while (!resolved(future)) Sys.sleep(5)`.
#'
#' @export
resolved <- function(x, ...) {
  ## Automatically update journal entries for Future object
  if (inherits(future, "Future") &&
      inherits(future[[".journal"]], "FutureJournal")) {
    start <- Sys.time()
    on.exit({
      appendToFutureJournal(x,
        event = "resolved",
        category = "querying",
        start = start,
        stop = Sys.time(),
        skip = FALSE
      )
    })
  }
  UseMethod("resolved")
}

#' @export
resolved.default <- function(x, ...) TRUE

#' @export
resolved.list <- function(x, ...) {
  fs <- futures(x)
  n_fs <- length(fs)
  
  ## Allocate results. Assume everything
  ## is resolved unless not.
  res <- rep(TRUE, times = n_fs)
  for (ii in seq_along(fs)) {
    f <- fs[[ii]]
    if (inherits(f, "Future")) res[[ii]] <- resolved(f, ...)
  }

  stop_if_not(length(res) == n_fs)

  dim <- dim(fs)
  if (!is.null(dim)) {
    dim(res) <- dim
    ## Preserve dimnames and names
    dimnames(res) <- dimnames(fs)
  }
  names(res) <- names(fs)

  stop_if_not(length(res) == n_fs)

  res
}

#' @export
resolved.environment <- function(x, ...) {
  fs <- futures(x)
  n_fs <- length(fs)
  names <- names(fs)
  fs <- as.list(fs)
  names(fs) <- names
  stop_if_not(length(fs) == n_fs)
  fs <- resolved(fs, ...)
  stop_if_not(length(fs) == n_fs)
  fs
}
