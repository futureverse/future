#' Control whether standard output should be captured or not
#'
#' @usage fassignment \%conditions\% capture
#'
#' @param fassignment The future assignment, e.g.
#'        `x %<-% { expr }`.
#'
#' @param capture If TRUE, the standard output will be captured, otherwise not.
#'
#' @aliases %conditions%
#' @rdname futureAssign
#' @export
`%conditions%` <- function(fassignment, capture) {
  fassignment <- substitute(fassignment)
  envir <- parent.frame(1)

  ## Temporarily set 'lazy' argument
  args <- getOption("future.disposable", list())
  args["conditions"] <- list(capture)
  options(future.disposable = args)
  on.exit(options(future.disposable = NULL))

  eval(fassignment, envir = envir, enclos = baseenv())
}
