FutureEvalError <- function(...) {
  ex <- FutureError(...)
  class(ex) <- c("FutureEvalError", class(ex))
  ex
}


attachPackages <- function(packages) {
  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebug_push("attachPackages() ...")
    mdebugf("packages: [n=%d] %s", length(packages), commaq(packages))
    on.exit(mdebug_pop("attachPackages() ... DONE"))
  }
  
  ## Nothing to do?
  if (length(packages) == 0L) return()

  attached_packages <- sub("package:", "", grep("^package:", search(), value = TRUE), fixed = TRUE)

  ## Skip already attached packages
  packages <- setdiff(packages, attached_packages)
  if (length(packages) == 0L) return()

  ## TROUBLESHOOTING: If the package fails to load, then library()
  ## suppress that error and generates a generic much less
  ## informative error message.  Because of this, we load the
  ## namespace first (to get a better error message) and then
  ## call library(), which attaches the package. /HB 2016-06-16
  lib.loc <- .libPaths()
  tryCatch({
    for (pkg in packages) {
      loadNamespace(pkg)
      library(pkg, character.only = TRUE, lib.loc = lib.loc, warn.conflicts = FALSE, quietly = FALSE, mask.ok = character(0L), exclude = character(0L), attach.required = TRUE)
    }
    NULL
  }, error = identity)
} ## attachPackages()


tmpl_expr_local <- bquote_compile(local({
  .(expr)
}))


getSysCalls <- local({
  sysCalls_local <- NULL
  sysCalls_no_local <- NULL
  
  function(local = TRUE) {
    if (local) {
      if (is.null(sysCalls_local)) {
        ## WORKAROUND: This makes assumption about withCallingHandlers()
        ## and local(). In case this changes, provide internal options to
        ## adjust this. /HB 2018-12-28
        skip <- getOption("future.makeExpression.skip.local", c(12L, 3L))
        sysCalls_local <<- function(calls = sys.calls(), from = 1L) {
          calls[seq.int(from = from + skip[1L], to = length(calls) - skip[2L])]
        }
      }
      sysCalls_local
    } else {
      if (is.null(sysCalls_no_local)) {
        ## WORKAROUND: This makes assumption about withCallingHandlers()
        ## In case this changes, provide internal options to adjust this.
        ## /HB 2018-12-28
        skip <<- getOption("future.makeExpression.skip", c(6L, 3L))
        sysCalls_no_local <<- function(calls = sys.calls(), from = 1L) {
          calls[seq.int(from = from + skip[1L], to = length(calls) - skip[2L])]
        }
      }
      sysCalls_no_local
    }
  }
})


## Is it possible to force single-threaded processing?
canForceSingleThreading <- local({
  .cache <- NULL
  
  function() {
    debug <- isTRUE(getOption("future.debug"))
    if (debug) {
      mdebug_push("canForceSingleThreading() ...")
      on.exit(mdebug_pop("canForceSingleThreading() ... DONE"))
    }
    
    if (!is.null(.cache)) {
      if (debug) mdebugf("results: %s (memoized)", .cache)
      return(.cache)
    }

    ans <- FALSE
    if (requireNamespace("RhpcBLASctl", quietly = TRUE)) {
      ## If RhpcBLASctl is compiled without OpenMP support, then it
      ## returns NA_integer_, or NULL if RhpcBLASctl (< 0.20-17)
      old <- RhpcBLASctl::omp_get_max_threads()
      
      ## Success?
      if (!is.null(old) && !is.na(old)) {
        ans <- TRUE
      }
    }

    if (debug) mdebugf("results: %s", ans)

    .cache <<- ans
    ans
  }
})


