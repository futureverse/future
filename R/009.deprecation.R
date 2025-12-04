deprecate_future_earlySignal <- function(earlySignal) {
  action <- getOption("future.future.earlySignal", "deprecated")
  dfcn <- if (action == "deprecated") .Deprecated else .Defunct
  dfcn(msg = sprintf("future() no longer takes argument 'earlySignal'. Attempts to use it is ignored, but will eventually become an error: earlySignal = %s", deparse(earlySignal)[1]))
}

