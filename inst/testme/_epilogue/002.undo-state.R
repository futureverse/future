testme <- as.environment("testme")

## Undo options
## (a) Reset
options(oopts0)

## (b) Remove added
local({
  added <- setdiff(names(options()), names(oopts0))
  opts <- vector("list", length = length(added))
  names(opts) <- added
  options(opts)
})

## (c) Assert that everything was undone
if (!identical(options(), oopts0)) {
  message("Failed to undo options:")
  oopts <- options()
  message(sprintf(" - Expected options: [n=%d] %s",
                  length(oopts0), hpaste(sQuote(names(oopts0)))))
  extra <- setdiff(names(oopts), names(oopts0))
  message(paste(sprintf(" - Options still there: [n=%d]", length(extra)),
                hpaste(sQuote(extra))))
  missing <- setdiff(names(oopts0), names(oopts))
  message(paste(sprintf(" - Options missing: [n=%d]", length(missing)),
                hpaste(sQuote(missing))))
  message("Differences option by option:")                
  for (name in names(oopts0)) {
    value0 <- oopts0[[name]]
    value  <- oopts[[name]]
    if (!identical(value, value0)) {
      if (testme[["debug"]]) {
        utils::str(list(name = name, expected = value0, actual = value))
      }
    }
  }
}


## Undo system environment variables
## (a) Reset
do.call(Sys.setenv, args=as.list(oenvs0))
## (b) Removed added
added <- setdiff(names(Sys.getenv()), names(oenvs0))
Sys.unsetenv(added)
## (c) Assert that everything was undone
if (!identical(Sys.getenv(), oenvs0)) {
  message("Failed to undo environment variables:")
  oenvs <- Sys.getenv()
  message(sprintf(" - Expected environment variables: [n=%d] %s",
                  length(oenvs0), hpaste(sQuote(names(oenvs0)))))
  extra <- setdiff(names(oenvs), names(oenvs0))
  message(paste(sprintf(" - Environment variables still there: [n=%d]", length(extra)),
                hpaste(sQuote(extra))))
  missing <- setdiff(names(oenvs0), names(oenvs))
  message(paste(sprintf(" - Environment variables missing: [n=%d]", length(missing)),
                hpaste(sQuote(missing))))
  message("Differences environment variable by environment variable:")
  for (name in names(oenvs0)) {
    value0 <- unname(oenvs0[name])
    value  <- unname(oenvs[name])
    if (!identical(value, value0)) {
      if (testme[["debug"]]) {
        utils::str(list(name = name, expected = value0, actual = value))
      }
    }
  }
}


## Assert undo was successful
if (testme[["debug"]]) {
  stopifnot(identical(options(), oopts0))
}

## Undo variables
rm(list = c(setdiff(ls(envir = globalenv()), ovars)), envir = globalenv())
