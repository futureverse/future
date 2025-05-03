now <- function(x = Sys.time(), format = "[%H:%M:%OS3] ") {
  ## format(x, format = format) ## slower
  format(as.POSIXlt(x, tz = ""), format = format)
}

debug_indent <- local({
  prefix <- ""
  depth <- 0L
  symbols <- rep(c("|", ":", ".", "'", ",", ";", "`"), times = 10L)

  function(delta = 0L) {
    if (delta == 0) return(prefix)
    if (delta > 0) {
      depth <<- depth + 1L
    } else if (delta < 0) {
      depth <<- depth - 1L
      if (depth < 0L) {
        calls <- paste(vapply(sys.calls(), FUN = deparse, FUN.VALUE = NA_character_), collapse = " -> ")
        warning(sprintf("[INTERNAL WARNING]: There appears to be one mdebug_pop() too many: %s", calls), call. = TRUE, immediate. = TRUE)
        depth <- 0L
      }
    }
    prefix <<- if (depth == 0) {
      ""
    } else {
      
      indent <- getOption("future.debug.indent", " ")
      paste(paste(symbols[seq_len(depth)], indent, sep = ""), collapse = "")
    }
  }
})

.debug <- new.env(parent = emptyenv())
.debug$stack <- list()

mdebug_push <- function(..., debug = isTRUE(getOption("future.debug"))) {
  if (!debug) return()
  msg <- mdebug(..., debug = debug)
  debug_indent(+1)
  .debug$stack <- c(.debug$stack, msg)
  invisible(msg)
}

mdebugf_push <- function(..., debug = isTRUE(getOption("future.debug"))) {
  if (!debug) return()
  msg <- mdebugf(..., debug = debug)
  debug_indent(+1)
  .debug$stack <- c(.debug$stack, msg)
  invisible(msg)
}

mdebug_pop <- function(..., debug = isTRUE(getOption("future.debug"))) {
  if (!debug) return()
  n <- length(.debug$stack)
  msg <- .debug$stack[n]
  .debug$stack <- .debug$stack[-n]
  debug_indent(-1)
  mdebug(sprintf("%s done", msg), debug = debug)
}

mdebugf_pop <- function(..., debug = isTRUE(getOption("future.debug"))) {
  if (!debug) return()
  n <- length(.debug$stack)
  msg <- .debug$stack[n]
  .debug$stack <- .debug$stack[-n]
  debug_indent(-1)
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
