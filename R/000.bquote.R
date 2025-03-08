## base::bquote() gained argument 'splice' in R 4.0.0 (April 2020)
## Below is a verbatim copy of bquote() in R 4.0.4
if (getRversion() < "4.0.0") {
  #' @importFrom utils globalVariables
  globalVariables(c(".", ".."))
  
  bquote_splice <- function (expr, where = parent.frame(), splice = FALSE) {
      if (!is.environment(where)) 
          where <- as.environment(where)
      unquote <- function(e) {
          if (is.pairlist(e)) 
              as.pairlist(lapply(e, unquote))
          else if (is.call(e)) {
              if (is.name(e[[1L]]) && as.character(e[[1]]) == ".") 
                  eval(e[[2L]], where)
              else if (splice) {
                  if (is.name(e[[1L]]) && as.character(e[[1L]]) == 
                    "..") 
                    stop("can only splice inside a call", call. = FALSE)
                  else as.call(unquote.list(e))
              }
              else as.call(lapply(e, unquote))
          }
          else e
      }
      is.splice.macro <- function(e) is.call(e) && is.name(e[[1L]]) && 
          as.character(e[[1L]]) == ".."
      unquote.list <- function(e) {
          p <- Position(is.splice.macro, e, nomatch = NULL)
          if (is.null(p)) 
              lapply(e, unquote)
          else {
              n <- length(e)
              head <- if (p == 1) 
                  NULL
              else e[1:(p - 1)]
              tail <- if (p == n) 
                  NULL
              else e[(p + 1):n]
              macro <- e[[p]]
              mexp <- eval(macro[[2L]], where)
              if (!is.vector(mexp)) 
                  stop("can only splice vectors")
              c(lapply(head, unquote), mexp, as.list(unquote.list(tail)))
          }
      }
      unquote(substitute(expr))
  }
} else {
  bquote_splice <- base::bquote
} ## if (getRversion() < "4.0.0")


#' @importFrom utils globalVariables
globalVariables(c(".", ".."))
bquote_compile <- function(expr, substitute = TRUE) {
  if (substitute) expr <- substitute(expr)
  
  tmpl <- list()
  
  unquote <- function(e, at = integer(0L)) {
    n <- length(e)
    if (n == 0L) return()

    if (is.pairlist(e)) {
      for (kk in 1:n) unquote(e[[kk]], at = c(at, kk))
      return()
    }

    if (!is.call(e)) return()
    
    ## .(<name>)?
    if (is.name(e[[1L]]) && as.character(e[[1]]) == ".") {
      ## Record location in expression tree
      entry <- list(
        expression = e[[2L]],
        at         = at
      )
      tmpl <<- c(tmpl, list(entry))
      return()
    }
  
    ## `{`, `+`, ...
    for (kk in 1:n) unquote(e[[kk]], at = c(at, kk))
  }

  dummy <- unquote(expr)
  attr(tmpl, "expression") <- expr
  tmpl
}


bquote_apply <- function(tmpl, envir = parent.frame()) {
  expr <- attr(tmpl, "expression")
  
  for (kk in seq_along(tmpl)) {
    entry <- tmpl[[kk]]
    value <- eval(entry[["expression"]], envir = envir)
    at <- entry[["at"]]
    
    ## Special case: Result becomes just a value
    nat <- length(at)
    if (nat == 0) return(value)

    ## Inject a NULL (needs special care) or a regular value?
    if (is.null(value)) {
      head <- if (nat == 1L) NULL else at[-nat]
      e <- if (is.null(head)) expr else expr[[head]]
      if (is.call(e)) {
        f <- as.list(e)
        f[at[nat]] <- list(NULL)
        e <- as.call(f)
      } else if (is.pairlist(e)) {
        e[1] <- list(NULL)
        e <- as.pairlist(e)
      } else {
        stopf("Unknown type of expression (please report to the maintainer): %s",
             sQuote(paste(deparse(e), collapse = "\\n")))
      }
      if (is.null(head)) {
        expr <- e
      } else {
        expr[[head]] <- e
      }
    } else {
      expr[[at]] <- value
    }
  }

  expr
}
