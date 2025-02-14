#' The value of a future or the values of all elements in a container
#'
#' Gets the value of a future or the values of all elements (including futures)
#' in a container such as a list, an environment, or a list environment.
#' If one or more futures is unresolved, then this function blocks until all
#' queried futures are resolved.
#'
#' @param future,x A [Future], an environment, a list, or a list environment.
#'
#' @param stdout If TRUE, standard output captured while resolving futures
#' is relayed, otherwise not.
#' 
#' @param signal If TRUE, \link[base]{conditions} captured while resolving
#' futures are relayed, otherwise not.
#' 
#' @param \dots All arguments used by the S3 methods.
#'
#' @return
#' `value()` of a Future object returns the value of the future, which can
#' be any type of \R object.
#'
#' `value()` of a list, an environment, or a list environment returns an
#' object with the same number of elements and of the same class.
#' Names and dimension attributes are preserved, if available.
#' All future elements are replaced by their corresponding `value()` values.
#' For all other elements, the existing object is kept as-is.
#' 
#' If `signal` is TRUE and one of the futures produces an error, then
#' that error is produced.
#'
#' @rdname value
#' @export
value <- function(...) UseMethod("value")


#' @rdname value
#' @export
value.Future <- function(future, stdout = TRUE, signal = TRUE, ...) {
  if (future$state == "created") {
    future <- run(future)
  }

  result <- result(future)
  stop_if_not(inherits(result, "FutureResult"))

  value <- result$value
  visible <- result$visible
  if (is.null(visible)) visible <- TRUE

  ## Always signal immediateCondition:s and as soon as possible.
  ## They will always be signaled if they exist.
  signalImmediateConditions(future)

  ## Output captured standard output?
  if (stdout) {
    if (length(result$stdout) > 0 &&
        inherits(result$stdout, "character")) {
      out <- paste(result$stdout, collapse = "\n")
      if (nzchar(out)) {
        ## AD HOC: Fix captured UTF-8 output on MS Windows?
        if (!isTRUE(result$r_info$captures_utf8) && getOption("future.stdout.windows.reencode", TRUE)) {
          out <- adhoc_native_to_utf8(out)
        }
        cat(out)
      }
    }

    ## Drop captured stdout to save memory?
    if (isTRUE(attr(future$stdout, "drop"))) {
      result$stdout <- NULL
      future$result <- result
    }
  }


  ## Were there any variables added to the global enviroment?
  if (length(result$globalenv$added) > 0L) {
    onMisuse <- getOption("future.globalenv.onMisuse", "ignore")
    if (onMisuse != "ignore") {
      if (onMisuse == "error") {
        cond <- GlobalEnvFutureError(globalenv = result$globalenv, future = future)
      } else if (onMisuse == "warning") {
        cond <- GlobalEnvFutureWarning(globalenv = result$globalenv, future = future)
      } else {
        cond <- NULL
        warnf("Unknown value on option 'future.globalenv.onMisuse': %s",
              sQuote(onMisuse))
      }

      if (!is.null(cond)) {
        ## FutureCondition to stack of captured conditions
        new <- list(condition = cond, signaled = FALSE)
        conditions <- result$conditions
        n <- length(conditions)
      
        ## An existing run-time error takes precedence
        if (n > 0L && inherits(conditions[[n]]$condition, "error")) {
          conditions[[n + 1L]] <- conditions[[n]]
          conditions[[n]] <- new
        } else {
          conditions[[n + 1L]] <- new
        }
        
        result$conditions <- conditions
        future$result <- result
      }
    }
  }


  ## Was RNG used without requesting RNG seeds?
  if (!isTRUE(future$.rng_checked) && isFALSE(future$seed) && isTRUE(result$rng)) {
    ## BACKWARD COMPATIBILITY: Until higher-level APIs set future()
    ## argument 'seed' to indicate that RNGs are used. /HB 2019-12-24
    if (any(grepl(".doRNG.stream", deparse(future$expr), fixed = TRUE))) {
      ## doFuture w/ doRNG, e.g. %dorng%
    } else if (is_lecyer_cmrg_seed(future$globals$...future.seeds_ii[[1]])) {
      .Defunct(msg = "Please upgrade your 'future.apply' or 'furrr' (type 1)")
    } else if (is_lecyer_cmrg_seed(future$envir$...future.seeds_ii[[1]])) {
      .Defunct(msg = "Please upgrade your 'future.apply' or 'furrr' (type 2)")
    } else {
      onMisuse <- getOption("future.rng.onMisuse", "warning")
      if (onMisuse != "ignore") {
        if (onMisuse == "error") {
          cond <- RngFutureError(future = future)
        } else if (onMisuse == "warning") {
          cond <- RngFutureWarning(future = future)
        } else {
          cond <- NULL
          warnf("Unknown value on option 'future.rng.onMisuse': %s",
                  sQuote(onMisuse))
        }

        if (!is.null(cond)) {
          ## RngFutureCondition to stack of captured conditions
          new <- list(condition = cond, signaled = FALSE)
          conditions <- result$conditions
          n <- length(conditions)
          
          ## An existing run-time error takes precedence
          if (n > 0L && inherits(conditions[[n]]$condition, "error")) {
            conditions[[n + 1L]] <- conditions[[n]]
            conditions[[n]] <- new
          } else {
            conditions[[n + 1L]] <- new
          }
          
          result$conditions <- conditions
          future$result <- result
        }
      }
    }
  }
  
  future$.rng_checked <- TRUE


  ## Check for non-exportable objects in the value?
  onReference <- getOption("future.globals.onReference", "ignore")
  if (onReference %in% c("error", "warning")) {
    new <- tryCatch({
      assert_no_references(value, action = onReference, source = "value")
      NULL
    }, FutureCondition = function(cond) {
      list(condition = cond, signaled  = FALSE)
    })

    if (!is.null(new)) {
      ## Append FutureCondition to the regular condition stack
      conditions <- result$conditions
      n <- length(conditions)

      ## An existing run-time error takes precedence
      if (n > 0L && inherits(conditions[[n]]$condition, "error")) {
        conditions[[n + 1L]] <- conditions[[n]]
        conditions[[n]] <- new
      } else {
        conditions[[n + 1L]] <- new
      }
      
      result$conditions <- conditions
      future$result <- result
    }
  }


  ## Signal captured conditions?
  conditions <- result$conditions
  if (length(conditions) > 0) {
    if (signal) {
      mdebugf("Future state: %s", sQuote(future$state))
      ## Will signal an (eval) error, iff exists
      signalConditions(future, exclude = getOption("future.relay.immediate", "immediateCondition"), resignal = TRUE)
    } else {
      ## Return 'error' object, iff exists, otherwise NULL
      error <- conditions[[length(conditions)]]$condition
      if (inherits(error, "error")) {
        value <- error
        visible <- TRUE
      }
    }
  }
  
  if (visible) value else invisible(value)
}


#' @rdname value
#' @export
value.list <- function(x, stdout = TRUE, signal = TRUE, ...) {
  y <- futures(x)
  y <- resolve(y, result = TRUE, stdout = stdout, signal = signal, force = TRUE)
  for (ii in seq_along(y)) {
    f <- y[[ii]]
    if (!inherits(f, "Future")) next
    v <- value(f, stdout = FALSE, signal = FALSE, ...)
    if (signal && inherits(v, "error")) stop(v)
    if (is.null(v)) {
      y[ii] <- list(NULL)
    } else {
      y[[ii]] <- v
      v <- NULL
    }
  }
  y
}


#' @rdname value
#' @export
value.listenv <- value.list


#' @rdname value
#' @export
value.environment <- function(x, stdout = TRUE, signal = TRUE, ...) {
  y <- futures(x)
  y <- resolve(y, result = TRUE, stdout = stdout, signal = signal, force = TRUE)
  names <- ls(envir = y, all.names = TRUE)
  for (key in names) {
    f <- y[[key]]
    if (!inherits(f, "Future")) next
    v <- value(f, stdout = FALSE, signal = FALSE, ...)
    if (signal && inherits(v, "error")) stop(v)
    y[[key]] <- v
  }
  y
}
