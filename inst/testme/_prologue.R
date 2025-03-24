local({
  path <- Sys.getenv("R_TESTME_PATH", NA_character_)
  if (!utils::file_test("-d", path)) {
    stop("There exist no such 'R_TESTME_PATH' folder: ", sQuote(path))
  }
  stopifnot("testme" %in% search())
  testme <- as.environment("testme")
  
  ## Find all prologue scripts
  files <- dir(file.path(path, "_prologue"), pattern = "*[.]R$", full.names = TRUE)
  files <- sort(files)
  testme[["prologue_scripts"]] <- files

  ## Source all prologue scripts inside the 'testme' environment
  expr <- quote({
    files <- prologue_scripts
    message(sprintf("Sourcing %d prologue scripts ...", length(files)))
    for (kk in seq_along(files)) {
      file <- files[kk]
      message(sprintf("%02d/%02d prologue script %s", kk, length(files), sQuote(file)))
      source(file, local = TRUE)
    }
    message(sprintf("Sourcing %d prologue scripts ... done", length(files)))
    rm(list = c("kk", "file", "files"))
  })
  eval(expr, envir = testme)
})
