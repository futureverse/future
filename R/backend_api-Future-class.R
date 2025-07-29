#' A future represents a value that will be available at some point in the future
#'
#' A _future_ is an abstraction for a _value_ that may
#' available at some point in the future.  A future can either be
#' `unresolved` or `resolved`, a state which can be checked
#' with [resolved()].  As long as it is _unresolved_, the
#' value is not available.  As soon as it is _resolved_, the value
#' is available via \code{\link[future]{value}()}.
#'
#' @inheritParams FutureBackend-class
#'
#' @param expr An \R \link[base]{expression}.
#'
#' @param envir The [environment] from where global objects should be
#' identified.
#'
#' @param substitute If TRUE, argument `expr` is
#' \code{\link[base]{substitute}()}:ed, otherwise not.
#'
#' @param stdout If TRUE (default), then the standard output is captured,
#' and re-outputted when `value()` is called.
#' If FALSE, any output is silenced (by sinking it to the null device as
#' it is outputted).
#' Using `stdout = structure(TRUE, drop = TRUE)` causes the captured
#' standard output to be dropped from the future object as soon as it has
#' been relayed. This can help decrease the overall memory consumed by
#' captured output across futures.
#' Using `stdout = NA` fully avoids intercepting the standard output;
#' behavior of such unhandled standard output depends on the future backend.
#  backend and the environment from which R runs.
#' 
#' @param conditions A character string of conditions classes to be captured
#' and relayed.  The default is to relay all conditions, including messages
#' and warnings.  To drop all conditions, use `conditions = character(0)`.
#' Errors are always relayed.
#' Attribute `exclude` can be used to ignore specific classes, e.g.
#' `conditions = structure("condition", exclude = "message")` will capture
#' all `condition` classes except those that inherits from the `message` class.
#' Using `conditions = structure(..., drop = TRUE)` causes any captured
#' conditions to be dropped from the future object as soon as it has
#' been relayed, e.g. by `value(f)`. This can help decrease the overall
#' memory consumed by captured conditions across futures.
#' Using `conditions = NULL` (not recommended) avoids intercepting conditions,
#' except from errors; behavior of such unhandled conditions depends on the
#' future backend and the environment from which R runs.
#' 
#' @param globals (optional) a logical, a character vector, or a named list
#' to control how globals are handled.
#' For details, see section 'Globals used by future expressions'
#' in the help for [future()].
#' 
#' @param packages (optional) a character vector specifying packages
#' to be attached in the \R environment evaluating the future.
#'
#' @param seed (optional) If TRUE, the random seed, that is, the state of the
#' random number generator (RNG) will be set such that statistically sound
#' random numbers are produced (also during parallelization).
#' If FALSE (default), it is assumed that the future expression does neither
#' need nor use random numbers generation.
#' To use a fixed random seed, specify a L'Ecuyer-CMRG seed (seven integer)
#' or a regular RNG seed (a single integer).  If the latter, then a
#' L'Ecuyer-CMRG seed will be automatically created based on the given seed.
#' Furthermore, if FALSE, then the future will be monitored to make sure it
#' does not use random numbers.  If it does and depending on the value of
#' option [future.rng.onMisuse], the check is
#' ignored, an informative warning, or error will be produced.
#' If `seed` is NULL, then the effect is as with `seed = FALSE`
#' but without the RNG check being performed.
#'
#' @param lazy If FALSE (default), the future is resolved
#' eagerly (starting immediately), otherwise not.
#'
#' @param gc If TRUE, the garbage collector run (in the process that
#' evaluated the future) only after the value of the future is collected.
#' Exactly when the values are collected may depend on various factors such
#' as number of free workers and whether `earlySignal` is TRUE (more
#' frequently) or FALSE (less frequently).
#' _Some future backends may ignore this argument._
#'
#' @param earlySignal Specified whether conditions should be signaled as soon
#' as possible or not.
#'
#' @param label A character string label attached to the future.
#'
#' @param \ldots Additional named elements of the future.
#' 
#' @return
#' `Future()` returns an object of class `Future`.
#'
#' @details
#' A Future object is itself an \link{environment}.
#'
#' @seealso
#' One function that creates a Future is [future()].
#' It returns a Future that evaluates an \R expression in the future.
#' An alternative approach is to use the \code{\link{\%<-\%}} infix
#' assignment operator, which creates a future from the
#' right-hand-side (RHS) \R expression and assigns its future value
#' to a variable as a \emph{\link[base:delayedAssign]{promise}}.
#'
#' @export
#' @keywords internal
#' @name Future-class
Future <- function(expr = NULL, envir = parent.frame(), substitute = TRUE, stdout = TRUE, conditions = "condition", globals = list(), packages = NULL, seed = FALSE, lazy = FALSE, gc = FALSE, earlySignal = FALSE, label = NULL, ...) {
  if (substitute) expr <- substitute(expr)
  t_start <- Sys.time()

  if (is.null(seed)) {
  } else if (isFALSE(seed)) {
  } else {
    rng_config <- parallel_rng_kind()
    if (rng_config[["is_seed"]](seed)) {
    } else {
      if (isTRUE(seed)) {
        sample.int(n = 1L, size = 1L, replace = FALSE)
      }
      .seed <- rng_config[["as_seed"]](seed)
      seed <- rng_config[["next_stream"]](.seed)
    }
  }

  with_assert({
    stop_if_not(is.logical(stdout), length(stdout) == 1L)
    if (!is.null(conditions)) {
      stop_if_not(is.character(conditions), !anyNA(conditions))
    }
  })

  args <- list(...)
  args_names <- names(args)
  if ("onReference" %in% args_names) {
    onReference <- args[["onReference"]]
  } else {
    onReference <- getOption("future.globals.onReference")
    if (is.null(onReference)) onReference <- "ignore"
  }

  ## WORKAROUND: Skip scanning of globals if already done /HB 2021-01-18
  if (!is.null(globals)) {
    if (!inherits(globals, "Globals") ||
        !isTRUE(attr(globals, "already-done", exact = TRUE))) {
      ## Global objects?
      ## 'persistent' is only allowed for ClusterFuture:s, which will be
      ## asserted when run() is called /HB 2023-01-17
      gp <- getGlobalsAndPackages(expr, envir = envir, tweak = tweakExpression, globals = globals, persistent = isTRUE(args[["persistent"]]), onReference = onReference, maxSize = +Inf)
      globals <- gp[["globals"]]
      expr <- gp[["expr"]]
    
      ## Record packages?
      if (length(packages) > 0 || (length(gp[["packages"]]) > 0 && lazy)) {
        packages <- c(gp[["packages"]], packages)
      }
      
      gp <- NULL
    }
  }
  
  if (length(packages) > 1L) packages <- unique(packages)

  with_assert({
    if (!is.null(globals)) {
      stop_if_not(is.list(globals),
                length(globals) == 0 || inherits(globals, "Globals"))
    }
  
    if (!is.null(packages)) {
      stop_if_not(
        is.character(packages),
        !anyNA(packages),
        all(nzchar(packages))
      )
    }
  
    if (!is.null(label)) {
      stop_if_not(length(label) == 1, is.character(label))
    }
  })

  ## FIXME: Deprecate conditions = NULL? (not recommended per help)
  ## /HB 2025-02-16
  if (!is.null(conditions)) {
    immediateConditionClasses <- attr(conditions, "immediateConditionClasses", exact = TRUE)
    if (is.null(immediateConditionClasses)) {
      immediateConditionClasses <- getOption("future.relay.immediate")
      if (is.null(immediateConditionClasses)) {
        immediateConditionClasses <- "immediateCondition"
      }
      attr(conditions, "immediateConditionClasses") <- immediateConditionClasses
    }
  }

  if ("reset" %in% args_names) {
    reset <- args[["reset"]]
    stop_if_not(is.character(reset), !anyNA(reset))
  } else {
    reset <- c("globalenv", "rng", "options", "envvars", "pwd", "plan", "threads")
  }

  core <- new.env(parent = emptyenv())

  ## Version of future
  version <- args[["version"]]
  if (is.null(version)) version <- "1.8"
  core[["version"]] <- version

  ## Future evaluation
  core[["expr"]] <- expr
  core[["envir"]] <- envir
  core[["stdout"]] <- stdout
  core[["conditions"]] <- conditions
  core[["globals"]] <- globals
  core[["packages"]] <- packages
  core[["seed"]] <- seed
  core[["lazy"]] <- lazy
  core[["asynchronous"]] <- TRUE  ## Reserved for future version (Issue #109)

  ## 'local' is now defunct and always TRUE, unless persistent = TRUE,
  ## which in turn may only be used for cluster futures. /HB 2023-01-11
  core[["local"]] <- TRUE

  core[["reset"]] <- reset

  ## Result
  core[["result"]] <- NULL

  ## Future miscellaneous
  core[["label"]] <- label
  core[["earlySignal"]] <- earlySignal
  core[["gc"]] <- gc
  
  core[["onReference"]] <- onReference
  core[["owner"]] <- session_uuid()
  counter <- .package[["futureCounter"]] <- .package[["futureCounter"]] + 1L
  core[["uuid"]] <- future_uuid(owner = core[["owner"]], counter = counter)
  core[["calls"]] <- sys.calls()

  ## The current state of the future, e.g.
  ## 'created', 'running', 'finished', 'failed', 'canceled', 'interrupted'
  core[["state"]] <- "created"

  ## Additional named arguments
  for (key in args_names) core[[key]] <- args[[key]]

  structure(core, class = c("Future", class(core)))
}


