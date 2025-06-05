#' A condition (message, warning, or error) that occurred while orchestrating a future
#'
#' While _orchestrating_ (creating, launching, querying, collection)
#' futures, unexpected run-time errors (and other types of conditions) may
#' occur.  Such conditions are coerced to a corresponding FutureCondition
#' class to help distinguish them from conditions that occur due to the
#' _evaluation_ of the future.
#' 
#' @param message A message condition.
#' 
#' @param call The call stack that led up to the condition.
#' 
#' @param uuid A universally unique identifier for the future associated with
#' this FutureCondition.
#' 
#' @param future The [Future] involved.
#' 
#' @return An object of class FutureCondition which inherits from class
#' \link[base:conditions]{condition} and FutureMessage, FutureWarning,
#' and FutureError all inherits from FutureCondition.
#' Moreover, a FutureError inherits from \link[base:conditions]{error},
#' a FutureWarning from \link[base:conditions]{warning}, and
#' a FutureMessage from \link[base:conditions]{message}.
#'
#' @export
#' @keywords internal
FutureCondition <- function(message, call = NULL, uuid = future[["uuid"]], future = NULL) {
  ## Support different types of input
  if (inherits(message, "condition")) {
    cond <- message
    message <- conditionMessage(cond)
    class <- class(cond)
  } else if (is.null(message)) {
    stop("INTERNAL ERROR: Trying to set up a FutureCondition with message = NULL")
  } else {
    class <- "condition"
  }

  message <- as.character(message)
  
  with_assert({
    if (length(message) != 1L) {
      stopf("INTERNAL ERROR: Trying to set up a FutureCondition with length(message) != 1L: %d", length(message))
    }

    if (!is.null(uuid)) {
      stop_if_not(is.character(uuid), !anyNA(uuid))
    }
    if (!is.null(future)) stop_if_not(inherits(future, "Future"))
  })

  if (!getOption("future.onFutureCondition.keepFuture", TRUE)) {
    future <- NULL
  }
  
  ## Create a condition object
  class <- c("FutureCondition", class)
  structure(list(message = message, call = call), 
            class = class[!duplicated(class, fromLast = TRUE)],
            uuid = uuid, future = future)
}


#' @importFrom utils tail
#' @export
print.FutureCondition <- function(x, ...) {
  NextMethod()

  uuid <- attr(x, "uuid", exact = TRUE)
  if (is.null(uuid)) {
    uuid <- "<NA>"
  } else {
    uuid <- paste(uuid, collapse = "-")
  }
  cat(sprintf("\n\nFuture UUID: %s\n", uuid))

  future <- attr(x, "future", exact = TRUE)

  if (!is.null(future)) {
    cat("\n\nDEBUG: BEGIN TROUBLESHOOTING HELP\n")

    if (!is.null(future)) {
      cat("Future involved:\n")
      print(future)
      cat("\n")
    }

    cat("DEBUG: END TROUBLESHOOTING HELP\n")
  }

  invisible(x)
} ## print()



#' @rdname FutureCondition
#' @export
FutureMessage <- function(message, call = NULL, uuid = future[["uuid"]], future = NULL) {
  cond <- FutureCondition(message = message, call = call, uuid = uuid, future = future)
  class <- c("FutureMessage", "message", class(cond))
  class(cond) <- class[!duplicated(class, fromLast = TRUE)]
  cond
}


#' @rdname FutureCondition
#' @export
FutureWarning <- function(message, call = NULL, uuid = future[["uuid"]], future = NULL) {
  cond <- FutureCondition(message = message, call = call, uuid = uuid, future = future)
  class <- c("FutureWarning", "warning", class(cond))
  class(cond) <- class[!duplicated(class, fromLast = TRUE)]
  cond
}


#' @rdname FutureCondition
#' @export
FutureError <- function(message, call = NULL, uuid = future[["uuid"]], future = NULL) {
  cond <- FutureCondition(message = message, call = call, uuid = uuid, future = future)
  class <- c("FutureError", "error", class(cond))
  class(cond) <- class[!duplicated(class, fromLast = TRUE)]
  cond
}


