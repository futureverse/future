#' @tags multisession
#' @tags connections worker-termination
#' @tags detritus-files

library(future)
options(future.debug = FALSE)

message("*** multisession - connections must not leak when futures error ...")

if (.Platform[["OS.type"]] == "windows") {
  ## This test takes very long to run on MS Windows (e.g. 5-10 minutes on
  ## win-builder).
  message("*** multisession - connections must not leak when futures error ... SKIPPED on MS Windows")
} else if (isTRUE(as.logical(Sys.getenv("R_COVR", "false")))) {
  ## Under covr, the many short-lived workers each write a coverage trace
  ## file on exit, which is slow and can leave truncated files behind
  ## causing covr::package_coverage() to fail when merging them
  message("*** multisession - connections must not leak when futures error ... SKIPPED when running covr")
} else {

  get_connections <- future:::get_connections
  diff_connections <- future:::diff_connections

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

}
