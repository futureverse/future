makeExpression <- local({
  skip <- skip.local <- NULL

  tmpl_expr_local <- bquote_compile(base::local(.(expr)))

  tmpl_enter_optenvar <- bquote_compile({
    ## Start time for future evaluation
    ...future.startTime <- base::Sys.time()
    
    ## Required packages are loaded and attached here
    .(enter)

    ## Record R options and environment variables
    ## Note, we do this _after_ loading and attaching packages, in
    ## case they set options/env vars needed for the session, e.g.
    ## https://github.com/Rdatatable/data.table/issues/5375
    ...future.oldOptions <- base::as.list(base::.Options)
    ...future.oldEnvVars <- base::Sys.getenv()
  })

  tmpl_exit_optenvar <- bquote_compile({
    ## (a) Reset options
    ## WORKAROUND: Do not reset 'nwarnings' unless changed, because
    ## that will, as documented, trigger any warnings collected
    ## internally to be removed.
    ## https://github.com/futureverse/future/issues/645
    if (identical(getOption("nwarnings"), ...future.oldOptions$nwarnings)) {
      ...future.oldOptions$nwarnings <- NULL
    }
    base::options(...future.oldOptions)

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
    ## diff <- base::setdiff(base::names(base::.Options),
    ##                       base::names(...future.oldOptions))
    ## if (base::length(diff) > 0L) {
    ##    opts <- base::vector("list", length = base::length(diff))
    ##    base::names(opts) <- diff
    ##    base::options(opts)
    ## }

    ## (d) Reset environment variables
    if (.Platform$OS.type == "windows") {
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
      envs <- base::Sys.getenv()
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

      if (length(args) > 0) base::do.call(base::Sys.setenv, args = args)

      ## Not needed anymore
      args <- names <- old_names <- NAMES <- envs <- common <- added <- removed <- NULL
    } else {
      base::do.call(base::Sys.setenv, args = base::as.list(...future.oldEnvVars))
    }
    
    ## For the same reason as we don't remove added R options, we don't
    ## remove added environment variables until we know it's safe.
    ## /HB 2022-04-30
    ## (d) Remove any environment variables added
    ## diff <- base::setdiff(base::names(base::Sys.getenv()), base::names(...future.oldEnvVars))
    ## base::Sys.unsetenv(diff)
    
    .(exit)
  })


  tmpl_enter_future_opts <- bquote_compile({
    .(enter)

    ## covr: skip=7
    base::options(
      ## Prevent .future.R from being source():d when future is attached
      future.startup.script      = FALSE,
      
      ## Assert globals when future is created (or at run time)?
      future.globals.onMissing   = .(globals.onMissing),
      
      ## Pass down other future.* options
      future.globals.maxSize         = .(getOption("future.globals.maxSize")),
      future.globals.method          = .(getOption("future.globals.method")),
      future.globals.onMissing       = .(getOption("future.globals.onMissing")),
      future.globals.onReference     = .(getOption("future.globals.onReference")),
      future.globals.resolve         = .(getOption("future.globals.resolve")),
      future.resolve.recursive       = .(getOption("future.resolve.recursive")),
      future.rng.onMisuse            = .(getOption("future.rng.onMisuse")),
      future.rng.onMisuse.keepFuture = .(getOption("future.rng.onMisuse.keepFuture")),
      future.stdout.windows.reencode = .(getOption("future.stdout.windows.reencode")),

      ## Other options relevant to making futures behave consistently
      ## across backends
      width = .(getOption("width"))      
    )

    ## Record above future options
    ...future.futureOptionsAdded <- base::setdiff(base::names(base::.Options), base::names(...future.oldOptions))
  })


  tmpl_exit_future_opts <- bquote_compile({
    ## Remove any "future" options added
    if (base::length(...future.futureOptionsAdded) > 0L) {
      opts <- base::vector("list", length = base::length(...future.futureOptionsAdded))
      base::names(opts) <- ...future.futureOptionsAdded
      base::options(opts)
    }
    
    .(exit)
  })


  tmpl_enter_workdir <- bquote_compile({
    .(enter)
    ...future.workdir <- getwd()
  })

  tmpl_exit_workdir <- bquote_compile({
    if (!identical(...future.workdir, getwd())) setwd(...future.workdir)
    .(exit)
  })


  tmpl_expr_evaluate <- bquote_compile({
    ## covr: skip=6
    .(enter)

    ## Capture standard output?
    if (.(is.na(stdout))) {  ## stdout = NA
      ## Don't capture, but also don't block any output
    } else {
      if (.(stdout)) {  ## stdout = TRUE
        ## Capture all output
        ## NOTE: Capturing to a raw connection is much more efficient
        ## than to a character connection, cf.
        ## https://www.jottr.org/2014/05/26/captureoutput/
        ...future.stdout <- base::rawConnection(base::raw(0L), open = "w")
      } else {  ## stdout = FALSE
        ## Silence all output by sending it to the void
        ...future.stdout <- base::file(
          base::switch(.Platform$OS.type, windows = "NUL", "/dev/null"),
          open = "w"
        )
      }
      base::sink(...future.stdout, type = "output", split = .(split))
      base::on.exit(if (!base::is.null(...future.stdout)) {
        base::sink(type = "output", split = .(split))
        base::close(...future.stdout)
      }, add = TRUE)
    }

    ...future.frame <- base::sys.nframe()
    ...future.conditions <- base::list()
    ...future.rng <- base::globalenv()$.Random.seed

    if (.(globalenv)) {
      ## Record names of variables in the global environment
      ...future.globalenv.names <- c(base::names(base::.GlobalEnv), "...future.value", "...future.globalenv.names", ".Random.seed")
    }

    ## NOTE: We don't want to use local(body) w/ on.exit() because
    ## evaluation in a local is optional, cf. argument 'local'.
    ## If this was mandatory, we could.  Instead we use
    ## a tryCatch() statement. /HB 2016-03-14
    ...future.result <- base::tryCatch({
      base::withCallingHandlers({
        ...future.value <- base::withVisible(.(expr))
        future::FutureResult(
          value = ...future.value$value,
          visible = ...future.value$visible,
          rng = !identical(base::globalenv()$.Random.seed, ...future.rng),
          globalenv = if (.(globalenv)) list(added = base::setdiff(base::names(base::.GlobalEnv), ...future.globalenv.names)) else NULL,
          started = ...future.startTime,
          version = "1.8"
        )
      }, condition = base::local({
        ## WORKAROUND: If the name of any of the below objects/functions
        ## coincides with a promise (e.g. a future assignment) then we
        ## we will end up with a recursive evaluation resulting in error:
        ##   "promise already under evaluation: recursive default argument
        ##    reference or earlier problems?"
        ## To avoid this, we make sure to import the functions explicitly
        ## /HB 2018-12-22
        c <- base::c
        inherits <- base::inherits
        invokeRestart <- base::invokeRestart
        length <- base::length
        list <- base::list
        seq.int <- base::seq.int
        signalCondition <- base::signalCondition
        sys.calls <- base::sys.calls
        `[[` <- base::`[[`
        `+` <- base::`+`
        `<<-` <- base::`<<-`
          
        sysCalls <- function(calls = sys.calls(), from = 1L) {
          calls[seq.int(from = from + .(skip[1L]), to = length(calls) - .(skip[2L]))]
        }
        
        function(cond) {
          is_error <- inherits(cond, "error")
            
          ## Ignore condition?
          ignore <- !is_error &&
                    !is.null(.(conditionClassesExclude)) && 
                    inherits(cond, .(conditionClassesExclude))
          
          ## Handle error:s specially
          if (is_error) {
            sessionInformation <- function() {
              list(
                r          = base::R.Version(),
                locale     = base::Sys.getlocale(),
                rngkind    = base::RNGkind(),
                namespaces = base::loadedNamespaces(),
                search     = base::search(),
                system     = base::Sys.info()
              )
            }
           ## Record condition
            ...future.conditions[[length(...future.conditions) + 1L]] <<- list(
              condition = cond,
              calls     = c(sysCalls(from = ...future.frame), cond$call),
              session   = sessionInformation(),
              timestamp = base::Sys.time(),
              signaled  = 0L
            )
        
            signalCondition(cond)
          } else if (!ignore &&
                     .(!is.null(conditionClasses)) &&
                     inherits(cond, .(conditionClasses))
                    ) {
            ## Relay 'immediateCondition' conditions immediately?
            ## If so, then do not muffle it and flag it as signalled
            ## already here.
            signal <- .(immediateConditions) && inherits(cond, .(immediateConditionClasses))
            ## Record condition
            ...future.conditions[[length(...future.conditions) + 1L]] <<- list(
              condition = cond,
              signaled = base::as.integer(signal)
            )
            if (.(immediateConditions && !split) && !signal) {
              ## muffleCondition <- future:::muffleCondition()
              muffleCondition <- .(muffleCondition)
              muffleCondition(cond, pattern = .(muffleInclude))
            }
          } else {
            if (.(!split && !is.null(conditionClasses))) {
              ## Muffle all non-captured conditions
              ## muffleCondition <- future:::muffleCondition()
              muffleCondition <- .(muffleCondition)
              muffleCondition(cond, pattern = .(muffleInclude))
            }
          }
        } ## function(cond)
      })) ## local() + withCallingHandlers()
    }, error = function(ex) {
      base::structure(base::list(
        value = NULL,
        visible = NULL,
        conditions = ...future.conditions,
        rng = !identical(base::globalenv()$.Random.seed, ...future.rng),
        started = ...future.startTime,
        finished = Sys.time(),
        session_uuid = NA_character_,
        version = "1.8"
      ), class = "FutureResult")
    }, finally = .(exit))
    
    if (.(!base::is.na(stdout))) {
      base::sink(type = "output", split = .(split))
      if (.(stdout)) {
        ...future.result$stdout <- base::rawToChar(
          base::rawConnectionValue(...future.stdout)
        )
      } else {
        ...future.result["stdout"] <- base::list(NULL)
      }
      base::close(...future.stdout)
      ...future.stdout <- NULL
    }

    ...future.result$conditions <- ...future.conditions
    ...future.result$finished <- base::Sys.time()
    
    ...future.result
  })


  function(expr, local = TRUE, immediateConditions = FALSE, stdout = TRUE, conditionClasses = NULL, split = FALSE, globals.onMissing = getOption("future.globals.onMissing", NULL), globalenv = (getOption("future.globalenv.onMisuse", "ignore") != "ignore"), enter = NULL, exit = NULL, version = "1.8") {
    conditionClassesExclude <- attr(conditionClasses, "exclude", exact = TRUE)
    muffleInclude <- attr(conditionClasses, "muffleInclude", exact = TRUE)
    if (is.null(muffleInclude)) muffleInclude <- "^muffle"
    
    if (immediateConditions && !is.null(conditionClasses)) {
      immediateConditionClasses <- getOption("future.relay.immediate", "immediateCondition")
      conditionClasses <- unique(c(conditionClasses, immediateConditionClasses))
    } else {
      immediateConditionClasses <- character(0L)
    }
    
    if (is.null(skip)) {
      ## WORKAROUND: skip = c(7/12, 3) makes assumption about withCallingHandlers()
      ## and local().  In case this changes, provide internal options to adjust this.
      ## /HB 2018-12-28
      skip <<- getOption("future.makeExpression.skip", c(6L, 3L))
      skip.local <<- getOption("future.makeExpression.skip.local", c(12L, 3L))
    }
    
    ## Evaluate expression in a local() environment?
    if (local) {
      expr <- bquote_apply(tmpl_expr_local)
      skip <- skip.local
    }
  
    ## Set and reset certain properties and states
    enter <- bquote_apply(tmpl_enter_workdir)
    enter <- bquote_apply(tmpl_enter_optenvar)
    enter <- bquote_apply(tmpl_enter_future_opts)

    exit <- bquote_apply(tmpl_exit_future_opts)
    exit <- bquote_apply(tmpl_exit_optenvar)
    exit <- bquote_apply(tmpl_exit_workdir)
  
    if (version == "1.8") {    
      expr <- bquote_apply(tmpl_expr_evaluate)
    } else {
      stop(FutureError("Internal error: Non-supported future expression version: ", version))
    }
  
    expr
  }
}) ## makeExpression()
