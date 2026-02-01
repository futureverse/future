#' Functions Moved to 'parallelly'
#'
#' The following function used to be part of \pkg{future}, but has since
#' been migrated to \pkg{parallelly}. The migration started with
#' \pkg{future} 1.20.0 (November 2020). They were moved because they
#' are also useful outside of the \pkg{future} framework.
#'
#' _If you are using any of these from the \pkg{future} package, please
#'  switch to use the ones from the \pkg{parallelly} package. Thank you!_
#'
#' * [parallelly::as.cluster()]    (no longer re-exported)
#    Used by: <none>
#' * [parallelly::autoStopCluster()]   (no longer re-exported)
#    Used by: <none>
#' * [parallelly::availableCores()]
#    Used by: ale (1), BatchGetSymbols (1), bistablehistory (1), codalm (1),
#             cft (1), couplr (1), deseats, dipsaus (1), drimmR (1),
#             elevatr (1), GetBCBData (1), gtfs2emis (1), gtfs2gps (1),
#             heterogen, ldaPrototype (1), PINstimation (1), powRICLPM (1),
#             rBiasCorrection (1), readsdr (1), recforest, sigminer (2),
#             skpr (1), smoots, sovereign (1), TriDimRegression (1),
#             uci (1), updog (1), whitewater (1), yfR (1) [2025-12-22]
#' * [parallelly::availableWorkers()]
#    Used by: wqspt (1) [2025-03-15]
#' * [parallelly::makeClusterMPI()]    (no longer re-exported)
#    Used by: <none>
#' * [parallelly::makeClusterPSOCK()]
#    Used by: eatRep (1), interflex (1), ivDiag (1) [2025-12-11]
#' * [parallelly::makeNodePSOCK()]     (no longer re-exported)
#    Used by: <none>
#' * [parallelly::supportsMulticore()]
#    Used by: furrr(2)
#
#  (1) Issue filed or PR sent
#  (2) In the next release
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
#' _Note that it is the goal to remove all of the above from this package._
#'
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
#' @keywords internal
NULL
