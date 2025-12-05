deprecateFutureArgument <- function(name, value) {
  option <- sprintf("future.future.%s", name)
  action <- getOption(option, "deprecated")
  action <- match.arg(action, choices = c("deprecated", "defunct", "ignore"))
  if (action == "ignore") return()
  dfcn <- if (action == "deprecated") .Deprecated else .Defunct
  dfcn(msg = sprintf("future() no longer takes argument '%s'. Attempts to use it is ignored, but will eventually become an error: %s = %s", name, name, deparse(value)[1]))
}