sQuoteLabel <- function(label) {
  if (inherits(label, "Future")) {
    future <- label
    label <- future[["label"]]
    if (is.null(label)) {
      uuid <- future[["uuid"]]
      idx <- uuid[length(uuid)]
      label <- sprintf("<unnamed-%s>", idx)
    } else if (is.na(label)) {
      label <- "NA"
    } else {
      label <- sQuote(label)
    }
    return(label)
  }
  
  if (is.null(label)) {
    "NULL"
  } else if (is.na(label)) {
    "NA"
  } else {
    sQuote(label)
  }
}

#' @importFrom utils head capture.output
#' @export
print.Future <- function(x, ...) {
  future <- x
  class <- class(future)
  cat(sprintf("%s:\n", class[1]))
  label <- sQuoteLabel(future)
  cat("Label: ", label, "\n", sep = "")
  cat("Expression:\n")
  print(future[["expr"]])

  ## FIXME: Add method globals_of() for Future such that it's possible
  ## also for SequentialFuture to return something here. /HB 2017-05-17
  gs <- future[["globals"]]
  ngs <- length(gs)
  if (ngs > 0) {
    gTotalSize <- objectSize(gs)
    gSizes <- sapply(gs, FUN = objectSize)
    o <- order(gSizes, decreasing = TRUE)
    o <- head(o, n = 5L)
    gSizes <- gSizes[o]
    gs <- gs[o]
    types <- vapply(gs, FUN.VALUE = NA_character_, FUN = function(g) class(g)[1])
    g <- sprintf("%s %s of %s", types, sQuote(names(gSizes)), sapply(gSizes, FUN = asIEC))
    if (ngs > length(gSizes)) g <- c(g, "...")
    g <- hpaste(g, maxHead = 5L, maxTail = 0L)
    cat(sprintf("Globals: %d objects totaling %s (%s)\n", ngs, asIEC(gTotalSize), g))
  } else {
    cat("Globals: <none>\n")
  }
  
  p <- future[["packages"]]
  np <- length(p)
  if (np > 0) {
    cat(sprintf("Packages: %d packages (%s)\n", np, commaq(p)))
  } else {
    cat("Packages: <none>\n")
  }
  
  if (is.integer(future[["seed"]])) {
    cat(sprintf("L'Ecuyer-CMRG RNG seed: c(%s)\n", paste(future[["seed"]], collapse = ", ")))
  } else {
    cat("L'Ecuyer-CMRG RNG seed: <none> (seed = ", deparse(future[["seed"]]), ")\n", sep = "")
  }

  cat(sprintf("Capture standard output: %s\n", future[["stdout"]]))
  conditions <- future[["conditions"]]
  if (length(conditions) > 0) {
    exclude <- attr(conditions, "exclude", exact = TRUE)
    if (length(exclude) == 0) exclude <- "<none>"
    immediateConditionClasses <- attr(conditions, "immediateConditionClasses", exact = TRUE)
    if (length(immediateConditionClasses) == 0) immediateConditionClasses <- "<none>"
    cat(sprintf("Capture condition classes: %s (excluding %s)\n",
                commaq(conditions),
                commaq(exclude)))
    cat(sprintf("Immediate condition classes: %s\n",
                commaq(immediateConditionClasses)))
  } else {
    cat("Capture condition classes: <none>\n")
  }

  cat(sprintf("Lazy evaluation: %s\n", future[["lazy"]]))
  cat(sprintf("Local evaluation: %s\n", future[["local"]]))
  cat(sprintf("Asynchronous evaluation: %s\n", future[["asynchronous"]]))
  cat(sprintf("Early signaling: %s\n", isTRUE(future[["earlySignal"]])))
  cat(sprintf("Environment: %s\n", envname(future[["envir"]])))

  state <- future[["state"]]
  cat(sprintf("State: %s\n", commaq(state)))
  
  result <- future[["result"]]
  hasResult <- inherits(result, "FutureResult")
  ## BACKWARD COMPATIBILITY
  hasResult <- hasResult || exists("value", envir = future, inherits = FALSE)
  if (hasResult) {
    cat("Resolved: TRUE\n")
  } else if (future[["state"]] == "created") {
    ## Don't launch lazy futures here
    cat("Resolved: FALSE\n")
  } else if (inherits(future, "UniprocessFuture") && future[["lazy"]]) {
    ## FIXME: Special case; will there every be other cases
    ## for which we need to support this? /HB 2016-05-03
    cat("Resolved: FALSE\n")
  } else {
    ## Don't signal conditions here
    ## Note that resolved() may produce a FutureError, e.g.
    ## due to invalid connection in a MultisessionFuture
    is_resolved <- FALSE
    cat(sprintf("Resolved: %s\n", tryCatch(resolved(future, .signalEarly = FALSE), error = function(ex) NA)))
  }

  cat(sprintf("Unique identifier: %s\n", paste(future[["uuid"]], collapse = "-")))
  cat(sprintf("Owner process: %s\n", future[["owner"]]))
  cat(sprintf("Class: %s\n", commaq(class)))

  if (hasResult) {
    if (!inherits(result, "FutureResult")) {
      stop(FutureError(sprintf("The %s object does not have a 'results' field", class(future)[1]), future = future))
    }
    
    value <- result[["value"]]
    cat(sprintf("Value: %s of class %s\n", asIEC(objectSize(value)), sQuote(class(value)[1])))
    
    conditions <- result[["conditions"]]
    conditionClasses <- vapply(conditions, FUN = function(c) class(c[["condition"]])[1], FUN.VALUE = NA_character_)
    cat(sprintf("Conditions captured: [n=%d] %s\n", length(conditionClasses), hpaste(sQuote(conditionClasses))))

    t0 <- result[["started"]]
    t1 <- result[["finished"]]
    cat(sprintf("Duration: %s (started %s)\n", format(t1-t0), t0))
    cat(sprintf("Worker process: %s\n", result[["session_uuid"]]))
  } else {
    cat("Value: <not collected>\n")
    cat("Conditions captured: <none>\n")
  }
} ## print()


