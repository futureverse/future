## Internal, disposable, opt-in: Drop unused objects from the closure
## environments of function globals
##
## A function created inside another function carries the whole call frame
## with it, including objects it never uses. When the function is exported to
## a parallel worker, all those objects are also exported. To avoid this,
## pruning function replaces those frame(s) with only the objects needed
## per globals scan.
##
## Pruning is unguarded, i.e. functions that look up variables dynamically,
## e.g. get("x") and eval(), are pruned too. To protect against this going
## unnoticed excluded variables are replaced by an active binding that
## throws an error if ever touched.


#' Was pruning requested?
#'
#' @param prune A list returned by `parsePrune()`.
#'
#' @param kind The kind of pruning.
#'
#' @returns TRUE or FALSE.
#'
#' @noRd
isPruneGlobalsRequested <- function(prune, kind = "closure") {
  ## Not requested?
  if (is.null(prune[[kind]])) return(FALSE)
  
  ## Skip if not needed
  if (inherits(plan(), c("sequential", "multicore"))) return(FALSE)

  TRUE
}


#' Parse what to prune
#'
#' @param prune NULL, TRUE, FALSE, or a character vector of kinds to prune.
#' The only kind is `"closure"`, which is the same as TRUE. If NULL, the
#' 'prune' element of option 'future.disposable' is used.
#'
#' @returns
#' A named list with one TRUE element per kind. A list is returned as-is.
#'
#' @noRd
parsePrune <- function(prune = NULL) {
  ## Already parsed?
  if (is.list(prune)) return(prune)

  ## The default is to look at "disposable" options
  if (is.null(prune)) {
    prune <- getOption("future.disposable", NULL)[["prune"]]
  }

  ## Pruning not requested?
  if (is.null(prune) || identical(prune, FALSE)) return(list())

  ## Pruning requested?
  if (identical(prune, TRUE)) prune <- "closure"

  ## Sanity check
  if (!is.character(prune) || anyNA(prune)) {
    stop("Invalid value of 'prune': must be NULL, TRUE, FALSE, or a character vector")
  }

  ## Known kind of pruning?
  kinds <- c("closure")
  unknown <- setdiff(prune, kinds)
  if (length(unknown) > 0L) {
    stop(sprintf("Invalid value of 'prune': unknown kind %s. Valid kinds are: %s", commaq(unknown), commaq(kinds)))
  }

  ## Create parsed pruning results
  res <- list()
  for (kind in prune) res[[kind]] <- TRUE
  
  res
}


## Is 'env' the frame of a function call, and not the global environment,
## a namespace, a package environment, or similar?
isFrameEnvironment <- function(env) {
  if (!is.environment(env)) return(FALSE)
  if (identical(env, globalenv())) return(FALSE)
  if (identical(env, baseenv())) return(FALSE)
  if (identical(env, emptyenv())) return(FALSE)
  if (isNamespace(env)) return(FALSE)
  if (grepl("^(package|imports):", environmentName(env))) return(FALSE)
  TRUE
}


## Has the closure environment of function 'fcn' already been pruned?
isClosureEnvironmentPruned <- function(fcn) {
  if (!is.function(fcn) || is.primitive(fcn)) return(FALSE)
  exists("...future.pruned", envir = environment(fcn), inherits = FALSE)
}


## Replace variables dropped with an active binding that gives an error,
## if accessed
makeDroppedVariableBinding <- function(name) {
  pkg <- .packageName
  fcn <- function() {
    stop(sprintf("[%s] Variable '%s' was dropped from the environment of a function global, because the scan for globals found no use of it. This is a bug. Please report it to the maintainers of the '%s' package", pkg, name, pkg), call. = FALSE)
  }

  env <- new.env(parent = baseenv())
  env[["name"]] <- name
  env[["pkg"]] <- pkg
  environment(fcn) <- env
  
  fcn
}


## The function of an active binding, or NULL if not supported, which is
## the case in R (< 4.4.0)
getActiveBindingFunction <- function(name, env) {
  if (getRversion() < "4.4.0") return(NULL)
  activeBindingFunction <- get("activeBindingFunction", mode = "function", envir = baseenv())
  activeBindingFunction(name, env)
}