#' @rdname FutureCondition
#' @export
RngFutureCondition <- function(message = NULL, call = NULL, uuid = future[["uuid"]], future = NULL) {
  if (is.null(message)) {
    label <- sQuoteLabel(future)
    message <- sprintf("UNRELIABLE VALUE: Future (%s) unexpectedly generated random numbers without specifying argument 'seed'. There is a risk that those random numbers are not statistically sound and the overall results might be invalid. To fix this, specify 'seed=TRUE'. This ensures that proper, parallel-safe random numbers are produced. To disable this check, use 'seed=NULL', or set option 'future.rng.onMisuse' to \"ignore\".", label)
  }
  cond <- FutureCondition(message = message, call = call, uuid = uuid, future = future)
  class <- c("RngFutureCondition", class(cond))
  class(cond) <- class[!duplicated(class, fromLast = TRUE)]
  cond
}

#' @rdname FutureCondition
#' @export
RngFutureWarning <- function(...) {
  cond <- RngFutureCondition(...)
  class <- c("RngFutureWarning", "FutureWarning", "warning", class(cond))
  class(cond) <- class[!duplicated(class, fromLast = TRUE)]
  cond
}

#' @rdname FutureCondition
#' @export
RngFutureError <- function(...) {
  cond <- RngFutureCondition(...)
  class <- c("RngFutureError", "FutureError", "error", class(cond))
  class(cond) <- class[!duplicated(class, fromLast = TRUE)]
  cond
}


#' @param hint (optional) A string with a suggestion on what might be wrong.
#'
#' @rdname FutureCondition
#' @export
UnexpectedFutureResultError <- function(future, hint = NULL) {
  label <- sQuoteLabel(future)
  expr <- hexpr(future[["expr"]])
  result <- future[["result"]]
  result_string <- hpaste(as.character(result))
  if (length(result_string) == 0L)
    result_string <- ""
  else if (nchar(result_string) > 512L)
    result_string <- paste(substr(result_string, start = 1L, stop = 512L),
                           "...")
  if (!is.null(hint)) {
    result_string <- if (nzchar(result_string)) {
      sprintf("%s. %s", result_string, hint)
    } else {
      hint
    }
  }
  msg <- sprintf("Unexpected result (of class %s != %s) retrieved for %s future (label = %s, expression = %s): %s",
                 sQuote(class(result)[1]), sQuote("FutureResult"),
                 class(future)[1], label, sQuote(expr),
                 result_string)
  cond <- FutureError(msg, future = future)
  class <- c("UnexpectedFutureResultError", class(cond))
  class(cond) <- class[!duplicated(class, fromLast = TRUE)]
  cond
}



#' @rdname FutureCondition
#' @export
GlobalEnvMisuseFutureCondition <- function(message = NULL, call = NULL, differences = NULL, uuid = future[["uuid"]], future = NULL) {
  if (is.null(message)) {
    label <- sQuoteLabel(future)
    message <- sprintf("%s (%s) added variables to the global environment. A future expression should never assign variables to the global environment - neither by assign() nor by <<-: [n=%d] %s", class(future)[1], label, length(differences[["added"]]), commaq(differences[["added"]]))
    message <- sprintf("%s. See also help(\"future.options\", package = \"future\")", message)
  }
  cond <- FutureCondition(message = message, call = call, uuid = uuid, future = future)
  cond[["differences"]] <- differences
  class <- c("GlobalEnvMisuseFutureCondition", class(cond))
  class(cond) <- class[!duplicated(class, fromLast = TRUE)]
  cond
}

#' @rdname FutureCondition
#' @export
GlobalEnvMisuseFutureWarning <- function(...) {
  cond <- GlobalEnvMisuseFutureCondition(...)
  class <- c("GlobalEnvMisuseFutureWarning", "FutureWarning", "warning", class(cond))
  class(cond) <- class[!duplicated(class, fromLast = TRUE)]
  cond
}

#' @rdname FutureCondition
#' @export
GlobalEnvMisuseFutureError <- function(...) {
  cond <- GlobalEnvMisuseFutureCondition(...)
  class <- c("GlobalEnvMisuseFutureError", "FutureError", "error", class(cond))
  class(cond) <- class[!duplicated(class, fromLast = TRUE)]
  cond
}


