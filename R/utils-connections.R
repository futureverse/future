## This is needed in order to be able to assert that we later
## actually work with the same connection.  See R-devel thread
## 'closeAllConnections() can really mess things up' on 2016-10-30
## (https://stat.ethz.ch/pipermail/r-devel/2016-October/073331.html)
#' @importFrom parallelly isConnectionValid
check_connection_details <- function(worker, future) {
  con <- worker[["con"]]
  
  ## Not a worker with a connection?
  if (!inherits(con, "connection")) return(NULL)

  isValid <- isConnectionValid(con)
  if (isValid) return(NULL)

  label <- sQuoteLabel(future)

  reason <- attr(isValid, "reason", exact = TRUE)
  reason <- gsub("[.]?[[:space:]]*$", "", reason)
  msg <- sprintf("The socket connection to the worker of %s future (%s) is lost or corrupted: %s", class(future)[1], label, reason)
  sprintf("%s. As an example, this may happen if base::closeAllConnections() have been called, for instance via base::sys.save.image() which in turn is called if the R session (pid %s) is forced to terminate", msg, Sys.getpid())
}