## Checks whether Future is owned by the current process or not
assertOwner <- local({
  hpid <- function(uuid) {
    info <- attr(uuid, "source", exact = TRUE)
    if (is.null(info)) info <- list(pid = NA_integer_, host = NA_character_)
    stop_if_not(is.list(info), length(info[["pid"]]) == 1L, length(info[["host"]]) == 1L)
    pid <- sprintf("%s; pid %d on %s", uuid, info[["pid"]], info[["host"]])
    stop_if_not(length(pid) == 1L)
    pid
  }
  
  function(future, ...) {
    if (!identical(future[["owner"]], session_uuid())) {
      stop(FutureError(sprintf("Invalid usage of futures: A future (here %s) whose value has not yet been collected can only be queried by the R process (%s) that created it, not by any other R processes (%s): %s", sQuote(class(future)[1]), hpid(future[["owner"]]), hpid(session_uuid()), hexpr(future[["expr"]])), future = future))
    }

    invisible(future)
  }
})


#' Run a future
#'
#' @param future A \link{Future}.
#' @param \ldots Not used.
#'
#' @return The [Future] object.
#'
#' @details
#' This function can only be called once per future.
#' Further calls will result in an informative error.
#' If a future is not run when its value is queried,
#' then it is run at that point.
#'
#' @aliases run
#' @rdname run
#' @export
#' @export run
#' @keywords internal
run.Future <- function(future, ...) {
  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebugf_push("run() for %s (%s) ...", sQuote(class(future)[1]), sQuoteLabel(future))
    mdebug("state: ", sQuote(future[["state"]]))
    on.exit(mdebugf_pop())
  }

  if (future[["state"]] != "created") {
    label <- sQuoteLabel(future)
    msg <- sprintf("A future (%s) can only be launched once", label)
    stop(FutureError(msg, future = future))
  }

  ## Be conservative for now; don't allow lazy futures created in another R
  ## session to be launched. This will hopefully change later, but we won't
  ## open this door until we understand the ramifications. /HB 2020-12-21
  if (isTRUE(getOption("future.lazy.assertOwner"))) {
    assertOwner(future)
  }

  ## Get the future backend, which will be created if not already done
  backend <- plan("backend")
  if (!is.null(backend)) {
    if (debug) {
      mdebugf_push("Using %s ...", class(backend)[1])
      counters <- backend[["counters"]]
      names <- names(counters)
      info <- sprintf("%s %s", counters, names)
      info <- paste(info, collapse = ", ")
      mdebugf("Number of futures since start: %d (%s)", counters[["created"]], info)
    }

    ## Protect against exporting too large objects
    future <- validateFutureGlobals(backend, future)
    stop_if_not(inherits(future, "Future"))
    
    ## Coerce to target Future class
    class(future) <- backend[["futureClasses"]]

    ## Add future settings with defaults from the backend
    for (name in c("earlySignal", "gc")) {
      if (is.null(future[[name]])) {
        future[[name]] <- backend[[name]]
      }
    }

    if (debug) mdebug_push("Launching futures ...")
    future[["backend"]] <- backend
    future[["start"]] <- proc.time()[[3]]
    future2 <- tryCatch(
      launchFuture(backend, future = future)
    , FutureError = function(ex) {
      ## Known error caught by the future backend
      stop(ex)
    }, error = function(ex) {
      ## Unexpected error
      msg <- conditionMessage(ex)
      label <- sQuoteLabel(future)
      msg <- sprintf("Caught an unexpected error of class %s when trying to launch future (%s) on backend of class %s. The reason was: %s", class(ex)[1], label, class(backend)[1], msg)
      stop(FutureLaunchError(msg, future = future))
    })
    if (debug) mdebug_pop()
    if (debug) mdebug("Future launched: ", commaq(class(future2)))
    stop_if_not(inherits(future2, "Future"))

    ## Increment counters
    counters <- backend[["counters"]]
    counters["created"] <- counters["created"] + 1L
    backend[["counters"]] <- counters
    
    if (debug) mdebugf_pop()
    
    return(future2)
  }


  ## --------------------------------------------------------------------
  ## Legacy, non-FutureBackend backends
  ## --------------------------------------------------------------------
  evaluator <- plan("next")
  if (debug) mdebug("Future backend: ", commaq(class(evaluator)))

  ## Create temporary future for a specific backend, but don't launch it
  ## AD HOC/WORKAROUND: /HB 2020-12-21
  args <- list(
    quote(future[["expr"]]),
    substitute = FALSE,
    envir = future[["envir"]],
    lazy = TRUE,
    stdout = future[["stdout"]],
    conditions = future[["conditions"]],
    globals = future[["globals"]],
    packages = future[["packages"]],
    seed = future[["seed"]],
    label = future[["label"]],
    reset = future[["reset"]],
    calls = future[["calls"]]
  )

  ## SPECIAL: 'cluster' takes argument 'persistent' for now /HB 2023-01-17
  has_persistent <- ("persistent" %in% names(future))
  if (has_persistent) args[["persistent"]] <- future[["persistent"]]
  
  tmpFuture <- do.call(evaluator, args = args)

  ## SPECIAL: 'cluster' takes argument 'persistent' for now /HB 2023-01-17
  if (has_persistent) {
    if (inherits(evaluator, "cluster") &&
        !inherits(evaluator, "multisession")) {
      tmpFuture[["local"]] <- !tmpFuture[["persistent"]]
    } else {
      .Defunct(msg = "Future field 'persistent' is defunct and must not be set", package = .packageName)
    }
  }

  if (debug) mdebug("Future class: ", commaq(class(tmpFuture)))

  ## AD HOC/SPECIAL:
  ## If 'earlySignal=TRUE' was set explicitly when creating the future,
  ## then override the plan, otherwise use what the plan() says
  if (isTRUE(future[["earlySignal"]])) tmpFuture[["earlySignal"]] <- TRUE

  ## If 'gc=TRUE' was set explicitly when creating the future,
  ## then override the plan, otherwise use what the plan() says
  if (isTRUE(future[["gc"]])) tmpFuture[["gc"]] <- TRUE

  ## Copy the full state of this temporary future into the main one
  ## This can be done because Future:s are environments and we can even
  ## assign attributes such as the class to existing environments
  
  if (debug) mdebugf_push("Copy elements of temporary %s to final %s object ...", sQuote(class(tmpFuture)[1]), sQuote(class(future)[1]))
  ## (a) Copy all elements
  for (name in names(tmpFuture)) {
    if (debug) mdebug("Field: ", sQuote(name))
    future[[name]] <- tmpFuture[[name]]
  }
  if (debug) mdebugf_pop()
  ## (b) Copy all attributes
  attributes(future) <- attributes(tmpFuture)

  ## (c) Temporary future no longer needed
  tmpFuture <- NULL

  ## Launch the future?
  if (future[["lazy"]]) {
    if (debug) mdebug_push("Launch lazy future ...")
    future <- run(future)
    if (debug) mdebug_pop()
  }

  ## Set FutureBackend, if it exists
  future[["backend"]] <- backend
  
  ## Sanity check: This method was only called for lazy futures
  stop_if_not(future[["state"]] != "created", future[["lazy"]])

  future
}

