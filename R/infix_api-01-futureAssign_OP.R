#' @usage x \%<-\% value
#'
#' @aliases %<-% %->%
#' @rdname futureAssign
#'
#' @export %<-% %->%
`%<-%` <- function(x, value) {
  target <- substitute(x)
  expr <- substitute(value)
  envir <- parent.frame(1)
  futureAssignInternal(target, expr, envir = envir, substitute = FALSE)
}

`%->%` <- function(value, x) {
  target <- substitute(x)
  expr <- substitute(value)
  envir <- parent.frame(1)
  futureAssignInternal(target, expr, envir = envir, substitute = FALSE)
}


#' @importFrom listenv get_variable parse_env_subset
futureAssignInternal <- function(target, expr, envir = parent.frame(), substitute = FALSE) {
  target <- parse_env_subset(target, envir = envir, substitute = substitute)
  assign.env <- target[["envir"]]

  name <- target[["name"]]
  if (inherits(target[["envir"]], "listenv")) {
    n <- length(target[["exists"]])
    if (n == 0L) {
      stop("Cannot future assign to an empty set")
    } else if (n > 1L) {
      stop("Cannot future assign to more than one element")
    }
    if (target[["exists"]]) {
      name <- get_variable(target[["envir"]], target[["idx"]], mustExist = TRUE, create = FALSE)
    } else {
      if (!is.na(name) && nzchar(name)) {
        name <- get_variable(target[["envir"]], name, mustExist = FALSE, create = TRUE)
      } else if (all(is.finite(target[["idx"]]))) {
        name <- get_variable(target[["envir"]], target[["idx"]], mustExist = FALSE, create = TRUE)
      } else if (all(is.na(target[["idx"]]))) {
        stop("subscript out of bounds")
      } else {
        stop("INTERNAL ERROR: Zero length variable name and unknown index")
      }
    }
  }

  futureAssign(name, expr, envir = envir, assign.env = assign.env, substitute = FALSE)
} # futureAssignInternal()
