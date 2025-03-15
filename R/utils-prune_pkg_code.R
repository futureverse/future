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

prune_debug <- function(expr) {
  if (!is.call(expr)) 
    return(expr)
  expr <- unclass(expr)
  fcn <- expr[[1]]
  if (!is.symbol(fcn)) 
    return(expr)
    
  ## if (debug) { ... }
  if (as.character(fcn) == "if") {
    cond <- expr[[2]]
    if (!is.symbol(cond)) 
      return(expr)
    if (as.character(cond) != "debug")
      return(expr)
    expr <- NULL
  } else if (as.character(fcn) == "<-") {
    lhs <- expr[[2]]
    if (!is.symbol(lhs)) 
      return(expr)
    if (as.character(lhs) != "debug")
      return(expr)
    expr <- quote(debug <- FALSE)
  }
  expr
}

prune_fcns <- function(expr) {
  expr <- prune_call(expr, name = "stop_if_not")
  expr <- prune_call(expr, name = "with_assert")
  expr <- prune_call(expr, name = "assert_no_positional_args_but_first")
  expr <- prune_call(expr, name = "assertValidConnection")
  expr <- prune_debug(expr)
#  expr <- prune_call(expr, name = "assertOwner")
  expr
}

prune_fcn <- function(name, envir) {
  if (exists(name, mode = "function", envir = envir, inherits = FALSE)) {
    fcn <- get(name, mode = "function", envir = envir, inherits = FALSE)
    body0 <- body(fcn)
    body <- walkAST(body0, call = prune_fcns)
    if (!identical(body, body0)) {
      attrs <- attributes(fcn)
      body(fcn) <- body
      attributes(fcn) <- attrs ## attributes are lost if body is changed
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
