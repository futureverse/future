#' Temporarily tweaks the arguments of the current strategy
#'
#' @usage fassignment \%tweak\% tweaks
#'
#' @param fassignment The future assignment, e.g.
#'        `x %<-% { expr }`.
#' @param tweaks A named list (or vector) with arguments that
#' should be changed relative to the current strategy.
#'
#' @aliases %tweak%
#' @rdname futureAssign
#'
#' @export
`%tweak%` <- function(fassignment, tweaks) {
  fassignment <- substitute(fassignment)
  envir <- parent.frame(1)
  stop_if_not(is.vector(tweaks))
  tweaks <- as.list(tweaks)
  stop_if_not(!is.null(names(tweaks)))

  ## Temporarily use a different plan
  oplan <- plan("list")
  on.exit(plan(oplan, substitute = FALSE, .call = NULL, .cleanup = FALSE, .init = FALSE))

  ## Tweak current strategy and apply
  plans <- oplan
  args <- c(list(plans[[1]], penvir = envir), tweaks)
  plans[[1]] <- do.call(tweak, args = args)
  plan(plans, substitute = FALSE, .call = NULL, .cleanup = FALSE, .init = FALSE)

  eval(fassignment, envir = envir, enclos = baseenv())
}
