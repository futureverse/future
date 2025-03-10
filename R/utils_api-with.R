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
  on.exit(plan(data))
  plan("next")
  expr
}
