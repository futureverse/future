#!/usr/bin/env Rscript

#' Run a 'testme' Test Script
#'
#' R usage:
#' testme("<name>")
#'
#' Command-line usage:
#' tests/test-<name>.R
#'
#' Command-line usage without package re-install:
#' inst/testme/run.R --name=<test_name>
#' inst/testme/run.R <test-name.R>
#'
#' Options:
#' --package=<pkg>     The name of the package being tested
#'                     (Environment variable: `R_TESTME_PACKAGE`)
#'                     (Default: The `Package` field of the DESCRIPTION file)
#' --name=<name>       The name of the test to run, used to locate the test
#'                     script `test-<name>.R`
#'                     (Environment variable: `R_TESTME_NAME`)
#' --not-cran          Set environment variable `NOT_CRAN=true`
#' --coverage=summary  Estimate test code coverage with basic summary
#' --coverage=tally    Estimate test code coverage with full tally summary
#' --coverage=report   Estimate test code coverage with full HTML report
#' --debug             Output debug messages
#'                     (Environment variable: `R_TESTME_DEBUG`)
#'
#' Examples:
#' testme/test-abc.R
#' testme/test-abc.R --not-cran
#' tests/test-cpuLoad.R --coverage=report
#'
#' inst/testme/run.R inst/testme/test-abc.R
#' inst/testme/run.R inst/testme/test-abc.R --coverage
#'
#' Environment variables:
#' * R_TESTME_PACKAGE
#' * R_TESTME_NAME
#' * R_TESTME_PATH
#' * R_TESTME_FILTER_NAME
#' * R_TESTME_FILTER_TAGS
#' * R_TESTME_COVERAGE
#' * R_TESTME_DEBUG
main <- function() {
  cmd_args <- commandArgs(trailingOnly = TRUE)
  
  pattern <- "--package=([[:alpha:][:alnum:]]+)"
  idx <- grep(pattern, cmd_args)
  if (length(idx) > 0L) {
    stopifnot(length(idx) == 1L)
    testme_package <- gsub(pattern, "\\1", cmd_args[idx])
    cmd_args <- cmd_args[-idx]
  } else {
    testme_package <- Sys.getenv("R_TESTME_PACKAGE", NA_character_)
    if (is.na(testme_package)) {
      desc <- read.dcf("DESCRIPTION")
      testme_package <- desc[1, "Package"]
    }
  }
  
  pattern <- "--path=([[:alpha:][:alnum:]]+)"
  idx <- grep(pattern, cmd_args)
  if (length(idx) > 0L) {
    stopifnot(length(idx) == 1L)
    path <- gsub(pattern, "\\1", cmd_args[idx])
    cmd_args <- cmd_args[-idx]
  } else {
    path <- Sys.getenv("R_TESTME_PATH", NA_character_)
    if (is.na(path)) {
      path <- file.path("inst", "testme")
    }
    if (!utils::file_test("-d", path)) {
      stop("There exist no such 'R_TESTME_PATH' folder: ", sQuote(path))
    }
  }
  
  pattern <- "--name=([[:alpha:][:alnum:]]+)"
  idx <- grep(pattern, cmd_args)
  if (length(idx) > 0L) {
    stopifnot(length(idx) == 1L)
    testme_name <- gsub(pattern, "\\1", cmd_args[idx])
    cmd_args <- cmd_args[-idx]
  } else {
    testme_name <- NULL
  }

  pattern <- "^--not-cran"
  idx <- grep(pattern, cmd_args)
  if (length(idx) > 0L) {
    cmd_args <- cmd_args[-idx]
    Sys.setenv(NOT_CRAN = "TRUE")
  }

  pattern <- "^--debug"
  idx <- grep(pattern, cmd_args)
  if (length(idx) > 0L) {
    cmd_args <- cmd_args[-idx]
    Sys.setenv(R_TESTME_DEBUG = "TRUE")
  }

  pattern <- "^--coverage(|=([[:alpha:][:alnum:]]+))$"
  idx <- grep(pattern, cmd_args)
  if (length(idx) > 0L) {
    value <- gsub(pattern, "\\2", cmd_args[idx])
    if (!nzchar(value)) {
      coverage <- "summary"
    } else {
      coverage <- match.arg(value, choices = c("none", "summary", "tally", "report"))
    }
    cmd_args <- cmd_args[-idx]
  } else {
    value <- Sys.getenv("R_TESTME_COVERAGE", "none")
    coverage <- match.arg(value, choices = c("none", "summary", "tally", "report"))
  }
  if (coverage != "none") {
    if (!utils::file_test("-f", "DESCRIPTION")) {
      stop("Current folder does not look like a package folder")
    }
  }
  
  ## Fallback for 'testme_name'?
  if (is.null(testme_name)) {
    if (length(cmd_args) > 0) {
      stopifnot(length(cmd_args) == 1L)
      file <- cmd_args[1]
      if (utils::file_test("-f", file)) {
        testme_name <- gsub("(^test-|[.]R$)", "", basename(file))
      } else {
        stop("No such file: ", file)
      }
    } else {
      testme_name <- Sys.getenv("R_TESTME_NAME", NA_character_)
      if (is.na(testme_name)) {
        stop("testme: Environment variable 'R_TESTME_NAME' is not set")
      }
    }
  } 
  
  testme_file <- file.path(path, sprintf("test-%s.R", testme_name))
  if (!utils::file_test("-f", testme_file)) {
    stop("There exist no such 'testme' file: ", sQuote(testme_file))
  }

  
  ## -----------------------------------------------------------------
  ## testme environment
  ## -----------------------------------------------------------------
  on_cran <- function() {
    not_cran <- Sys.getenv("NOT_CRAN", NA_character_)
    if (is.na(not_cran)) {
      not_cran <- FALSE
    } else {
      not_cran <- isTRUE(as.logical(not_cran))
    }
    !interactive() && !not_cran
  } ## on_cran()
  
  
  ## Get test script tags
  tags <- local({
    lines <- readLines(testme_file, warn = FALSE)
    pattern <- "^#'[[:blank:]]+@tags[[:blank:]]+"
    lines <- grep(pattern, lines, value = TRUE)
    tags <- sub(pattern, "", lines)
    tags
  })
  if (length(tags) > 0) {
    tags <- sub("[[:blank:]]*$", "", tags)
    tags <- unlist(strsplit(tags, split = "[[:blank:]]+"))
    tags <- sort(unique(tags))
  } else {
    tags <- character(0L)
  }

  debug <- isTRUE(as.logical(Sys.getenv("R_TESTME_DEBUG")))

  coverage <- match.arg(coverage, choices = c("none", "summary", "tally", "report"))

  ## Create 'testme' environment on the search() path
  testme_config <- list(
     testme = TRUE,
    package = testme_package,
       name = testme_name,
       tags = tags,
     status = "created",
      start = proc.time(),
     script = testme_file,
       path = path,
    on_cran = on_cran(),
       coverage = coverage,
      debug = debug
  )
  if ("testme" %in% search()) detach(name = "testme")
  testme <- attach(testme_config, name = "testme", warn.conflicts = FALSE)
  rm(list = c("tags", "testme_package", "testme_name", "testme_file"))
  

  ## -----------------------------------------------------------------
  ## Filters
  ## -----------------------------------------------------------------
  ## Skip on CRAN? To run these tests, set env var NOT_CRAN=true
  if ("skip_on_cran" %in% tags && on_cran()) {
    testme[["status"]] <- "skipped"
  }

  code <- Sys.getenv("R_TESTME_FILTER_NAME", NA_character_)
  if (!is.na(code)) {
    expr <- tryCatch(parse(text = code), error = identity)
    if (inherits(expr, "error")) {
      stop("Syntax error in R_TESTME_FILTER_NAME: ", sQuote(code))
    }
    
    keep <- tryCatch(eval(expr, envir = testme), error = identity)
    if (inherits(keep, "error")) {
      stop("Evaluation of R_TESTME_FILTER_NAME=%s produced an error: %s",
           sQuote(code), conditionMessage(keep))
    }
    if (!isTRUE(keep)) testme[["status"]] <- "skipped"
  }
  
  code <- Sys.getenv("R_TESTME_FILTER_TAGS", NA_character_)
  if (!is.na(code)) {
    expr <- tryCatch(parse(text = code), error = identity)
    if (inherits(expr, "error")) {
      stop("Syntax error in R_TESTME_FILTER_TAGS: ", sQuote(code))
    }
    keep <- tryCatch(eval(expr, envir = testme), error = identity)
    if (inherits(keep, "error")) {
      stop("Evaluation of R_TESTME_FILTER_TAGS=%s produced an error: %s",
           sQuote(code), conditionMessage(keep))
    }
    if (!isTRUE(keep)) testme[["status"]] <- "skipped"
  }
  
  testme_run_test(testme)
} ## main()



