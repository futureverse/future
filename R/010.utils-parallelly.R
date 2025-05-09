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
