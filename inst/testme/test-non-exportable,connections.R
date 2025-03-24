#' @tags globals non-exportable
#' @tags detritus-files
#' @tags cluster

library(future)

message("*** Non-exportable globals ...")

options(future.debug = FALSE)
options(future.globals.onReference = "warning")
plan(cluster, workers = 1L)


message("* R connections ...")

## Create a dummy, global connection with a high enough connection index
## such that it won't conflict with an existing connection index on the
## worker. We use sink():s to "pad" with enough connections
tmp_file <- tempfile()
utils::capture.output(utils::capture.output({
  con <- file(tmp_file, open = "wb")
}))
cat("hello\n", file = con)
flush(con)
bfr <- readLines(con = tmp_file)
print(bfr)
stopifnot(bfr == "hello")
message(sprintf("Connection index of dummy 'con' connection: %d\n", as.integer(con)))
stopifnot(as.integer(con) >= 6)


message("- Run-time error")

## Assert we can detect the reference
res <- tryCatch({
  f <- future(cat("world\n", file = con), stdout = NA)
}, FutureWarning = identity)
print(res)
stopifnot(inherits(res, "FutureWarning"),
          grepl("non-exportable reference", conditionMessage(res)))

f <- future({
  max <- max(getAllConnections(), na.rm = TRUE)
  cat(sprintf("Max connection index on worker: %d\n", max))
  if (as.integer(con) <= max) {
    warning(sprintf("TEST ERROR: Index of global 'con' is the same of an existing connection of the worker: %d in [0,%d]", as.integer(con), max))
  }
  cat("world\n", file = con)
})
res <- tryCatch({
  v <- value(f)
}, error = identity)
print(res)
stopifnot(inherits(res, "error"))
## Nothing changed
bfr <- readLines(con = tmp_file)
print(bfr)
stopifnot(bfr == "hello")

close(con)
file.remove(tmp_file)

message("* R connections ... DONE")


message("*** Non-exportable globals ... DONE")

