#' Set random seed for future assignment
#'
#' @usage fassignment \%seed\% seed
#'
#' @param fassignment The future assignment, e.g.
#'        `x %<-% { expr }`.
#' @inheritParams future
#'
#' @aliases %seed%
#' @rdname futureAssign
#'
#' @export
`%seed%` <- function(fassignment, seed) {
  fassignment <- substitute(fassignment)
  envir <- parent.frame(1)

  ## Temporarily set 'seed' argument
  args <- getOption("future.disposable", list())
  args["seed"] <- list(seed)
  options(future.disposable = args)
  on.exit(options(future.disposable = NULL))

  eval(fassignment, envir = envir, enclos = baseenv())
}