#' @export
#' @keywords internal
run <- function(future, ...) {
  ## Automatically update journal entries for Future object
  if (inherits(future, "Future") &&
      inherits(future[[".journal"]], "FutureJournal")) {
    start <- Sys.time()
    on.exit({
      appendToFutureJournal(future,
          event = "launch",
       category = "overhead",
          start = start,
           stop = Sys.time()
      )
    })
  }
  UseMethod("run")
}


#' @export
#' @keywords internal
result <- function(future, ...) {
  ## Automatically update journal entries for Future object
  if (inherits(future, "Future") &&
      inherits(future[[".journal"]], "FutureJournal")) {
    start <- Sys.time()
    on.exit({
      appendToFutureJournal(future,
           event = "gather",
        category = "overhead",
           start = start,
            stop = Sys.time()
      )

      ## Signal FutureJournalCondition?
      if (!isTRUE(future[[".journal_signalled"]])) {
        journal <- journal(future)
        label <- sQuoteLabel(future)
        msg <- sprintf("A future (%s) of class %s was resolved", label, class(future)[1])
        cond <- FutureJournalCondition(message = msg, journal = journal) 
        signalCondition(cond)
        future[[".journal_signalled"]] <- TRUE
      }
    })
  }
  UseMethod("result")
}

#' Get the results of a resolved future
#'
#' @param future A \link{Future}.
#' @param \ldots Not used.
#'
#' @return The [FutureResult] object.
#'
#' @details
#' This function is only part of the _backend_ Future API.
#' This function is _not_ part of the frontend Future API.
#'
#' @aliases result
#' @rdname result
#' @export
#' @keywords internal
result.Future <- function(future, ...) {
  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebugf_push("result() for %s (%s) ...", sQuote(class(future)[1]), sQuoteLabel(future))
    mdebug("state: ", sQuote(future[["state"]]))
    on.exit(mdebugf_pop())
  }
  
  ## Has the result already been collected?
  result <- future[["result"]]
  if (!is.null(result)) {
    ## Assert result is for the expected future
    assertFutureResult(future)
    
    ## Always signal immediateCondition:s and as soon as possible.
    ## They will always be signaled if they exist.
    signalImmediateConditions(future)

    if (inherits(result, "FutureError")) stop(result)
    return(result)
  }
  
  if (future[["state"]] == "created") {
    future <- run(future)
  }

  if (!future[["state"]] %in% c("finished", "failed", "canceled", "interrupted")) {
    ## BACKWARD COMPATIBILITY:
    ## For now, it is value() that collects the results.  Later we want
    ## all future backends to use result() to do it. /HB 2018-02-22
    value(future, stdout = FALSE, signal = FALSE)

    ## Always signal immediateCondition:s and as soon as possible.
    ## They will always be signaled if they exist.
    signalImmediateConditions(future)
  }

  result <- future[["result"]]
  if (inherits(result, "FutureResult")) {
    ## Assert result is for the expected future
    assertFutureResult(future)
    return(result)
  }

  ## BACKWARD COMPATIBILITY
  result <- future[["value"]]
  if (inherits(result, "FutureResult")) {
    ## Assert result is for the expected future
    assertFutureResult(future)
    return(result)
  }

  version <- future[["version"]]
  if (is.null(version)) {
    warning(FutureWarning("Future version was not set. Using default %s",
                          sQuote(version)))
  }

  ## Sanity check
  if (is.null(result) && version == "1.8") {
    if (inherits(future, "MulticoreFuture")) {
      label <- sQuoteLabel(future)
      msg <- sprintf("A future (%s) of class %s did not produce a FutureResult object but NULL. This suggests that the R worker terminated (crashed?) before the future expression was resolved.", label, class(future)[1])
      stop(FutureError(msg, future = future))
    }
  }

  .Defunct(msg = "Future objects with an internal version of 1.7 or earlier are defunct. This error is likely coming from a third-party package or other R code. Please report this to the maintainer of the 'future' package so this can be resolved.", package = .packageName)
}


