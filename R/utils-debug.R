now <- function(x = Sys.time(), format = "[%H:%M:%OS3] ") {
  ## format(x, format = format) ## slower
  format(as.POSIXlt(x, tz = ""), format = format)
}

debug_indent <- local({
  symbols <- rep(c("|", ":", ".", "'", ",", ";", "`"), times = 10L)
  function() {
    depth <- length(.debug[["stack"]])
    if (depth == 0) return("")
    indent <- getOption("future.debug.indent", " ")
    paste(paste(symbols[seq_len(depth)], indent, sep = ""), collapse = "")
  }
})

if (!exists(".debug", inherits = FALSE)) .debug <- new.env(parent = emptyenv())
if (!"stack" %in% names(".debug")) .debug$stack <- list()

mdebug_push <- function(..., debug = isTRUE(getOption("future.debug"))) {
  if (!debug) return()
  msg <- mdebug(..., debug = debug)
  .debug$stack <- c(.debug$stack, msg)
  invisible(msg)
}

mdebugf_push <- function(..., debug = isTRUE(getOption("future.debug"))) {
  if (!debug) return()
  msg <- mdebugf(..., debug = debug)
  .debug$stack <- c(.debug$stack, msg)
  invisible(msg)
}

mdebug_pop <- function(..., debug = isTRUE(getOption("future.debug"))) {
  if (!debug) return()
  n <- length(.debug$stack)
  msg <- .debug$stack[n]
  .debug$stack <- .debug$stack[-n]
  mdebug(sprintf("%s done", msg), debug = debug)
}

mdebugf_pop <- function(..., debug = isTRUE(getOption("future.debug"))) {
  if (!debug) return()
  n <- length(.debug$stack)
  msg <- .debug$stack[n]
  .debug$stack <- .debug$stack[-n]
  mdebug(sprintf("%s done", msg), debug = debug)
}

mdebug <- function(..., prefix = now(), debug = isTRUE(getOption("future.debug"))) {
  if (!debug) return()
  prefix <- paste(prefix, debug_indent(), sep = "")
  msg <- paste(..., sep = "")
  message(sprintf("%s%s", prefix, msg))
  invisible(msg)
}

mdebugf <- function(..., appendLF = TRUE,
                    prefix = now(), debug = isTRUE(getOption("future.debug"))) {
  if (!debug) return()
  prefix <- paste(prefix, debug_indent(), sep = "")
  msg <- sprintf(...)
  message(sprintf("%s%s", prefix, msg), appendLF = appendLF)
  invisible(msg)
}

#' @importFrom utils capture.output
mprint <- function(..., appendLF = TRUE, prefix = now(), debug = isTRUE(getOption("future.debug"))) {
  if (!debug) return()
  prefix <- paste(prefix, debug_indent(), sep = "")
  message(paste(prefix, capture.output(print(...)), sep = "", collapse = "\n"), appendLF = appendLF)
}

#' @importFrom utils capture.output str
mstr <- function(..., appendLF = TRUE, prefix = now(), debug = isTRUE(getOption("future.debug"))) {
  if (!debug) return()
  prefix <- paste(prefix, debug_indent(), sep = "")
  message(paste(prefix, capture.output(str(...)), sep = "", collapse = "\n"), appendLF = appendLF)
}
