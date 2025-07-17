#' Evaluate an expression using a temporarily set future plan
#'
#' @inheritParams plan
#'
#' @param data The future plan to use temporarily, e.g. `plan(multisession)`.
#'
#' @param expr The R expression to be evaluated.
#'
#' @param local If TRUE, then the future plan specified by `data`
#' is applied temporarily in the calling frame. Argument `expr` must
#' not be specified if `local = TRUE`.
#'
#' @param envir The environment where the future plan should be set and the
#' expression evaluated.
#'
#' @return The value of the expression evaluated (invisibly).
#'
#' @example incl/with.R
#'
#' @include utils_api-plan.R
#' @rdname plan
#' @export
with.FutureStrategyList <- function(data, expr, ..., local = FALSE, envir = parent.frame(), .cleanup = NA) {
  ## At this point, 'data' has already been resolved by
  ## R's dispatching mechanism. At this point, it is
  ## too late to override with .cleanup = FALSE.
  
  temporary <- attr(plan("next"), "with-temporary")
  if (is.logical(temporary)) {
    old_plan <- data
    if (is.na(.cleanup)) .cleanup <- TRUE
  } else {
    old_plan <- plan(data, .init = FALSE, .cleanup = FALSE)
    if (is.na(.cleanup)) .cleanup <- FALSE
  }

  if (local) {
    if (!missing(expr)) stop("Argument 'expr' must not be specified when local = TRUE")
    undoPlan <- function() plan(old_plan, .init = FALSE, .cleanup = .cleanup)
    call <- as.call(list(undoPlan))
    args <- list(call, add = TRUE, after = TRUE)
    do.call(base::on.exit, args = args, envir = envir)
  } else {
    on.exit({
      ## Always cleanup the temporarily used backend
      plan(old_plan, .init = FALSE, .cleanup = .cleanup)
    })
  
    invisible(eval(expr, envir = envir))
  }
}
