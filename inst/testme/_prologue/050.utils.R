## Local functions for test scripts
printf <- function(...) cat(sprintf(...))
mstr <- function(...) message(paste(capture.output(str(...)), collapse = "\n"))
attachLocally <- function(x, envir = parent.frame()) {
  for (name in names(x)) {
    assign(name, value = x[[name]], envir = envir)
  }
}

## WORKAROUND: capture.output() gained argument 'split' in R 3.3.0
if (getRversion() >= "3.3.0") {
  capture.output <- utils::capture.output 
} else {
  capture.output <- function(..., split = FALSE) utils::capture.output(...)
}

recordConditions <- function(expr, ..., parse = TRUE) {
  conditions <- list()
  withCallingHandlers(expr, condition = function(c) {
    attr(c, "received") <- Sys.time()
    conditions[[length(conditions) + 1L]] <<- c
  })
  conditions
}

recordRelay <- function(...) {
  stdout <- capture.output(conditions <- recordConditions(...), split = TRUE)
  if (length(stdout) > 0) stdout <- paste0(stdout, "\n")
  msgs <- sapply(conditions, FUN = conditionMessage)
  list(stdout = stdout, msgs = msgs)
}