#' @rdname FutureCondition
#' @export
ConnectionMisuseFutureCondition <- function(message = NULL, call = NULL, differences = NULL, uuid = future[["uuid"]], future = NULL) {
  if (is.null(message)) {
    label <- sQuoteLabel(future)
    message <- sprintf("%s (%s) added, removed, or modified connections. A future expression must close any opened connections and must not close connections it did not open", class(future)[1], label)
    if (!is.null(differences)) {
      details <- lapply(differences, FUN = function(diffs) {
        if (is.null(diffs)) {
          "<none>"
        } else {
          diffs <- apply(diffs, MARGIN = 1L, FUN = function(diff) {
            paste(sprintf("%s=%s", names(diff), diff), collapse = ", ")
          })
          paste(sprintf("[%s]", diffs), collapse = "; ")
        }
      })
      details <- unlist(details, use.names = TRUE)
      counts <- vapply(differences, FUN = NROW, FUN.VALUE = 0L)
      details <- sprintf("%d connection %s (%s)", counts, names(details), details)
      details <- paste(details, collapse = ", ")
      message <- sprintf("%s. Details: %s", message, details)
    }
    message <- sprintf("%s. See also help(\"future.options\", package = \"future\")", message)
  }
  cond <- FutureCondition(message = message, call = call, uuid = uuid, future = future)
  cond[["differences"]] <- differences
  class <- c("ConnectionMisuseFutureCondition", "MisuseFutureCondition", class(cond))
  class(cond) <- class[!duplicated(class, fromLast = TRUE)]
  cond
}

#' @rdname FutureCondition
#' @export
ConnectionMisuseFutureWarning <- function(...) {
  cond <- ConnectionMisuseFutureCondition(...)
  class <- c("ConnectionMisuseFutureWarning", "MisuseFutureWarning", "FutureWarning", "warning", class(cond))
  class(cond) <- class[!duplicated(class, fromLast = TRUE)]
  cond
}

#' @rdname FutureCondition
#' @export
ConnectionMisuseFutureError <- function(...) {
  cond <- ConnectionMisuseFutureCondition(...)
  class <- c("ConnectionMisuseFutureError", "MisuseFutureError", "FutureError", "error", class(cond))
  class(cond) <- class[!duplicated(class, fromLast = TRUE)]
  cond
}



#' @rdname FutureCondition
#' @export
DeviceMisuseFutureCondition <- function(message = NULL, call = NULL, differences = NULL, uuid = future[["uuid"]], future = NULL) {
  if (is.null(message)) {
    label <- sQuoteLabel(future)
    message <- sprintf("%s (%s) added, removed, or modified devices. A future expression must close any opened devices and must not close devices it did not open", class(future)[1], label)
    if (!is.null(differences)) {
      details <- character(0L)
      for (kk in seq_len(nrow(differences))) {
        data <- differences[kk, ]
        details[[kk]] <- sprintf("index=%d, before=%s, after=%s", data[["index"]], sQuote(data[["before"]]), sQuote(data[["after"]]))
      }
      details <- unlist(details, use.names = FALSE)
      details <- sprintf("%d devices differ: %s", length(details), paste(details, collapse = "; "))
      message <- sprintf("%s. Details: %s", message, details)
    }
    message <- sprintf("%s. See also help(\"future.options\", package = \"future\")", message)
  }
  cond <- FutureCondition(message = message, call = call, uuid = uuid, future = future)
  cond[["differences"]] <- differences
  class <- c("DeviceMisuseFutureCondition", "MisuseFutureCondition", class(cond))
  class(cond) <- class[!duplicated(class, fromLast = TRUE)]
  cond
}

#' @rdname FutureCondition
#' @export
DeviceMisuseFutureWarning <- function(...) {
  cond <- DeviceMisuseFutureCondition(...)
  class <- c("DeviceMisuseFutureWarning", "MisuseFutureWarning", "FutureWarning", "warning", class(cond))
  class(cond) <- class[!duplicated(class, fromLast = TRUE)]
  cond
}

