argnames <- function(..., exclude = "...") {
  fcns <- list(...)
  names <- lapply(fcns, FUN = function(fcn) {
    names(formals(fcn))
  })
  names <- unlist(names, use.names = FALSE)
  names <- unique(names)
  names <- setdiff(names, exclude)
}

tweakable <- function(x, ...) {
  attr(x, "tweakable", exact = TRUE)
}

untweakable <- function(x, ...) {
  attr(x, "untweakable", exact = TRUE)
}

`tweakable<-` <- function(x, value) {
  if (is.function(value)) {
    value <- list(value)
  }
  names <- names(formals(x))
  
  for (kk in seq_along(value)) {
    obj <- value[[kk]]
    if (is.character(obj)) {
      names <- c(names, obj)
    } else {
      names <- c(names, tweakable(obj))
    }
  }
  names <- setdiff(names, "...")
  
  names <- setdiff(names, untweakable(x))
  for (kk in seq_along(value)) {
    obj <- value[[kk]]
    if (is.character(obj)) {
      names <- setdiff(names, obj)
    } else {
      names <- setdiff(names, untweakable(obj))
    }
  }
  names <- unique(names)
  attr(x, "tweakable") <- names
  invisible(x)
}

`untweakable<-` <- function(x, value) {
  attr(x, "untweakable") <- unique(value)
  invisible(x)
}