setNumberOfThreads <- function(openmp = NA_integer_, rcpp = openmp) {
  debug <- isTRUE(getOption("future.debug"))
  if (debug) {
    mdebug_push("setNumberOfThreads() ...")
    on.exit(mdebug_pop("setNumberOfThreads() ... DONE"))
  }
  
  if (is.list(openmp)) {
    new_threads <- openmp
  } else {
    if (is.na(rcpp)) rcpp <- ""
    new_threads <- list(
      openmp = openmp,
        rcpp = rcpp
    )
  }

  if (debug) {
    args <- unlist(new_threads)
    args <- sprintf("%s=%s", names(args), args)
    args <- paste(args, collapse = ", ")
    mdebug("arguments: ", args)
  }

  old_threads <- list(
    openmp = NA_integer_,
      rcpp = NA_character_
  )

  curr_threads <- list(
    openmp = NA_integer_,
      rcpp = NA_character_
  )

  ## ---------------------------------------------------
  ## (a) Force single-threaded OpenMP, iff needed
  ## ---------------------------------------------------
  if (canForceSingleThreading()) {
    new <- new_threads[["openmp"]]
    stop_if_not(length(new) == 1L, is.numeric(new))
    old <- RhpcBLASctl::omp_get_max_threads()
    old_threads[["openmp"]] <- old
    RhpcBLASctl::omp_set_num_threads(new)
    res <- RhpcBLASctl::omp_get_max_threads()
    curr_threads[["openmp"]] <- res
    if (!is.numeric(res) || is.na(res)) {
      warning(FutureWarning(sprintf("Failed to set number of OMP thread on this system. Number of threads used: %s", res)))
    } else if (res != new) {
      warning(FutureWarning(sprintf("Failed to change the number of OMP thread on this system. Number of threads used: %s", res)))
    }
  }

  ## ---------------------------------------------------
  ## (b) Force single-threaded RcppParallel, iff needed
  ## ---------------------------------------------------
  new <- new_threads[["rcpp"]]
  stop_if_not(length(new) == 1L, is.numeric(new) || is.character(new))
  old <- Sys.getenv("RCPP_PARALLEL_NUM_THREADS", "")
  old_threads[["rcpp"]] <- old
  new <- as.character(new)
  if (new != old) {
    if (nzchar(new)) {
      Sys.setenv(RCPP_PARALLEL_NUM_THREADS = new)
    } else {
      Sys.unsetenv("RCPP_PARALLEL_NUM_THREADS")
    }
  }
  curr_threads[["rcpp"]] <- Sys.getenv("RCPP_PARALLEL_NUM_THREADS", "")

  if (debug) {
    args <- unlist(old_threads)
    args <- sprintf("%s=%s", names(args), args)
    args <- paste(args, collapse = ", ")
    mdebug("previous settings: ", args)
    
    args <- unlist(curr_threads)
    args <- sprintf("%s=%s", names(args), args)
    args <- paste(args, collapse = ", ")
    mdebug("new settings: ", args)
  }

  invisible(old_threads)
} ## setNumberOfThreads()


get_connections <- function() {
  lapply(getAllConnections()[-(1:3)], FUN = getConnection)
}

diff_connections <- function(after, before) {
  ## Expand
  before_idxs <- vapply(before, FUN = as.integer, FUN.VALUE = NA_integer_)
  after_idxs <- vapply(after, FUN = as.integer, FUN.VALUE = NA_integer_)
  max <- max(before_idxs, after_idxs, na.rm = TRUE)
  if (is.infinite(max)) {
    return(c(added = list(), removed = list(), replaced = list()))
  }
  
  before2 <- as.list(rep(NA_character_, length.out = max))
  names(before2) <- as.character(seq_len(max))
  after2 <- before2
  for (kk in seq_along(before)) {
    con <- before[[kk]]
    before2[[as.integer(con)]] <- con
  }
  for (kk in seq_along(after)) {
    con <- after[[kk]]
    after2[[as.integer(con)]] <- con
  }

  ## Drop unchanged connections
  for (kk in seq_len(max)) {
    if (identical(after2[[kk]], before2[[kk]])) {
      before2[[kk]] <- after2[[kk]] <- NA_integer_
    }
  }
  before2 <- before2[!vapply(before2, FUN = is.na, FUN.VALUE = FALSE)]
  after2 <- after2[!vapply(after2, FUN = is.na, FUN.VALUE = FALSE)]
  added_idx <- as.integer(setdiff(names(after2), names(before2)))
  removed_idx <- as.integer(setdiff(names(before2), names(after2)))
  replaced_idx <- as.integer(intersect(names(after2), names(before2)))
  
  added <- lapply(added_idx, FUN = function(idx) {
    con <- getConnection(idx)
    summary(con)
  })
  names(added) <- added_idx

  removed <- lapply(removed_idx, FUN = function(idx) {
    list(details = "information not collected")
  })
  names(removed) <- removed_idx

  replaced <- lapply(replaced_idx, FUN = function(idx) {
    con <- getConnection(idx)
    summary(con)
  })
  names(replaced) <- replaced_idx

  list(added = added, removed = removed, replaced = replaced)
}

