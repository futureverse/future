#' @exportS3Method all.equal future
all.equal.future <- function(target, current, ..., debug = FALSE) {
  if (debug) {
    mdebug_push("all.equal() for future ...")
    on.exit(mdebug_pop())
    mstr(list(target = target, current = current))
  }
  
  ## Compare formals
  if (!isTRUE(all.equal(formals(target), formals(current)))) {
    if (debug) mdebug("Formals differ")
    return("Formals differ")
  }

  ## Prune 'class' attribute
  class(target) <- setdiff(class(target), "FutureStrategy")
  class(current) <- setdiff(class(current), "FutureStrategy")

  ## Compare attributes
  target_attrs <- attributes(target)
  current_attrs <- attributes(current)
  
  ## Ignore some attributes when comparing stacks
  ignore <- c("call", "init", "backend", "srcref")
  target_names <- setdiff(names(target_attrs), ignore)
  current_names <- setdiff(names(current_attrs), ignore)

  ## Same attribute names?
  if (!identical(target_names, current_names)) {
    if (debug) mdebug("Attribute names differ")
    return("Attribute names differ")
  }

  ## Same attribute values?
  target_attrs <- target_attrs[target_names]
  current_attrs <- current_attrs[current_names]
  if (!isTRUE(all.equal(target_attrs, current_attrs))) {
    if (debug) mdebug("Attribute values differ")
    return("Attribute values differ")
  }

  TRUE
} ## all.equal() for 'future'