#' @param testme A names list
#'
testme_run_test <- function(testme) {
  message(sprintf("Test %s ...", sQuote(testme[["name"]])))
  if (testme[["debug"]]) {
    message("testme:")
    message(paste(utils::capture.output(utils::str(as.list(testme))), collapse = "\n"))
  }

  path <- testme[["path"]]

  ## Process prologue scripts, if they exist
  if (testme[["status"]] != "skipped" &&
      utils::file_test("-d", file.path(path, "_prologue"))) {
    testme[["status"]] <- "prologue"
    local({
      ## Find all prologue scripts
      files <- dir(file.path(path, "_prologue"), pattern = "*[.]R$", full.names = TRUE)
      files <- sort(files)
      testme[["prologue_scripts"]] <- files

      ## Source all prologue scripts inside the 'testme' environment
      expr <- bquote({
        files <- prologue_scripts
        if (.(testme[["debug"]])) message(sprintf("Sourcing %d prologue scripts ...", length(files)))
        for (kk in seq_along(files)) {
          file <- files[kk]
          if (.(testme[["debug"]])) message(sprintf("%02d/%02d prologue script %s", kk, length(files), sQuote(file)))
          source(file, local = TRUE)
        }
        if (.(testme[["debug"]])) message(sprintf("Sourcing %d prologue scripts ... done", length(files)))
        rm(list = c("kk", "file", "files"))
      })
      eval(expr, envir = testme)
    })
  
  #  ## In case prologue scripts overwrote some elements in 'testme'
  #  for (name in names(testme_config)) {
  #    testme[[name]] <- testme_config[[name]]
  #  }
  }
  
  
  ## Run test script
  ## Note, prologue scripts may trigger test to be skipped
  if (testme[["status"]] != "skipped") {
    if (testme[["debug"]]) message("Running test script: ", sQuote(testme[["script"]]))
    testme[["status"]] <- "failed"
    str(testme[["coverage"]])
    if (testme[["coverage"]] != "none") {
      pkg_env <- pkgload::load_all()
      cov <- covr::environment_coverage(pkg_env[["env"]], test_files = testme[["script"]])
      ## Keep source files with non-zero coverage
      tally <- covr::tally_coverage(cov)
      tally <- subset(tally, value > 0)
      cov <- cov[covr::display_name(cov) %in% unique(tally$filename)]
      testme[["test_coverage"]] <- cov
    } else {
      testme[["test_coverage"]] <- NULL
      source(testme[["script"]], echo = TRUE)
    }
    testme[["status"]] <- "success"
  }
  
  
  ## Process epilogue scripts, if they exist
  ## Note, epilogue scripts may change status or produce check errors
  if (testme[["status"]] == "success" &&
      utils::file_test("-d", file.path(path, "_epilogue"))) {
    testme[["status"]] <- "epilogue"
    local({
      ## Find all epilogue scripts
      files <- dir(file.path(path, "_epilogue"), pattern = "*[.]R$", full.names = TRUE)
      files <- sort(files)
      testme[["epilogue_scripts"]] <- files
    
      ## Source all epilogue scripts inside the 'testme' environment
      expr <- bquote({
        files <- epilogue_scripts
        if (.(testme[["debug"]])) message(sprintf("Sourcing %d epilogue scripts ...", length(files)))
        for (kk in seq_along(files)) {
          file <- files[kk]
          if (.(testme[["debug"]])) message(sprintf("%02d/%02d epilogue script %s", kk, length(files), sQuote(file)))
          source(file, local = TRUE)
        }
        if (.(testme[["debug"]])) message(sprintf("Sourcing %d epilogue scripts ... done", length(files)))
        rm(list = c("kk", "file", "files"))
      })
      eval(expr, envir = testme)
    })
    testme[["status"]] <- "success"
  }
  
  testme[["stop"]] <- proc.time()
  dt <- testme[["stop"]] - testme[["start"]]
  dt_str <- sprintf("%s=%.1gs", names(dt), dt)
  message("Test time: ", paste(dt_str, collapse = ", "))
  
  if ("testme" %in% search()) detach(name = "testme")

  cov <- testme[["test_coverage"]]
  if (!is.null(cov)) {
    message("Source files covered by the test script:")
    if (length(cov) > 0) {
      print(cov)
      if ("tally" %in% testme[["coverage"]]) {
        tally <- covr::tally_coverage(cov)
        print(tally)
      }
      if ("report" %in% testme[["coverage"]]) {
        html <- covr::report(cov, browse = FALSE)
        browseURL(html)
        Sys.sleep(5.0)
      }
    } else {
      message("* No source files were covered by this test!")
    }
  }

  message(sprintf("Test %s ... %s", sQuote(testme[["name"]]), testme[["status"]]))
} ## testme_run_test()


main()