#' @rdname resolved
#' @export
resolved.Future <- function(x, run = TRUE, ...) {
  future <- x
  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebugf_push("resolved() for %s (%s) ...", class(future)[1], sQuoteLabel(future))
    on.exit(mdebug_pop())
    mdebug("state: ", sQuote(future[["state"]]))
    mdebug("run: ", run)
  }
  
  ## A lazy future not even launched?
  if (future[["state"]] == "created") {
    if (!run) return(FALSE)
    if (debug) mdebug_push("run() ...")
    future <- run(future)
    if (debug) {
      mdebug_pop()
      mdebug_push("resolved() ...")
    }
    res <- resolved(future, ...)
    if (debug) {
      mdebug("resolved: ", res)
      mdebug_pop()
    }
    return(res)
  }

  ## Signal conditions early, iff specified for the given future
  ## Note, collect = TRUE will block here, which is intentional
  signalEarly(future, collect = TRUE, ...)

  if (debug) mdebug("result: ", sQuote(class(future[["result"]])[1]))
  if (inherits(future[["result"]], "FutureResult")) return(TRUE)
  
  res <- (future[["state"]] %in% c("finished", "failed", "canceled", "interrupted"))

  if (debug) mdebug("resolved: ", res)

  res
}



# Get the executable closure, a.k.a. "the core", of the future
getFutureCore <- function(future, ..., debug = isTRUE(getOption("future.debug"))) {
  stop_if_not(inherits(future, "Future"))
  if (debug) {
    mdebug_push("getFutureCore() ...")
    on.exit(mdebug_pop())
  }

  ## Globals used by the future
  globals <- future[["globals"]]

  ## Packages needed to resolve the future
  pkgs <- future[["packages"]]
  if (length(pkgs) > 0) {
    if (debug) mdebugf("Packages needed by the future expression (n = %d): %s", length(pkgs), commaq(pkgs))
  } else {
    if (debug) mdebug("Packages needed by the future expression (n = 0): <none>")
  }

  ## Create a future core
  core <- list(
    expr     = future[["expr"]],
    globals  = globals,
    packages = pkgs,
    seed     = future[["seed"]]
  )

  core
} # getFutureCore()


