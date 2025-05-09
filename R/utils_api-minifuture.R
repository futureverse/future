#' @return
#' `minifuture(expr)` creates a future with minimal overhead, by disabling
#' user-friendly behaviors, e.g. automatic identification of global
#' variables and packages needed, and relaying of output. Unless you have
#' good reasons for using this function, please use [future()] instead.
#' This function exists mainly for the purpose of profiling and identifying
#' which automatic features of [future()] introduce extra overhead.
#'
#' @rdname future
#' @export
minifuture <- function(expr, substitute = TRUE, globals = NULL, packages = NULL, stdout = NA, conditions = NULL, seed = NULL, ..., envir = parent.frame()) {
  if (substitute) expr <- substitute(expr)
  reset <- character(0L)
  future(expr, substitute = FALSE, globals = globals, packages = packages, stdout = stdout, conditions = conditions, seed = seed, reset = reset, ..., envir = envir)
}
