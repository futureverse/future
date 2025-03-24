#' @tags multithreading
#' @tags multicore

library(future)

plan(multicore)

message("*** multicore() and multi-threading ...")

message("supportsMulticore(): ", sQuote(supportsMulticore()))
message("availableCores('multicore'): ", sQuote(availableCores("multicore")))
message("supports_omp_threads(): ", sQuote(supports_omp_threads()))

if (requireNamespace("RhpcBLASctl", quietly = TRUE)) {
  message("Checking RhpcBLASctl capabilities ...")
  nthreads_0 <- RhpcBLASctl::omp_get_max_threads()
  utils::str(list(nthreads_0 = nthreads_0))
  message("- Number of OpenMP threads: ", sQuote(nthreads_0))
  
  message("- Trying to set number of OpenMP threads to one")
  try(RhpcBLASctl::omp_set_num_threads(1L))
  nthreads_1 <- RhpcBLASctl::omp_get_max_threads()
  utils::str(list(nthreads_1 = nthreads_1))
  message("  - Number of OpenMP threads: ", sQuote(nthreads_1))
  try(RhpcBLASctl::omp_set_num_threads(nthreads_0))

  f <- future(RhpcBLASctl::omp_get_max_threads())
  nthreads_child <- value(f)
  utils::str(list(nthreads_child = nthreads_child))
  message(sprintf("  - Number of OpenMP threads in %s future: %s", sQuote(class(f)[1]), sQuote(nthreads_child)))

  nthreads_children <- parallel::mclapply(1:2, FUN = function(x) {
    RhpcBLASctl::omp_get_max_threads()
  })
  utils::str(list(nthreads_children = nthreads_children))
  message("  - Number of OpenMP threads in mclapply(): ", sQuote(nthreads_children[[1]]))

  message("- Trying to reset number of OpenMP threads")
  nthreads_2 <- RhpcBLASctl::omp_get_max_threads()
  utils::str(list(nthreads_2 = nthreads_2))
  message("  - Number of OpenMP threads: ", sQuote(nthreads_2))
  stopifnot(identical(nthreads_2, nthreads_0))
  message("Checking RhpcBLASctl capabilities ... done")
}

if (supportsMulticore() && availableCores("multicore") >= 2L && supports_omp_threads()) {
  nthreads_0 <- RhpcBLASctl::omp_get_max_threads()
  
  for (enable in c(TRUE, FALSE)) {
    options(future.fork.multithreading.enable = enable)

    message(sprintf("'future.fork.multithreading.enable' = %s ...", enable))

    f <- future(list(nthreads = RhpcBLASctl::omp_get_max_threads()))
    nthreads <- value(f)$nthreads
    cat(sprintf("Number of OpenMP threads in %s future: %d\n", sQuote(class(f)[1]), nthreads))

    ## Assert that single-threading was set?
    if (enable) {
      stopifnot(enable && nthreads >= nthreads_0)
    } else {
      ## FIXME: On CRAN r-devel-linux-x86_64-fedora-clang (2020-01-17):
      ## Number of OpenMP threads in 'MulticoreFuture' future: 24
      ## Error: !enable && nthreads == 1L is not TRUE
      stopifnot(!enable && nthreads == 1L)
    }
      
    message(sprintf("'future.fork.multithreading.enable' = %s ... DONE", enable))
  } ## for (enable ...)
} ## if (requireNamespace("RhpcBLASctl", ...)) {

message("*** multicore() and multi-threading ... DONE")

