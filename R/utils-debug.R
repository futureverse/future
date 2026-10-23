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
if (!"stack" %in% names(.debug)) .debug$stack <- list()

mdebug_push <- function(..., debug = isTRUE(getOption("future.debug"))) {
  if (!debug) return(invisible(0L))
  msg <- mdebug(..., debug = debug)
  .debug$stack <- c(.debug$stack, msg)
  invisible(length(.debug$stack) - 1L)
}

mdebugf_push <- function(..., debug = isTRUE(getOption("future.debug"))) {
  if (!debug) return(invisible(0L))
  msg <- mdebugf(..., debug = debug)
  .debug$stack <- c(.debug$stack, msg)
  invisible(length(.debug$stack) - 1L)
}

mdebug_pop <- function(..., depth = NULL, debug = isTRUE(getOption("future.debug"))) {
  if (!debug) return(invisible(0L))
  if (!is.null(depth)) {
    while (length(.debug$stack) > depth) {
      mdebug_pop(debug = debug)
    }
    return(invisible(length(.debug$stack)))
  }
  n <- length(.debug$stack)
  msg <- .debug$stack[n]
  .debug$stack <- .debug$stack[-n]
  mdebug(sprintf("%s done", msg), debug = debug)
  invisible(length(.debug$stack))
}

mdebugf_pop <- function(..., depth = NULL, debug = isTRUE(getOption("future.debug"))) {
  if (!debug) return(invisible(0L))
  if (!is.null(depth)) {
    while (length(.debug$stack) > depth) {
      mdebugf_pop(debug = debug)
    }
    return(invisible(length(.debug$stack)))
  }
  n <- length(.debug$stack)
  msg <- .debug$stack[n]
  .debug$stack <- .debug$stack[-n]
  mdebug(sprintf("%s done", msg), debug = debug)
  invisible(length(.debug$stack))
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
