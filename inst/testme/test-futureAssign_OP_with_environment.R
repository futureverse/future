#' @tags futureAssign
#' @tags environment
#' @tags sequential multisession multicore

library(future)

## BACKWARD COMPATIBILITY
if (getRversion() < "3.2.0") {
  names <- function(x) if (is.environment(x)) ls(envir = x) else base::names(x)
}

message("*** %<-% to environment ...")

## - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## Async delayed assignment (infix operator)
## - - - - - - - - - - - - - - - - - - - - - - - - - - - -
z <- new.env()
stopifnot(length(names(z)) == 0L)

message("*** %<-% to environment: Assign by index (not allowed)")
res <- try(z[[1]] %<-% { 2 } %lazy% TRUE, silent = TRUE)
stopifnot(inherits(res, "try-error"))

message("*** %<-% to environment: Assign by name (new)")
z$B %<-% { TRUE }  %lazy% TRUE
stopifnot(length(z) == 2) # sic!
stopifnot("B" %in% ls(z))

y <- as.list(z)
str(y)
stopifnot(length(y) == 1)
stopifnot(identical(names(y), "B"))


message("*** %<-% to environment: Potential task name clashes")
u <- new.env()
u$a %<-% { 1 } %lazy% TRUE
stopifnot(length(u) == 2)
stopifnot("a" %in% names(u))
fu <- futureOf(u$a)

v <- new.env()
v$a %<-% { 2 } %lazy% TRUE
stopifnot(length(v) == 2)
stopifnot("a" %in% names(v))
fv <- futureOf(v$a)
stopifnot(!identical(fu, fv))

fu <- futureOf(u$a)
stopifnot(!identical(fu, fv))

stopifnot(identical(u$a, 1))
stopifnot(identical(v$a, 2))

message("*** %<-% to environment ... DONE")

