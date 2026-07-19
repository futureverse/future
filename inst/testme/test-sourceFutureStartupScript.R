#' @tags utils-internal startup
#' @tags detritus-files

library(future)

sourceFutureStartupScript <- future:::sourceFutureStartupScript

## A private folder, so that we do not pick up a real ~/.future.R
path <- file.path(tempdir(), "test-sourceFutureStartupScript")
dir.create(path, recursive = TRUE, showWarnings = FALSE)

reset <- function() {
  Sys.unsetenv("R_FUTURE_STARTUP_SCRIPT")
  options(future.startup.script = NULL)
}
reset()

message("*** sourceFutureStartupScript() - disabled ...")

## Disabled via the R option
options(future.startup.script = FALSE)
stopifnot(identical(sourceFutureStartupScript(), character(0L)))
reset()

## Disabled via the environment variable
Sys.setenv(R_FUTURE_STARTUP_SCRIPT = "FALSE")
stopifnot(identical(sourceFutureStartupScript(), character(0L)))
## ... also lower case, because the value is upper-cased
Sys.setenv(R_FUTURE_STARTUP_SCRIPT = "false")
stopifnot(identical(sourceFutureStartupScript(), character(0L)))
reset()

## An empty set of scripts is a no-op
options(future.startup.script = character(0L))
stopifnot(identical(sourceFutureStartupScript(), character(0L)))
reset()

## A non-existing script is a no-op
options(future.startup.script = file.path(path, "does-not-exist.R"))
stopifnot(identical(sourceFutureStartupScript(), character(0L)))
reset()

## Neither TRUE nor FALSE must be a single, non-missing value
options(future.startup.script = NA)
res <- tryCatch(sourceFutureStartupScript(), error = identity)
print(res)
stopifnot(inherits(res, "error"))
reset()

message("*** sourceFutureStartupScript() - disabled ... DONE")


message("*** sourceFutureStartupScript() - sourcing ...")

## A script that is sourced
script <- file.path(path, "startup-ok.R")
cat("startup_script_was_sourced <- TRUE\n", file = script)
options(future.startup.script = script)
res <- sourceFutureStartupScript()
print(res)
stopifnot(identical(res, script))
stopifnot(isTRUE(get("startup_script_was_sourced", envir = globalenv())))
rm("startup_script_was_sourced", envir = globalenv())
reset()

## Only the first existing script is sourced
script2 <- file.path(path, "startup-second.R")
cat("startup_script_2 <- TRUE\n", file = script2)
options(future.startup.script = c(script, script2))
res <- sourceFutureStartupScript()
print(res)
stopifnot(identical(res, script))
stopifnot(!exists("startup_script_2", envir = globalenv()))
rm("startup_script_was_sourced", envir = globalenv())
reset()

## The environment variable may list several scripts. On MS Windows they are
## separated by ';' only, because ':' is part of the drive letter of an
## absolute pathname
Sys.setenv(R_FUTURE_STARTUP_SCRIPT =
             paste(file.path(path, "nope.R"), script,
                   sep = .Platform$path.sep))
res <- sourceFutureStartupScript()
print(res)
stopifnot(identical(res, script))
rm("startup_script_was_sourced", envir = globalenv())
reset()

## A single, absolute pathname works too, which on MS Windows means the
## drive letter must not be mistaken for a separator
Sys.setenv(R_FUTURE_STARTUP_SCRIPT = script)
res <- sourceFutureStartupScript()
print(res)
stopifnot(identical(res, script))
rm("startup_script_was_sourced", envir = globalenv())
reset()

## On non-Windows platforms, ';' also works as a separator
if (.Platform$OS.type != "windows") {
  Sys.setenv(R_FUTURE_STARTUP_SCRIPT =
               paste(file.path(path, "nope.R"), script, sep = ";"))
  res <- sourceFutureStartupScript()
  print(res)
  stopifnot(identical(res, script))
  rm("startup_script_was_sourced", envir = globalenv())
  reset()
}

## 'TRUE' in the environment variable means "use the defaults"
Sys.setenv(R_FUTURE_STARTUP_SCRIPT = "TRUE")
res <- sourceFutureStartupScript(default = script)
print(res)
stopifnot(identical(res, script))
rm("startup_script_was_sourced", envir = globalenv())
reset()

## An error while sourcing is caught and turned into a warning
bad <- file.path(path, "startup-bad.R")
cat("stop('startup failure')\n", file = bad)
options(future.startup.script = bad)
res <- withCallingHandlers({
  tryCatch(sourceFutureStartupScript(), warning = identity)
}, warning = function(w) invokeRestart("muffleWarning"))
print(res)
stopifnot(inherits(res, "warning"),
          grepl("Failed to source", conditionMessage(res)))
reset()

message("*** sourceFutureStartupScript() - sourcing ... DONE")


message("*** sourceFutureStartupScript() - debug output ...")

options(future.startup.script = script)
Sys.setenv(R_FUTURE_STARTUP_SCRIPT = script)
res <- sourceFutureStartupScript(debug = TRUE)
print(res)
stopifnot(identical(res, script))
rm("startup_script_was_sourced", envir = globalenv())
reset()

## Debug output also on the disabled and not-found paths
options(future.startup.script = FALSE)
stopifnot(identical(sourceFutureStartupScript(debug = TRUE), character(0L)))
options(future.startup.script = character(0L))
stopifnot(identical(sourceFutureStartupScript(debug = TRUE), character(0L)))
options(future.startup.script = file.path(path, "does-not-exist.R"))
stopifnot(identical(sourceFutureStartupScript(debug = TRUE), character(0L)))
reset()

message("*** sourceFutureStartupScript() - debug output ... DONE")

## Clean up
file.remove(dir(path, pattern = "[.]R$", full.names = TRUE))