getFutureCapture <- function(future, ..., debug = isTRUE(getOption("future.debug"))) {
  stop_if_not(inherits(future, "Future"))
  if (debug) {
    mdebug_push("getFutureCapture() ...")
    on.exit(mdebug_pop())
  }

  split <- future[["split"]]
  if (is.null(split)) split <- FALSE
  stop_if_not(is.logical(split), length(split) == 1L, !is.na(split))

  conditionClasses <- future[["conditions"]]
  if (is.null(conditionClasses)) {
    immediateConditionClasses <- NULL
  } else {
    immediateConditionClasses <- attr(conditionClasses, "immediateConditionClasses", exact = TRUE)
    if (is.null(immediateConditionClasses)) immediateConditionClasses <- "immediateCondition"
    if (length(immediateConditionClasses) > 0 && !is.null(conditionClasses)) {
      exclude <- attr(conditionClasses, "exclude", exact = TRUE)
      muffleInclude <- attr(conditionClasses, "muffleInclude", exact = TRUE)
      if (is.null(muffleInclude)) muffleInclude <- "^muffle"
      conditionClasses <- c(conditionClasses, immediateConditionClasses)
      attr(conditionClasses, "exclude") <- exclude
      attr(conditionClasses, "muffleInclude") <- muffleInclude
    }
  }

  capture <- list(
    stdout                     = future[["stdout"]],
    split                      = split,
    conditionClasses           = conditionClasses,
    immediateConditionClasses  = immediateConditionClasses,
    immediateConditionHandlers = list()
  )

  capture
} # getFutureCapture()