#' @rdname FutureCondition
#' @export
DeviceMisuseFutureError <- function(...) {
  cond <- DeviceMisuseFutureCondition(...)
  class <- c("DeviceMisuseFutureError", "MisuseFutureError", "FutureError", "error", class(cond))
  class(cond) <- class[!duplicated(class, fromLast = TRUE)]
  cond
}



#' @rdname FutureCondition
#' @export
DefaultDeviceMisuseFutureCondition <- function(message = NULL, incidents = NULL, call = NULL, uuid = future[["uuid"]], future = NULL) {
  if (is.null(message)) {
    label <- sQuoteLabel(future)
    message <- sprintf("%s (%s) opened the default graphics device", class(future)[1], label)
    if (length(incidents) > 0L) {
      calls <- lapply(incidents, FUN = lapply, deparse)
      calls <- lapply(calls, FUN = function(calls) {
        if (length(calls) > 3L) calls <- c(head(calls, n = 3L), "...")
        calls
      })
      calls <- lapply(calls, FUN = paste, collapse = " -> ")
      calls <- unlist(calls, use.names = FALSE)
      calls <- sprintf("%d: %s", seq_along(calls), calls)
      calls <- paste(calls, collapse = "; ")
      message <- sprintf("%s (%s) opened the default graphics device (%s)", class(future)[1], label, calls)
    }
    message <- sprintf("%s. This happens for instance if plot() is called without explicitly opening a graphics device before. Using default graphics devices in parallel processing will typically leave behind an 'Rplots.pdf' file on the parallel worker. If the intention is to plot to file, please open a graphics device explicitly (e.g. pdf() or png()) [recommended], or set your preferred `options(default = ...)` [not recommended], then plot, and make sure to close it at the end (i.e. dev.off())", message)
    message <- sprintf("%s. See also help(\"future.options\", package = \"future\")", message)
  }
  cond <- FutureCondition(message = message, call = call, uuid = uuid, future = future)
  class <- c("DefaultDeviceMisuseFutureCondition", "MisuseFutureCondition", class(cond))
  class(cond) <- class[!duplicated(class, fromLast = TRUE)]
  cond
}

#' @rdname FutureCondition
#' @export
DefaultDeviceMisuseFutureWarning <- function(...) {
  cond <- DefaultDeviceMisuseFutureCondition(...)
  class <- c("DefaultDeviceMisuseFutureWarning", "MisuseFutureWarning", "FutureWarning", "warning", class(cond))
  class(cond) <- class[!duplicated(class, fromLast = TRUE)]
  cond
}

#' @rdname FutureCondition
#' @export
DefaultDeviceMisuseFutureError <- function(...) {
  cond <- DefaultDeviceMisuseFutureCondition(...)
  class <- c("DefaultDeviceMisuseFutureError", "MisuseFutureError", "FutureError", "error", class(cond))
  class(cond) <- class[!duplicated(class, fromLast = TRUE)]
  cond
}



#' @rdname FutureCondition
#' @export
FutureLaunchError <- function(..., future = NULL) {
  cond <- FutureError(..., future = future)
  class <- c("FutureLaunchError", class(cond))
  class(cond) <- class[!duplicated(class, fromLast = TRUE)]
  cond
}

#' @rdname FutureCondition
#' @export
FutureInterruptError <- function(..., future = NULL) {
  cond <- FutureError(..., future = future)
  class <- c("FutureInterruptError", class(cond))
  class(cond) <- class[!duplicated(class, fromLast = TRUE)]
  cond
}

#' @rdname FutureCondition
#' @export
FutureCanceledError <- function(..., future = NULL) {
  cond <- FutureError(..., future = future)
  class <- c("FutureCanceledError", class(cond))
  class(cond) <- class[!duplicated(class, fromLast = TRUE)]
  cond
}

#' @rdname FutureCondition
#' @export
FutureDroppedError <- function(..., future = NULL) {
  cond <- FutureError(..., future = future)
  class <- c("FutureDroppedError", class(cond))
  class(cond) <- class[!duplicated(class, fromLast = TRUE)]
  cond
}
