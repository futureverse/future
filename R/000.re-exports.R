#' Functions Moved to 'parallelly'
#'
#' The following function used to be part of \pkg{future} but has since
#' been migrated to \pkg{parallelly}.  The migration started with
#' \pkg{future} 1.20.0 (November 2020).  They were moved because they
#' are also useful outside of the \pkg{future} framework.
#'
#' * [parallelly::as.cluster()]
#' * [parallelly::autoStopCluster()]   (no longer re-exported)
#' * [parallelly::availableCores()]
#' * [parallelly::availableWorkers()]
#' * [parallelly::makeClusterMPI()]    (no longer re-exported)
#' * [parallelly::makeClusterPSOCK()]
#' * [parallelly::makeNodePSOCK()]     (no longer re-exported)
#' * [parallelly::supportsMulticore()]
#' 
#' For backward-compatible reasons, _some_ of these functions remain
#' available as exact copies also from this package (as re-exports), e.g.
#'
#' ```r
#' cl <- parallelly::makeClusterPSOCK(2)
#' ```
#'
#' can still be accessed as:
#'
#' ```r
#' cl <- future::makeClusterPSOCK(2)
#' ```
#'
#' Note that the long-term goal is to remove all of them from this package.
#'
#' For example
#'
#' @importFrom parallelly as.cluster
#' @export as.cluster
#' @aliases as.cluster
#'
#' @importFrom parallelly availableCores
#' @export availableCores
#' @aliases availableCores
#'
#' @importFrom parallelly availableWorkers
#' @export availableWorkers
#' @aliases availableWorkers
#'
#' @importFrom parallelly makeClusterPSOCK
#' @export makeClusterPSOCK
#' @aliases makeClusterPSOCK
#'
#' @importFrom parallelly supportsMulticore
#' @export supportsMulticore
#' @aliases supportsMulticore
#'
#' @name re-exports
NULL
