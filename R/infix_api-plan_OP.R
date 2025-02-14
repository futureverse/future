#' Use a specific plan for a future assignment
#'
#' @usage fassignment \%plan\% strategy
#'
#' @param fassignment The future assignment, e.g.
#'        `x %<-% { expr }`.
#' @param strategy The mechanism for how the future should be
#'        resolved. See [plan()] for further details.
#'
#' @seealso
#' The [plan()] function sets the default plan for all futures.
#'
#' @export
`%plan%` <- function(fassignment, strategy) {
  fassignment <- substitute(fassignment)
  strategy <- substitute(strategy)
  envir <- parent.frame(1)

  ## Temporarily use a different plan
  oplan <- plan("list")
  on.exit(plan(oplan, substitute = FALSE, .call = NULL, .cleanup = FALSE, .init = FALSE))
  plan(strategy, substitute = FALSE, .call = NULL, .cleanup = FALSE, .init = FALSE)

  eval(fassignment, envir = envir, enclos = baseenv())
}
