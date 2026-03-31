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
#' * [parallelly::availableCores()]
#    Used by: ale (1), BatchGetSymbols (2), codalm (1), cft (1),
#             couplr (2), deseats, dipsaus (1), elevatr (1), heterogen,
#             PINstimation (1), powRICLPM (1), readsdr (1), recforest,
#             sigminer (2), skpr (1), smoots, sovereign (1),
#             TriDimRegression (1), uci (1) [2025-12-22, 2026-01-31]
#' * [parallelly::availableWorkers()]
#    Used by: wqspt (1) [2025-03-15]
#' * [parallelly::makeClusterPSOCK()]
#    Used by: eatRep (1), interflex (1), ivDiag (1) [2025-12-11]
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
#' @name re-exports
#' @keywords internal
NULL
