#' @tags result sequential

library(future)

plan(sequential)

message("*** result() ...")

## A resolved future gives a FutureResult
f <- future(42L)
v <- value(f)
res <- result(f)
stopifnot(inherits(res, "FutureResult"))
stopifnot(identical(res[["value"]], 42L))

## Asking again returns the already collected result
res2 <- result(f)
stopifnot(inherits(res2, "FutureResult"))
stopifnot(identical(res2[["value"]], 42L))

## A lazy future that has not been launched is run by result()
f <- future(6L * 7L, lazy = TRUE)
stopifnot(identical(f[["state"]], "created"))
res <- result(f)
stopifnot(inherits(res, "FutureResult"))
stopifnot(identical(res[["value"]], 42L))

## A future that produced an error still gives a FutureResult, holding
## the condition
f <- future(stop("boom"))
res <- result(f)
stopifnot(inherits(res, "FutureResult"))
conds <- res[["conditions"]]
stopifnot(length(conds) > 0L)
classes <- vapply(conds, FUN = function(c) class(c[["condition"]])[1],
                  FUN.VALUE = NA_character_)
stopifnot(any(grepl("Error", classes)))

message("*** result() ... DONE")


message("*** result() - with debug output ...")

local({
  oopts <- options(future.debug = TRUE)
  on.exit(options(oopts))
  f <- future(42L)
  res <- result(f)
  stopifnot(inherits(res, "FutureResult"))
})

message("*** result() - with debug output ... DONE")


message("*** result() - with journal ...")

local({
  oopts <- options(future.journal = TRUE)
  on.exit(options(oopts))

  f <- future(42L)
  stopifnot(inherits(f[[".journal"]], "FutureJournal"))

  ## Collecting the result appends a 'gather' event to the journal
  res <- result(f)
  stopifnot(inherits(res, "FutureResult"))
  j <- f[[".journal"]]
  stopifnot(inherits(j, "FutureJournal"))
  stopifnot("gather" %in% j[["event"]])

  ## The journal condition is only signalled once, which is recorded on the
  ## future itself
  stopifnot(isTRUE(f[[".journal_signalled"]]))

  ## Asking again still works, and does not signal again
  res <- result(f)
  stopifnot(inherits(res, "FutureResult"))
  stopifnot(isTRUE(f[[".journal_signalled"]]))
})

message("*** result() - with journal ... DONE")
