now <- function(x = Sys.time(), format = "[%H:%M:%OS3] ") {
  ## format(x, format = format) ## slower
  format(as.POSIXlt(x, tz = ""), format = format)
}

debug_indent <- local({
  prefix <- ""
  depth <- 0L
  symbols <- rep(c("|", ":", "."), times = 3L)
 
  function(delta = 0L) {
    if (delta == 0) return(prefix)
    if (delta > 0) {
      depth <<- depth + 1L
    } else if (delta < 0) {
      depth <<- depth - 1L
    }
    prefix <<- paste(paste(symbols[seq_len(depth)], " "), collapse = "")
  }
})

mdebug_push <- function(..., debug = isTRUE(getOption("future.debug"))) {
  if (!debug) return()
  mdebug(..., debug = debug)
  debug_indent(+1)
}

mdebug_pop <- function(..., debug = isTRUE(getOption("future.debug"))) {
  if (!debug) return()
  debug_indent(-1)
  mdebug(..., debug = debug)
}

mdebugf_push <- function(..., debug = isTRUE(getOption("future.debug"))) {
  if (!debug) return()
  mdebugf(..., debug = debug)
  debug_indent(+1)
}

mdebugf_pop <- function(..., debug = isTRUE(getOption("future.debug"))) {
  if (!debug) return()
  debug_indent(-1)
  mdebugf(..., debug = debug)
}

mdebug <- function(..., prefix = now(), debug = isTRUE(getOption("future.debug"))) {
  if (!debug) return()
  prefix <- paste(prefix, debug_indent(), sep = "")
  message(prefix, ...)
}

mdebugf <- function(..., appendLF = TRUE,
                    prefix = now(), debug = isTRUE(getOption("future.debug"))) {
  if (!debug) return()
  prefix <- paste(prefix, debug_indent(), sep = "")
  message(prefix, sprintf(...), appendLF = appendLF)
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