evalFuture <- function(
    data = list(
      core = list(
        expr = NULL,
        globals = list(),
        packages = character(0L),
        seed = NULL
      ),
      capture = list(
        stdout = TRUE,
        split = FALSE,
        conditionClasses = character(0L),
        immediateConditionClasses = character(0L),
        immediateConditionHandlers = list()
      ),
      context = list(
        backendPackages = character(0L),
        strategiesR = NULL,
        threads = NA_integer_,
        forwardOptions = NULL
      )
    )) {
  tryCatch({
    evalFutureInternal(data)
  }, error = function(ex) {
    ## Wrap up in a FutureError
    msg <- sprintf("future::evalFuture() failed on %s (pid %s) at %s", Sys.info()[["nodename"]], Sys.getpid(), format(Sys.time(), "%FT%T"))
    if (!requireNamespace("future")) {
      msg <- sprintf("%s. Package 'future' is not available", msg)
    }
    msg <- sprintf("%s. Possible other reasons: %s", msg, conditionMessage(ex))
    ex <- simpleError(msg)
    class(ex) <- c("FutureLaunchError", "FutureError", class(ex))
#    structure(list(
#      value = ex,
#      visible = FALSE,
#      rng = FALSE,
#      started = Sys.time(),
#      finished = Sys.time()
#    ), class = c("FutureResult"))
    ex
  })
} ## evalFuture()


