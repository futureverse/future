#' Evaluate an expression using a temporarily set future plan
#'
#' @param data The future plan to use temporarily.
#'
#' @param expr The R expression to be evaluated.
#'
#' @param \ldots Not used.
#'
#' @param local If TRUE, then the future plan specified by `data`
#' is applied temporarily in the calling frame. Argument `expr` must
#' not be specified if `local = TRUE`.
#'
#' @param envir The environment where the future plan should be set and the
#' expression evaluated.
#'
#' @return The value of the expression evaluated.
#'
#' @example incl/with.R
#'
#' @rdname plan
#' @export
with.FutureStrategyList <- function(data, expr, ..., local = FALSE, envir = parent.frame()) {
  ## At this point, 'data' has already been resolved by
  ## R's dispatching mechanism. At this point, it is
  ## too late to override with .cleanup = FALSE.
  old_plan <- data

  if (local) {
    if (!missing(expr)) stop("Argument 'expr' must not be specified when local = TRUE")
    undoPlan <- function() plan(old_plan, .cleanup = TRUE)
    call <- as.call(list(undoPlan))
    args <- list(call, add = TRUE, after = TRUE)
    do.call(base::on.exit, args = args, envir = envir)
  } else {
    on.exit({
      ## Always cleanup the temporarily used backend
      plan(old_plan, .cleanup = TRUE)
    })
  
    invisible(eval(expr, envir = envir))
  }
}
