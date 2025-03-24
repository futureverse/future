#' @tags windows

library(future)

adhoc_native_to_utf8 <- future:::adhoc_native_to_utf8

## WORKAROUND: In order to avoid this test script itself to use UTF-8
## encoding, we generate such UTF-8 strings at run-time instead from
## escaped UTF-8 strings.
strings <- c(
        "[x] hello" = "[x] hello",
    "\\u2713 hello" = "<U+2713> hello",
  "'\\u2713 hello'" = "'<U+2713> hello'",
  '"\\u2713 hello"' = '"<U+2713> hello"',
    "\\u306B hello" = "<U+306B> hello"
)
for (kk in seq_along(strings)) {
  name <- names(strings)[kk]
  code <- paste('"', gsub('"', '\\"', name, fixed = TRUE), '"', sep = "")
  name <- eval(parse(text = code))
  names(strings)[kk] <- name
}

for (kk in seq_along(strings)) {
  message(sprintf("Test case #%d:", kk))
  truth  <- names(strings)[kk]
  input  <- strings[[kk]]
  output <- adhoc_native_to_utf8(input)
  message(sprintf(" -  input: %s", input))
  message(sprintf(" - output: %s", output))
  message(sprintf(" -  truth: %s", truth))
  ## NOTE: Not all MS Windows environment support UTF-8.  Then
  ## the above does not work and input == truth
  stopifnot(identical(input, truth) || identical(output, truth))
}