#' @exportS3Method all.equal FutureStrategyList
all.equal.FutureStrategyList <- function(target, current, ..., debug = FALSE) {
  if (debug) {
    mdebug_push("all.equal() for FutureStrategyList ...")
    on.exit(mdebug_pop())
  }

  stop_if_not(is.list(target), is.list(current))

  if (length(target) != length(current)) {
    if (debug) mdebug("Different lengths")
    return(FALSE)
  }

  if (!identical(names(target), names(current))) {
    if (debug) mdebug("Different names")
    return(FALSE)
  }

  if (debug) {
    mdebug("New stack:")
    mstr(target)
    mdebug("Old stack:")
    mstr(current)
  }

  if (identical(target, current)) {
    if (debug) mdebug("Identical")
    return(TRUE)
  } else {
    if (debug) mdebug("Not identical")
  }

  for (kk in seq_along(target)) {
    if (!isTRUE(all.equal(target[[kk]], current[[kk]], debug = debug))) {
      msg <- sprintf("Future strategies differ at level %d", kk)
      if (debug) mdebug(msg)
      return(msg)
    }
  }

  TRUE
} ## all.equal() for FutureStrategyList


  assert_no_disallowed_strategies <- function(stack) {
    noplans <- getOption("future.plan.disallow")
    if (length(noplans) == 0L) return()

    for (kk in seq_along(stack)) {
      evaluator <- stack[[kk]]
      if (!inherits(evaluator, noplans)) next
      clazz <- class(evaluator)[1]
      if (!clazz %in% noplans) next  ## <== sic!

      stop(FutureError(sprintf("Can not use %s in the future plan because it is on the list of future strategies that are not allow per option 'future.plan.disallow': %s", sQuote(clazz), commaq(noplans))))
    }
  }


  evaluator_uses <- function(evaluator, strategy) {
    if (!inherits(evaluator, strategy)) return(FALSE)
    ## NOTE: Yes, we are indeed inspecting the 'class' attribute itself
    class <- class(evaluator)
    if (class[1] == strategy) return(TRUE)
    if (length(class) == 1L) return(FALSE)
    if (class[1] == "tweaked" && class[2] == strategy) return(TRUE)
    ## Special case for strategy == "multiprocess"
    if (strategy == "multiprocess" && class[length(class)] == strategy) return(TRUE)
    FALSE
  }


  warn_about_multicore <- local({
    .warn <- TRUE

    function(stack) {
      if (!.warn) return()

      ## Is 'multicore' used despite not being supported on the current
      ## platform?    
      for (kk in seq_along(stack)) {
        if (evaluator_uses(stack[[kk]], "multicore")) {
          supportsMulticore(warn = TRUE)
          ## Warn only once, if at all
          .warn <<- FALSE
          break
        }
      }
    }
  })


  plan_default_stack <- local({
    defaultStack <- NULL
                              
    function() {
      if (is.null(defaultStack)) {
        defaultStrategy <- structure(sequential,
                                     call = substitute(plan(sequential)))
        defaultStack <<- structure(list(defaultStrategy),
                                   class = c("FutureStrategyList", "list"))
      }
      defaultStack
    }
  }) ## plan_default_stack()


  plan_cleanup <- function(evaluator, cleanup = NA, debug = FALSE) {
    if (debug) {
      if (inherits(evaluator, "character")) {
        first <- sprintf('"%s"', evaluator)
      } else {
        first <- sprintf("<%s>", commaq(class(evaluator)))
      }
      mdebugf_push("plan(): plan_cleanup(%s, cleanup = %s) ...", first, cleanup)
      on.exit(mdebug_pop())
    }

    ## Skip clean up for other reasons?
    if (is.na(cleanup)) {
      temporary <- attr(plan("next"), "with-temporary", exact = TRUE)
      if (is.logical(temporary)) cleanup <- isTRUE(temporary)
    }

    ## Nothing to do?
    if (identical(cleanup, FALSE)) return()

    backend <- attr(evaluator, "backend", exact = TRUE)
    if (inherits(backend, "FutureBackend")) {
      stopWorkers(backend)
    }

    ## Legacy, non-FutureBackend backends, and other fallbacks
    cleanup_fcn <- attr(evaluator, "cleanup", exact = TRUE)
    if (!is.null(cleanup_fcn)) {
      if (is.function(cleanup_fcn)) {
        cleanup_fcn()
      } else {
        stop(FutureError(sprintf("Unknown type of 'cleanup' attribute on current future backend: %s", commaq(class(cleanup_fcn)))))
      }
    } else {
      if (debug) mdebugf_push("Legacy shutdown of cluster workers ...")
      ## Legacy shutdown of cluster workers
      clusterRegistry$stopCluster(debug = debug)
      if (debug) mdebug_pop()
    }
  } ## plan_cleanup()


  plan_init <- function(evaluator, debug = FALSE) {
    if (debug) {
      mdebugf_push("plan(): plan_init() of %s ...", commaq(class(evaluator)))
      on.exit(mdebug_pop())
    }

    if (debug) mstr(evaluator)

    init <- attr(evaluator, "init", exact = TRUE)
    if (debug) mdebugf("init: %s", deparse(init))
    if (identical(init, "done")) {
      if (debug) mdebug("Already inititated. Skipping")
    }
    
    if (identical(init, TRUE)) {
      ## IMPORANT: Initiate only once.  This avoids an infinite
      ## recursive loop caused by other plan() calls.
      attr(evaluator, "init") <- "done"

      factory <- attr(evaluator, "factory")

      ## Launch FutureBackend?
      if (!is.null(factory)) {
        if (!is.null(attr(evaluator, "backend"))) {
          stop(FutureError(sprintf("%s did not shut itself down properly", class(attr(evaluator, "backend"))[1])))
        }
        backend <- makeFutureBackend(evaluator, debug = debug)
        attr(evaluator, "backend") <- backend
        return(evaluator)
      }


      ## Non-FutureBackend backends are initiated by calling the evaluator
      ## Create dummy future to trigger setup (minimum overhead)
      f <- evaluator(NA, label = "future-plan-test", 
                     globals = FALSE, lazy = FALSE)

      ## Cleanup, by resolving it
      ## (otherwise the garbage collector would have to do it)
      res <- tryCatch({
        value(f)
      }, FutureError = identity)
      if (inherits(res, "FutureError")) {
        res[["message"]] <- paste0("Initialization of plan() failed, because the test future used for validation failed. The reason was: ", conditionMessage(res))
        stop(res)
      }

      if (!identical(res, NA)) {
        res <- if (is.null(res)) {
          "NULL"
        } else {
          commaq(res)
        }
        stop(FutureError(sprintf("Initialization of plan() failed, because the value of the test future is not NA as expected: %s", res)))
      }
    } ## if (identical(init, TRUE)
    
    evaluator
  } ## plan_init()




