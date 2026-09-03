#' @tags workdir
#' @tags sequential multisession multicore

library(future)
message("*** Futures - working directory ...")

strategies <- supportedStrategies()

owd <- getwd()

for (strategy in strategies) {
  message(sprintf("- plan('%s') ...", strategy))
  plan(strategy)

  ## The working directory should be reset, if the future changed it
  wd <- getwd()
  other <- tempfile("future-workdir")
  dir.create(other)
  f <- future({
    setwd(other)
    getwd()
  })
  v <- value(f)
  stopifnot(
    !identical(normalizePath(v), normalizePath(wd)),
    identical(getwd(), wd),
    identical(value(future(getwd())), wd)
  )
  unlink(other, recursive = TRUE)

  message(sprintf("- plan('%s') ... done", strategy))
}

plan(sequential)


message("*** Futures - working directory that cannot be entered ...")

## A future must resolve also when the current working directory cannot be
## entered, e.g. when it is on a file system that does not allow it. This
## used to produce a "cannot change working directory" error [#814]
## Note, we cannot test against 'multisession' here, because R CMD check
## will fail if the current directory is not writable.
plan(sequential)

wd <- tempfile("future-workdir")
dir.create(wd)
setwd(wd)
Sys.chmod(wd, mode = "000")

## Only test, iff the folder can no longer be entered
usable <- !inherits(tryCatch(setwd(wd), error = identity), "error")
if (!usable) v <- tryCatch(value(future(42L)), error = identity)

Sys.chmod(wd, mode = "700")
setwd(owd)
unlink(wd, recursive = TRUE)

if (usable) {
  message("- Skipping; the working directory can still be entered")
} else {
  stopifnot(identical(v, 42L))
}


message("*** Futures - working directory that no longer exists ...")

## A future must resolve also when the current working directory has been
## removed. Then getwd() returns NULL, which used to produce a "character
## argument expected" error from setwd(NULL) [#814]
plan(sequential)

wd <- tempfile("future-workdir")
dir.create(wd)
setwd(wd)
unlink(wd, recursive = TRUE)

## Only test, iff the folder could indeed be removed while being the current
## working directory, which is not the case on, say, MS Windows
gone <- is.null(getwd())
if (gone) v <- tryCatch(value(future(42L)), error = identity)

setwd(owd)
unlink(wd, recursive = TRUE)

if (gone) {
  stopifnot(identical(v, 42L))
} else {
  message("- Skipping; the working directory still exists")
}

setwd(owd)

message("*** Futures - working directory ... DONE")
