
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
#' @param inorder If TRUE, then standard output and conditions are relayed,
#' and value reduction, is done in the order the futures occur in `x`, but
#' always as soon as possible. This is achieved by buffering the details
#' until they can be released. By setting `inorder = FALSE`, no buffering
#' takes place and everything is relayed and reduced as soon as a new future
#' is resolved. Regardlessly, the values are always returned in the same
#' order as `x`.
#'
#' @param drop If TRUE, resolved futures are minimized in size and invalidated
#' as soon the as their values have been collected and any output and
#' conditions have been relayed.
#' Combining `drop = TRUE` with `inorder = FALSE` reduces the memory use
#' sooner, especially avoiding the risk of holding on to future values until
#' the very end.
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
#' that error is relayed. Any remaining, non-resolved futures in `x` are
#' canceled, prior to signaling such an error.
#'
#' @example incl/value.R
#'
#' @rdname value
#' @export
value <- function(...) UseMethod("value")


drop_future <- function(future) {
  class <- class(future)[1]
  label <- sQuoteLabel(future)
  msg <- sprintf("Future (%s) of class %s is no longer valid, because its content has been minimized using value(..., drop = TRUE)", label, class)
  error <- FutureDroppedError(msg, future = future)
  
  future <- reset(future)
  future[["expr"]] <- NULL
  future[["globals"]] <- NULL
  future[["packages"]] <- NULL
  future[["result"]] <- FutureResult(conditions = list(
    list(condition = error, signaled = FALSE)
  ))
  future[["state"]] <- "finished"
  class(future) <- c("DroppedFuture", "UniprocessFuture", "Future")
  future
}


