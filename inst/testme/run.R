testme_name <- Sys.getenv("R_TESTME_NAME", NA_character_)
if (is.na(testme_name)) {
  stop("testme: Environment variable 'R_TESTME_NAME' is not set")
}

testme_package <- Sys.getenv("_R_CHECK_PACKAGE_NAME_", NA_character_)
if (is.na(testme_package)) testme_package <- "future"

path <- Sys.getenv("R_TESTME_PATH", NA_character_)
if (is.na(path)) {
  path <- system.file(package = testme_package, "testme", mustWork = TRUE)
} else if (!utils::file_test("-d", path)) {
  stop("There exist no such 'R_TESTME_PATH' folder: ", sQuote(path))
}
Sys.setenv(R_TESTME_PATH = path)

filename <- sprintf("test-%s.R", testme_name)
file <- file.path(path, filename)
if (!utils::file_test("-f", file)) {
  stop("There exist no such 'testme' file: ", sQuote(file))
}

## -----------------------------------------------------------------
## testme environment
## -----------------------------------------------------------------
## Get test script tags
tags <- local({
  lines <- readLines(file.path(path, filename), warn = FALSE)
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

## Create 'testme' environment on the search() path
if ("testme" %in% search()) detach(name = "testme")
envir <- attach(list(
  package = testme_package,
     name = testme_name,
     tags = tags,
   status = "created",
    start = proc.time(),
    debug = isTRUE(as.logical(Sys.getenv("R_TESTME_DEBUG")))
), name = "testme", warn.conflicts = FALSE)
rm(list = c("tags", "testme_package", "testme_name"))

## -----------------------------------------------------------------
## Filters
## -----------------------------------------------------------------
code <- Sys.getenv("R_TESTME_FILTER_NAME", NA_character_)
if (!is.na(code)) {
  expr <- tryCatch(parse(text = code), error = identity)
  if (inherits(expr, "error")) {
    stop("Syntax error in R_TESTME_FILTER_NAME: ", sQuote(code))
  }
  
  keep <- tryCatch(eval(expr, envir = envir), error = identity)
  if (inherits(keep, "error")) {
    stop("Evaluation of R_TESTME_FILTER_NAME=%s produced an error: %s",
         sQuote(code), conditionMessage(keep))
  }
  if (!isTRUE(keep)) envir[["status"]] <- "skipped"
}

code <- Sys.getenv("R_TESTME_FILTER_TAGS", NA_character_)
if (!is.na(code)) {
  expr <- tryCatch(parse(text = code), error = identity)
  if (inherits(expr, "error")) {
    stop("Syntax error in R_TESTME_FILTER_TAGS: ", sQuote(code))
  }
  keep <- tryCatch(eval(expr, envir = envir), error = identity)
  if (inherits(keep, "error")) {
    stop("Evaluation of R_TESTME_FILTER_TAGS=%s produced an error: %s",
         sQuote(code), conditionMessage(keep))
  }
  if (!isTRUE(keep)) envir[["status"]] <- "skipped"
}

message(sprintf("Test %s ...", sQuote(envir[["name"]])))

## Process prologue scripts
if (envir[["status"]] != "skipped") {
  envir[["status"]] <- "prologue"
  source(file.path(path, "_prologue.R"))
}

## Run test script
## Note, prologue scripts may trigger test to be skipped
if (envir[["status"]] != "skipped") {
  message("Running test script: ", sQuote(filename))
  envir[["status"]] <- "failed"
  source(file.path(path, filename), echo = TRUE)
  envir[["status"]] <- "success"

  ## Process epilogue scripts
  ## Note, epilogue scripts may change status or produce check errors
  envir[["status"]] <- "epilogue"
  source(file.path(path, "_epilogue.R"))
  envir[["status"]] <- "success"
}

envir[["stop"]] <- proc.time()
dt <- envir[["stop"]] - envir[["start"]]
dt_str <- sprintf("%s=%.1gs", names(dt), dt)
message("Test time: ", paste(dt_str, collapse = ", "))

message(sprintf("Test %s ... %s", sQuote(envir[["name"]]), envir[["status"]]))

if ("testme" %in% search()) detach(name = "testme")