getFutureContext <- function(future, mc.cores = NULL, local = TRUE, ..., debug = isTRUE(getOption("future.debug"))) {
  stop_if_not(inherits(future, "Future"))
  if (debug) {
    mdebug_push("getFutureContext() ...")
    on.exit(mdebug_pop())
  }

  backend <- future[["backend"]]
  
  ## Future strategies
  strategiesR <- plan("tail")
  stop_if_not(length(strategiesR) >= 0L)
  ##  mdebugf("Number of tail backends: %d", length(strategiesR))

  ## Use default future backend + identify packages needed by the backend
  if (length(strategiesR) == 0L) {
    if (debug) mdebug("Packages needed by future backend (n = 0): <none>")
    strategiesR <- sequential
    backendPackages <- c("future")
  } else {
    ## Identify package namespaces needed for backends
    backendPackages <- lapply(strategiesR, FUN = environment)
    backendPackages <- lapply(backendPackages, FUN = environmentName)
    backendPackages <- unlist(backendPackages, use.names = FALSE)
    if (length(backendPackages) > 1L) backendPackages <- unique(backendPackages)
    if (length(backendPackages) > 0L) {
      ## CLEANUP: Only keep those that are loaded in the current session
      backendPackages <- intersect(backendPackages, loadedNamespaces())
    }
    if (debug) mdebugf("Packages needed by future strategies (n = %d): %s", length(backendPackages), commaq(backendPackages))
  }

  forwardOptions <- list(
    ## Assert globals when future is created (or at run time)?
    future.globals.onMissing          = getOption("future.globals.onMissing"),
  
    ## Pass down other future.* options
    future.connections.onMisuse       = getOption("future.connections.onMisuse"),
    future.devices.onMisuse           = getOption("future.devices.onMisuse"),
    future.globalenv.onMisuse         = getOption("future.globalenv.onMisuse"),
    future.globals.maxSize            = backend[["maxSizeOfObjects"]],
    future.globals.method             = getOption("future.globals.method"),
    future.globals.onReference        = future[["onReference"]],
    future.globals.resolve            = getOption("future.globals.resolve"),
    future.resolve.recursive          = getOption("future.resolve.recursive"),
    future.rng.onMisuse               = getOption("future.rng.onMisuse"),
    future.rng.onMisuse.keepFuture    = getOption("future.rng.onMisuse.keepFuture"),
    future.stdout.windows.reencode    = getOption("future.stdout.windows.reencode"),

    future.fork.multithreading.enable = getOption("future.fork.multithreading.enable"),

    future.globalenv.onMisuse         = getOption("future.globalenv.onMisuse"),

    future.makeExpression.skip        = getOption("future.makeExpression.skip"),
    future.makeExpression.skip.local  = getOption("future.makeExpression.skip.local"),
    
    ## Other options relevant to making futures behave consistently
    ## across backends
    width                             = getOption("width")
  )

  if (!is.null(mc.cores)) {
    forwardOptions[["mc.cores"]] <- mc.cores
  }

  reset <- future[["reset"]]

  if (is.null(local)) local <- future[["local"]]
  
  ## To be cleaned up /HB 2025-01-02
  persistent <- future[["persistent"]]
  if (isTRUE(persistent)) local <- FALSE

  ## Create a future context
  context <- list(
    uuid            = future[["uuid"]],
    threads         = NA_integer_,
    strategiesR     = strategiesR,
    backendPackages = backendPackages,
    forwardOptions  = forwardOptions,
    reset           = reset,
    local           = local
  )

  context
} # getFutureContext()