evalFutureInternal <- function(data) {
  debug <- FALSE

  core <- data[["core"]]
  capture <- data[["capture"]]
  context <- data[["context"]]

  expr <- core[["expr"]]
  
  globals <- core[["globals"]]
  packages <- core[["packages"]]
  seed <- core[["seed"]]

  stdout <- capture[["stdout"]]
  split <- capture[["split"]]
  if (is.null(stdout)) stdout <- TRUE
  conditionClasses <- capture[["conditionClasses"]]
  immediateConditionClasses <- capture[["immediateConditionClasses"]]
  immediateConditionHandlers <- capture[["immediateConditionHandlers"]]

  backendPackages <- context[["backendPackages"]]
  strategiesR <- context[["strategiesR"]]
  threads <- context[["threads"]]
  forwardOptions <- context[["forwardOptions"]]
  if (is.null(threads)) threads <- NA_integer_
  ## This will eventually always be TRUE
  local <- context[["local"]]
  if (is.null(local)) local <- TRUE
  reset <- context[["reset"]]

  with_assert({
    if (!is.null(immediateConditionHandlers)) {
      stop_if_not(is.list(immediateConditionHandlers))
      if (length(immediateConditionHandlers) > 0) {
        stop_if_not(    
          !is.null(names(immediateConditionHandlers)),
          all(vapply(immediateConditionHandlers, FUN = is.function, FUN.VALUE = FALSE))
        )
      }
    }

    stop_if_not(
      length(forwardOptions) == 0L || !is.null(names(forwardOptions)),
      length(local) == 1L && is.logical(local) && !is.na(local),
      length(stdout) == 1L && is.logical(stdout),
      length(split) == 1L && is.logical(split) && !is.na(split),
      is.null(conditionClasses) || (is.character(conditionClasses) && !anyNA(conditionClasses) && all(nzchar(conditionClasses))),
      is.null(immediateConditionClasses) || (is.character(immediateConditionClasses) && !anyNA(immediateConditionClasses) && all(nzchar(immediateConditionClasses))),
      is.null(seed) || parallel_rng_kind()[["is_seed"]](seed) || (is.logical(seed) && !is.na(seed) || !seed),
      is.character(backendPackages) && !anyNA(backendPackages) && all(nzchar(backendPackages)),
      length(threads) == 1L && is.integer(threads) && (is.na(threads) || threads >= 1L),
      is.character(reset), !anyNA(reset)
    )

    if (is.function(strategiesR)) {
      if (!inherits(strategiesR, "future")) {
        stop(FutureEvalError(sprintf("Argument 'strategiesR' is a function, but does not inherit 'future': %s", commaq(class(strategiesR)))))
      }
    } else if (is.list(strategiesR)) {
      for (kk in seq_along(strategiesR)) {
        strategy <- strategiesR[[kk]]
        if (!inherits(strategy, "future")) {
          stop(FutureEvalError(sprintf("Element #%d of list 'strategiesR' is a function, but does not inherit 'future': %s", kk, commaq(class(strategy)))))
        }
      }
    } else if (is.character(strategiesR)) {
    } else {
      stop(FutureEvalError(sprintf("Unknown value of argument 'strategiesR': %s", commaq(class(strategiesR)))))
    }
  })


  ## Is it possible to force single-threaded processing?
  if (!is.na(threads)) {
    ## Setting other than single-threaded processing is currently not
    ## supported. /HB 2024-12-30
    if (threads != 1L) {
      stop(FutureEvalError(sprintf("Non-supported value on argument 'threads': %d", threads)))
    }
    
    if (!canForceSingleThreading()) {
      threads <- NA_integer_
    }
  }


  ## Start time for future evaluation
  ...future.startTime <- Sys.time()


  ## -----------------------------------------------------------------
  ## Load and attached backend packages
  ## -----------------------------------------------------------------
  attachPackages(backendPackages)


  ## -----------------------------------------------------------------
  ## Record current state
  ## -----------------------------------------------------------------
  ## Record RNG state
  ...future.rng <- globalenv()[[".Random.seed"]]
  
  ## mc.cores
  ...future.mc.cores.old <- getOption("mc.cores")

  ## Load and attached packages
  attachPackages(packages)

  ## Note, we record R options and environment variables _after_
  ## loading and attaching packages, in case they set options/env vars
  ## needed for the session, e.g.
  ## https://github.com/Rdatatable/data.table/issues/5375
  

  ## -----------------------------------------------------------------
  ## Reset the current state on exit
  ## -----------------------------------------------------------------
  if (length(reset) > 0) {
    if ("envvars" %in% reset) {
      ## Record environment variables
      ...future.oldEnvVars <- Sys.getenv()
  
      on.exit({
        ## (d) Reset environment variables
        if (.Platform[["OS.type"]] == "windows") {
          ## On MS Windows, there are two special cases to consider:
          ##
          ## (1) You cannot have empty environment variables. When one is assigned
          ## an empty string, MS Windows interprets that as it should be removed.
          ## That is, if we do Sys.setenv(ABC = ""), it'll have the
          ## same effect as Sys.unsetenv("ABC").
          ## However, when running MS Windows on msys2, we might see empty
          ## environment variables also MS Windows. We can also observe this on
          ## GitHub Actions and when running R via Wine.
          ## Because of this, we need to take extra care to preserve empty ("")
          ## environment variables.
          ##
          ## (2) Environment variable names are case insensitive. However, it is
          ## still possible to have two or more environment variables that have
          ## the exact same toupper() names, e.g. 'TEMP', 'temp', and 'tEmP'.
          ## This can happen if 'temp' and 'tEmP' are inherited from the host
          ## environment (e.g. msys2), and 'TEMP' is set by MS Windows.
          ## What complicates our undoing here is that Sys.setenv() is non-case
          ## sensitive.  This means, if we do Sys.setenv(temp = "abc") when
          ## both 'temp' and 'TEMP' exists, then we'll lose 'TEMP'.  So, we
          ## should on undo an environment variable if the upper-case version
          ## does not exist.
    
          old_names <- names(...future.oldEnvVars)
          envs <- Sys.getenv()
          names <- names(envs)
          common <- intersect(names, old_names)
          added <- setdiff(names, old_names)
          removed <- setdiff(old_names, names)
          
          ## (a) Update environment variables that have changed
          changed <- common[...future.oldEnvVars[common] != envs[common]]
          NAMES <- toupper(changed)
          args <- list()
          for (kk in seq_along(NAMES)) {
            name <- changed[[kk]]
            NAME <- NAMES[[kk]]
            ## Skip if Case (2), e.g. 'temp' when 'TEMP' also exists?
            if (name != NAME && is.element(NAME, old_names)) next
            args[[name]] <- ...future.oldEnvVars[[name]]
          }
    
          ## (b) Remove newly added environment variables
          NAMES <- toupper(added)
          for (kk in seq_along(NAMES)) {
            name <- added[[kk]]
            NAME <- NAMES[[kk]]
            ## Skip if Case (2), e.g. 'temp' when 'TEMP' also exists?
            if (name != NAME && is.element(NAME, old_names)) next
            args[[name]] <- ""
          }
    
          ## (c) Add removed environment variables
          NAMES <- toupper(removed)
          for (kk in seq_along(NAMES)) {
            name <- removed[[kk]]
            NAME <- NAMES[[kk]]
            ## Skip if Case (2), e.g. 'temp' when 'TEMP' also exists?
            if (name != NAME && is.element(NAME, old_names)) next
            args[[name]] <- ...future.oldEnvVars[[name]]
          }
    
          if (length(args) > 0) do.call(Sys.setenv, args = args)
    
          ## Not needed anymore
          args <- names <- old_names <- NAMES <- envs <- common <- added <- removed <- NULL
        } else {
          do.call(Sys.setenv, args = as.list(...future.oldEnvVars))
        }
        
        ## For the same reason as we don't remove added R options, we don't
        ## remove added environment variables until we know it's safe.
        ## /HB 2022-04-30
        ## (d) Remove any environment variables added
        ## diff <- setdiff(names(Sys.getenv()), names(...future.oldEnvVars))
        ## Sys.unsetenv(diff)
      }, add = TRUE)
    } ## if ("envvar" ...)
  
  
    if ("options" %in% reset) {
      ## Record R options
      ...future.oldOptions <- as.list(.Options)
  
      on.exit({
        ## (a) Reset options
        ## WORKAROUND: Do not reset 'nwarnings' unless changed, because
        ## that will, as documented, trigger any warnings collected
        ## internally to be removed.
        ## https://github.com/futureverse/future/issues/645
        if (identical(getOption("nwarnings"), ...future.oldOptions[["nwarnings"]])) {
          ...future.oldOptions[["nwarnings"]] <- NULL
        }
        options(...future.oldOptions)
    
        ## There might be packages that add essential R options when
        ## loaded or attached, and if their R options are removed, some of
        ## those packages might break. Because we don't know which these
        ## packages are, and we cannot detect when a random packages is
        ## loaded/attached, we cannot reliably workaround R options added
        ## on package load/attach.  For this reason, I'll relax the
        ## resetting of R options to only be done to preexisting R options
        ## for now. These thoughts were triggered by a related data.table
        ## issue, cf. https://github.com/futureverse/future/issues/609
        ## /HB 2022-04-29
        
        ## (b) Remove any options added
        ## diff <- setdiff(names(.Options),
        ##                       names(...future.oldOptions))
        ## if (length(diff) > 0L) {
        ##    opts <- vector("list", length = length(diff))
        ##    names(opts) <- diff
        ##    options(opts)
        ## }
      }, add = TRUE)
    } ## if ("options" ...)
  
  
    if ("plan" %in% reset) {
      ## Record the original future strategy set on this worker
      ...future.plan.old <- getOption("future.plan")
      ...future.plan.old.envvar <- Sys.getenv("R_FUTURE_PLAN", NA_character_)
      ...future.strategy.old <- plan("list")

      on.exit({
        ## Revert to the original future strategy
        ## Reset option 'future.plan' and env var 'R_FUTURE_PLAN'
        options(future.plan = ...future.plan.old)
        plan(...future.strategy.old, .cleanup = FALSE, .init = FALSE)
        if (is.na(...future.plan.old.envvar)) {
          Sys.unsetenv("R_FUTURE_PLAN")
        } else {
          Sys.setenv(R_FUTURE_PLAN = ...future.plan.old.envvar)
        }
        
        ## Reset R option 'mc.cores'
        options(mc.cores = ...future.mc.cores.old)
      }, add = TRUE)
    } ## if ("plan" ...)
  
  
    if ("rng" %in% reset) {
      ## Record RNG kind too
      ...future.rngkind <- RNGkind()[1]
    
      on.exit({
        ## Undo RNG state
        RNGkind(...future.rngkind)
        if (is.null(...future.rng)) {
          if (exists(".Random.seed", envir = globalenv(), inherits = FALSE)) {
            rm(list = ".Random.seed", envir = globalenv(), inherits = FALSE)
          }
        } else {
          assign(".Random.seed", ...future.rng, envir = globalenv(), inherits = FALSE)
        }
      }, add = TRUE)
    } ## if ("rng" ...)
  
  
    if ("pwd" %in% reset) {
      ## Record current working directory
      ...future.workdir <- getwd()
  
      on.exit({
        ## Reset working directory
        setwd(...future.workdir)
      }, add = TRUE)
    } ## if ("pwd" ...)
  }


  ## Prevent .future.R from being source():d when future is attached
  options(future.startup.script = FALSE)

  ## Options forwarded from parent process
  if (length(forwardOptions) > 0) {
    oopts <- do.call(options, args = forwardOptions)
    on.exit({
      options(oopts)
    }, add = TRUE)
  }
  

  ## -----------------------------------------------------------------
  ## Evaluate future in the correct context
  ## -----------------------------------------------------------------
  ## Evaluate expression in a local() environment?
  if (local) {
    expr <- bquote_apply(tmpl_expr_local)
  }

  ## Ignore, capture or discard standard output?
  if (is.na(stdout)) {  ## stdout = NA
    ## Don't capture, but also don't block any output
  } else {
    if (stdout) {  ## stdout = TRUE
      ## Capture all output
      ## NOTE: Capturing to a raw connection is much more efficient
      ## than to a character connection, cf.
      ## https://www.jottr.org/2014/05/26/captureoutput/
      ...future.stdout <- rawConnection(raw(0L), open = "w")
    } else {  ## stdout = FALSE
      ## Silence all output by sending it to the void
      ...future.stdout <- file(
        switch(.Platform[["OS.type"]], windows = "NUL", "/dev/null"),
        open = "w"
      )
    }
    sink(...future.stdout, type = "output", split = split)
    on.exit(if (!is.null(...future.stdout)) {
      sink(type = "output", split = split)
      close(...future.stdout)
    }, add = TRUE)
  }

  ## Prevent 'future.plan' / R_FUTURE_PLAN settings from being nested
  options(future.plan = NULL)
  Sys.unsetenv("R_FUTURE_PLAN")

  ## Prevent multithreading?
  if (!is.na(threads) && threads == 1L) {
    ## Force single-threaded OpenMP, iff needed
    old <- setNumberOfThreads(threads)
    
    if ("threads" %in% reset) {
      on.exit(setNumberOfThreads(old), add = TRUE)
    }
  }

  
  ## -----------------------------------------------------------------
  ## Limit nested parallelization
  ## -----------------------------------------------------------------
  ...future.ncores <- NA_integer_
  
  ## (a) Identify default number of cores - ignoring plan settings
  ## FIXME: Can the results here be memoized? Can the results be
  ## precalculated and stored in the strategy stack? /HB 2025-02-17
  if (FALSE) {
    ...future.ncores <- local({
      ans <- NA_integer_
      options(parallelly.availableCores.fallback = 1L)
      ## NOTE: availableCores() is expensive
      ncores <- availableCores(which = "all")
      ncores <- ncores[setdiff(names(ncores), c("system", "_R_CHECK_LIMIT_CORES_", "Bioconductor"))]
      n_ncores <- length(ncores)
      if (n_ncores > 0) {
        if (n_ncores > 1) {
          ncores <- ncores[setdiff(names(ncores), "fallback")]
        }
        if (n_ncores > 0) {
          ans <- min(ncores, na.rm = TRUE)
        }
      }
      ans
    })
  }


  ## Use the next-level-down ("popped") future strategy
  plan(strategiesR, .cleanup = FALSE, .init = FALSE)

  if (!is.na(...future.ncores)) {
    if (is.function(strategiesR)) {
      nextStrategy <- strategiesR
    } else if (is.list(strategiesR)) {
      nextStrategy <- strategiesR[[1]]
    } else if (is.character(strategiesR)) {
      nextStrategy <- plan("next")
    } else {
      ## Should not happen
      nextStrategy <- NULL
    }

    ## (b) Identify default number of cores - acknowledging plan settings
    ...future.ncores <- local({
      nworkers <- nbrOfWorkers(nextStrategy)
      min(c(nworkers, ...future.ncores), na.rm = TRUE)
    })
  }

  if (!is.na(...future.ncores)) {
    ...future.options.ncores <- options(mc.cores = ...future.ncores)
    on.exit(options(...future.options.ncores), add = TRUE)
  }
  

  ## Set RNG seed?
  if (is.numeric(seed)) {
    genv <- globalenv()
    genv[[".Random.seed"]] <- seed
  }


  ## -----------------------------------------------------------------
  ## Record state to report on:
  ##  1. assignments to the global environment
  ##  2. add or removed connections
  ## -----------------------------------------------------------------
  globalenv <- getOption("future.globalenv.onMisuse")
  if (is.null(globalenv)) {
    globalenv <- FALSE
  } else {
    globalenv <- (globalenv != "ignore")
    if (globalenv) {
      ## Record names of variables in the global environment
      ...future.globalenv.names <- c(names(.GlobalEnv), "...future.value", "...future.globalenv.names", ".Random.seed")
    }
  }


  checkConnections <- getOption("future.connections.onMisuse")
  if (is.null(checkConnections)) {
    checkConnections <- TRUE
  } else {
    checkConnections <- (checkConnections != "ignore")
  }
  if (checkConnections) {
    ...future.connections <- get_connections()
  }


  ## Attach globals to the global environment
  ## Undo changes on exit
  if (length(globals) > 0) {
    ## Preserve globals in all environments until the global environment
    names <- names(globals)
    currEnvs <- list()
    pastEnvs <- list()
    env <- globalenv()
    repeat {
      if (identical(env, emptyenv())) break
      if (isNamespace(env)) {
        env <- parent.env(env)
        next
      }
      
      oldEnv <- new.env(parent = emptyenv())
      for (name in names) {
        ## Environment might be locked. If so, it'll fail on the
        ## first object, and skip from there.
        tryCatch({
          if (exists(name, envir = env, inherits = FALSE)) {
            value <- get(name, envir = env, inherits = FALSE)
            rm(list = name, envir = env, inherits = FALSE)
            assign(name, value = value, envir = oldEnv, inherits = FALSE)
          }
        }, error = identity)
      }
      currEnvs <- c(currEnvs, env)
      pastEnvs <- c(pastEnvs, oldEnv)
      if (identical(env, globalenv())) break
      env <- parent.env(env)
    }

    if ("globalenv" %in% reset) {
      on.exit({
        ## Remove globals from the global environment
        rm(list = names(globals), envir = globalenv(), inherits = FALSE)
        ## Restore objects in all modified environments
        for (ee in seq_along(currEnvs)) {
          oldEnv <- pastEnvs[[ee]]
          env <- currEnvs[[ee]]
          for (name in names(oldEnv)) {
            value <- get(name, envir = oldEnv, inherits = FALSE)
            assign(name, value = value, envir = env, inherits = FALSE)
          }
        } ## for (ee ...)
      }, add = TRUE)
    }
    
    assign_globals(globalenv(), globals = globals)
  }

  conditionClassesExclude <- attr(conditionClasses, "exclude", exact = TRUE)
  muffleInclude <- attr(conditionClasses, "muffleInclude", exact = TRUE)
  if (is.null(muffleInclude)) muffleInclude <- "^muffle"

  ...future.frame <- sys.nframe()
  ...future.conditions <- list()

  ## NOTE: We don't want to use local(body) w/ on.exit() because
  ## evaluation in a local is optional, cf. argument 'local'.
  ## If this was mandatory, we could.  Instead we use
  ## a tryCatch() statement. /HB 2016-03-14
  ...future.result <- tryCatch({
    tryCatch({
      withCallingHandlers({
        ...future.value <- withVisible(eval(expr, envir = globalenv()))
        FutureResult(
          value = ...future.value[["value"]],
          visible = ...future.value[["visible"]],
          conditions = ...future.conditions,
          rng = !identical(globalenv()[[".Random.seed"]], ...future.rng),
          globalenv = if (globalenv) list(added = setdiff(names(.GlobalEnv), ...future.globalenv.names)) else NULL,
          misuse_connections = if (checkConnections) diff_connections(get_connections(), ...future.connections) else NULL,
          started = ...future.startTime
        )
      }, condition = function(cond) {
          is_error <- inherits(cond, "error")
          if (is_error) {
            ## Disable timeouts as soon as possible, in case there is a
            ## timeout set by the future expression, which triggered
            ## this error
            setTimeLimit(cpu = Inf, elapsed = Inf, transient = FALSE)
          }
          
          ## Handle immediately?
          if (length(immediateConditionHandlers) > 0) {
            ## Handle immediateCondition:s?
            idxs <- inherits(cond, names(immediateConditionHandlers), which = TRUE)
            if (length(idxs) > 0 && !identical(idxs, 0L)) {
              class <- class(cond)[idxs[[1]]]
              handler <- immediateConditionHandlers[[class]]
              res <- handler(cond)
  
              ## Avoid condition from being signaled more than once
              muffleCondition(cond)
  
              ## Record condition
              ...future.conditions[[length(...future.conditions) + 1L]] <<- list(
                condition = cond,
                signaled = 1L
              )
  
              return()
            }
          }
  
          ## Ignore condition?
          ignore <- !is_error &&
                    !is.null(conditionClassesExclude) && 
                    inherits(cond, conditionClassesExclude)
          
          ## Handle error:s specially
          if (is_error) {
            sessionInformation <- function() {
              list(
                r          = R.Version(),
                locale     = Sys.getlocale(),
                rngkind    = RNGkind(),
                namespaces = loadedNamespaces(),
                search     = search(),
                system     = Sys.info()
              )
            }
  
            sysCalls <- getSysCalls()
  
            ## Record condition
            ...future.conditions[[length(...future.conditions) + 1L]] <<- list(
              condition = cond,
              calls     = c(sysCalls(from = ...future.frame), cond[["call"]]),
              session   = sessionInformation(),
              timestamp = Sys.time(),
              signaled  = 0L
            )
        
            signalCondition(cond)
          } else if (!ignore &&
                     !is.null(conditionClasses) &&
                     inherits(cond, conditionClasses)
                    ) {
            ## Relay 'immediateCondition' conditions immediately?
            ## If so, then do not muffle it and flag it as signalled
            ## already here.
            signal <- inherits(cond, immediateConditionClasses)
            ## Record condition
            ...future.conditions[[length(...future.conditions) + 1L]] <<- list(
              condition = cond,
              signaled = as.integer(signal)
            )
            if (length(immediateConditionClasses) > 0 && !split && !signal) {
              muffleCondition(cond, pattern = muffleInclude)
            }
          } else {
            if (!split && !is.null(conditionClasses)) {
              ## Muffle all non-captured conditions
              muffleCondition(cond, pattern = muffleInclude)
            }
          }
        } ## function(cond)
      ) ## withCallingHandlers()
    }, finally = {
      ## Disable timeouts as soon as possible, in case there is a
      ## timeout set by the future expression
      setTimeLimit(cpu = Inf, elapsed = Inf, transient = FALSE)
    }) ## tryCatch() for future evaluation 
  }, interrupt = function(ex) {
    FutureResult(
      conditions = ...future.conditions,
      rng = !identical(globalenv()[[".Random.seed"]], ...future.rng),
      globalenv = if (globalenv) list(added = setdiff(names(.GlobalEnv), ...future.globalenv.names)) else NULL,
      misuse_connections = diff_connections(get_connections(), ...future.connections),
      started = ...future.startTime
    )
  }, error = function(ex) {
    FutureResult(
      conditions = ...future.conditions,
      rng = !identical(globalenv()[[".Random.seed"]], ...future.rng),
      globalenv = if (globalenv) list(added = setdiff(names(.GlobalEnv), ...future.globalenv.names)) else NULL,
      misuse_connections = diff_connections(get_connections(), ...future.connections),
      started = ...future.startTime
    )
  }) ## output tryCatch()
  

  ## -----------------------------------------------------------------
  ## Get captured standard output?
  ## -----------------------------------------------------------------
  if (!is.na(stdout)) {
    sink(type = "output", split = split)
    if (stdout) {
      ...future.result[["stdout"]] <- rawToChar(
        rawConnectionValue(...future.stdout)
      )
    } else {
      ...future.result["stdout"] <- list(NULL)
    }
    close(...future.stdout)
    ...future.stdout <- NULL
  }

  ...future.result
} ## evalFuture()
