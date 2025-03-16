#' Control whether standard output should be captured or not
#'
#' @usage fassignment \%stdout\% capture
#'
#' @param fassignment The future assignment, e.g.
#'        `x %<-% { expr }`.
#'
#' @param capture If TRUE, the standard output will be captured, otherwise not.
#'
#' @aliases %stdout%
#' @rdname futureAssign
#'
#' @export
`%stdout%` <- function(fassignment, capture) {
  fassignment <- substitute(fassignment)
  envir <- parent.frame(1)

  ## Temporarily set 'lazy' argument
  args <- getOption("future.disposable", list())
  args["stdout"] <- list(capture)
  options(future.disposable = args)
  on.exit(options(future.disposable = NULL))

  eval(fassignment, envir = envir, enclos = baseenv())
}
