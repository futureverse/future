#' Create a future assignment
#'
#' `x %<-% value` (also known as a "future assignment") and
#' `futureAssign("x", value)` create a [Future] that evaluates the expression
#' (`value`) and binds it to variable `x` (as a
#' \link[base:delayedAssign]{promise}). The expression is evaluated in parallel
#' in the background. Later on, when `x` is first queried, the value of future
#' is automatically retrieved as it were a regular variable and `x` is
#' materialized as a regular value.
#'
#' @inheritParams Future-class
#' 
#' @param value An \R \link[base]{expression}.
#'
#' @param \ldots Additional arguments passed to [Future()].
#'
#' @param x the name of a future variable, which will hold the value
#'        of the future expression (as a promise).
#'
#' @param assign.env The \link[base]{environment} to which the variable
#' should be assigned.
#'
#' @return
#' `futureAssign()` and `x %<-% expr` returns the [Future] invisibly,
#' e.g. `f <- futureAssign("x", expr)` and `f <- (x %<-% expr)`.
#'
#'
#' @details
#'
#' For a future created via a future assignment, `x %<-% value` or
#' `futureAssign("x", value)`, the value is bound to a promise, which when
#' queried will internally call [value()]  on the future and which will then
#' be resolved into a regular variable bound to that value. For example, with
#' future assignment `x %<-% value`, the first time variable `x` is queried
#' the call blocks if, and only if, the future is not yet resolved. As soon
#' as it is resolved, and any succeeding queries, querying `x` will
#' immediately give the value.
#'
#' The future assignment construct `x %<-% value` is not a formal assignment
#' per se, but a binary infix operator on objects `x` and expression `value`.
#' However, by using non-standard evaluation, this constructs can emulate an
#' assignment operator similar to `x <- value`. Due to \R's precedence rules
#' of operators, future expressions often need to be explicitly bracketed,
#' e.g. `x %<-% { a + b }`.
#'
#'
#' @section Adjust future arguments of a future assignment:
#'
#' [future()] and [futureAssign()] take several arguments that can be used
#' to explicitly specify what global variables and packages the future should
#' use. They can also be used to override default behaviors of the future,
#' e.g. whether output should be relayed or not. When using a future
#' assignment, these arguments can be specified via corresponding
# '`%<argument name>%` infix operators that are appended after the future
#' assignment expression.  For example, `x %<-% { rnorm(10) } %seed% TRUE`
#' corresponds to `futureAssign("x", { rnorm(10) }, seed = TRUE)`. Here are
#' a several examples.
#'
#' To explicitly specify variables and functions that a future assignment
#' should use, use `%globals%`. To explicitly specify which packages need
#' to be attached for the evaluate to success, use `%packages%`. For
#' example,
#'
#' ```
#' > x <- rnorm(1000)
#' > y %<-% { median(x) } %globals% list(x = x) %packages% "stats"
#' > y
#' [1] -0.03956372
#' ```
#'
#' The `median()` function is part of the 'stats' package.
#'
#' To declare that you will generate random numbers, use `%seed%`, e.g.
#'
#' ```
#' > x %<-% { rnorm(3) } %seed% TRUE
#' > x
#' [1] -0.2590562 -1.2262495  0.8858702
#' ```
#'
#' To disable relaying of standard output (e.g. `print()`, `cat()`, and
#' `str()`), while keeping relaying of conditions (e.g. `message()` and
# `warning()`) enabled (default), use `%stdout%`, e.g.
#'
#' ```
#' > x %<-% { cat("Hello\n"); message("Hi there"); 42 } %stdout% FALSE
#' > y <- 13
#' > z <- x + y
#' Hi there
#' > z
#' [1] 55
#' ```
#'
#' To disable relaying of conditions, use `%conditions%`, e.g.
#'
#' ```
#' > x %<-% { cat("Hello\n"); message("Hi there"); 42 } %conditions% character(0)
#' > y <- 13
#' > z <- x + y
#' Hello
#' > z
#' [1] 55
#' ```
#'
#' ```
#' > x %<-% { print(1:10); message("Hello"); 42 } %stdout% FALSE
#' > y <- 13
#' > z <- x + y
#' Hello
#' > z
#' [1] 55
#' ```
#'
#' To create a future without launching in such that it will only be
#' processed if the value is really needed, use `%lazy%`, e.g.
#'
#' ```
#' > x %<-% { Sys.sleep(5); 42 } %lazy% TRUE
#' > y <- sum(1:10)
#' > system.time(z <- x + y)
#'   user  system elapsed 
#'   0.004   0.000   5.008
#' > z
#' [1] 97
#' ```
#'
#'
#' @section Error handling:
#'
#' Because future assignments are promises, errors produced by the the
#' future expression will not be signaled until the value of the future is
#' requested. For example, if you create a future assignment that produce
#' an error, you will not be affected by the error until you "touch" the
#' future-assignment variable. For example, 
#'
#' ```
#' > x %<-% { stop("boom") }
#' > y <- sum(1:10)
#' > z <- x + y
#' Error in eval(quote({ : boom
#' ```
#'
#'
#' @section Use alternative future backend for future assignment:
#'
#' Futures are evaluated on the future backend that the user has specified
#' by [plan()]. With regular futures, we can temporarily use another future
#' backend by wrapping our code in `with(plan(...), { ... }]`, or temporarily
#' inside a function using `with(plan(...), local = TRUE)`. To achieve the
#' same for a specific future assignment, use `%plan%`, e.g.
#'
#' ```
#' > plan(multisession)
#' > x %<-% { 42 }
#' > y %<-% { 13 } %plan% sequential
#' > z <- x + y
#' > z
#' [1] 55
#' ```
#'
#' Here `x` is resolved in the background via the [multisession] backend,
#' whereas `y` is resolved sequentially in the main R session.
#'
#'
#' @section Getting the future object of a future assignment:
#'
#' The underlying [Future] of a future variable `x` can be retrieved without
#' blocking using \code{f <- \link{futureOf}(x)}, e.g.
#'
#' ```
#' > x %<-% { stop("boom") }
#' > f_x <- futureOf(x)
#' > resolved(f_x)
#' [1] TRUE
#' > x
#' Error in eval(quote({ : boom
#' > value(f_x)
#' Error in eval(quote({ : boom
#' ```
#'
#' Technically, both the future and the variable (promise) are assigned at
#' the same time to environment `assign.env` where the name of the future is
#' `.future_<name>`.
#'
#'
#' @rdname futureAssign
#' @export
futureAssign <- function(x, value, envir = parent.frame(), substitute = TRUE, lazy = FALSE, seed = FALSE, globals = TRUE, packages = NULL, stdout = TRUE, conditions = "condition", earlySignal = FALSE, label = NULL, gc = FALSE, ..., assign.env = envir) {
  stop_if_not(is.character(x), !is.na(x), nzchar(x))
  if (substitute) value <- substitute(value)
  
  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  ## (1) Arguments passed to future()
  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  future.args <- list(value, envir = envir, lazy = lazy, seed = seed, globals = globals, packages = packages, stdout = stdout, conditions = conditions, earlySignal = earlySignal, label = label, gc = gc, ...)
  ## Any arguments set via disposible option?
  args <- getOption("future.disposable")
  if (!is.null(args)) {
    for (name in names(args)) future.args[name] <- args[name]
    on.exit(options(future.disposable = NULL))
  }


  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  ## (2) Create future
  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  ## Name of "future" saved in parallel with the "promise"
  future_name <- sprintf(".future_%s", x)
  if (exists(future_name, envir = assign.env)) {
    msg <- sprintf("A future with name %s already exists in environment %s: %s", sQuote(future_name), sQuote(environmentName(assign.env)), hpaste(ls(envir = assign.env, all.names = TRUE)))
##    warning(msg)
  }

  ## Evaluate expression/value as a "future" and assign its value to
  ## a variable as a "promise".
  ## NOTE: We make sure to pass 'envir' in order for globals to
  ## be located properly.
  future <- do.call(future::future, args = future.args, envir = envir)

  ## Assign future to assignment environment
  future_without_gc <- future
  future_without_gc[[".gcenv"]] <- NULL
  assign(future_name, future_without_gc, envir = assign.env)


  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  ## (3) Create promise holding the future's value
  ## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  ## Here value may throw an error causing the assign value to be a
  ## "delayed" error, which will be thrown each time the variable is
  ## retrieved.
  env <- new.env()
  env[["job"]] <- future
  delayedAssign(x, local({
    value <- value(future)
    ## Remove internal future variable
    rm(list = future_name, envir = assign.env)
    value
  }), eval.env = env, assign.env = assign.env)

  invisible(future)
}
