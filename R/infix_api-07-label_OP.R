#' Specify label for a future assignment
#'
#' @usage fassignment \%label\% label
#'
#' @param fassignment The future assignment, e.g.
#'        `x %<-% { expr }`.
#' @inheritParams future
#'
#' @aliases %label%
#' @rdname futureAssign
#'
#' @export
`%label%` <- function(fassignment, label) {
  fassignment <- substitute(fassignment)
  envir <- parent.frame(1)

  ## Temporarily set 'label' argument
  args <- getOption("future.disposable", list())
  args["label"] <- list(label)
  options(future.disposable = args)
  on.exit(options(future.disposable = NULL))
  
  eval(fassignment, envir = envir, enclos = baseenv())
}
