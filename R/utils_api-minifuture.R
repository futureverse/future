#' Create a minimalistic future with minimal automatic features
#'
#' Same as [future()], but with different default arguments. Specifically,
#' globals and packages must be manually specified, conditions are not
#' captured, standard output is not captured, random seeds are not declared
#' or set.
#'
#' @inheritParams future
#'
#' @param expr An \R \link[base]{expression}.
#'
#' @param \ldots Additional arguments passed to [future()].
#'
#' @return A [Future]
#' @export
minifuture <- function(expr, substitute = TRUE, globals = NULL, packages = NULL, stdout = NA, conditions = NULL, seed = NULL, ..., envir = parent.frame()) {
  if (substitute) expr <- substitute(expr)
  reset <- character(0L)
  future(expr, substitute = FALSE, globals = globals, packages = packages, stdout = stdout, conditions = conditions, seed = seed, reset = reset, ..., envir = envir)
}
