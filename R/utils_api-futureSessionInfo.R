#' Get future-specific session information and validate current backend
#'
#' @param test If TRUE, one or more futures are created to query workers
#' and validate their information.
#'
#' @param anonymize If TRUE, user names and host names are anonymized.
#'
#' @return Nothing.
#'
#' @example incl/futureSessionInfo.R
#'
#' @export
futureSessionInfo <- function(test = TRUE, anonymize = TRUE) {
  mprint0 <- function(...) mprint(..., prefix = NULL, debug = TRUE)
  mprintf0 <- function(...) mdebugf(..., prefix = NULL, debug = TRUE)   
  mstr0 <- function(...) mstr(..., prefix = NULL, debug = TRUE)
  
  message("*** Package versions")
  p <- c("future", "parallelly", "parallel", "globals", "listenv")
  v <- vapply(p, FUN = function(pkg) {
    as.character(packageVersion(pkg))
  }, FUN.VALUE = NA_character_)
  message(comma(sprintf("%s %s", p, v)))
  message()

  message("*** Allocations")
  message("availableCores():")
  mprint0(availableCores(which = "all"))

  message("availableWorkers():")
  workers <- availableWorkers(which = "all")
  workers <- workers[sapply(workers, FUN = length) > 0]
  mprint0(workers)
  message()

  message("*** Settings")
  names <- c(
    "future.plan",
    "future.fork.multithreading.enable",
    "future.globals.maxSize",
    "future.globals.onReference",
    "future.resolve.recursive",
    "future.rng.onMisuse",
    "future.wait.timeout",
    "future.wait.interval",
    "future.wait.alpha",
    "future.startup.script"
  )    
  for (name in names) {
    value <- getOption(name)
    if (is.character(value)) value <- sQuote(value)
    if (is.null(value)) value <- "<not set>"
    mprintf0("- %s=%s", name, value)
  }
  message()
  
  message("*** Backends")
  msgf("Number of workers: %d\n", nbrOfWorkers())
  mprint0(plan("list"))
  message()

  message("*** Basic tests")
  if (test) {
    anonymize_info <- function(vs) {
      map <- list(
        host = c("nodename"),
        user = c("login", "user", "effective_user")
      )

      for (prefix in names(map)) {
        fields <- map[[prefix]]
        mvalues <- Sys.info()[fields]  ## values in main R session
        uvalues <- unlist(vs[, fields], use.names = FALSE)
        uvalues <- sort(unique(c(mvalues, uvalues)))
        avalues <- sprintf("%s%03d", prefix, seq_along(uvalues))
        names(avalues) <- uvalues
        for (value in names(avalues)) {
          for (field in fields) {
            idxs <- which(vs[[field]] == value)
            vs[[field]][idxs] <- avalues[value]
          }
        }
      }
      vs
    } ## anonymize_info()

    ## Information on the main R session
    vs <- data.frame(
      pid    = Sys.getpid(),
      r      = getRversion(),
      as.list(Sys.info())
    )
    if (anonymize) vs <- anonymize_info(vs)
    message("Main R session details:")
    mprint0(vs)

    delay <- getOption("future.futureSessionInfo.delay", 1.0)  ## seconds

    ## Information on the workers
    fs <- list()
    for (ii in seq_len(nbrOfWorkers())) {
      fs[[ii]] <- future({
        Sys.sleep(delay)
        data.frame(
          worker = ii,
          pid    = Sys.getpid(),
          r      = getRversion(),
          as.list(Sys.info())
        )
      }, label = sprintf("futureSessionInfo-%d", ii))
    }
    vs <- value(fs)
    vs <- do.call(rbind, vs)
    rownames(vs) <- NULL

    if (anonymize) vs <- anonymize_info(vs)

    message("Worker R session details:")
    mprint0(vs)
    
    npid <- length(unique(vs[["pid"]]))
    if (npid == nbrOfWorkers()) {
      mprintf0("Number of unique worker PIDs: %d (as expected)", npid)
    } else {
      mprintf0("WARNING: Number of unique worker PIDs does not match number expected workers: %d != %d", npid, nbrOfWorkers())
    }
  }
  
  invisible()
}