#' @rdname value
#' @export
value.Future <- function(future, stdout = TRUE, signal = TRUE, drop = FALSE, ...) {
  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebugf_push("value() for %s (%s) ...", class(future)[1], sQuoteLabel(future))
    on.exit(mdebugf_pop())
  }
  
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
    if (debug) mdebugf_push("relay stdout ...")
    
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
    
    if (debug) mdebug_pop()
  }


  if (debug) mdebugf_push("check for misuse ...")

  ## ------------------------------------------------------------------
  ## Report on misuse of the global environment
  ## ------------------------------------------------------------------
  ## Were there any variables added to the global enviroment?
  if (length(result[["misuseGlobalEnv"]][["added"]]) > 0L) {
    onMisuse <- getOption("future.globalenv.onMisuse")
    if (is.null(onMisuse)) onMisuse <- "ignore"
    if (onMisuse != "ignore") {
      if (onMisuse == "error") {
        cond <- GlobalEnvMisuseFutureError(differences = result[["misuseGlobalEnv"]], future = future)
      } else if (onMisuse == "warning") {
        cond <- GlobalEnvMisuseFutureWarning(differences = result[["misuseGlobalEnv"]], future = future)
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


  ## ------------------------------------------------------------------
  ## Report on misuse of the connections
  ## ------------------------------------------------------------------
  ## Were there any connections added, removed, or changed?
  if (any(lengths(result[["misuseConnections"]]) > 0L)) {
    onMisuse <- getOption("future.connections.onMisuse")
    if (is.null(onMisuse)) onMisuse <- "warning"
    if (onMisuse != "ignore") {
      if (onMisuse == "error") {
        cond <- ConnectionMisuseFutureError(differences = result[["misuseConnections"]], future = future)
      } else if (onMisuse == "warning") {
        cond <- ConnectionMisuseFutureWarning(differences = result[["misuseConnections"]], future = future)
      } else {
        cond <- NULL
        warnf("Unknown value on option 'future.connections.onMisuse': %s",
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


  ## ------------------------------------------------------------------
  ## Report on misuse of the devices
  ## ------------------------------------------------------------------
  ## Were there any devices added, removed, or changed?
  if (!is.null(result[["misuseDevices"]])) {
    onMisuse <- getOption("future.devices.onMisuse")
    if (is.null(onMisuse)) onMisuse <- "warning"
    if (onMisuse != "ignore") {
      if (onMisuse == "error") {
        cond <- DeviceMisuseFutureError(differences = result[["misuseDevices"]], future = future)
      } else if (onMisuse == "warning") {
        cond <- DeviceMisuseFutureWarning(differences = result[["misuseDevices"]], future = future)
      } else {
        cond <- NULL
        warnf("Unknown value on option 'future.devices.onMisuse': %s",
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

  ## ------------------------------------------------------------------
  ## Report on misuse of the default devices
  ## ------------------------------------------------------------------
  if (length(result[["misuseDefaultDevice"]]) > 0L) {
    onMisuse <- getOption("future.defaultDevice.onMisuse")
    if (is.null(onMisuse)) onMisuse <- "warning"
    if (onMisuse != "ignore") {
      if (onMisuse == "error") {
        cond <- DefaultDeviceMisuseFutureError(incidents = result[["misuseDefaultDevice"]], future = future)
      } else if (onMisuse == "warning") {
        cond <- DefaultDeviceMisuseFutureWarning(incidents = result[["misuseDefaultDevice"]], future = future)
      } else {
        cond <- NULL
        warnf("Unknown value on option 'future.defaultDevice.onMisuse': %s",
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


  ## ------------------------------------------------------------------
  ## Report on misuse of the RNG
  ## ------------------------------------------------------------------
  ## Was RNG used without requesting RNG seeds?
  if (!isTRUE(future[[".rng_checked"]]) && isFALSE(future[["seed"]]) && isTRUE(result[["rng"]])) {
    ## BACKWARD COMPATIBILITY: Until higher-level APIs set future()
    ## argument 'seed' to indicate that RNGs are used. /HB 2019-12-24
    rng_config <- parallel_rng_kind()
    is_seed <- rng_config[["is_seed"]]
    
    if (any(grepl(".doRNG.stream", deparse(future[["expr"]]), fixed = TRUE))) {
      ## doFuture w/ doRNG, e.g. %dorng%
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

  if (debug) mdebugf_pop()



  ## Signal captured conditions?
  conditions <- result[["conditions"]]
  if (length(conditions) > 0) {
    if (signal) {
      if (debug) {
        mdebugf_push("relay conditions ...")
        mdebugf("Future state: %s", sQuote(future[["state"]]))
      }
      ## Will signal an (eval) error, iff exists

      conditionClasses <- future[["conditions"]]
      immediateConditionClasses <- attr(conditionClasses, "immediateConditionClasses", exact = TRUE)
      if (is.null(immediateConditionClasses)) {
        immediateConditionClasses <- "immediateCondition"
      }

      signalConditions(future, exclude = immediateConditionClasses, resignal = TRUE)
      if (debug) mdebugf_pop()
    } else {
      ## Return 'error' object, iff exists, otherwise NULL
      error <- conditions[[length(conditions)]][["condition"]]
      if (inherits(error, "error")) {
        value <- error
        visible <- TRUE
      }
    }
  }

  ## Minimize and invalidate results?
  if (drop) {
    mdebugf_push("Minimize future object ...")
    future <- drop_future(future)
    mdebugf_pop()
  }
  
  if (isTRUE(visible)) value else invisible(value)
}


name_of_function <- function(fcn, add_backticks = FALSE) {
  env <- baseenv()
  names <- names(env)
  for (name in names) {
    obj <- get(name, envir = env, inherits = FALSE)
    if (is.function(obj) && identical(obj, fcn)) {
      if (add_backticks && !grepl("^[[:alpha:]]", name)) {
        name <- sprintf("`%s`", name)
      }
      return(name)
    }
  }
  "<unknown function>"
}

#' @inheritParams resolve
#' @inheritParams value
#'
#' @param reduce An optional function for reducing all the values.
#' Optional attribute `init` can be used to set initial value for the
#' reduction. If not specified, the first value will be used as the
#' initial value.
#' Reduction of values is done as soon as possible, but always in the
#' same order as `x`, unless `inorder` is FALSE.
#'
#' @param cancel,interrupt If TRUE and `signal` is TRUE, non-resolved futures
#' are canceled as soon as an error is detected in one of the futures,
#' before signaling the error. Argument `interrupt` is passed to `cancel()`
#' controlling whether non-resolved futures should also be interrupted.
#'
#' @rdname value
#' @export
value.list <- function(x, idxs = NULL, recursive = 0, reduce = NULL, stdout = TRUE, signal = TRUE, cancel = TRUE, interrupt = cancel, inorder = TRUE, drop = FALSE, force = TRUE, sleep = getOption("future.wait.interval", 0.01), ...) { 
  if (is.logical(recursive)) {
    if (recursive) recursive <- getOption("future.resolve.recursive", 99)
  }
  recursive <- as.numeric(recursive)

  ## Validate 'reduce'
  do_reduce <- !is.null(reduce)

  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebugf_push("value() for %s ...", class(x)[1])
    mdebugf("recursive: %s", recursive)
    mdebugf("reduce: %s", do_reduce)
    on.exit(mdebugf_pop())
  }

  if (do_reduce) {
    reduced_until <- 0L
    reduced_init <- ("init" %in% names(attributes(reduce)))
    reduce_init <- attr(reduce, "init")
    reduced_value <- attr(reduce, "init", exact = TRUE)

    if (is.character(reduce)) {
      ## SPECIAL CASE: User-friendly workaround
      ## See R-devel thread '[Rd] structure(<primitive function>, ...) is
      ## sticky: a bug, or should it be an error?' on 2025-03-19
      ## <https://stat.ethz.ch/pipermail/r-devel/2025-March/083892.html>
      ## Only allowed for primitive functions
      if (!exists(reduce, mode = "function", envir = baseenv(), inherits = FALSE)) {
        stop(sprintf("There exist no such 'reduce' function in the 'base' package: %s()", reduce))
      }
      fcn <- get(reduce, mode = "function", envir = baseenv(), inherits = FALSE)
      if (!is.primitive(fcn)) {
        name <- name_of_function(fcn)
       stop(sprintf("The 'reduce' function %s() is not a primitive function. Please use 'reduce = %s' instead", reduce, name))
      }
      reduce <- fcn
    } else if (is.function(reduce)) {
      stop_if_not(is.function(reduce))
      if (!is.primitive(reduce)) {
        args <- names(formals(reduce))
        if (length(args) == 0) {
          stop("The 'reduce' function must take at least one argument")
        }
      }
    }
    
    ## SPECIAL CASE: Protect against mistakes
    ## See R-devel thread '[Rd] structure(<primitive function>, ...) is
    ## sticky: a bug, or should it be an error?' on 2025-03-19
    ## <https://stat.ethz.ch/pipermail/r-devel/2025-March/083892.html>
    if (is.primitive(reduce) && !is.null(attr(reduce, "init", exact = TRUE))) {
      ## FIXME?: At least in R 4.4.3, none of the primitive functions have
      ## attributes. Because of that, we could do attributes(reduce) <- NULL
      ## here before throwing the error. But is that a safe assumption?
      name <- name_of_function(reduce)
      nameq <- name
      if (!grepl("^[[:alpha:]]", nameq)) nameq <- sprintf("`%s`", nameq)
      stop(sprintf("You must not set an 'init' reduce value on 'base' function %s(), because it is a primitive function. You can use 'reduce = structure(\"%s\", init = <value>)' instead", nameq, name))
    }
  } ## if (do_reduce)

  stop_if_not(
    length(stdout) == 1L, is.logical(stdout), !is.na(stdout),
    length(signal) == 1L, is.logical(signal), !is.na(signal),
    length(cancel) == 1L, is.logical(cancel), !is.na(cancel)
  )
  if (isTRUE(interrupt) && !isTRUE(cancel)) {
    stop("Argument 'interrupt' must not be TRUE if argument 'cancel' is FALSE")
  }
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


  ## NOTE: Everything is considered non-resolved by default

  ## Total number of values to resolve
  total <- nx
  remaining <- seq_len(nx)
  resolved <- logical(length = nx)

  ## Relay, and in order or out of order?
  if (inorder) {
    signalConditionsASAP <- make_signalConditionsASAP(nx, stdout = stdout, signal = signal, force = force && !drop, debug = debug)
  } else {
    signalConditionsASAP <- function(...) TRUE
  }

  if (debug) {
    mdebugf("length: %d", nx)
    mdebugf("elements: %s", hpaste(sQuote(names(x))))
  }

  if (do_reduce) {
    reduced <- logical(length = nx)

    ## Reduce in order or out of order?
    if (inorder) {
      reduce_forward <- function(from) {
        if (debug) {
          mdebug_push("reduce_forward() ...")
          on.exit(mdebug_pop())
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
            mdebug("reduced: ", paste(reduced, collapse = ", "))
          }
          from <- from + 1L
        }
      }
    } else {
      reduce_forward <- local({
        first <- TRUE
        function(from) {
          if (debug) {
            mdebug_push("reduce_forward() - inorder = FALSE ...")
            on.exit(mdebug_pop())
          }
          while (from <= nx) {
            if (reduced[from]) return()
            if (!resolved[from]) return()
            value <- values[[from]]
            if (first) {
              reduced_value <<- value
              first <<- FALSE
            } else {
              reduced_value <<- reduce(reduced_value, value)
            }
            reduced[from] <<- TRUE
            reduced_until <<- from
            values[from] <<- list(NULL)
            if (debug) mdebug("reduced: ", paste(reduced, collapse = ", "))
            from <- from + 1L
          }
        }
      })
    }
  }

  ## Collect values for all remaining elements
  while (length(remaining) > 0) {
    if (debug) mdebug("Number of remaining objects: ", length(remaining))
    for (ii in remaining) {
      mdebugf("checking value #%d:", ii)
      obj <- x[[ii]]

      if (is.atomic(obj)) {
        if (debug) mdebugf("'obj' is atomic")
        if (relay) signalConditionsASAP(obj, resignal = FALSE, pos = ii)
        value <- obj
        resolved[ii] <- TRUE
        x[ii] <- list(NULL)
        values[ii] <- list(value)
        
        if (do_reduce) {
          ## Reduce in order or out of order?
          if (inorder) {
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
          } else {
            reduce_forward(from = ii)
            if (debug) mdebugf("reduced value: %s", deparse(reduced_value))
          }
          if (debug) {
            mdebug("reduced: ", paste(reduced, collapse = ", "))
          }          
        }
      } else {
        if (debug) mdebugf("'obj' is %s", class(obj)[1])
        
        ## If an unresolved future, move on to the next object
        ## so that future can be resolved in the asynchronously
        if (inherits(obj, "Future")) {
          ## Lazy future that is not yet launched?
          if (obj[["state"]] == 'created') obj <- run(obj)
          
          if (!resolved(obj)) {
            next
          }
          
          if (debug) mdebugf("%s #%d", class(obj)[1], ii)
          relay_ok <- relay && signalConditionsASAP(obj, resignal = FALSE, exclude = "error", pos = ii)
          
          value <- local({
            if (debug) {
              mdebugf_push("value(<%s>, ...) ...", class(obj)[1])
              mdebugf_pop()
            }
            value <- value(obj, stdout = !inorder, signal = !inorder, drop = drop)
            if (debug) mdebugf("value: <%s>", class(value)[1])
            value
          })
          
          if (signal && inherits(value, "error")) {
            if (debug) mdebugf_push("signal %s ...", class(value)[1])
            
            if (debug) mdebug_push("futures(x) ...")
            y <- futures(x)
            if (debug) mdebug_pop()
            
            if (cancel) {
              local({
                if (debug) {
                  mdebugf_push("cancel(y, interrupt = %s) ...", interrupt)
                  mdebug_pop()
                }
                cancel(y, interrupt = interrupt)
              })
            }
            
            if (debug) mdebug_push("resolve(y, ...) ...")
            ## Resolve remaining futures, while relaying output and
            ## conditions, but without signaling any errors
            for (kk in seq_along(y)) {
              tryCatch(resolve(y[[kk]], result = TRUE, stdout = stdout, signal = signal, force = !drop), error = identity)
            }
            if (debug) mdebug_pop()
            
            if (debug) {
              mdebugf("stop(value) in 3, 2, 1 ...")
              mdebug_pop()
            }
            stop(value)
          } ## if (signal && inherits(value, "error"))
          
          resolved[ii] <- TRUE
          x[ii] <- list(NULL)
          values[ii] <- list(value)
          
          if (do_reduce) {
            ## Reduce in order or out of order?
            if (inorder) {
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
            } else {
              reduce_forward(from = ii)
              if (debug) mdebugf("reduced value: %s", deparse(reduced_value))
            }
            if (debug) {
              mdebug("reduced: ", paste(reduced, collapse = ", "))
            }          
          }
        } else {
          if (relay) signalConditionsASAP(obj, resignal = FALSE, pos = ii)
          value <- obj
          resolved[ii] <- TRUE
          x[ii] <- list(NULL)
          values[ii] <- list(value)
          
          if (do_reduce) {
            ## Reduce in order or out of order?
            if (inorder) {
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
            } else {
              reduce_forward(from = ii)
              if (debug) mdebugf("reduced value: %s", deparse(reduced_value))
            }
            if (debug) {
              mdebug("reduced: ", paste(reduced, collapse = ", "))
            }          
          }
        }

        relay_ok <- relay && signalConditionsASAP(obj, resignal = FALSE, exclude = "error", pos = ii)
        
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
      if (debug) mdebugf("length: %d (resolved future %s)", length(remaining), ii)
      stop_if_not(!anyNA(remaining))
      mdebugf_pop()
    } # for (ii ...)

    ## Wait a bit before checking again
    if (length(remaining) > 0) Sys.sleep(sleep)
  } # while (...)

  if (inorder && !drop && (relay || force)) {
    if (debug) mdebugf_push("Relaying remaining futures ...")
    signalConditionsASAP(resignal = FALSE, exclude = "error", pos = 0L)
    if (debug) mdebug_pop()
  }

  if (do_reduce) {
    ## If reduced in order, reduce remaining non-reduced values
    if (inorder) {
      reduce_forward(from = reduced_until)
    } else {
      reduce_forward(from = 1L)
    }
    stop_if_not(
      all(resolved),
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