#' Plan how to resolve a future
#'
#' This function allows _the user_ to plan the future, more specifically,
#' it specifies how [future()]:s are resolved,
#' e.g. sequentially or in parallel.
#'
#' @param strategy The type of future backend (function or name of one) to use
#' for resolving a future. If `NULL`, then the current backend is returned.
#'
#' @param \ldots Additional arguments overriding the default arguments
#' of the evaluation function.  Which additional arguments are supported
#' depends on which future backend is used, e.g. several support
#' argument `workers` but not all. For details, see the individual
#' backends of which some are linked to below.
#"
#' @param substitute If `TRUE`, the `strategy` expression is
#' `substitute()`:d, otherwise not.
#'
#' @param .call (internal) Used for recording the call to this function.
#'
#' @param .skip (internal) If `TRUE`, then attempts to set a future backend
#' that is the same as what is currently in use, will be skipped.
#'
#' @param .cleanup (internal) Used to stop implicitly started clusters.
#'
#' @param .init (internal) Used to initiate workers.
#'
#' @return
#' `plan()` returns a the previous plan invisibly if a new future backend
#' is chosen, otherwise it returns the current one visibly.
#'
#' @example incl/plan.R
#'
#' @details
#' The default backend is [`sequential`], but another one can be set
#' using `plan()`, e.g. `plan(multisession)` will launch parallel workers
#' running in the background, which then will be used to resolve future.
#' To shut down background workers launched this way, call `plan(sequential)`.
#'
#'
#' @section Built-in evaluation strategies:
#' The \pkg{future} package provides the following built-in backends:
#'
#' \describe{
#'  \item{[`sequential`]:}{
#'    Resolves futures sequentially in the current \R process, e.g.
#'    `plan(sequential)`.
#'  }
#'  \item{[`multisession`]:}{
#'    Resolves futures asynchronously (in parallel) in separate
#'    \R sessions running in the background on the same machine, e.g.
#'    `plan(multisession)` and `plan(multisession, workers = 2)`.
#'  }
#'  \item{[`multicore`]:}{
#'    Resolves futures asynchronously (in parallel) in separate
#'    _forked_ \R processes running in the background on
#'    the same machine, e.g.
#'    `plan(multicore)` and `plan(multicore, workers = 2)`.
#'    This backend is not supported on Windows.
#'  }
#'  \item{[`cluster`]:}{
#'    Resolves futures asynchronously (in parallel) in separate
#'    \R sessions running typically on one or more machines, e.g.
#'    `plan(cluster)`, `plan(cluster, workers = 2)`, and
#'    `plan(cluster, workers = c("n1", "n1", "n2", "server.remote.org"))`.
#'  }
#' }
#'
#'
#' @section Other evaluation strategies available:
#'
#' In addition to the built-in ones, additional parallel backends are
#' implemented in future-backend packages \pkg{future.callr} and
#' \pkg{future.mirai} that leverage R package \pkg{callr} and
#' \pkg{mirai}:
#'
#' \describe{
#'  \item{`callr`:}{
#'   Similar to `multisession`, this resolved futures in parallel in
#'   background \R sessions on the local machine via the \pkg{callr}
#'   package, e.g. `plan(future.callr::callr)` and
#'   `plan(future.callr::callr, workers = 2)`. The difference is that
#'   each future is processed in a fresh parallel R worker, which is
#'   automatically shut down as soon as the future is resolved.
#'   This can help decrease the overall memory. Moreover, contrary
#'   to `multisession`, `callr` does not rely on socket connections,
#'   which means it is not limited by the number of connections that
#'   \R can have open at any time.
#'  }
#' 
#'  \item{`mirai_multisession`:}{
#'   Similar to `multisession`, this resolved futures in parallel in
#'   background \R sessions on the local machine via the \pkg{mirai}
#'   package, e.g. `plan(future.mirai::mirai_multisession)` and
#'   `plan(future.mirai::mirai_multisession, workers = 2)`.
#'  }
#' 
#'  \item{`mirai_cluster`:}{
#'   Similar to `cluster`, this resolved futures in parallel via
#'   pre-configured \R \pkg{mirai} daemon processes, e.g.
#'   `plan(future.mirai::mirai_cluster)`.
#'  }
#' }
#'
#' Another example is the \pkg{future.batchtools} package, which leverages
#' \pkg{batchtools} package, to resolve futures via high-performance compute
#' (HPC) job schedulers, e.g. LSF, Slurm, TORQUE/PBS, Grid Engine, and
#' OpenLava;
#'
#' \describe{
#'  \item{`batchtools_slurm`:}{
#'   The backend resolved futures via the Slurm scheduler, e.g.
#'   `plan(future.batchtools::batchtools_slurm)`.
#'  }
#'
#'  \item{`batchtools_torque`:}{
#'   The backend resolved futures via the TORQUE/PBS scheduler, e.g.
#'   `plan(future.batchtools::batchtools_torque)`.
#'  }
#'
#'  \item{`batchtools_sge`:}{
#'   The backend resolved futures via the Grid Engine (SGE, AGE) scheduler,
#'   e.g. `plan(future.batchtools::batchtools_sge)`.
#'  }
#'
#'  \item{`batchtools_lsf`:}{
#'   The backend resolved futures via the Load Sharing Facility (LSF)
#'   scheduler, e.g. `plan(future.batchtools::batchtools_lsf)`.
#'  }
#'
#'  \item{`batchtools_openlava`:}{
#'   The backend resolved futures via the OpenLava scheduler, e.g.
#'  `plan(future.batchtools::batchtools_openlava)`.
#'  }
#' }
#'
#'
#' @section For package developers:
#'
#' Please refrain from modifying the future backend inside your packages /
#' functions, i.e. do not call `plan()` in your code. Instead, leave
#' the control on what backend to use to the end user. This idea is part of
#' the core philosophy of the future framework---as a developer you can never
#' know what future backends the user have access to. Moreover, by not making
#' any assumptions about what backends are available, your code will also work
#' automatically with any new backends developed after you wrote your code.
#'
#' If you think it is necessary to modify the future backend within a
#' function, then make sure to undo the changes when exiting the function.
#' This can be achieved by using `with(plan(...), local = TRUE)`, e.g.
#'
#' \preformatted{
#'   my_fcn <- function(x) {
#'     with(plan(multisession), local = TRUE)
#'     y <- analyze(x)
#'     summarize(y)
#'   }
#' }
#'
#' This is important because the end-user might have already set the future
#' strategy elsewhere for other purposes and will most likely not known that
#' calling your function will break their setup.
#' _Remember, your package and its functions might be used in a greater
#' context where multiple packages and functions are involved and those might
#' also rely on the future framework, so it is important to avoid stepping on 
#' others' toes._
#'
#'
#' @section Using plan() in scripts and vignettes:
#'
#' When writing scripts or vignettes that use futures, try to place any
#' call to `plan()` as far up (i.e. as early on) in the code as possible.  
#' This will help users to quickly identify where the future plan is set up
#' and allow them to modify it to their computational resources.
#' Even better is to leave it to the user to set the `plan()` prior to
#' `source()`:ing the script or running the vignette.
#' If a \file{\link{.future.R}} exists in the current directory and / or in
#' the user's home directory, it is sourced when the \pkg{future} package is
#' _loaded_. Because of this, the \file{.future.R} file provides a
#' convenient place for users to set the `plan()`.
#' This behavior can be controlled via an \R option---see
#' [future options][future.options] for more details.
#'
#' @importFrom utils capture.output
#' @export
plan <- local({
  ## Stack of type of futures to use
  stack <- NULL

  plan_set <- function(newStack, skip = TRUE, cleanup = NA, init = TRUE, debug = FALSE) {
    stop_if_not(!is.null(newStack), is.list(newStack), length(newStack) >= 1L)

    if (debug) {
      mdebugf_push("plan(): plan_set(<%d strategies>, skip = %s, cleanup = %s, init = %s) ...", length(newStack), skip, cleanup, init)
      on.exit(mdebug_pop())
    }

    oldStack <- stack

    ## Assign new stack
    class(newStack) <- unique(c("FutureStrategyList", class(newStack)))

    ## Skip if already set?
    if (skip) {
      if (debug) {
        mdebug("plan(): Skip requested. Using the old stack")
        mprint(oldStack)
      }
    } else if (isTRUE(all.equal(newStack, oldStack, debug = debug))) {
      if (debug) {
        mdebug("plan(): Skip setting new future backend stack because it is the same as the current one:")
        mprint(oldStack)
      }
      return(oldStack)
    }

    if (debug) {
      mdebug("plan(): Setting new future backend stack:")
      mprint(newStack)
      mstr(newStack)
    }

    assert_no_disallowed_strategies(newStack)

    ## Warn about 'multicore' on certain systems
    warn_about_multicore(newStack)

    ## Stop/cleanup any previously registered backends?
    plan_cleanup(stack[[1L]], cleanup = cleanup, debug = debug)
#    attr(stack[[1L]], "with-temporary") <- NULL

    stack <<- newStack

    if (init) {
      ## Was plan set from within with()? If so, it should only be set
      ## temporarily, e.g. with() should use cleanup = TRUE.
      calls <- sys.calls()
      ncalls <- length(calls)
      if (ncalls > 2L) {
        for (ii in (ncalls-2L):1) {
          call <- calls[[ii]]
          fcn <- call[[1]]
          if (is.symbol(fcn) && fcn == as.symbol("with")) {
            attr(stack[[1]], "with-temporary") <- TRUE
          } else if (is.call(fcn) &&
                     is.symbol(fcn[[1]]) && fcn[[1]] == as.symbol("::") &&
                     is.symbol(fcn[[2]]) && fcn[[2]] == as.symbol("base") &&
                     is.symbol(fcn[[3]]) && fcn[[3]] == as.symbol("with")) {
            attr(stack[[1]], "with-temporary") <- TRUE
          }
        }
      }
    } ## if (init)
    
    ## Initiate future workers?
    if (init) stack[[1]] <<- plan_init(stack[[1]], debug = debug)

    ## Sanity checks
    with_assert({
      nbrOfWorkers <- nbrOfWorkers()
      if (debug) mdebugf(sprintf("plan(): nbrOfWorkers() = %.0f", nbrOfWorkers))

      stop_if_not(
        is.numeric(nbrOfWorkers), length(nbrOfWorkers) == 1L, 
        !is.na(nbrOfWorkers), nbrOfWorkers >= 1L
      )
    })

    invisible(oldStack)
  } ## plan_set()


  ## Main function
  function(strategy = NULL, ..., substitute = TRUE, .skip = FALSE, .call = TRUE,
           .cleanup = NA, .init = TRUE) {
    if (substitute) strategy <- substitute(strategy)
    if (is.logical(.skip)) stop_if_not(length(.skip) == 1L, !is.na(.skip))
    if (is.logical(.call)) stop_if_not(length(.call) == 1L, !is.na(.call))

    debug <- isTRUE(getOption("future.debug"))
    if (debug) {
      if (inherits(strategy, "character")) {
        first <- sprintf('"%s"', strategy)
      } else {
        first <- sprintf("<%s>", commaq(class(strategy)[1]))
      }
      mdebugf_push("plan(%s, .skip = %s, .cleanup = %s, .init = %s) ...", first, .skip, .cleanup, .init)
      on.exit(mdebug_pop())
    }
    
    ## Once per session
    if (is.null(stack)) {
      stack <<- plan_default_stack()
      if (debug) mdebug("Created default stack")
    }
    
    ## Predefined "actions":
    if (identical(strategy, "backend")) {
      strategy <- stack[[1L]]
      backend <- attr(strategy, "backend")
      if (is.null(backend)) {
        strategy <- plan_init(strategy, debug = debug)
        stack[[1L]] <<- strategy
        backend <- attr(strategy, "backend")
      }
      return(backend)
    } else if (is.null(strategy) || identical(strategy, "next")) {
      ## Next future strategy?
      strategy <- stack[[1L]]
      if (!inherits(strategy, "FutureStrategy")) {
        class(strategy) <- c("FutureStrategy", class(strategy))
      }
      stop_if_not(is.function(strategy))
      if (debug) mdebugf("Getting current (\"next\") strategy: %s", commaq(class(strategy)))
      return(strategy)
    } else if (identical(strategy, "default")) {
      strategy <- getOption("future.plan")
      if (is.null(strategy)) strategy <- sequential
      if (debug) mdebugf("Getting default stack: %s", commaq(class(strategy)))
    } else if (identical(strategy, "list")) {
      if (debug) mdebugf("Getting full stack: [n=%d] %s", length(stack), commaq(sapply(stack, FUN = class)))
      
      ## WORKAROUND 1: Was plan("list") called from 'codalm' tests?
      ## https://github.com/jfiksel/codalm/issues/4
      if (all(c("codalm", "testthat") %in% loadedNamespaces())) {
        ignore <- c("init", "backend")
        class <- class(stack)
        stack <- lapply(stack, FUN = function(s) {
          for (name in ignore) attr(s, name) <- NULL
          s
        })
        class(stack) <- class
      }

      ## List stack of future strategies?
      return(stack)
    } else if (identical(strategy, "tail")) {
      ## List stack of future strategies except the first
      stack <- stack[-1]
      if (debug) mdebugf("Getting stack without first backend: [n=%d] %s", length(stack), commaq(sapply(stack, FUN = class)))
      return(stack)
    } else if (identical(strategy, "reset")) {
      if (debug) mdebug_push("Resetting stack ...")
      ## Stop/cleanup any previously registered backends?
      plan_cleanup(stack[[1]], cleanup = .cleanup, debug = debug)
      ## Reset stack of future strategies?
      stack <<- plan_default_stack()
      if (debug) mdebug_pop()
      return(stack)
    } else if (identical(strategy, "pop")) {
      if (debug) mdebug_push("Popping stack ...")
      ## Pop backend stack and return old stack
      ## (so it can be pushed back later)
      oldStack <- stack
      stack <<- stack[-1L]
      if (length(stack) == 0L) stack <<- plan_default_stack()
      if (debug) mdebug_pop()
      return(oldStack)
    }

    ## Current and new stack of future strategies
    oldStack <- stack
    newStack <- NULL

    ## Arguments to be tweaked
    targs <- list(...)

    ## Set new stack?
    if (is.function(strategy)) {
      ## Tweak the strategy function?
      if (length(targs) > 0) {
        args <- c(list(strategy), targs, penvir = parent.frame())
        strategy <- do.call(tweak, args = args)
      }
      strategy <- list(strategy)
    }

    if (is.list(strategy)) {
      oldStack <- plan_set(strategy, skip = .skip, cleanup = .cleanup, init = .init, debug = debug)
      return(invisible(oldStack))
    }

    ## (a) Is a (plain) list of future strategies specified?
    if (is.language(strategy)) {
      first <- as.list(strategy)[[1]]
      if (is.symbol(first)) {
        ## If a function call, e.g. list(...), then make sure to look up
        ## a function to be used as 'first'.  This makes sure that base::list()
        ## is used with plan(list(...)) even when there is a non-function 
        ## 'list' on the search() path, e.g. gsubfn::list.
        if (is.call(strategy)) {
          first <- get(as.character(first), mode="function", 
                       envir = parent.frame(), inherits = TRUE)
        } else {
          first <- eval(first, envir = parent.frame(), enclos = baseenv())
        }

        ## A list object, e.g. plan(oplan)?
        if (is.list(first)) {
          strategies <- first
          res <- plan(strategies, substitute = FALSE,
                      .cleanup = .cleanup, .init = .init)
          return(invisible(res))
        }

        if (is.function(first) && !inherits(first, "future")) {
          strategies <- eval(strategy, envir = parent.frame(), enclos = baseenv())

          ## Specified explicitly using plan(list(...))?
          ## Example: plan(list(sequential, multicore))
          if (is.list(strategies)) {
            ## Coerce strings to functions, e.g.
            ## plan(list("sequential", multicore))
            for (kk in seq_along(strategies)) {
              strategy_kk <- strategies[[kk]]
              if (is.character(strategy_kk)) {
                strategy_kk <- tweak(strategy_kk, penvir = parent.frame())
                strategies[[kk]] <- strategy_kk
              }
            }
            newStack <- strategies
            stop_if_not(!is.null(newStack), is.list(newStack), length(newStack) >= 1L)
          } else if (is.function(strategies) && !inherits(strategies, "future")) {
            ## Example: plan(x[["abc"]])
            strategies <- list(strategies)
            newStack <- strategies
            stop_if_not(!is.null(newStack), is.list(newStack), length(newStack) >= 1L)
          }
        }
      }
    }

    ## (b) Otherwise, assume a single future backend
    if (is.null(newStack)) {
      if (is.symbol(strategy)) {
        strategy <- eval(strategy, envir = parent.frame(), enclos = baseenv())
      } else if (is.language(strategy)) {
        strategyT <- as.list(strategy)

        ## tweak(...)?
        if (strategyT[[1]] == as.symbol("tweak")) {
          strategy <- eval(strategy, envir = parent.frame(), enclos = baseenv())
        } else {
          isSymbol <- sapply(strategyT, FUN = is.symbol)
          if (!all(isSymbol)) {
            strategy <- eval(strategyT[[1L]], envir = parent.frame(), enclos = baseenv())
            if (length(strategyT) > 1L) {
              ## Tweak this part of the future strategy
              args <- c(list(strategy), strategyT[-1L], penvir = parent.frame())
              strategy <- do.call(tweak, args = args)
            }
          } else {
            strategy <- eval(strategy, envir = parent.frame(), enclos = baseenv())
          }
        }
      }

      ## Tweak future strategy accordingly
      args <- c(list(strategy), targs, penvir = parent.frame())
      tstrategy <- do.call(tweak, args = args, quote = TRUE)

      ## Setup a new stack of future strategies (with a single one)
      newStack <- list(tstrategy)
      stop_if_not(!is.null(newStack), is.list(newStack), length(newStack) >= 1L)
    }

    ## Attach call attribute to each strategy in the stack?
    if (!is.null(.call)) {
      ## The call to assign
      call <- if (isTRUE(.call)) sys.call() else .call

      for (kk in seq_along(newStack)) {
        strategy <- newStack[[kk]]
        ## Skip if already has a call attibute
        if (!is.null(attr(strategy, "call", exact = TRUE))) next
        ## Attach call
        attr(strategy, "call") <- call
        newStack[[kk]] <- strategy
      }
      stop_if_not(!is.null(newStack), is.list(newStack), length(newStack) >= 1L)
    }

    ## Set new future backend stack for futures
    oldStack <- plan_set(newStack, skip = .skip, cleanup = .cleanup, init = .init, debug = debug)
    invisible(oldStack)
  } # function()
}) # plan()