getFutureBackendConfigs <- function(future, ...) {
  UseMethod("getFutureBackendConfigs")
}


getFutureData <- function(future, ..., debug = isTRUE(getOption("future.debug"))) {
  if (debug) {
    mdebug_push("getFutureData() ...")
    on.exit(mdebug_pop())
  }

  args <- list(...)

  ## Extract the future core
  data <- list(
       core = getFutureCore(future, debug = debug),
    capture = getFutureCapture(future, debug = debug),
    context = getFutureContext(future, mc.cores = args[["mc.cores"]], local = args[["local"]], debug = debug)
  )

  ## Tweak per backend?
  configs <- getFutureBackendConfigs(future, debug = debug)
  for (name in names(configs)) {
    config <- configs[[name]]
    current <- data[[name]]
    for (key in names(config)) {
      current[[key]] <- config[[key]]
    }
    data[[name]] <- current
  }

  data
} ## getFutureData()



#' Inject code for the next type of future to use for nested futures
#'
#' @param future Current future.
#' @param \ldots Not used.
#'
#' @return A future expression with code injected to set what
#' type of future to use for nested futures, iff any.
#'
#' @details
#' If there is no future backend specified after this one, the default
#' is to use [sequential] futures.  This conservative approach protects
#' against spawning off recursive futures by mistake, especially
#' [multicore] and [multisession] ones.
#' The default will also set `options(mc.cores = 1L)` (*) so that
#' no parallel \R processes are spawned off by functions such as
#' \code{parallel::mclapply()} and friends.
#'
#' Currently it is not possible to specify what type of nested
#' futures to be used, meaning the above default will always be
#' used.
#' See \href{https://github.com/futureverse/future/issues/37}{Issue #37}
#' for plans on adding support for custom nested future types.
#'
#' (*) Ideally we would set `mc.cores = 0` but that will unfortunately
#'     cause `mclapply()` and friends to generate an error saying
#'     "'mc.cores' must be >= 1".  Ideally those functions should
#'     fall back to using the non-multicore alternative in this
#'     case, e.g. `mclapply(...)` => `lapply(...)`.
#'     See \url{https://github.com/HenrikBengtsson/Wishlist-for-R/issues/7}
#'     for a discussion on this.
#'
#' @aliases getExpression.Future
#' @keywords internal
#'
#' @export
getExpression <- function(future, ...) UseMethod("getExpression")

#' @export
getExpression.Future <- local({
  tmpl_expr_evaluate <- bquote_compile({
    "# future:::getExpression.Future(): evaluate the future via evalFuture()"
    future:::evalFuture(data = .(data))
  })

  function(future, expr = future[["expr"]], ...) {
    debug <- isTRUE(getOption("future.debug"))
    ##  mdebug("getExpression() ...")
    
    data <- getFutureData(future, ..., debug = debug)
    expr <- bquote_apply(tmpl_expr_evaluate)

    if (isTRUE(getOption("future.debug"))) mprint(expr)
  
    ##  mdebug("getExpression() ... DONE")
    
    expr
  }
}) ## getExpression()


#' @export
`$<-.Future` <- function(x, name, value) {
  if (name == "state") {
    if (!is.element(value, c("created", "running", "finished", "failed", "canceled", "interrupted"))) {
      action <- getOption("future.state.onInvalid", "warning")
      
      if (action != "ignore") {
        msg <- sprintf("Trying to assign an invalid value to the internal '%s' field of a %s object: %s", name, class(x)[1], value)
        if (action == "error") {
          stop(FutureError(msg, call = sys.call(), future = x))
        } else {
          warning(FutureWarning(msg, call = sys.call(), future = x))
        }
      }
    }
  }
  
  NextMethod()
}
