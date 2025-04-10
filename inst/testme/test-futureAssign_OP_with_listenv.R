#' @tags futureAssign
#' @tags listenv
#' @tags sequential multisession multicore

library(future)
library(listenv)

message("*** %<-% to listenv ...")

## - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## Future assignment via infix operator
## - - - - - - - - - - - - - - - - - - - - - - - - - - - -
z <- listenv()
stopifnot(length(names(z)) == 0)

message("*** %<-% to listenv: Assign by index")
z[[1]] %<-% { 2 } %lazy% TRUE
stopifnot(length(z) == 1)
stopifnot(length(names(z)) == 0)

z[[1]] %<-% { 2 } %lazy% TRUE
stopifnot(length(z) == 1)
stopifnot(length(names(z)) == 0)

z[[4]] %<-% { "async!" } %lazy% TRUE
stopifnot(length(z) == 4)
stopifnot(length(names(z)) == 0)

message("*** %<-% to listenv: Update names")
names(z) <- c("A", "B", "C", "D")
stopifnot(identical(names(z), c("A", "B", "C", "D")))


message("*** %<-% to listenv: Assign by name (existing)")
z$B %<-% { TRUE } %lazy% TRUE
stopifnot(length(z) == 4)
stopifnot(identical(names(z), c("A", "B", "C", "D")))

y <- as.list(z)
str(y)
stopifnot(length(y) == 4)
stopifnot(identical(names(y), c("A", "B", "C", "D")))


message("*** %<-% to listenv: Asserting no name clashes among futures")
u <- listenv()
u$a %<-% { 1 } %lazy% TRUE
stopifnot(identical(names(u), "a"))
fu <- futureOf(u$a)

v <- listenv()
v$a %<-% { 2 } %lazy% TRUE
stopifnot(identical(names(v), "a"))
fv <- futureOf(v$a)
stopifnot(!identical(fu, fv))

fu <- futureOf(u$a)
stopifnot(!identical(fu, fv))

stopifnot(identical(u$a, 1))
stopifnot(identical(v$a, 2))


message("*** %<-% to listenv: multiple dimensions ...")

x0 <- list()
length(x0) <- 6
dim(x0) <- c(3, 2)

x <- listenv()
length(x) <- 6
dim(x) <- c(3, 2)

for (cc in 1:ncol(x)) {
  for (rr in 1:nrow(x)) {
    x0[[rr, cc]] <- sprintf("(%s, %s)", rr, cc)
    x[[rr, cc]] %<-% sprintf("(%s, %s)", rr, cc) %lazy% TRUE
  }
}

y <- as.list(x)
dim(y) <- dim(x)
stopifnot(identical(y, x0))

message("*** %<-% to listenv: multiple dimensions ... DONE")

message("*** %<-% to listenv ... DONE")

