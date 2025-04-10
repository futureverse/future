#' Get all futures in a container
#'
#' Gets all futures in an environment, a list, or a list environment
#' and returns an object of the same class (and dimensions).
#' Non-future elements are returned as is.
#'
#' @param x An environment, a list, or a list environment.
#' @param \ldots Not used.
#'
#' @return An object of same type as `x` and with the same names
#' and/or dimensions, if set.
#'
#' @details
#' This function is useful for retrieve futures that were created via
#' future assignments (`%<-%`) and therefore stored as promises.
#' This function turns such promises into standard `Future`
#' objects.
#'
#' @export
futures <- function(x, ...) UseMethod("futures")

#' @export
futures.list <- function(x, ...) {
  x
}

#' @export
futures.environment <- function(x, ...) {
  fs <- futureOf(envir = x, mustExist = FALSE, drop = FALSE)

  ## Create object of same class as 'x'
  res <- new.env()
  for (key in names(fs)) {
    f <- fs[[key]]
    if (inherits(f, "Future")) {
      res[[key]] <- f
    } else {
      res[[key]] <- x[[key]]
    }
  }

  res
}

#' @export
#' @importFrom listenv listenv
futures.listenv <- function(x, ...) {
  fs <- futureOf(envir = x, mustExist = FALSE, drop = FALSE)

  ## Create object of same class as 'x'
  res <- listenv()
  length(res) <- length(fs)
  for (ii in seq_along(fs)) {
    f <- fs[[ii]]
    if (inherits(f, "Future")) {
      res[[ii]] <- f
    } else {
      value <- x[[ii]]
      if (is.null(value)) {
        res[ii] <- list(value)
      } else {
        res[[ii]] <- value
      }
    }
  }

  dim <- dim(x)
  if (!is.null(dim)) {
    dim(res) <- dim
    ## Preserve dimnames and names
    dimnames(res) <- dimnames(x)
  }
  names(res) <- names(x)

  res
}
