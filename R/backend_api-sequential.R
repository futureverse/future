#' Create a sequential future whose value will be in the current \R session
#'
#' A sequential future is a future that is evaluated sequentially in the
#' current \R session similarly to how \R expressions are evaluated in \R.
#' The only difference to \R itself is that globals are validated
#' by default just as for all other types of futures in this package.
#'
#' @details
#' This function is _not_ meant to be called directly.  Instead, the
#' typical usages are:
#'
#' ```r
#' # Evaluate futures sequentially in the current R process
#' plan(sequential)
#' ```
#'
#' @inheritParams future
#' @inheritParams Future-class
#' 
#' @return
#' A [SequentialFuture].
#'
#' @example incl/sequential.R
#'
#' @aliases uniprocess
#' @export
sequential <- function(..., envir = parent.frame()) {
  future <- SequentialFuture(..., envir = envir)
  if (!future$lazy) future <- run(future)
  invisible(future)
}
class(sequential) <- c("sequential", "uniprocess", "future", "function")
