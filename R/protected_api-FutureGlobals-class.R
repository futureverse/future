#' A representation of a set of globals used with futures
#'
#' @param object A named list.
#'
#' @param resolved A logical indicating whether these globals
#'        have been scanned for and resolved futures or not.
#' 
#' @param total_size The total size of all globals, if known.
#' 
#' @param \ldots Not used.
#'
#' @return An object of class `FutureGlobals`.
#'
#' @details
#' This class extends the \link[globals]{Globals} class by adding
#' attributes `resolved` and `total_size`.
#'
#' @aliases as.FutureGlobals as.FutureGlobals.FutureGlobals
#' as.FutureGlobals.Globals as.FutureGlobals.list [.FutureGlobals
#' c.FutureGlobals unique.FutureGlobals
#'
#' @importFrom globals Globals
#' @export
#' @keywords internal
FutureGlobals <- function(object = list(), resolved = FALSE, total_size = NA_real_, ...) {
  if (!is.list(object)) {
    stopf("Argument 'object' is not a list: %s", class(object)[1])
  }

  if (!inherits(object, "Globals")) {
    object <- Globals(object, ...)
    attr(object, "resolved") <- resolved
    attr(object, "total_size") <- total_size
  } else if (!inherits(object, "FutureGlobals")) {
    attr(object, "resolved") <- resolved
    attr(object, "total_size") <- total_size
  }
  
  structure(object, class = c("FutureGlobals", class(object)))
}

#' @export
resolved.FutureGlobals <- function(x, ...) attr(x, "resolved", exact = TRUE)

#' @export
as.FutureGlobals <- function(x, ...) UseMethod("as.FutureGlobals")

#' @export
as.FutureGlobals.FutureGlobals <- function(x, ...) x

#' @export
as.FutureGlobals.Globals <- function(x, ...) {
  class(x) <- c("FutureGlobals", class(x))
  attr(x, "resolved") <- FALSE
  attr(x, "total_size") <- NA_real_
  x
}

#' @export
as.FutureGlobals.list <- function(x, ...) {
  as.FutureGlobals(as.Globals(x, ...))
}

#' @export
`[.FutureGlobals` <- function(x, i) {
  resolved <- attr(x, "resolved", exact = TRUE)
  size <- attr(x, "total_size", exact = TRUE)
  x <- NextMethod()
  attr(x, "resolved") <- resolved
  attr(x, "total_size") <- size
  x
}

#' @export
c.FutureGlobals <- function(x, ...) {
  args <- list(...)
  if (length(args) == 0) return(x)

  ## Are all imputs resolved?
  resolved <- attr(x, "resolved", exact = TRUE)
  resolved_args <- lapply(args, FUN = function(x) isTRUE(attr(x, "resolved", exact = TRUE)))
  resolved_args <- unlist(resolved_args, use.names = FALSE)
  resolved <- resolved && all(resolved_args)

  ## Total size?
  size <- attr(x, "total_size", exact = TRUE)
  if (!is.na(size)) {
    size_args <- lapply(args, FUN = function(z) {
      size <- attr(z, "total_size", exact = TRUE)
      if (is.null(size)) NA_real_ else size
    })
    size_args <- unlist(size_args, use.names = FALSE)
    size <- size + sum(size_args, na.rm = FALSE)
  }
  
  x <- NextMethod()

  attr(x, "resolved") <- resolved
  attr(x, "total_size") <- size
  
  x
}

#' @export
unique.FutureGlobals <- function(x, ...) {
  nx <- length(x)
  if (nx == 0) return(x)
  
  resolved <- attr(x, "resolved", exact = TRUE)
  size <- attr(x, "total_size", exact = TRUE)
  x <- NextMethod()
  attr(x, "resolved") <- resolved

  ## Were any elements dropped?
  if (length(x) != nx) size <- NA_real_
  attr(x, "total_size") <- size
  
  x
}


#' @export
resolve.FutureGlobals <- function(x, ...) {
  ## Nothing to do?
  if (length(x) == 0) return(x)
  
  ## Already resolved?
  if (isTRUE(attr(x, "resolved", exact = TRUE))) return(x)

  x <- NextMethod()

  ## At this point we consider these future globals resolved (regardless of 'recursive')
  attr(x, "resolved") <- TRUE

  ## Since we don't know whether the above turned any futures into their
  ## values, we cannot make any assumption about the total size.
  attr(x, "total_size") <- NA_real_

  x
}