## Replace function globals with copies whose closure environments only
## hold variables that are among the globals
pruneGlobalsClosureEnvironments <- local({
  find_frame <- function(e, frames) {
    for (kk in seq_along(frames)) {
      if (identical(e, frames[[kk]])) return(kk)
    }
    NA_integer_
  }

  ## Variables dropped by an earlier pruning, if any
  dropped_before <- function(frame) {
    get0("...future.pruned", envir = frame, inherits = FALSE, ifnotfound = character(0L))
  }

  function(globals, debug = FALSE) {
    used <- names(globals)
  
    ## Identify functions
    is_fcn <- vapply(globals, FUN = function(g) {
      is.function(g) && !is.primitive(g)
    }, FUN.VALUE = NA)
    fcn_names <- names(globals)[is_fcn]
    
    ## Already pruned?
    pruned <- vapply(fcn_names, FUN = function(name) {
      isClosureEnvironmentPruned(globals[[name]])
    }, FUN.VALUE = NA)
    fcn_names <- fcn_names[!pruned]
  
    # Nothing to do?
    if (length(fcn_names) == 0L) return(globals)
  
    ## Identify all frames of all global functions, including their enclosing frames
    frames <- list()
    for (name in fcn_names) {
      e <- environment(globals[[name]])
      while (isFrameEnvironment(e)) {
        known <- vapply(frames, FUN = identical, FUN.VALUE = NA, e)
        if (!any(known)) frames[[length(frames) + 1L]] <- e
        e <- parent.env(e)
      }
    }
  
    ## Nothing to do?
    if (length(frames) == 0L) return(globals)

    ## Handle when pre-existing active bindings are in the frames,
    ## If this happens in R (< 4.4.0), we have to skip pruning,
    ## because this requires R (>= 4.4.0).
    for (frame in frames) {
      for (name in intersect(names(frame), used)) {
        if (name %in% dropped_before(frame)) next
        if (!bindingIsActive(name, frame)) next

        ## Detected an active binding
        fcn <- getActiveBindingFunction(name, frame)

        ## If R (< 4.4.0), pruning cannot be supported, so skip
        if (is.null(fcn)) return(globals)

        ## Add active binding variable
        used <- union(used, all.names(body(fcn)))
      }
    }

    ## Nothing to drop?
    keep <- c("...", "...future.pruned", used)
    found <- FALSE
    for (frame in frames) {
      drop <- setdiff(names(frame), c(keep, dropped_before(frame)))
      if (length(drop) > 0L) {
        found <- TRUE
        break
      }
    }
    if (!found) {
      if (debug) mdebug("Pruning skipped: no unused variables to drop")
      return(globals)
    }

    ## Create new fresh frames cloning the original structure of
    ## the frames. Start with the outer ones.
    new_frames <- vector("list", length(frames))
    for (kk in seq_along(frames)) {
      parent <- parent.env(frames[[kk]])
      if (is.na(find_frame(parent, frames))) {
        new_frames[[kk]] <- new.env(parent = parent)
      }
    }
    
    ## Resolve frames whose parents are other frames
    remaining <- which(vapply(new_frames, FUN = is.null, FUN.VALUE = NA))
    while (length(remaining) > 0L) {
      updated <- FALSE
      for (kk in remaining) {
        jj <- find_frame(parent.env(frames[[kk]]), frames)
        new_parent <- new_frames[[jj]]
        if (!is.null(new_parent)) {
          new_frames[[kk]] <- new.env(parent = new_parent)
          updated <- TRUE
        }
      }

      ## What's left?
      remaining <- which(vapply(new_frames, FUN = is.null, FUN.VALUE = NA))

      ## Shouldn't happen, but if nothing was updated, avoid infinite loop
      ## by simply skipping pruning
      if (!updated) return(globals)
    }

    ## For each object dropped, add an active binding that will produce a
    ## run-time error. This protects against silent mistakes when pruning.
    dropped <- character(0L)
    for (kk in seq_along(frames)) {
      frame <- frames[[kk]]
      new_frame <- new_frames[[kk]]
      dropped_kk <- dropped_before(frame)

      for (name in names(frame)) {
        ## Already pruned?
        if (name == "...future.pruned") next

        if (name %in% dropped_kk) {
          ## Dropped by an earlier pruning, so keep it that way
          makeActiveBinding(name, makeDroppedVariableBinding(name), env = new_frame)
        } else if (name %in% used) {
          ## Copy needed objects to new frame
          if (bindingIsActive(name, frame)) {
            ## Keep it active, without evaluating it
            ## Note, we only get here if R (>= 4.4.0)
            fcn <- getActiveBindingFunction(name, frame)
            jj <- find_frame(environment(fcn), frames)
            if (!is.na(jj)) environment(fcn) <- new_frames[[jj]]
            makeActiveBinding(name, fcn, env = new_frame)
          } else {
            ## Copy as-is
            value <- get(name, envir = frame, inherits = FALSE)
            assign(name, value, envir = new_frame)
          }
        } else if (name != "...") {
          ## Drop
          dropped <- c(dropped, name)
          dropped_kk <- c(dropped_kk, name)
          makeActiveBinding(name, makeDroppedVariableBinding(name), env = new_frame)
        }
      } ## for (name ...)
      
      ## Record that this frame was pruned, and what was dropped
      assign("...future.pruned", unique(dropped_kk), envir = new_frame)
    } ## for (kk ...)
    
    if (debug) {
      mdebugf("Pruned the closure environments of function globals %s: dropped %d unused variables: %s", commaq(fcn_names), length(dropped), hpaste(sQuote(dropped)))
    }
  
    ## Point functions in the old frames to the new frames, both those
    ## in the frames and those among the globals
    for (kk in seq_along(frames)) {
      new_frame <- new_frames[[kk]]
      for (name in intersect(names(new_frame), used)) {
        ## Skip active bindings, which must not be evaluated
        if (bindingIsActive(name, new_frame)) next
        
        fcn <- get(name, envir = new_frame, inherits = FALSE)
        if (is.function(fcn) && !is.primitive(fcn)) {
          jj <- find_frame(environment(fcn), frames)
          if (!is.na(jj)) {
            environment(fcn) <- new_frames[[jj]]
            assign(name, fcn, envir = new_frame)
          }
        }
      }
    }

    ## Update function environments
    for (name in fcn_names) {
      fcn <- globals[[name]]
      jj <- find_frame(environment(fcn), frames)
      if (!is.na(jj)) {
        environment(fcn) <- new_frames[[jj]]
        globals[[name]] <- fcn
      }
    }
  
    globals
  }
})


