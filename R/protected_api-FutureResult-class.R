#' Results from resolving a future
#'
#' @param value The value of the future expression.
#' If the expression was not fully resolved (e.g. an error) occurred,
#' the the value is `NULL`.
#'
#' @param visible If TRUE, the value was visible, otherwise invisible.
#' 
#' @param conditions A list of zero or more list elements each containing
#' a captured \link[base:conditions]{condition} and possibly more meta data such as the
#' call stack and a timestamp.
#'
#' @param rng If TRUE, the `.Random.seed` was updated from resolving the
#' future, otherwise not.
#'
#' @param \ldots (optional) Additional named results to be returned.
#' 
#' @param started,finished \link[base:DateTimeClasses]{POSIXct} timestamps
#' when the evaluation of the future expression was started and finished.
#'
#' @param version The version format of the results.
#'
#' @return An object of class FutureResult.
#'
#' @details
#' This function is only part of the _backend_ Future API.
#' This function is _not_ part of the frontend Future API.
#'
#' @section Note to developers:
#' The FutureResult structure is _under development_ and may change at anytime,
#' e.g. elements may be renamed or removed.  Because of this, please avoid
#' accessing the elements directly in code.  Feel free to reach out if you need
#' to do so in your code.
#'
#' @export
#' @keywords internal
FutureResult <- local({
  r_info <- NULL

  function(value = NULL, visible = TRUE, stdout = NULL, conditions = NULL, rng = FALSE, ..., uuid = NULL, started = .POSIXct(NA_real_), finished = Sys.time(), version = "1.8") {
    args <- list(...)
    if (length(args) > 0) {
      names <- names(args)
      if (is.null(names) || any(nchar(names) == 0)) {
        stop(FutureError(
          "Internal error: All arguments to FutureResult() must be named"
        ))
      }
    }
  
    stop_if_not(is.logical(visible), length(visible) == 1L, !is.na(visible))
  
    if (!is.null(stdout)) stop_if_not(is.character(stdout))
  
    stop_if_not(is.null(conditions) || is.list(conditions))
  
    stop_if_not(is.logical(rng), length(rng) == 1L, !is.na(rng))
  
    stop_if_not(is.character(version), length(version) == 1L, !is.na(version))
  
    if (version == "1.7") {
      .Defunct(msg = "FutureResult objects with an internal version of 1.7 or earlier are defunct. This error is likely coming from a third-party package or other R code. Please report this to the maintainer of the 'future' package so this can be resolved.", package = .packageName)
    }

    if (is.null(r_info)) {
      r_info <<- list(
              version = getRversion(),
                   os = .Platform[["OS.type"]],
              os_name = Sys.info()[["sysname"]],
        captures_utf8 = can_capture_utf8()
      )
    }

    structure(list(
      value        = value,
      visible      = visible,
      stdout       = stdout,
      conditions   = conditions,
      rng          = rng,
      ...,
      started      = started,
      finished     = finished,
      uuid         = uuid, 
      session_uuid = session_uuid(),
      r_info       = r_info,
      version      = version
    ), class = "FutureResult")
  }
})


#' @rdname FutureResult
#' @export
#' @keywords internal
as.character.FutureResult <- function(x, ...) {
  info <- x[c("value", "stdout", "conditions", "version")]
  info <- sapply(info, FUN = function(value) {
    if (is.null(value)) return("NULL")
    value <- as.character(value)
    if (length(value) == 0L) return("")
    value <- hpaste(value)
    if (nchar(value) > 20L)
      value <- paste0(substr(value, start = 1L, stop = 20L), " ...")
    value
  })
  info <- sprintf("%s: %s", names(info), sQuote(info))
  info <- paste(info, collapse = "; ")
  sprintf("%s: %s", class(x)[1], info)
}

#' @rdname FutureResult
#' @export
#' @keywords internal
print.FutureResult <- function(x, ...) {
  s <- sprintf("%s:", class(x)[1])
  s <- c(s, sprintf("value: %s", commaq(class(x[["value"]]))))
  if (!is.null(v <- x[["visible"]])) s <- c(s, sprintf("visible: %s", v))
  s <- c(s, sprintf("stdout: %s", class(x[["stdout"]])))
  conditions <- x[["conditions"]]
  conditionClasses <- vapply(conditions, FUN = function(c) class(c[["condition"]])[1], FUN.VALUE = NA_character_)
  s <- c(s, sprintf("conditions: [n = %d] %s", length(conditions), paste(conditionClasses, collapse = ", ")))
  if (!is.null(v <- x[["rng"]])) s <- c(s, sprintf("RNG used: %s", v))
  t0 <- x[["started"]]
  t1 <- x[["finished"]]
  s <- c(s, sprintf("duration: %s (started %s)", format(t1-t0), t0))
  s <- c(s, sprintf("version: %s", x[["version"]]))
  cat(s, sep = "\n")
}


## Assert the collected FutureResult is for the future
assertFutureResult <- function(future, debug = FALSE) {
  if (debug) {
    mdebug_push("assertFutureResult() ...")
    on.exit(mdebug_pop())
  }
  result <- future[["result"]]
  uuid <- result[["uuid"]]
  if (is.null(uuid)) {
    if (debug) mdebug("Future uuid: <none> (skipping)")
    return(NULL)
  }
  if (debug) mdebugf("Future uuid: %s", paste(uuid, collapse = "-"))
  if (identical(uuid, future[["uuid"]])) {
    if (debug) mdebug("identical; success")
    return(NULL)
  }
  label <- sQuoteLabel(future)
  result_uuid <- paste(uuid, collapse = "-")
  future_uuid <- paste(future[["uuid"]], collapse = "-")
  msg <- sprintf("Result for future (%s) is from another future. UUIDs do not match: %s != %s", label, result_uuid, future_uuid)
  stop(UnexpectedFutureResultError(msg))
}

