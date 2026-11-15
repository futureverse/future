#' @tags FutureCondition conditions warning.length

library(future)

message("*** FutureCondition and R option 'warning.length' ...")

## R's default error and warning handlers truncate messages to
## getOption("warning.length") characters, which defaults to 1000.
## When a FutureCondition is signaled via stop() or warning(), this
## limit is temporarily increased to the maximum (8170), and then
## restored when stop() or warning() exits
oopts <- options(warning.length = 1000L)

msg <- paste(c(strrep("x", 1500L), "END-OF-MESSAGE"), collapse = "")
error <- FutureError(msg)
warning <- FutureWarning(msg)

## The limit is increased while the condition is signaled
for (cond in list(error, warning)) {
  message(sprintf("- %s", class(cond)[1]))
  value <- NA_integer_
  res <- tryCatch({
    withCallingHandlers({
      if (inherits(cond, "error")) stop(cond) else warning(cond)
    }, condition = function(c) {
      value <<- getOption("warning.length")
    })
  }, condition = identity)
  stopifnot(inherits(res, class(cond)[1]))
  print(value)
  stopifnot(identical(value, 8170L))

  ## ... and restored afterward
  stopifnot(identical(getOption("warning.length"), 1000L))

  ## The message itself is never truncated
  stopifnot(grepl("END-OF-MESSAGE", conditionMessage(res), fixed = TRUE))
}

message("- conditionMessage() outside of stop() and warning()")
## Calling conditionMessage() elsewhere does not change the limit
local({
  msg <- conditionMessage(error)
  stopifnot(identical(getOption("warning.length"), 1000L))
})
f <- function() {
  msg <- conditionMessage(error)
  getOption("warning.length")
}
stopifnot(identical(f(), 1000L))
stopifnot(identical(getOption("warning.length"), 1000L))

message("- An uncaught FutureError is not truncated")
## An uncaught error is printed by R's default error handler, which
## requires a separate R session to observe
rscript <- file.path(R.home("bin"), "Rscript")
expr <- 'future::FutureError(paste(c(strrep("x", 1500L), "END-OF-MESSAGE"), collapse = ""))'
expr <- sprintf("options(warning.length = 1000L); stop(%s)", expr)
out <- suppressWarnings({
  system2(rscript, args = c("--vanilla", "-e", shQuote(expr)), stdout = TRUE, stderr = TRUE)
})
print(out)
stopifnot(
  !is.null(attr(out, "status")),
  any(grepl("END-OF-MESSAGE", out, fixed = TRUE))
)

options(oopts)

message("*** FutureCondition and R option 'warning.length' ... DONE")
