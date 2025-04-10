#' Get the future of a future variable
#'
#' Get the future of a future variable that has been created directly
#' or indirectly via [future()].
#'
#' @param var the variable.  If NULL, all futures in the
#' environment are returned.
#'
#' @param envir the environment where to search from.
#'
#' @param mustExist If TRUE and the variable does not exists, then
#' an informative error is thrown, otherwise NA is returned.
#'
#' @param default the default value if future was not found.
#'
#' @param drop if TRUE and `var` is NULL, then returned list
#' only contains futures, otherwise also `default` values.
#'
#' @return A [Future] (or `default`).
#' If `var` is NULL, then a named list of Future:s are returned.
#'
#' @example incl/futureOf.R
#'
#' @export
#' @importFrom listenv mapping parse_env_subset
futureOf <- function(var = NULL, envir = parent.frame(), mustExist = TRUE, default = NA, drop = FALSE) {
  ## Argument 'expr':
  expr <- substitute(var)


  ## Inspect by expression?
  if (!is.null(expr)) {
    target <- parse_env_subset(expr, envir = envir, substitute = FALSE)
    future <- get_future(target, mustExist = mustExist)
    return(future)
  }


  ## Otherwise, inspect all variables in environment
  if (inherits(envir, "listenv")) {
    map <- mapping(envir)
    res <- list()
    length(res) <- length(map)
    names(res) <- names(map)

    for (idx in seq_along(res)) {
      target <- parse_env_subset(idx, envir = envir, substitute = FALSE)
      future <- get_future(target, mustExist = FALSE, default = default)
      if (!is.null(future) || !is.atomic(future) || !is.na(future)) {
        res[[idx]] <- future
      }
    }
  } else {
    ## names(x) is only supported in R (>= 3.2.0)
    vars <- ls(envir = envir, all.names = TRUE)
    vars <- grep("^.future_", vars, invert = TRUE, value = TRUE)
    res <- lapply(vars, FUN = function(var) {
      target <- parse_env_subset(var, envir = envir, substitute = FALSE)
      get_future(target, mustExist = FALSE, default = default)
    })
    names(res) <- vars
  }

  ## Keep only futures?
  if (drop && length(res) > 0) {
    keep <- sapply(res, FUN = inherits, "Future")
    res <- res[keep]
  } else {
    ## Preserve dimensions
    dim <- dim(envir)
    if (!is.null(dim)) {
      dim(res) <- dim
      dimnames(res) <- dimnames(envir)
    }
  }

  res
}


get_future <- function(target, mustExist = TRUE, default = NA) {
  res <- default

  if (!target[["exists"]]) {
    msg <- sprintf("No such future variable: %s", target[["code"]])
    if (mustExist) {
      mdebug("ERROR: ", msg)
      stop(msg, call. = FALSE)
    }
    attr(res, "reason") <- msg
    return(res)
  }

  envir <- target[["envir"]]
  envirName <- environmentName(envir)
  if (!nzchar(envirName)) envirName <- "<noname>"

  ## (a) Check if element is a future promise
  if (inherits(envir, "listenv")) {
    map <- mapping(envir)
    name <- map[target[["idx"]]]
  } else {
    name <- target[["name"]]
  }
  future_name <- sprintf(".future_%s", name)
  if (exists(future_name, envir = envir, inherits = FALSE)) {
    return(get(future_name, envir = envir, inherits = FALSE))
  }

  ## (b) Check if element itself is a future object
  if (exists(name, envir = envir, inherits = FALSE)) {
    future <- get(name, envir = envir, inherits = FALSE)
    if (inherits(future, "Future")) return(future)
  }

  ## Not found
  msg <- sprintf("Future (%s) not found in %s %s: %s", sQuote(name), class(envir)[1], sQuote(envirName), sQuote(target[["code"]]))
  if (mustExist) {
    mdebug("ERROR: ", msg)
    stop(msg, call. = FALSE)
  }

  attr(res, "reason") <- msg
  res
} # get_future()
