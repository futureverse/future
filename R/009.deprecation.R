deprecateFutureArgument <- function(name, value) {
  option <- sprintf("future.future.%s", name)
  action <- getOption(option, "deprecated")
  action <- match.arg(action, choices = c("deprecated", "defunct", "ignore"))
  if (action == "ignore") return()
  dfcn <- if (action == "deprecated") .Deprecated else .Defunct
  dfcn(msg = sprintf("future::future() no longer takes argument '%s'. Attempts to use will eventually be ignored and then become an error: %s = %s", name, name, deparse(value)[1]))
}


deprecatePlanArgument <- function(name, value) {
  option <- sprintf("future.plan.%s", name)
  action <- getOption(option, "deprecated")
  action <- match.arg(action, choices = c("deprecated", "defunct", "ignore"))
  if (action == "ignore") return()
  dfcn <- if (action == "deprecated") .Deprecated else .Defunct
  dfcn(msg = sprintf("future::plan() no longer takes argument '%s'. Attempts to use will eventually be ignored and then become an error: %s = %s", name, name, deparse(value)[1]))
}

