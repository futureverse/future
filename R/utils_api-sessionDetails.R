#' Outputs details on the current \R session
#'
#' @param env If TRUE, `Sys.getenv()` information is returned.
#'
#' @return Invisibly a list of all details.
#'
#' @importFrom utils sessionInfo
#' @export
#' @keywords internal
sessionDetails <- function(env = FALSE) {
  ## Gather all details
  details <- list(
    "Sys.time()" = Sys.time(),
    "sessionInfo()" = sessionInfo(),
    "commandArgs()" = commandArgs(),
    "Sys.info()" = Sys.info(),
    "capabilities()" = capabilities(),
    ".libPaths" = .libPaths(),
    "Sys.getenv()" = Sys.getenv(),
    "Sys.getlocale()" = Sys.getlocale(),
    ".Platform" = .Platform,
    ".Machine" = .Machine,
    "getwd()" = getwd(),
    "tempdir()" = tempdir(),
    "options()" = options(),
    "warnings()" = warnings()
  )

  ## May contain secret keys and tokens. Exclude by default.
  if (!env) details[["Sys.getenv()"]] <- NULL

  class(details) <- c("sessionDetails", class(details))
  details
}

#' @export
`[.sessionDetails` <- function(x, ...) {
  class <- class(x)
  x <- NextMethod()
  class(x) <- class
  x
}

#' @export
print.sessionDetails <- function(x, output = c("output", "message"), headers = TRUE, width = getOption("width"), ...) {
  banner <- function(s, width = getOption("width"), newline = TRUE) {
    if (is.null(s)) s <- ""
    width <- width - 1L * newline
    if (nzchar(s)) {
      padding <- width - nchar(s) - 3L
      x <- c("= ", s, " ", rep("=", times = padding))
    } else {
      x <- rep("=", times = width)
    }
    if (newline) x <- c(x, "\n")
    paste(x, collapse = "")
  }
  
  output <- match.arg(output, choices = c("output", "message"))
  
  con <- NULL
  if (output == "output") {
    con <- stderr()
  } else if (output == "message") {
    con <- stderr()
  }

  output <- capture.output({
    if (headers) {
      cat(banner(""))
      cat("= SESSION DETAILS (BEGIN)\n")
      cat(banner(""))
      cat("\n")
    }
    for (kk in seq_along(x)) {
      if (headers) cat(banner(names(x)[kk]))
      info <- x[[kk]]
      print(info, ...)
      cat("\n")
    }
    if (headers) {
      cat(banner(""))
      cat("= SESSION DETAILS (STOP)\n")
      cat(banner(""))
    }
  })
  output <- paste(c(output, ""), collapse = "\n")
  cat(output, file = con)
  
  invisible(x)
} ## sessionDetails()
