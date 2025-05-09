#' Temporarily tweaks the arguments of the current backend
#'
#' @usage fassignment \%tweak\% tweaks
#'
#' @param fassignment The future assignment, e.g.
#'        `x %<-% { expr }`.
#' @param tweaks A named list (or vector) with arguments that
#' should be changed relative to the current backend.
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
  strategy <- plans[[1]]
  args <- c(list(strategy, penvir = envir), tweaks)
  strategy <- do.call(tweak, args = args)
  plans[[1]] <- strategy
  plan(plans, substitute = FALSE, .call = NULL, .cleanup = FALSE, .init = TRUE)

  eval(fassignment, envir = envir, enclos = baseenv())
}
