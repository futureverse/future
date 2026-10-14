#' @tags multisession
#' @tags connections worker-termination

library(future)
options(future.debug = FALSE)

get_connections <- future:::get_connections
diff_connections <- future:::diff_connections

message("*** multisession - connections must not leak when futures error ...")

fn <- function() {
  fs <- vector("list", length = 10L)
  for (ii in seq_along(fs)) {
    fs[[ii]] <- future(stop("boom"))
  }
  value(fs)
}

leaked <- list()
out_of_sync <- list()

for (kk in 1:25) {
  message(sprintf("Iteration #%d ...", kk))

  cons_before <- get_connections()
  plan(multisession, workers = 2L)
  tryCatch(fn(), error = identity)
  withCallingHandlers({
    plan(sequential)
  }, FutureWarning = function(w) {
    if (grepl("out of sync", conditionMessage(w), fixed = TRUE)) {
      out_of_sync[[length(out_of_sync) + 1L]] <- w
    }
    invokeRestart("muffleWarning")
  })
  cons_after <- get_connections()

  delta <- diff_connections(cons_after, cons_before)
  if (length(delta[["added"]]) > 0L) {
    message(sprintf("Stray connection(s) left open after iteration #%d:", kk))
    print(delta[["added"]])
    leaked[[length(leaked) + 1L]] <- delta[["added"]]

    ## Close all
    for (idx in delta[["added"]][["index"]]) {
      tryCatch(close(getConnection(idx)), error = identity)
    }
  }

  message(sprintf("Iteration #%d ... done", kk))
}

stopifnot(length(out_of_sync) == 0L)
stopifnot(length(leaked) == 0L)

message("*** multisession - connections must not leak when futures error ... DONE")
