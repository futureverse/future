#' Evaluate an R expression while collecting journals from completed futures
#' 
#' @param expr The R expression to evaluate
#'
#' @param substitute If TRUE, then `expr` is subtituted, otherwise not.
#'
#' @param envir The environment where `expr` should be evaluated
#'
#' @details
#' This function evaluates an R expression and capture the journals
#' signaled by futures as they are completed. A future [journal] comprise
#' a log of events appearing during the life-span of a future, e.g.
#' the timestamps when the future was created, launched, queried,
#' resolved, and its results are collected.
#'
#' @return
#' A list of \link[=journal]{FutureJournal}:s.
#'
#' @example incl/capture_journals.R
#'
#' @keywords internal
#' @noRd
capture_journals <- function(expr, substitute = TRUE, envir = parent.frame()) {
  oopts <- options(future.journal = TRUE)
  on.exit(options(oopts))
  
  journals <- NULL
  withCallingHandlers({
    eval(expr, envir = envir)
  }, FutureJournalCondition = function(cond) {
    journals <<- c(journals, list(cond[["journal"]]))
  })
  
  journals
}
