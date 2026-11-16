#' @tags connections
#' @tags misuse
#' @tags sequential multisession

library(future)

options(future.debug = FALSE)

message("*** Run-time errors with future.connections.onMisuse = 'ignore' ...")

oopts <- options(future.connections.onMisuse = "ignore")

strategies <- c("sequential")
if (parallelly::availableCores() >= 2L) strategies <- c(strategies, "multisession")

for (strategy in strategies) {
  message(sprintf("- plan('%s')", strategy))
  if (strategy == "sequential") plan(sequential) else plan(strategy, workers = 2L)

  message("  - a successful future")
  f <- future(42)
  v <- value(f)
  stopifnot(identical(v, 42))
  r <- result(f)
  stopifnot(is.null(r[["misuseConnections"]]))

  message("  - a future that produces an error")
  res <- tryCatch({
    f <- future(stop("boom"))
    value(f)
  }, error = identity)
  print(res)
  stopifnot(
    inherits(res, "error"),
    !inherits(res, "FutureError"),
    identical(conditionMessage(res), "boom")
  )
  r <- result(f)
  stopifnot(
    inherits(r, "FutureResult"),
    is.null(r[["misuseConnections"]])
  )
}

plan(sequential)
options(oopts)

message("*** Run-time errors with future.connections.onMisuse = 'ignore' ... DONE")