supportedStrategies <- function(strategies = c("sequential", "multicore",
                                               "multisession", "cluster")) {
  if (!supportsMulticore()) strategies <- setdiff(strategies, "multicore")
  strategies
}


#' @importFrom utils capture.output str
#' @export
print.future <- function(x, ...) {
  class <- setdiff(class(x), c("FutureStrategy", "tweaked", "function"))
  s <- sprintf("%s:", class[1])
  specs <- list()
  args <- args(x)

  ## Simplify the value on the 'workers' argument?
  formals <- formals(args)
  if (!is.atomic(formals[["workers"]]) && !is.language(formals[["workers"]])) {
    bfr <- capture.output(print(formals[["workers"]]))
    if (length(bfr) > 6L) {
      bfr2 <- capture.output(str(formals[["workers"]]))
      if (length(bfr2) < length(bfr)) bfr <- bfr2
      if (length(bfr) > 6L) bfr <- c(bfr[1:6], "...")
    }
    formals[["workers"]] <- paste0("<", paste(bfr, collapse = "; "), ">")
    formals(args) <- formals
  }

  args <- deparse(args, width.cutoff = 500L)
  args <- args[-length(args)]
  args <- gsub("(^[ ]+|[ ]+$)", "", args)
  args <- paste(args, collapse = " ")
  specs[["args"]] <- args
  specs[["tweaked"]] <- inherits(x, "tweaked")
  specs[["call"]] <- paste(deparse(attr(x, "call", exact = TRUE), 
                              width.cutoff = 500L),
                      collapse="")
  specs <- paste0("- ", names(specs), ": ", unlist(specs))
  s <- c(s, specs)
  s <- paste(s, collapse = "\n")
  cat(s, "\n", sep = "")

  ## FutureBackend?
  if (!is.null(attr(x, "factory", exact = FALSE))) {
    backend <- attr(x, "backend", exact = FALSE)
    if (is.null(backend)) {
      cat("FutureBackend to be launched\n")
    } else {
      print(backend, ...)
    }
  }
  
  invisible(x)
}