## Prune a single function, e.g. a worker function sent to a parallel worker.
pruneClosureEnvironment <- function(fcn, prune = parsePrune()) {
  ## Nothing to do?
  if (!isPruneGlobalsRequested(prune)) return(fcn)
  if (!is.function(fcn) || is.primitive(fcn)) return(fcn)
  if (!isFrameEnvironment(environment(fcn))) return(fcn)
  if (isClosureEnvironmentPruned(fcn)) return(fcn)

  ## Identify globals needed by fcn() and prune everything else
  tryCatch({
    envir <- new.env(parent = emptyenv())
    envir[["fun"]] <- fcn
    gp <- getGlobalsAndPackages(
            quote(fun()), envir = envir,
            globals = TRUE, maxSize = +Inf,
            prune = prune
          )
    fun <- gp[["globals"]][["fun"]]
    if (is.function(fun)) fun else fcn
  }, error = function(ex) {
    ## On error, skip pruning
    fcn
  })
}


## Is the pruned version of fcn() still a valid copy? fcn() may stay the
## same while objects in its closure environment change, e.g. via `<<-`.
## A cached pruned version is only valid if the closure environments of
## fcn() have the same variables, each one identical to when 'fcn() was
## first pruned
isPrunedClosureEnvironmentCurrent <- function(fcn, pruned) {
  e <- environment(fcn)
  e_pruned <- environment(pruned)
  tryCatch({
    while (isFrameEnvironment(e)) {
      ## Not pruned?
      if (!isFrameEnvironment(e_pruned)) return(FALSE)
      
      ## Check for differences
      names <- setdiff(names(e), "...")
      names_pruned <- setdiff(names(e_pruned), c("...", "...future.pruned"))
      if (!setequal(names, names_pruned)) return(FALSE)
      
      dropped <- get0("...future.pruned", envir = e_pruned, inherits = FALSE, ifnotfound = character(0L))
      for (name in names_pruned) {
        ## Dropped variables are not copied
        if (name %in% dropped) next
        
        ## Compare active bindings by their functions, without evaluating them
        if (bindingIsActive(name, e) || bindingIsActive(name, e_pruned)) {
          if (!bindingIsActive(name, e) || !bindingIsActive(name, e_pruned)) return(FALSE)

          fcn_a <- getActiveBindingFunction(name, e)
          fcn_b <- getActiveBindingFunction(name, e_pruned)
          if (is.null(fcn_a) || !identical(fcn_a, fcn_b, ignore.environment = TRUE)) return(FALSE)
          
          next
        }
        
        value <- get(name, envir = e, inherits = FALSE)
        value_pruned <- get(name, envir = e_pruned, inherits = FALSE)
        if (is.function(value) && !is.primitive(value) && isFrameEnvironment(environment(value))) {
          ## Functions in a frame were moved to the pruned frame, so compare code
          if (!is.function(value_pruned) ||
              !identical(value, value_pruned, ignore.environment = TRUE)) {
            return(FALSE)
          }
        } else if (!identical(value, value_pruned)) {
          return(FALSE)
        }
      } ## for (name ...)

      ## Walk up to the parent environment
      e <- parent.env(e)
      e_pruned <- parent.env(e_pruned)
    } ## while (...)
    
    TRUE
  }, error = function(ex) {
    FALSE
  })
}


