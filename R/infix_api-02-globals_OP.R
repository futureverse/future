#' Specify globals and packages for a future assignment
#'
#' @usage
#' fassignment \%globals\% globals
#' fassignment \%packages\% packages
#'
#' @inheritParams future
#'
#' @param fassignment The future assignment, e.g.
#'        `x %<-% { expr }`.
#'
#' @param packages (optional) a character vector specifying packages
#' to be attached in the \R environment evaluating the future.
#' 
#' @aliases %packages%
#' @rdname futureAssign
#'
#' @export
`%globals%` <- function(fassignment, globals) {
  fassignment <- substitute(fassignment)
  envir <- parent.frame(1)

  ## Temporarily set 'globals' argument
  args <- getOption("future.disposable", list())
  args["globals"] <- list(globals)
  options(future.disposable = args)
  on.exit(options(future.disposable = NULL))

  eval(fassignment, envir = envir, enclos = baseenv())
}

#' @export
`%packages%` <- function(fassignment, packages) {
  fassignment <- substitute(fassignment)
  envir <- parent.frame(1)

  ## Temporarily set 'packages' argument
  args <- getOption("future.disposable", list())
  args["packages"] <- list(packages)
  options(future.disposable = args)
  on.exit(options(future.disposable = NULL))

  eval(fassignment, envir = envir, enclos = baseenv())
}
