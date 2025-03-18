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
#' @param \ldots All arguments used by the S3 methods.
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
  if (future[["state"]] == "created") {
    future <- run(future)
  }

  result <- result(future)
  stop_if_not(inherits(result, "FutureResult"))

  value <- result[["value"]]
  visible <- result[["visible"]]

  ## Always signal immediateCondition:s and as soon as possible.
  ## They will always be signaled if they exist.
  signalImmediateConditions(future)

  ## Output captured standard output?
  if (stdout) {
    if (length(result[["stdout"]]) > 0 &&
        inherits(result[["stdout"]], "character")) {
      out <- paste(result[["stdout"]], collapse = "\n")
      if (nzchar(out)) {
        ## AD HOC: Fix captured UTF-8 output on MS Windows?
        if (!isTRUE(result[["r_info"]][["captures_utf8"]]) &&
            getOption("future.stdout.windows.reencode", TRUE)) {
          out <- adhoc_native_to_utf8(out)
        }
        cat(out)
      }
    }

    ## Drop captured stdout to save memory?
    if (isTRUE(attr(future[["stdout"]], "drop"))) {
      result[["stdout"]] <- NULL
      future[["result"]] <- result
    }
  }


  ## Were there any variables added to the global enviroment?
  if (length(result[["globalenv"]][["added"]]) > 0L) {
    onMisuse <- getOption("future.globalenv.onMisuse")
    if (is.null(onMisuse)) onMisuse <- "ignore"
    if (onMisuse != "ignore") {
      if (onMisuse == "error") {
        cond <- GlobalEnvFutureError(globalenv = result[["globalenv"]], future = future)
      } else if (onMisuse == "warning") {
        cond <- GlobalEnvFutureWarning(globalenv = result[["globalenv"]], future = future)
      } else {
        cond <- NULL
        warnf("Unknown value on option 'future.globalenv.onMisuse': %s",
              sQuote(onMisuse))
      }

      if (!is.null(cond)) {
        ## FutureCondition to stack of captured conditions
        new <- list(condition = cond, signaled = FALSE)
        conditions <- result[["conditions"]]
        n <- length(conditions)
      
        ## An existing run-time error takes precedence
        if (n > 0L && inherits(conditions[[n]][["condition"]], "error")) {
          conditions[[n + 1L]] <- conditions[[n]]
          conditions[[n]] <- new
        } else {
          conditions[[n + 1L]] <- new
        }
        
        result[["conditions"]] <- conditions
        future[["result"]] <- result
      }
    }
  }


  ## Was RNG used without requesting RNG seeds?
  if (!isTRUE(future[[".rng_checked"]]) && isFALSE(future[["seed"]]) && isTRUE(result[["rng"]])) {
    ## BACKWARD COMPATIBILITY: Until higher-level APIs set future()
    ## argument 'seed' to indicate that RNGs are used. /HB 2019-12-24
    rng_config <- parallel_rng_kind()
    is_seed <- rng_config[["is_seed"]]
    
    if (any(grepl(".doRNG.stream", deparse(future[["expr"]]), fixed = TRUE))) {
      ## doFuture w/ doRNG, e.g. %dorng%
    } else if (is_seed(future[["globals"]][["...future.seeds_ii"]][[1]])) {
      .Defunct(msg = "Please upgrade your 'future.apply' or 'furrr' (type 1)")
    } else if (is_seed(future[["envir"]][["...future.seeds_ii"]][[1]])) {
      .Defunct(msg = "Please upgrade your 'future.apply' or 'furrr' (type 2)")
    } else {
      onMisuse <- getOption("future.rng.onMisuse")
      if (is.null(onMisuse)) onMisuse <- "warning"
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
          conditions <- result[["conditions"]]
          n <- length(conditions)
          
          ## An existing run-time error takes precedence
          if (n > 0L && inherits(conditions[[n]][["condition"]], "error")) {
            conditions[[n + 1L]] <- conditions[[n]]
            conditions[[n]] <- new
          } else {
            conditions[[n + 1L]] <- new
          }
          
          result[["conditions"]] <- conditions
          future[["result"]] <- result
        }
      }
    }
  }
  
  future[[".rng_checked"]] <- TRUE


  ## Check for non-exportable objects in the value?
  onReference <- future[["onReference"]]
  if (onReference %in% c("error", "warning")) {
    new <- tryCatch({
      assert_no_references(value, action = onReference, source = "value")
      NULL
    }, FutureCondition = function(cond) {
      list(condition = cond, signaled  = FALSE)
    })

    if (!is.null(new)) {
      ## Append FutureCondition to the regular condition stack
      conditions <- result[["conditions"]]
      n <- length(conditions)

      ## An existing run-time error takes precedence
      if (n > 0L && inherits(conditions[[n]][["condition"]], "error")) {
        conditions[[n + 1L]] <- conditions[[n]]
        conditions[[n]] <- new
      } else {
        conditions[[n + 1L]] <- new
      }
      
      result[["conditions"]] <- conditions
      future[["result"]] <- result
    }
  }


  ## Signal captured conditions?
  conditions <- result[["conditions"]]
  if (length(conditions) > 0) {
    if (signal) {
      mdebugf("Future state: %s", sQuote(future[["state"]]))
      ## Will signal an (eval) error, iff exists

      conditionClasses <- future[["conditions"]]
      immediateConditionClasses <- attr(conditionClasses, "immediateConditionClasses", exact = TRUE)
      if (is.null(immediateConditionClasses)) {
        immediateConditionClasses <- "immediateCondition"
      }

      signalConditions(future, exclude = immediateConditionClasses, resignal = TRUE)
    } else {
      ## Return 'error' object, iff exists, otherwise NULL
      error <- conditions[[length(conditions)]][["condition"]]
      if (inherits(error, "error")) {
        value <- error
        visible <- TRUE
      }
    }
  }
  
  if (isTRUE(visible)) value else invisible(value)
}


