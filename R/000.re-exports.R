#' Functions Moved to 'parallelly'
#'
#' The following function used to be part of \pkg{future} but has since
#' been migrated to \pkg{parallelly}.  The migration started with
#' \pkg{future} 1.20.0 (November 2020).  They were moved because they
#' are also useful outside of the \pkg{future} framework.
#'
#' * [parallelly::as.cluster()]
#    Used by: googleComputeEngineR(1)
#' * [parallelly::autoStopCluster()]   (no longer re-exported)
#    Used by: <none>
#' * [parallelly::availableCores()]
#    Used by: aroma.affymetrix(1,2), ARPALData, BatchGetSymbols,
#             bistablehistory, codalm, crossmap, cft, CSCNet, deseats,
#             dipsaus, drimmR, elevatr, foieGras(3), future.BatchJobs(3),
#             future.callr, GetBCBData, gtfs2emis, heterogen, isoreader,
#             ItemResponseTrees, ldaPrototype, lidR, meedr, microservices,
#             microsynth, origami, PINstimation, powRICLPM, rBiasCorrection,
#             readsdr, recforest, rkeops, sigminer, skpr, smoots, sovereign,
#             TriDimRegression, uci, updog, whitewater, yfR
#' * [parallelly::availableWorkers()]
#    Used by: aroma.affymetrix(1,2), wqspt(1)
#' * [parallelly::makeClusterMPI()]    (no longer re-exported)
#    Used by: <none>
#' * [parallelly::makeClusterPSOCK()]
#    Used by: bigDM(1), eatRep, fect, foieGras(3), googleComputeEngineR(1),
#             gsynth, interflex, ivDiag
#' * [parallelly::makeNodePSOCK()]     (no longer re-exported)
#    Used by: <none>
#' * [parallelly::supportsMulticore()]
#    Used by: crossmap, dhReg, furrr(1), microservices, sctransform
#
#  (1) PR sent
#  (2) Non-breaking; code is never run
#  (3) No longer on CRAN
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
