.package <- new.env()

future_1.40.0_regression_note <- function() {
  if (interactive() && isTRUE(getOption("future.regression.note", TRUE))) {
    msg <- sprintf('future %s: Two regressions (https://github.com/futureverse/future/issues/778) and https://github.com/futureverse/future/issues/781) were introduced in future 1.40.0 (2025-04-10). If your think you are affected, you can roll back to future 1.34.0 by calling:\n\n  install.packages("https://cran.r-project.org/src/contrib/Archive/future/future_1.34.0.tar.gz")\n\nTo disable this startup message, set options(future.regression.note = FALSE) or environment variable R_FUTURE_REGRESSION_NOTE=false.\n', packageVersion("future"))
    packageStartupMessage(msg)
  }
}


## covr: skip=all
#' @importFrom utils packageVersion
.onLoad <- function(libname, pkgname) {
  .package[["version"]] <- packageVersion(pkgname)
  .package[["futureCounter"]] <- 0L

  if (isTRUE(as.logical(Sys.getenv("R_FUTURE_PRUNE_PKG_CODE", "FALSE")))) {
    prune_pkg_code()
  }

  update_package_option("future.debug", mode = "logical")
  debug <- isTRUE(getOption("future.debug"))

  ## Special case: Disable 'R_FUTURE_PLAN' when 'R CMD check'
  ## runs checks on examples, because, for instance,
  ## R_FUTURE_PLAN=multisession, will create connections that
  ## the check code will think are left over connections.
  if (nzchar(Sys.getenv("R_FUTURE_PLAN")) && "CheckExEnv" %in% search()) {
    Sys.unsetenv("R_FUTURE_PLAN")
  }
  
  if (debug) {
    envs <- Sys.getenv()
    envs <- envs[grep("R_FUTURE_", names(envs), fixed = TRUE)]
    envs <- sprintf("- %s=%s", names(envs), sQuote(envs))
    mdebug(paste(c("Future-specific environment variables:", envs), collapse = "\n"))
  }

  ## Set future options based on environment variables
  update_package_options(debug = debug)
  
  ## Initiate the R session UUID, which will also set/update
  ## .GlobalEnv[[".Random.seed"]].
  session_uuid(attributes = FALSE)

  ## Report on future plan, if set
  strategy <- getOption("future.plan")
  if (!is.null(strategy)) {
    if (debug) {
      if (is.character(strategy)) {
        mdebugf("Option 'future.plan' = %s", sQuote(strategy))
      } else {
        mdebugf("Option 'future.plan' of type %s", sQuote(mode(strategy)))
      }
    }
  }

  args <- parseCmdArgs()
  p <- args[["p"]]
  if (!is.null(p)) {
    if (debug) mdebugf("R command-line argument: -p %s", p)
    
    ## Apply
    options(mc.cores = p)
    ## options(Ncpus = p) ## FIXME: Does it make sense? /HB 2016-04-02

    ## Set 'future.plan' option?
    if (!is.null(strategy)) {
      if (debug) mdebug(" => 'future.plan' already set.")
    } else if (p == 1L) {
      if (debug) mdebug(" => options(future.plan = sequential)")
      options(future.plan = sequential)
    } else {
      if (debug) mdebugf(" => options(future.plan = tweak(multisession, workers = %s))", p)
      options(future.plan = tweak(multisession, workers = p))
    }
  }

  ## Create UUID for this process
  id <- session_uuid()

  if (debug) {
    mdebugf("R process uuid: %s", id)
    mdebug("Setting plan('default')")
  }
  
  ## NOTE: Don't initiate during startup - it might hang / give an error
  plan("default", .init = FALSE)

  ## Register future::FUTURE
  registerClusterTypes()
} ## .onLoad()


## covr: skip=all
#' @importFrom utils file_test
.onAttach <- function(libname, pkgname) {
  ## Source .future.R script, if one exists
  sourceFutureStartupScript()

##  future_1.40.0_regression_note()
}


sourceFutureStartupScript <- function(default = c(".future.R", "~/.future.R"), debug = isTRUE(getOption("future.debug"))) {
  ## Get default from env var?
  pathnames <- Sys.getenv("R_FUTURE_STARTUP_SCRIPT")
  if (nchar(pathnames) == 0L) {
    pathnames <- TRUE
  } else {
    if (debug) mdebug("R_FUTURE_STARTUP_SCRIPT: ", sQuote(pathnames))
    pathnames <- strsplit(pathnames, split = "[:;]", fixed = FALSE)[[1]]
    if (identical(toupper(pathnames), "TRUE")) {
      pathnames <- TRUE
    } else if (identical(toupper(pathnames), "FALSE")) {
      pathnames <- FALSE
    }
  }

  ## Get default from R option?
  pathnames <- getOption("future.startup.script", pathnames)
  
  ## BACKWARD COMPATIBILITY
  if (is.logical(pathnames)) {
    if (debug) mdebug("Option 'future.startup.script': ", paste(pathnames, collapse = ", "))
    stop_if_not(length(pathnames) == 1L, !is.na(pathnames))
    ## Nothing to do?
    if (!pathnames) {
      if (debug) mdebug("Future startup scripts disabled")
      return(character(0L))
    }
    pathnames <- default
  }
  
  stop_if_not(is.character(pathnames), !anyNA(pathnames))

  ## Nothing to do?
  if (length(pathnames) == 0L) {
    if (debug) mdebug("No future startup scripts specified")
    return(character(0L))
  }
  
  if (debug) mdebug("Future startup scripts considered: ", commaq(pathnames))
  pathnames <- pathnames[file_test("-f", pathnames)]

  ## Nothing to do?
  if (length(pathnames) == 0L) {
    if (debug) mdebug("Future startup scripts found: <none>")
    return(character(0L))
  }
  
  pathname <- pathnames[1]
  if (debug) {
    mdebugf("Future startup scripts found: %s", commaq(pathnames))
    mdebugf("Future startup script to load: %s", sQuote(pathname))
  }
  
  tryCatch({
    source(pathname, chdir = FALSE, echo = FALSE, local = FALSE)
  }, error = function(ex) {
    msg <- sprintf("Failed to source %s file while attaching the future package. Will ignore this error, but please investigate. The error message was: %s", sQuote(pathname), sQuote(ex[["message"]]))
    if (debug) mdebug(msg)
    warning(msg)
  })

  pathname
} ## sourceFutureStartupScript()
