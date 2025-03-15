## A *rough* estimate of size of an object + its environment.
#' @keywords internal 
#' @importFrom utils object.size
#' @importFrom parallelly serializedSize
objectSize <- function(x, depth = 3L, enclosure = FALSE) {
  # Nothing to do?
  if (isNamespace(x)) return(0)
  if (depth <= 0) return(0)

  method <- getOption("future.globals.objectSize.method")
  if (is.null(method) || method == "serializedSize") {
    size <- serializedSize(x)
    return(size)
  } else if (method != "objectSize") {
    stop(paste("Unknown value on option 'future.globals.objectSize.method':", sQuote(method)))
  }
  
  if (!is.list(x) && !is.environment(x)) {
    size <- unclass(object.size(x))
    ## Issue #176 is because of this
    if (missing(enclosure)) {
      enclosure <- getOption("future.globals.objectSize.enclosure")
    }
    if (isTRUE(enclosure)) x <- environment(x)
  } else {
    size <- 0
  }

  ## Nothing more to do?
  if (depth == 1) return(size)

  .scannedEnvs <- new.env()
  scanned <- function(e) {
    for (name in names(.scannedEnvs))
      if (identical(e, .scannedEnvs[[name]])) return(TRUE)
    FALSE
  }
  
  objectSize_list <- function(x, depth) {
    ## Nothing to do?
    if (depth <= 0) return(0)

    if (inherits(x, "FutureGlobals")) {
      size <- attr(x, "total_size", exact = TRUE)
      if (!is.na(size)) return(size)
    }

    depth <- depth - 1L
    size <- 0

    ## Use the true length that corresponds to what .subset2() uses
    nx <- .length(x)

    for (kk in seq_len(nx)) {
      ## NOTE: Use non-class dispatching subsetting to avoid infinite loop,
      ## e.g. x <- packageVersion("future") gives x[[1]] == x.
      x_kk <- .subset2(x, kk)
      if (missing(x_kk)) {
        ## e.g. x <- alist(a=)
      } else if (is.list(x_kk)) {
        size <- size + objectSize_list(x_kk, depth = depth)
      } else if (is.environment(x_kk)) {
        if (!scanned(x_kk)) size <- size + objectSize_env(x_kk, depth = depth)
      } else {
        size <- size + unclass(object.size(x_kk))
      }
    }
    size
  } ## objectSize_list()
  
  objectSize_env <- function(x, depth) {
    # Nothing to do?
    if (depth <= 0) return(0)
    depth <- depth - 1L
    if (isNamespace(x)) return(0)
##    if (inherits(x, "Future")) return(0)

    size <- 0

    ## Get all objects in the environment
    elements <- ls(envir = x, all.names = TRUE)
    if (length(elements) == 0) return(0)

    ## Skip variables that are future promises in order
    ## to avoid inspecting promises that are already
    ## under investigation.
    skip <- grep("^.future_", elements, value = TRUE)
    if (length(skip) > 0) {
      skip <- gsub("^.future_", "", elements)
      elements <- setdiff(elements, skip)
      if (length(elements) == 0) return(0)
    }
    
    ## Avoid scanning the current environment again
    name <- sprintf("env_%d", length(.scannedEnvs))
    .scannedEnvs[[name]] <- x

    for (element in elements) {
      ## FIXME: Some elements may not exist, although ls() returns them
      ## and exists() say they do exist, cf. Issue #161 /HB 2017-08-24
      ## NOTE: Hmm... is it possible to test for the existence or are
      ## we doomed to have to use of tryCatch() here?
      res <- tryCatch({
        x_kk <- .subset2(x, element)
        NULL  ## So that 'x_kk' is not returned, which may be missing()
      }, error = identity)

      ## A promise that cannot be resolved? This could be a false positive,
      ## e.g. an expression not to be resolved, cf. Issue #161 /HB 2017-08-24
      if (inherits(res, "error")) next

      ## Nothing to do?
      if (missing(x_kk)) next
      
      if (is.list(x_kk)) {
        size <- size + objectSize_list(x_kk, depth = depth)
      } else if (is.environment(x_kk)) {
##        if (!inherits(x_kk, "Future") && !scanned(x_kk)) {
        if (!scanned(x_kk)) {
          size <- size + objectSize_env(x_kk, depth = depth)
        }
      } else {
        size <- size + unclass(object.size(x_kk))
      }
    }
  
    size
  } ## objectSize_env()

  ## Suppress "Warning message:
  ##   In doTryCatch(return(expr), name, parentenv, handler) :
  ##   restarting interrupted promise evaluation"
  suppressWarnings({
    if (is.list(x)) {
      size <- size + objectSize_list(x, depth = depth - 1L)
    } else if (is.environment(x)) {
      size <- size + objectSize_env(x, depth = depth - 1L)
    }
  })

  size
}
