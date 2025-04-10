#' Place a sticky-globals environment immediately after the global environment
#'
#' @param erase (logical) If TRUE, the environment is erased, otherwise not.
#'
#' @param name (character) The name of the environment on the [base::search]
#' path.
#'
#' @param pos (integer) The position on the search path where the
#' environment should be positioned.  If `pos == 0L`, then the environment
#' is detached, if it exists.
#'
#' @return (invisible; environment) The environment.
#'
#' @keywords internal
sticky_globals <- function(erase = FALSE, name = "future:sticky_globals", pos = 2L) {
  attach_to_search_path <- base::attach

  search_path <- search()
  stop_if_not((pos == 0L || pos >= 2L), pos < length(search_path))
  curr_pos <- match(name, table = search_path)

  ## Detach?
  if (pos == 0L) {
    if (is.na(curr_pos)) return(NULL)
    env <- detach(pos = curr_pos)
    return(env)
  }
  
  if (is.na(curr_pos)) {
    env <- attach_to_search_path(NULL, name = name, pos = pos)
  } else {
    if (erase) {
      env <- detach(pos = curr_pos)
      env <- attach_to_search_path(NULL, name = name, pos = pos)
    } else if (curr_pos != pos) {
      child <- pos.to.env(pos - 1L)
      env <- detach(pos = curr_pos)
      parent.env(env) <- pos.to.env(pos)
      parent.env(child) <- env
    } else {
      env <- pos.to.env(pos)
    }
  }
  
  env
}


#' Export globals to the sticky-globals environment of the cluster nodes
#'
#' @param cl (cluster) A cluster object as returned by
#' [parallel::makeCluster()].
#'
#' @param globals (list) A named list of sticky globals to be exported.
#'
#' @return (invisible; cluster) The cluster object.
#'
#' @details
#' This requires that the \pkg{future} package is installed on the cluster
#' nodes.
#'
#' @importFrom parallel clusterCall
#' @keywords internal
clusterExportSticky <- function(cl, globals) {
  stop_if_not(inherits(cl, "cluster"))
  
  if (is.character(globals)) {
    names <- globals
    globals <- lapply(globals, FUN = get)
    names(globals) <- names
  } else {
    stop_if_not(is.list(globals))
  }
  
  if (length(globals) == 0L) return(invisible(cl))
  stop_if_not(!is.null(names(globals)))

  clusterCall(cl, fun = function(globals) {
    ns <- getNamespace("future")
    sticky_globals <- get("sticky_globals", mode = "function", envir = ns)
    env <- sticky_globals()
    for (name in names(globals))
      env[[name]] <- globals[[name]]
    TRUE
  }, globals = globals)

  invisible(cl)
}
