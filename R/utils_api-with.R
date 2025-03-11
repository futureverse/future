#' Evaluate an expression using a temporarily set future plan
#'
#' @param data The future plan to use temporarily.
#'
#' @param The R expression to be evaluated.
#'
#' @param \ldots Not used.
#'
#' @return The value of the expression evaluated.
#'
#' @example incl/with.R
#'
#' @export
with.FutureStrategyList <- function(data, expr, ...) {
  ## At this point, 'data' has already been resolved by
  ## R's dispatching mechanism. At this point, it is
  ## too late to override with .cleanup = FALSE.
  old_plan <- data
  on.exit({
    ## Always cleanup the temporarily used backend, iff there is a
    ## cleanup() function declared.
    ## Note, we do it here for now, to avoid legacy cleanup in plan()
    cleanup <- attr(plan("next"), "cleanup", exact = TRUE)
    if (is.function(cleanup)) cleanup()
    
    plan(old_plan, .cleanup = FALSE)
  })
  
  expr
}