## The object names of the frames of a function, from the inside out
frameNames <- function(fcn) {
  res <- list()
  e <- environment(fcn)
  while (isFrameEnvironment(e)) {
    res[[length(res) + 1L]] <- sort(names(e))
    e <- parent.env(e)
  }
  res
}


## Prune a function, or return a cached pruned version. The same worker
## function is typically sent to several nodes, so cache 'env' holds the
## most recent ones. A cached version is only used if it is still current,
## cf. isPrunedClosureEnvironmentCurrent(). If pruning left the function
## as-is, because there was nothing to drop, then its frames are the same,
## so instead we check that no variables have been added or removed since
#' @importFrom utils tail
pruneClosureEnvironmentCached <- function(fcn, env) {
  if (!is.function(fcn) || is.primitive(fcn)) return(fcn)

  prune <- function(fcn) {
    pruned <- pruneClosureEnvironment(fcn)
    names <- NULL
    if (identical(environment(pruned), environment(fcn))) {
      names <- frameNames(fcn)
    }
    list(pruned = pruned, names = names)
  }

  is_current <- function(fcn, entry) {
    names <- entry[["names"]]
    if (is.null(names)) {
      isPrunedClosureEnvironmentCurrent(fcn, entry[["pruned"]])
    } else {
      identical(frameNames(fcn), names)
    }
  }

  original <- env[["prune_original"]]
  for (kk in seq_along(original)) {
    if (identical(fcn, original[[kk]])) {
      entry <- env[["prune_entry"]][[kk]]
      
      ## If stale, re-prune
      if (!is_current(fcn, entry)) {
        entry <- prune(fcn)
        env[["prune_entry"]][[kk]] <- entry
      }

      ## Done
      return(entry[["pruned"]])
    }
  }

  ## Update cache
  entry <- prune(fcn)
  ## Keep the most recent ones only
  keep <- tail(seq_along(original), n = 9L)
  env[["prune_original"]] <- c(original[keep], list(fcn))
  env[["prune_entry"]] <- c(env[["prune_entry"]][keep], list(entry))
  
  entry[["pruned"]]
}
