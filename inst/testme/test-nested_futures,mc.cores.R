#' @tags nested-futures
#' @tags listenv
#' @tags detritus-files
#' @tags sequential multisession multicore

library(future)
library(listenv)
options(future.debug = FALSE)

## WORKAROUND: R CMD check --as-cran on Windows will report
## 
## * checking for detritus in the temp directory ... NOTE
## Found the following files/directories:
##  'Rscript171866c62e
##
## which I think is due to a bug in R. For details, see R-devel thread 
## 'R for Windows leaves detritus in the temp directory' on 2021-06-15
## <https://stat.ethz.ch/pipermail/r-devel/2021-June/080830.html>.
## Until fixed, we skip the one test that triggers this bug.
winWorkaround <- (.Platform$OS.type == "windows" && getRversion() >= "4.0.0")

message("*** Nested futures - mc.cores ...")

strategies <- NULL
if (!covr_testing) strategies <- c(strategies, "multisession")
if (supportsMulticore()) strategies <- c(strategies, "multicore")

pid <- Sys.getpid()
cat(sprintf("Main PID: %d\n", pid))

cat("Available cores on this machine:\n")
cores <- availableCores()
print(cores)

for (mc in 1:2) {
  message(sprintf("- mc.cores = %d ...", mc))
  options(mc.cores = mc)
  mc2 <- min(mc, cores)
  
  for (strategy in strategies) {
    message(sprintf("plan(list('sequential', '%s')):", strategy))
    plan(list('sequential', strategy))
    message("Number of workers: ", nbrOfWorkers())
    
    a %<-% {
      b1 %<-% Sys.getpid()
      b2 %<-% Sys.getpid()
      list(
        pid = Sys.getpid(),
        mc = mc,
        mc2 = mc2,
        mc.cores = getOption("mc.cores"),
        cores = availableCores(),
        plan = plan("list"),
        nbrOfWorkers = nbrOfWorkers(),
        pid1 = b1,
        pid2 = b2
      )
    }
    utils::str(a)
    
    ## First layer is 'sequential', so the PID should be the
    ## same as in the main R session
    stopifnot(
      identical(a$mc.cores, mc),
      a$pid == pid
    )

    ## Number of workers should be the same as number of cores
    stopifnot(a$nbrOfWorkers == a$cores)

    ## Is 'sequential' used as a fallback for the nested parallel backend?
    if (a$cores == 1) {
      stopifnot(
        a$pid1 == pid,
        a$pid2 == pid
      )
    } else {
      stopifnot(
        a$pid1 != pid,
        a$pid2 != pid,
        a$pid2 != a$pid1
      )
    }
    
    if (mc == 1L) {
      message(sprintf("plan(list('sequential', '%s':2)):", strategy))
      plan(list('sequential', tweak(strategy, workers = I(2))))
      message("Number of workers: ", nbrOfWorkers())
      
      a %<-% {
        b1 %<-% Sys.getpid()
        b2 %<-% Sys.getpid()
        list(
          pid = Sys.getpid(),
          mc = mc,
          mc2 = mc2,
          mc.cores = getOption("mc.cores"),
          cores = availableCores(),
          plan = plan("list"),
          nbrOfWorkers = nbrOfWorkers(),
          pid1 = b1,
          pid2 = b2
        )
      }
      
      utils::str(a)

      ## First layer is 'sequential', so the PID should be the
      ## same as in the main R session
      stopifnot(
        identical(a$mc.cores, mc),
        a$pid == pid
      )
  
      ## Second layer is forced to *not* fall back to sequential
      stopifnot(
        a$cores == 1L,
        a$nbrOfWorkers == 2L,
        a$pid1 != pid,
        a$pid2 != pid,
        a$pid2 != a$pid1
      )
    } ## if (mc == 1L)


    message(sprintf("plan(list('%s', 'sequential')):", strategy))
    plan(list(strategy, 'sequential'))
    message("Number of workers: ", nbrOfWorkers())
    
    a %<-% {
      b1 %<-% Sys.getpid()
      b2 %<-% Sys.getpid()
      list(
        pid = Sys.getpid(),
        mc = mc,
        mc2 = mc2,
        mc.cores = getOption("mc.cores"),
        cores = availableCores(),
        plan = plan("list"),
        nbrOfWorkers = nbrOfWorkers(),
        pid1 = b1,
        pid2 = b2
      )
    }
    utils::str(a)

    ## Was 'sequential' used as a fallback for the first layer?
    if (availableCores() == 1L) {
      stopifnot(
        a$pid == pid
      )
    } else {
      stopifnot(
        a$pid != pid
      )
    }
    
    stopifnot(
      a$nbrOfWorkers == 1L,
      a$pid1 == a$pid,
      a$pid2 == a$pid,
      a$pid2 == a$pid1
    )


    message(sprintf("plan(list('%s', '%s')):", strategy, strategy))
    plan(list(strategy, strategy))
    message("Number of workers: ", nbrOfWorkers())
    
    a %<-% {
      b1 %<-% { Sys.sleep(0.2); Sys.getpid() }
      b2 %<-% Sys.getpid()
      list(
        pid = Sys.getpid(),
        mc = mc,
        mc2 = mc2,
        mc.cores = getOption("mc.cores"),
        cores = availableCores(),
        plan = plan("list"),
        nbrOfWorkers = nbrOfWorkers(),
        pid1 = b1,
        pid2 = b2
      )
    }
    utils::str(a)

    ## Was 'sequential' used as a fallback for the first layer?
    if (availableCores() == 1L) {
      stopifnot(
        nbrOfWorkers() == 1L,
        a$pid == pid
      )
    } else {
      stopifnot(
        nbrOfWorkers() == mc,
        a$pid != pid
      )
    }

    ## Make sure 'sequential' was used as a fallback for the second layer
    stopifnot(
      a$nbrOfWorkers == 1L,
      a$pid1 == a$pid,
      a$pid1 == a$pid,
      a$pid2 == a$pid1
    )

    if (mc == 1L && !winWorkaround) {
      message(sprintf("plan(list('%s':2, '%s':2)):", strategy, strategy))
      plan(list(tweak(strategy, workers = I(2)), tweak(strategy, workers = I(2))))
      message("Number of workers: ", nbrOfWorkers())
      
      a %<-% {
        b1 %<-% Sys.getpid()  ## This stalls
        b2 %<-% Sys.getpid()
        list(
          pid = Sys.getpid(),
          mc = mc,
          mc2 = mc2,
          mc.cores = getOption("mc.cores"),
          cores = availableCores(),
          plan = plan("list"),
          nbrOfWorkers = nbrOfWorkers(),
          pid1 = b1,
          pid2 = b2
        )
      }
      utils::str(a)

      ## First layer is forced to *not* fall back to sequential
      stopifnot(
        nbrOfWorkers() == 2L,
        a$pid != pid
      )
  
      ## Second layer is forced to *not* fall back to sequential
      stopifnot(
        a$cores == 1L,
        a$nbrOfWorkers == 2L,
        a$pid1 != pid,
        a$pid2 != pid,
        a$pid2 != a$pid1
      )
    }

    ## Assert that nested the FutureRegistry is not inherited when using
    ## nested strategies, particularly 'multicore'.
    ## https://github.com/futureverse/future/issues/231
    fs <- lapply(1:2, FUN = function(i) future( value(future(TRUE)) ))
    v <- value(fs)
  } ## for (strategy ...)

  message(sprintf(" - mc.cores = %d ... DONE", mc))
} ## for (mc ...)

message("*** Nested futures - mc.cores ... DONE")

