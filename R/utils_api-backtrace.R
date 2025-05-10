#' Back trace the expressions evaluated when an error was caught
#'
#' @param future A future with a caught error.
#'
#' @param envir the environment where to locate the future.
#'
#' @param \ldots Not used.
#'
#' @return A list with the future's call stack that led up to the error.
#'
#' @examples
#' my_log <- function(x) log(x)
#' foo <- function(...) my_log(...)
#' 
#' f <- future({ foo("a") })
#' res <- tryCatch({
#'   v <- value(f)
#' }, error = function(ex) {
#'   t <- backtrace(f)
#'   print(t)
#' })
#' \dontshow{
#' ## R CMD check: make sure any open connections are closed afterward
#' plan(sequential)
#' }
#'
#' @export
backtrace <- function(future, envir = parent.frame(), ...) {
  ## Argument 'expr':
  expr <- substitute(future)

  if (!is.null(expr)) {
    future <- tryCatch({
      target <- parse_env_subset(expr, envir = envir, substitute = FALSE)
      get_future(target, mustExist = TRUE)
    }, error = function(ex) {
      eval(expr, envir = envir, enclos = baseenv())
    })
    stop_if_not(inherits(future, "Future"))    
  }

  if (!resolved(future)) {
    stopf("No error has been caught because the future is unresolved: %s", sQuote(expr))
  }

  result <- result(future)
  conditions <- result[["conditions"]]
  
  ## Find 'error' condition
  error <- NULL
  for (kk in seq_along(conditions)) {
    c <- conditions[[kk]]
    if (inherits(c[["condition"]], "error")) {
      error <- c
      break
    }
  }

  if (is.null(error)) {
    stopf("No error was caught for this future: %s", sQuote(expr))
  }

  calls <- error[["calls"]]

  if (is.null(calls)) {
    stopf("The error call stack was not recorded for this future: %s", sQuote(expr))
  }

  ## Recreate the full call stack
  calls <- c(future[["calls"]], calls)
  
  calls
} ## backtrace()
