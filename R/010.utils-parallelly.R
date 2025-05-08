#' @importFrom parallelly makeClusterPSOCK makeNodePSOCK
makeClusterPSOCK_args <- local({
  .args <- NULL
  
  function() {
    if (is.null(.args)) {
      ## Arguments meant for makeClusterPSOCK() and makeNodePSOCK()
      args <- character(0L)
      for (name in c("makeClusterPSOCK", "makeNodePSOCK")) {
        if (!exists(name, mode = "function")) next
        fcn <- get(name, mode = "function")
        args <- c(args, names(formals(fcn)))
      }
      args <- unique(args)
      args <- setdiff(args, "...")
      .args <<- args
    }
    .args
  }
})


if (packageVersion("parallelly") <= "1.44.0") {
  ## WORKAROUND: 'constraints-N' ignores 'fallback' settings
  availableCores <- function(constraints = NULL, ...) {
    constraints_org <- constraints
    pattern_connections <- "^connections-[[:digit:]]+$"
    idxs <- grep(pattern_connections, constraints)
    if (length(idxs) == 0) {
      return(parallelly::availableCores(constraints = constraints, ...))
    }

    constraints_con <- constraints[idxs]
    constraints <- constraints[-idxs]
    ncores <- parallelly::availableCores(constraints = constraints, ...)
    if (!any(constraints_con %in% names(ncores))) return(ncores)

    upper <- parallelly::availableCores(methods = constraints_con)
    ncores <- ncores[ncores <= upper]
    ncores
  }
}
