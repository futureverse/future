#' @tags utils-internal session_uuid

library(future)
session_uuid <- future:::session_uuid

message("*** session_uuid() ...")

id0 <- session_uuid()
print(id0)

## Reset session UUID (hack)
environment(session_uuid)$uuids <- list()

id <- session_uuid()
print(id)
stopifnot(id != id0)

## Assert that forked child processes get a unique session id
## Issue: https://github.com/futureverse/future/issues/187
if (supportsMulticore()) {
  plan(multicore, workers = 2L)
  fs <- lapply(1:2, FUN = function(i) {
    future({
      session_uuid()
    })
  })
  ids <- unlist(value(fs))
  print(ids)
  stopifnot(all(ids != id), length(unique(ids)) == 2L)
}

message("*** session_uuid() ... DONE")

