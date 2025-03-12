#' @param expr An R expression to be evaluated.
#'
#' @param envir The environment where the future plan should be set and the expression evaluated.
#'
#' @return
#' `withPlan()` returns the value of the expression evaluated.
#'
#' @rdname plan
#' @export
withPlan <- function(strategy = NULL, expr, envir = parent.frame(), .cleanup = NA, substitute = TRUE, ...) {
  if (substitute) strategy <- substitute(strategy)

  ## Make sure to reset back to the current plan, and
  ## to clean up the the temporary plan that was set
  oplan <- plan("list")
  on.exit({
    plan(oplan, .cleanup = TRUE)
  })
  
  ## Set the new, temporary plan, without cleaning up the current one
  plan(strategy, substitute = FALSE, .cleanup = FALSE, ...)
  
  eval(expr, envir = envir)
}


#' @return
#' `localPlan()` returns the current future plan before applying the temporary one.
#'
#' @rdname plan
#' @export
localPlan <- function(strategy = NULL, .cleanup = NA, envir = parent.frame(), substitute = TRUE, ...) {
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
