#' @tags utils-internal tweakable

library(future)

argnames <- future:::argnames
tweakable <- future:::tweakable
untweakable <- future:::untweakable
`tweakable<-` <- future:::`tweakable<-`
`untweakable<-` <- future:::`untweakable<-`

message("*** argnames() ...")

fcn_ab <- function(a, b, ...) NULL
fcn_bc <- function(b, c) NULL

## The '...' argument is excluded by default
stopifnot(identical(argnames(fcn_ab), c("a", "b")))

## Argument names of several functions are merged, without duplicates
stopifnot(identical(argnames(fcn_ab, fcn_bc), c("a", "b", "c")))

## Additional names may be excluded
stopifnot(identical(argnames(fcn_ab, exclude = c("...", "a")), "b"))

## A function without arguments has no argument names
stopifnot(length(argnames(function() NULL)) == 0L)

message("*** argnames() ... DONE")


message("*** tweakable() and untweakable() ...")

## Neither attribute is set by default
stopifnot(is.null(tweakable(fcn_ab)), is.null(untweakable(fcn_ab)))

message("*** tweakable() and untweakable() ... DONE")


message("*** untweakable() <- ...")

fcn <- function(x, y) NULL
untweakable(fcn) <- c("y", "y")
## Duplicates are dropped
stopifnot(identical(untweakable(fcn), "y"))

message("*** untweakable() <- ... DONE")


message("*** tweakable() <- ...")

## The formal arguments become tweakable, except '...'
fcn <- function(x, y, ...) NULL
tweakable(fcn) <- character(0L)
stopifnot(identical(tweakable(fcn), c("x", "y")))

## Arguments listed as untweakable are excluded
fcn <- function(x, y, ...) NULL
untweakable(fcn) <- "y"
tweakable(fcn) <- character(0L)
stopifnot(identical(tweakable(fcn), "x"))

## The tweakable arguments of another function are inherited
donor <- function(p, q) NULL
tweakable(donor) <- character(0L)
stopifnot(identical(tweakable(donor), c("p", "q")))

fcn <- function(x, y) NULL
tweakable(fcn) <- donor
stopifnot(identical(tweakable(fcn), c("x", "y", "p", "q")))

## The untweakable arguments of the other function are dropped
donor2 <- function(p, q) NULL
tweakable(donor2) <- character(0L)
untweakable(donor2) <- "p"
fcn <- function(x, y) NULL
tweakable(fcn) <- donor2
stopifnot(identical(tweakable(fcn), c("x", "y", "q")))

## Assigning a single function is the same as assigning a list of one
fcn2 <- function(x, y) NULL
tweakable(fcn2) <- list(donor)
stopifnot(identical(tweakable(fcn2), tweakable({
  tmp <- function(x, y) NULL
  tweakable(tmp) <- donor
  tmp
})))

## Assigning a character value adds those names as tweakable
fcn <- function(x, y) NULL
tweakable(fcn) <- "z"
stopifnot(identical(tweakable(fcn), c("x", "y", "z")))

## ... also several of them, and already known names are not duplicated
fcn <- function(x, y) NULL
tweakable(fcn) <- c("y", "z", "w")
stopifnot(identical(tweakable(fcn), c("x", "y", "z", "w")))

## Untweakable names are still dropped
fcn <- function(x, y) NULL
untweakable(fcn) <- "y"
tweakable(fcn) <- "z"
stopifnot(identical(tweakable(fcn), c("x", "z")))

## A mix of a function and character names, as used for
## ClusterFutureBackend, adds both
donor2 <- function(a, b) NULL
tweakable(donor2) <- character(0L)
fcn <- function(x, y) NULL
tweakable(fcn) <- list(donor2, c("z", "w"))
stopifnot(all(c("x", "y", "z", "w") %in% tweakable(fcn)))

message("*** tweakable() <- ... DONE")
