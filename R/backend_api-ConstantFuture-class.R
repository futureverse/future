# Used by getGlobalsAndPackages()
ConstantFuture <- function(..., substitute = FALSE, globals = NULL, packages = NULL, stdout = NA, conditions = NULL, seed = NULL, lazy = FALSE, envir = emptyenv()) {
  future <- Future(..., substitute = substitute, globals = NULL, packages = NULL, stdout = NA, conditions = NULL, seed = NULL, lazy = FALSE, envir = envir)
  t_start <- Sys.time()
  future[["result"]] <- FutureResult(
    value = eval(future[["expr"]], envir = envir),
    seed = seed,
    started = t_start,
    finished = t_start
  )
  future[["state"]] <- "finished"
  future <- structure(future, class = c("ConstantFuture", class(future)))
  future
}

#' @export
run.ConstantFuture <- function(future, ...) {
  future
}

#' @export
result.ConstantFuture <- function(future, ...) {
  future[["result"]]
}
