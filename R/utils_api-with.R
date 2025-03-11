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


#' @param envir The environment where the future plan should be set.
#'
#' @rdname plan
#' @export
localPlan <- function(strategy = NULL, ..., .cleanup = NA, substitute = TRUE, envir = parent.frame()) {
  if (substitute) strategy <- substitute(strategy)
  if (identical(envir, topenv())) {
    stop("Can only set a local future plan inside a function or inside local()")
  }

  ## Set up on.exit() in the parent frame
  oplan <- plan("list")
  undoPlan <- function() plan(oplan, .cleanup = TRUE)
  call <- as.call(list(undoPlan))
  args <- list(call, add = TRUE, after = TRUE)
  do.call(base::on.exit, args = args, envir = envir)
  
  ## Set the new, temporary plan, without cleaning up the current one
  plan(strategy, substitute = FALSE, .cleanup = FALSE, ...)
  
  invisible(oplan)
}


ping <- function(..., envir = parent.frame()) {
  a <- 42
  
  ## Set up on.exit() in the parent frame
  thunk <- as.call(list(function() print(2*a)))
  args <- list(thunk, add = TRUE, after = TRUE)
  do.call(base::on.exit, args = args, envir = envir)
}
