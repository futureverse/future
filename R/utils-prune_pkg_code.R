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

prune_stop_if_not <- function(expr) {
  prune_call(expr, name = "stop_if_not")
}

#' @importFrom globals walkAST
prune_pkg_code <- function(env = topenv(parent.frame())) {
  names <- names(env)
  for (name in names) {
    if (exists(name, mode = "function", envir = env, inherits = FALSE)) {
      fcn <- get(name, mode = "function", envir = env, inherits = FALSE)
      body0 <- body(fcn)
      body <- walkAST(body0, call = prune_stop_if_not)
      if (!identical(body, body0)) {
        body(fcn) <- body
        assign(name, fcn, envir = env, inherits = FALSE)
      }
    }
  }
}
