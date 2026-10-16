#' @tags globals
#' @tags where
#' @tags sequential multisession multicore

library(future)
oopts <- c(oopts, options(future.debug = FALSE))

message("*** Globals - sanitizing attribute 'where' (futureverse/future-ideas#1120) ...")

FutureGlobals <- future:::FutureGlobals

## Emulate a future_mapply() call with a 'FUN' with a large enclosing
## environment. This test makes sure that enclosing environment is not
## exported to parallel workers.

# A large environment that should never be exported
large_env <- new.env()
large_env$unrelated_large_object <- rep(0, 1e6)  ## ~8 MB

fcn <- function() 42
environment(fcn) <- globalenv()

make_globals <- function() {
  structure(
    list(keep_globalenv = fcn, keep_emptyenv = 1, drop_me = 2),
    where = list(
      keep_globalenv = globalenv(),
      keep_emptyenv  = emptyenv(),
      drop_me        = large_env
    )
  )
}

message("- getGlobalsAndPackages() cleans up 'where' (keepWhere = TRUE) ...")
oopts2 <- options(future.globals.keepWhere = TRUE)
globals <- FutureGlobals(make_globals(), resolved = TRUE)
gp <- getGlobalsAndPackages(expression(), globals = globals)
where <- attr(gp$globals, "where")
str(where)
stopifnot(
  identical(where[["keep_globalenv"]], globalenv()),
  identical(where[["keep_emptyenv"]], emptyenv()),
  !identical(where[["drop_me"]], large_env),   ## <= the test
  !identical(where[["drop_me"]], globalenv()),
  !identical(where[["drop_me"]], emptyenv()),
  identical(environmentName(where[["drop_me"]]), "")
)
options(oopts2)
