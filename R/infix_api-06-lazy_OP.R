#' Control lazy / eager evaluation for a future assignment
#'
#' @usage fassignment \%lazy\% lazy
#'
#' @param fassignment The future assignment, e.g.
#'        `x %<-% { expr }`.
#' @inheritParams future
#'
#' @aliases %lazy%
#' @rdname futureAssign
#'
#' @export
`%lazy%` <- function(fassignment, lazy) {
  fassignment <- substitute(fassignment)
  envir <- parent.frame(1)

  ## Temporarily set 'lazy' argument
  args <- getOption("future.disposable", list())
  args["lazy"] <- list(lazy)
  options(future.disposable = args)
  on.exit(options(future.disposable = NULL))

  eval(fassignment, envir = envir, enclos = baseenv())
}
