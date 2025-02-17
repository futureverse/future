with_assert <- function(expr, ...) {
  invisible(expr)
}

prune_call <- function(expr, name) {
  if (!is.call(expr)) 
    return(expr)
  expr <- unclass(expr)
  fcn <- expr[[1]]
  if (!is.symbol(fcn)) 
    return(expr)
  if (as.character(fcn) != name)
    return(expr)
  NULL
}

prune_fcns <- function(expr) {
  expr <- prune_call(expr, name = "stop_if_not")
  expr <- prune_call(expr, name = "with_assert")
  expr
}

prune_fcn <- function(name, envir) {
  if (exists(name, mode = "function", envir = envir, inherits = FALSE)) {
    fcn <- get(name, mode = "function", envir = envir, inherits = FALSE)
    body0 <- body(fcn)
    body <- walkAST(body0, call = prune_fcns)
    if (!identical(body, body0)) {
      body(fcn) <- body
      assign(name, fcn, envir = envir, inherits = FALSE)
      return(TRUE)
    }
  }
  FALSE
}

#' @importFrom globals walkAST
prune_pkg_code <- function(env = topenv(parent.frame())) {
  res <- lapply(names(env), FUN = prune_fcn, envir = env)

  env <- environment(plan)
  res <- lapply(names(env), FUN = prune_fcn, envir = env)
}
