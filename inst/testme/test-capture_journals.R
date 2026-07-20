#' @tags journals
#' @tags sequential
#' @tags multisession
#' @tags multicore

library(future)
capture_journals <- future:::capture_journals

options(future.debug = FALSE)

strategies <- c("sequential", "multisession")
if (future::supportsMulticore()) {
  strategies <- c(strategies, "multicore")
}

message("*** capture_journals() w/ summary() ...")

options(future.journal = TRUE)

set.seed(42)
xs <- rnorm(1e7)  ## emulate export overhead

for (strategy in strategies) {
  message(sprintf("- strategy: %s ...", strategy))
  plan(strategy)
  
  js <- capture_journals({
    fs <- lapply(5:1, FUN = function(x) future({
      Sys.sleep(0.3) ## emulate processing time
      sum(xs)
    }))
    vs <- value(fs)
  })
  
  stopifnot(
    is.list(js),
    all(vapply(js, FUN = is.data.frame, FUN.VALUE = NA))
  )
  
  js_combined <- do.call(rbind, js)
  print(js_combined)
  
  stats <- summary(js_combined)
  print(stats)
  
  stopifnot(
    inherits(stats, "FutureJournalSummary"),
    attr(stats, "nbr_of_futures") == 5L,
    attr(stats, "workers") >= 1L,
    attr(stats, "workers_used") >= 1L
  )

  ## Shut down parallel workers
  plan(sequential)

  message(sprintf("- strategy: %s ... done", strategy))
}

message("*** capture_journals() w/ summary() ... done")