#' @export
print.FutureStrategy <- print.future


#' @importFrom utils capture.output
#' @export
print.FutureStrategyList <- function(x, ...) {
  s <- "List of future strategies:"

  for (kk in seq_along(x)) {
    x_kk <- x[[kk]]
    class <- setdiff(class(x_kk), c("tweaked", "function"))
    s_kk <- sprintf("%d. %s:", kk, class[1])
    specs <- list()

    args <- args(x_kk)

    ## Simplify the value on the 'workers' argument?
    formals <- formals(args)
    if (!is.atomic(formals[["workers"]]) && !is.language(formals[["workers"]])) {
      bfr <- capture.output(print(formals[["workers"]]))
      if (length(bfr) > 6L) {
        bfr2 <- capture.output(str(formals[["workers"]]))
        if (length(bfr2) < length(bfr)) bfr <- bfr2
        if (length(bfr) > 6L) bfr <- c(bfr[1:6], "...")
      }
      formals[["workers"]] <- paste0("<", paste(bfr, collapse = "; "), ">")
      formals(args) <- formals
    }

    args <- deparse(args, width.cutoff = 500L)
    args <- args[-length(args)]
    args <- gsub("(^[ ]+|[ ]+$)", "", args)
    args <- paste(args, collapse = " ")
    specs[["args"]] <- args
    specs[["tweaked"]] <- inherits(x_kk, "tweaked")
    specs[["call"]] <- paste(deparse(attr(x_kk, "call", exact = TRUE), 
                                width.cutoff = 500L),
                        collapse = "")
    specs <- paste0("   - ", names(specs), ": ", unlist(specs))
    s <- c(s, s_kk, specs)
  }

  s <- paste(s, collapse = "\n")
  cat(s, "\n", sep = "")
  invisible(x)
}


#' Free up active background workers
#'
#' @param x A FutureStrategy.
#'
#' @param \ldots Not used.
#'
#' @export
#'
#' @details
#' This function will resolve any active futures that is currently
#' being evaluated on background workers.
#'
#' @examples
#' resetWorkers(plan())
#'
#' @keywords internal
#' @export
resetWorkers <- function(x, ...) UseMethod("resetWorkers")


#' @export
resetWorkers.default <- function(x, ...) invisible(x)

#' @export
resetWorkers.multicore <- function(x, ...) {
  if (usedCores() == 0L) return(invisible(x))
  reg <- sprintf("multicore-%s", session_uuid())
  FutureRegistry(reg, action = "collect-all", earlySignal = FALSE)
  stop_if_not(usedCores() == 0L)
}
