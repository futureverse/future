deprecateArgument <- function(fcn, name, value) {
  fcn <- match.arg(fcn, choices = c("future", "plan", "resolved"))
  option <- sprintf("future.%s.%s", fcn, name)
  action <- getOption(option, "deprecated")
  action <- match.arg(action, choices = c("deprecated", "defunct", "ignore"))
  if (action == "ignore") return()
  dfcn <- if (action == "deprecated") .Deprecated else .Defunct
  msg <- sprintf("future::%s() no longer takes argument '%s'. Attempts to use will eventually be ignored and then become an error: %s = %s", fcn, name, name, deparse(value)[1])

  calls <- sys.calls()
  for (kk in seq_along(calls)) {
    call <- calls[[kk]]
    if (is.language(call) && identical(call[[1]], as.symbol(fcn))) {
      calls <- calls[seq_len(kk)]
      break
    }
  }

  for (kk in seq_along(calls)) {
    call <- calls[[kk]]
    if (kk < length(calls)) call <- call[1]
    call <- deparse(call)
    calls[[kk]] <- call
  }
  calls <- paste(calls, collapse = " -> ")
  msg <- sprintf("%s [%s]", msg, calls)
  
  dfcn(msg = msg)
}
