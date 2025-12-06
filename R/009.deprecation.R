deprecateArgument <- function(fcn, name, value) {
  fcn <- match.arg(fcn, choices = c("future", "plan"))
  option <- sprintf("future.%s.%s", fcn, name)
  action <- getOption(option, "deprecated")
  action <- match.arg(action, choices = c("deprecated", "defunct", "ignore"))
  if (action == "ignore") return()
  dfcn <- if (action == "deprecated") .Deprecated else .Defunct
  msg <- sprintf("future::%s() no longer takes argument '%s'. Attempts to use will eventually be ignored and then become an error: %s = %s", fcn, name, name, deparse(value)[1])
  dfcn(msg = msg)
}
