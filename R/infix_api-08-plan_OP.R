#' Use a specific plan for a future assignment
#'
#' @usage fassignment \%plan\% strategy
#'
#' @param fassignment The future assignment, e.g.
#'        `x %<-% { expr }`.
#' @param strategy The backend controlling how the future is
#'        resolved. See [plan()] for further details.
#'
#' @aliases %plan%
#' @rdname futureAssign
#'
#' @export
`%plan%` <- function(fassignment, strategy) {
  fassignment <- substitute(fassignment)
  strategy <- substitute(strategy)
  envir <- parent.frame(1)

  ## Temporarily use a different plan
  oplan <- plan("list")
  on.exit({
    ## Note, we cannot use .cleanup = TRUE here, because the
    ## future created with the future assignment, needs it
    ## the backend to be alive in order for result() to work.
    ## FIXME: Figure out how to delay the cleanup until
    ## the delayed future assignment is resolved. /HB 2025-03-11
    plan(oplan, substitute = FALSE, .call = NULL, .cleanup = FALSE, .init = FALSE)
  })
  plan(strategy, substitute = FALSE, .call = NULL, .cleanup = FALSE, .init = FALSE)

  eval(fassignment, envir = envir, enclos = baseenv())
}