#' @inheritParams resolve
#'
#' @param reduce An optional function for reducing all the values.
#' Optional attribute `init` can be used to set initial value for the
#' reduction. If not specified, the first value will be used as the
#' initial value.
#' Reduction of values is done as soon as possible, but always in the
#' same order as `x`.
#'
#' @param interrupt If TRUE and `signal` is TRUE, non-resolved futures are
#' interrupted as soon as an error is detected in one of the futures,
#' before signaling the error.
#'
#' @rdname value
#' @export
value.list <- function(x, idxs = NULL, recursive = 0, reduce = NULL, stdout = TRUE, signal = TRUE, interrupt = TRUE, force = TRUE, sleep = getOption("future.wait.interval", 0.01), ...) {
  if (is.logical(recursive)) {
    if (recursive) recursive <- getOption("future.resolve.recursive", 99)
  }
  recursive <- as.numeric(recursive)

  ## Validate 'reduce'
  do_reduce <- !is.null(reduce)

  if (do_reduce) {
    with_assert({
      stop_if_not(is.function(reduce))
      if (!is.primitive(reduce)) {
        args <- names(formals(reduce))
        if (length(args) == 0) {
          stop("The 'reduce' function must take at least one argument")
        }
      }
    })
    
    reduced_until <- 0L
    reduced_init <- ("init" %in% names(attributes(reduce)))
    reduced_value <- attr(reduce, "init", exact = TRUE)
  }

  stop_if_not(
    length(stdout) == 1L, is.logical(stdout), !is.na(stdout),
    length(signal) == 1L, is.logical(signal), !is.na(signal),
    length(interrupt) == 1L, is.logical(interrupt), !is.na(interrupt)
  )
  relay <- (stdout || signal)

  x <- futures(x)
  
  ## Subset?
  if (!is.null(idxs)) {
    if (inherits(x, "listenv")) {
      idxs <- subset_list(x, idxs = idxs)
    } else {
      idxs <- subset_listenv(x, idxs = idxs)
    }
    x <- x[idxs]
    idxs <- NULL
  }

  if (inherits(x, "listenv")) {
    ## NOTE: Contrary to other implementations that use .length(x), we here
    ## do need to use generic length() that dispatches on class.
    nx <- length(x)
  } else {
    nx <- .length(x)
  }
  
  values <- vector("list", length = nx)
  if (!do_reduce) {
    dim <- dim(x)
    if (!is.null(dim)) {
      dim(values) <- dim
      ## Preserve dimnames and names
      dimnames(values) <- dimnames(x)
    }
    names(values) <- names(x)
  }
  
  ## Nothing todo?
  if (nx == 0) {
    if (do_reduce) return(reduced_value)
    return(values)
  }

  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebug("value() on list ...")
    mdebugf(" - recursive: %s", recursive)
    on.exit(mdebug("value() on list ... done"))
  }

  
  ## NOTE: Everything is considered non-resolved by default

  ## Total number of values to resolve
  total <- nx
  remaining <- seq_len(nx)
  resolved <- logical(length = nx)

  ## Relay?
  signalConditionsASAP <- make_signalConditionsASAP(nx, stdout = stdout, signal = signal, force = force, debug = debug)

  if (debug) {
    mdebugf(" length: %d", nx)
    mdebugf(" elements: %s", hpaste(sQuote(names(x))))
  }

  if (do_reduce) {
    reduced <- logical(length = nx)
  
    reduce_forward <- function(from) {
      if (debug) {
        mdebug("reduce_forward() ...")
        on.exit({
          mdebug("reduce_forward() ... done")
        })
      }
      if (reduced_until == nx) return()
      while (from <= nx) {
        if (!resolved[from]) return()
        value <- values[[from]]
        reduced_value <<- reduce(reduced_value, value)
        reduced[from] <<- TRUE
        reduced_until <<- from
        values[from] <<- list(NULL)
        if (debug) {
          mdebug("- reduced: ", paste(reduced, collapse = ", "))
        }
        from <- from + 1L
      }
    }
  }

  ## Resolve all elements
  while (length(remaining) > 0) {
    mdebug(" - Number of remaining objects: ", length(remaining))
    for (ii in remaining) {
      mdebugf(" - checking value #%d ...", ii)
      obj <- x[[ii]]

      if (is.atomic(obj)) {
        if (relay) signalConditionsASAP(obj, resignal = FALSE, pos = ii)
        value <- obj
        resolved[ii] <- TRUE
        x[ii] <- list(NULL)
        values[ii] <- list(value)
        
        if (do_reduce) {
          if (ii == reduced_until + 1L) {
            if (reduced_init || reduced_until > 0L) {
              reduced_value <- reduce(reduced_value, value)
            } else {
              reduced_value <- value
            }
            reduced[ii] <- TRUE
            reduced_until <- ii
            values[ii] <- list(NULL)
            reduce_forward(from = ii + 1L)
          }
          if (debug) {
            mdebug(" - reduced: ", paste(reduced, collapse = ", "))
          }          
        }
      } else {
        ## If an unresolved future, move on to the next object
        ## so that future can be resolved in the asynchronously
        if (inherits(obj, "Future")) {
          ## Lazy future that is not yet launched?
          if (obj[["state"]] == 'created') obj <- run(obj)
          if (!resolved(obj)) next
          if (debug) mdebugf("Future #%d", ii)
          relay_ok <- relay && signalConditionsASAP(obj, resignal = FALSE, pos = ii)
          
          value <- value(obj, stdout = FALSE, signal = FALSE)
          if (signal && inherits(value, "error")) {
            y <- futures(x)
            if (interrupt) interrupt(y)
            y <- resolve(y, result = TRUE, stdout = stdout, signal = signal, force = TRUE)
            stop(value)
          }
          
          resolved[ii] <- TRUE
          x[ii] <- list(NULL)
          values[ii] <- list(value)
          
          if (do_reduce) {
            if (ii == reduced_until + 1L) {
              if (reduced_init || reduced_until > 0L) {
                reduced_value <- reduce(reduced_value, value)
              } else {
                reduced_value <- value
              }
              reduced[ii] <- TRUE
              reduced_until <- ii
              values[ii] <- list(NULL)
              resolved[ii] <- TRUE
              reduce_forward(from = ii + 1L)
            }
            if (debug) {
              mdebug(" - reduced: ", paste(reduced, collapse = ", "))
            }          
          }
        }
  
        relay_ok <- relay && signalConditionsASAP(obj, resignal = FALSE, pos = ii)
        
        ## In all other cases, try to resolve
        resolve(
          obj,
          recursive = recursive - 1,
          result = TRUE,
          stdout = stdout && relay_ok,
          signal = signal && relay_ok,
          sleep = sleep, ...
        )
      }

      ## Assume resolved at this point
      remaining <- setdiff(remaining, ii)
      if (debug) mdebugf(" - length: %d (resolved future %s)", length(remaining), ii)
      stop_if_not(!anyNA(remaining))
      mdebugf(" - checking value #%d ... done", ii)
    } # for (ii ...)

    ## Wait a bit before checking again
    if (length(remaining) > 0) Sys.sleep(sleep)
  } # while (...)

  if (relay || force) {
    if (debug) mdebug("Relaying remaining futures")
    signalConditionsASAP(resignal = FALSE, pos = 0L)
  }

  if (do_reduce) {
    reduce_forward(from = reduced_until)
    stop_if_not(
      all(resolved),
      reduced_until == nx,
      all(reduced),
      all(lengths(values) == 0L)
    )
    values <- reduced_value
  }

  values
} ## value() for list


#' @rdname value
#' @export
value.listenv <- value.list


#' @rdname value
#' @importFrom listenv as.listenv
#' @export
value.environment <- function(x, ...) {
  value(as.listenv(x), ...)
}
