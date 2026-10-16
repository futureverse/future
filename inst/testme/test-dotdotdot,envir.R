#' @tags dotdotdot
#' @tags sequential cluster multisession multicore

library(future)

message("*** Global '...' and ...future.FUN() in custom environments ...")

## BUG FIX: https://github.com/futureverse/future.apply/issues/130

for (cores in 1:availCores) {
  message(sprintf("Testing with %d cores ...", cores))
  options(mc.cores = cores)

  for (strategy in supportedStrategies(cores)) {
    message(sprintf("- plan('%s') ...", strategy))
    plan(strategy, substitute = FALSE)

    ## Case 1: ...future.FUN() lives in an environment that does not inherit
    ## from the global environment. This used to give "cycles in parent
    ## chains are not allowed" (R >= 4.5.0) or an infinite loop (R < 4.5.0)
    fcn <- function(...) {
      ...future.FUN <- local(function(x) x, envir = new.env(parent = baseenv()))
      f <- future(...future.FUN(42L, ...))
      value(f)
    }
    y <- fcn()
    stopifnot(identical(y, 42L))

    ## Case 2: ...future.FUN() uses '...' as a global variable, which is
    ## then passed as an explicit global (e.g. by future.apply)
    fcn <- function(FUN, ...) {
      ...future.FUN <- FUN
      globals <- globals::globalsByName(c("...future.FUN", "..."), envir = environment())
      f <- future(...future.FUN(42L), globals = globals)
      value(f)
    }

    ## ... and is a closure that does not inherit from the global environment
    makeFUN <- local(function(...) function(x) x + sum(...), envir = new.env(parent = baseenv()))
    FUN <- makeFUN(1L, 2L)
    y <- fcn(FUN, "not-used")
    stopifnot(identical(y, 45L))

    ## Case 3: ...future.FUN() uses '...' as a global variable, and lives
    ## in the global environment, or in an environment that inherits from
    ## the global environment. In the latter case, that environment must
    ## be restored afterward, which did not happen for sequential futures
    FUN <- function(x) x + sum(...)
    environment(FUN) <- globalenv()
    y <- fcn(FUN, 1L, 2L)
    stopifnot(identical(y, 45L))

    env <- new.env(parent = globalenv())
    FUN <- local(function(x) x + sum(...), envir = env)
    y <- fcn(FUN, 1L, 2L)
    stopifnot(identical(y, 45L))
    stopifnot(identical(parent.env(env), globalenv()))

    ## Case 4: ...future.FUN() does not use '...' as a global variable, and
    ## lives in an environment that inherits from the global environment.
    ## That environment must not be modified, which happened for
    ## sequential futures
    fcn <- function(...) {
      ...future.FUN <- local(function(x) x, envir = env)
      f <- future(...future.FUN(42L, ...))
      value(f)
    }
    y <- fcn()
    stopifnot(identical(y, 42L))
    stopifnot(identical(parent.env(env), globalenv()))

    message(sprintf("- plan('%s') ... DONE", strategy))
  } ## for (strategy ...)

  message(sprintf("Testing with %d cores ... DONE", cores))
} ## for (cores ...)

message("*** Global '...' and ...future.FUN() in custom environments ... DONE")
