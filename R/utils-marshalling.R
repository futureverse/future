reference_filters <- local({
  filters <- default <- list(
    ignore_envirs = function(ref, typeof, class, ...) {
      typeof != "environment"
    }
  )

  function(action = "drop_function", ...) {
    if (action == "drop_function") {
      function(ref) {
        typeof <- typeof(ref)
        class <- class(ref)
        for (kk in seq_along(filters)) {
          filter <- filters[[kk]]
          if (filter(ref, typeof = typeof, class = class)) next
          return(TRUE) ## drop reference
        }
        FALSE  ## don't drop reference
      }
    } else if (action == "set") {
      filters <<- list(...)
    } else if (action == "reset") {
      filters <<- default
    } else if (action == "append") {
      filters <<- c(filters, list(...))
    } else if (action == "prepend") {
      filters <<- c(list(...), filters)
    } else if (action == "get") {
      filters
    }
  }
})


#' Get the first or all references of an \R object
#'
#' @param x The \R object to be checked.
#' 
#' @param first_only If `TRUE`, only the first reference is returned,
#' otherwise all references.
#'
#' @return `find_references()` returns a list of zero or more references
#' identified.
#' 
#' @keywords internal
find_references <- function(x, first_only = FALSE) {
  con <- nullcon()
  on.exit(close(con))

  ## Get function that drops references
  drop_reference <- reference_filters()
  
  refs <- list()
    
  refhook <- if (first_only) {
    function(ref) {
      if (drop_reference(ref)) return(NULL)
      refs <<- c(refs, list(ref))
      stop(structure(list(message = ""), class = c("refhook", "condition")))
    }
  } else {
    function(ref) {
      if (drop_reference(ref)) return(NULL)
      refs <<- c(refs, list(ref))
      NULL
    }
  }
  
  tryCatch({
    serialize(x, connection = con, ascii = FALSE, xdr = FALSE,
              refhook = refhook)
  }, refhook = identity)
  
  refs
}


#' Assert that there are no references among the identified globals
#'
#' @param action Type of action to take if a reference is found.
#'
#' @param source Is the source of `x` the globals or the value of the future?
#' 
#' @return If a reference is detected, an informative error, warning, message,
#' or a character string is produced, otherwise `NULL` is returned
#' invisibly.
#'
#' @rdname find_references
#' 
#' @keywords internal
assert_no_references <- function(x, action = c("error", "warning", "message", "string"), source = c("globals", "value")) {
  ## Don't look for references in the 'where' attribute of Globals objects
  if (inherits(x, "Globals")) {
    attr(x, "where") <- NULL
    attr(x, "class") <- NULL
  }
  
  ref <- find_references(x, first_only = TRUE)
  if (length(ref) == 0) return(NULL)
  ref <- ref[[1]]
  
  action <- match.arg(action, choices = c("error", "warning", "message", "string"))
  source <- match.arg(source, choices = c("globals", "value"))

  typeof <- typeof(ref)
  class <- class(ref)[1]
  if (class == typeof) {
    typeof <- sQuote(typeof)
  } else {
    typeof <- sprintf("%s of class %s", sQuote(typeof), sQuote(class))
  }

  if (source == "globals") {
    ## Identify which global object has a reference
    global <- " (<unknown>)"
    if (is.list(x) && !is.null(names(x))) {
      for (ii in seq_along(x)) {
        ref_ii <- find_references(x[ii], first_only = TRUE)
        if (length(ref_ii) > 0) {
          global <- sprintf(" (%s of class %s)",
                            sQuote(names(x)[ii]), sQuote(class(x[[ii]])[1]))
          ref <- ref_ii[[1]]
          break
        }
      }
    }
    msg <- sprintf("Detected a non-exportable reference (%s) in one of the globals%s used in the future expression", typeof, global)
  } else if (source == "value") {
    msg <- sprintf("Detected a non-exportable reference (%s) in the value (of class %s) of the resolved future", typeof, sQuote(class(x)[1]))
  }
  
  if (action == "error") {
    stop(FutureError(msg, call = NULL))
  } else if (action == "warning") {
    warning(FutureWarning(msg, call = NULL))
  } else if (action == "message") {
    message(FutureMessage(msg, call = NULL))
  } else if (action == "string") {
    msg
  }
}
