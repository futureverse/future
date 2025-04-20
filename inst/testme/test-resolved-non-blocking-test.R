#' @tags resolved
#' @tags sequential multisession multicore
#' @tags skip_on_cran

library(future)
options(future.debug = FALSE)

## Don't poll too frequently in order for these tests to not fail
options(future.wait.interval = 0.1)

message("*** resolved() - assert non-blocking while launching lazy futures ...")

for (cores in 1:availCores) {
  message(sprintf("Testing with %d cores ...", cores))
  options(mc.cores = cores)

  strategies <- supportedStrategies(cores)
  print(strategies)
  
  for (strategy in strategies) {
    message(sprintf("- plan('%s') with cores=%d ...", strategy, cores))
    plan(strategy)

    ## This test requires that all workers are free when tests start
    resetWorkers(plan())
  
    message("Creating lazy futures:")
    xs <- as.list(1:3)
    fs <- lapply(xs, FUN = function(kk) {
      future({
        Sys.sleep(kk/2)
        kk
      }, lazy = TRUE)
    })
    vs <- vector("list", length = length(fs))
    ss <- vapply(fs, FUN = function(f) f[["state"]], NA_character_)
    print(ss)
    stopifnot(all(ss == "created"))
    
    rs <- rep(NA, times = length(fs))
    for (ff in seq_along(fs)) {
      for (kk in ff:length(fs)) {
        message(sprintf("Checking if future #%d is resolved:", kk))
        rs[[kk]] <- resolved(fs[[kk]])
        ss <- vapply(fs, FUN = function(f) f[["state"]], NA_character_)
        print(ss)
        if (inherits(fs[[kk]], "UniprocessFuture")) {
          ## All sequential futures were resolved when created
          stopifnot(rs[[kk]])
          stopifnot(ss[[kk]] == "finished")
        } else {
          ## Because of timing issues, we cannot no know for sure in
          ## what state non-sequential future are at this point in time
        }
      } ## for (kk ...)
    
      message(sprintf("Waiting for future #%d to finish ... ", ff), appendLF = FALSE)
      vs[[ff]] <- value(fs[[ff]])
      message("done")
    
      rs[[ff]] <- resolved(fs[[ff]])
      stopifnot(rs[ff])
    
      ss <- vapply(fs, FUN = function(f) f[["state"]], NA_character_)
      stopifnot(ss[ff] == "finished")
      nbrOfFinished <- sum(ss == "finished")
      if (inherits(fs[[kk]], "UniprocessFuture")) {
        ## All sequential futures were resolved when created
        stopifnot(nbrOfFinished == length(fs))
      } else {
        stopifnot(nbrOfFinished == ff)
      }
    } ## for (ff ...)
    
    ss <- vapply(fs, FUN = function(f) f[["state"]], NA_character_)
    print(ss)
    stopifnot(all(ss == "finished"))
    
    message("Collecting values:")
    vs <- value(fs)
    str(vs)
    stopifnot(identical(vs, xs))
  
    message(sprintf("- plan('%s') with cores=%d ... DONE", strategy, cores))
  } ## for (strategy ...)

  message(sprintf("Testing with %d cores ... DONE", cores))
} ## for (cores ...)

message("*** resolved() - assert non-blocking while launching lazy futures ... DONE")

