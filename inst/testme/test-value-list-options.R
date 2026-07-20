#' @tags value futures sequential listenv

library(future)
library(listenv)

plan(sequential)

mkfutures <- function(n = 4L) {
  fs <- lapply(seq_len(n), FUN = function(i) future(i))
  names(fs) <- letters[seq_len(n)]
  fs
}

message("*** value() - 'reduce' validation ...")

## A 'reduce' function given as the name of a base primitive
stopifnot(identical(value(mkfutures(), reduce = "+"), 10L))

## ... also with an 'init' value
stopifnot(identical(value(mkfutures(), reduce = structure("+", init = 100L)),
                    110L))

## A name that is not a base function
res <- tryCatch(value(mkfutures(), reduce = "no_such_function_here"),
                error = identity)
print(res)
stopifnot(inherits(res, "error"),
          grepl("no such 'reduce' function", conditionMessage(res)))

## A base function that is not primitive
res <- tryCatch(value(mkfutures(), reduce = "paste0"), error = identity)
print(res)
stopifnot(inherits(res, "error"),
          grepl("not a primitive function", conditionMessage(res)))

## A custom reduce function
stopifnot(identical(value(mkfutures(), reduce = function(a, b) a + b), 10L))

## ... with an 'init' value
res <- value(mkfutures(), reduce = structure(function(a, b) a + b, init = 100L))
stopifnot(identical(res, 110L))

## A reduce function must take at least one argument
res <- tryCatch(value(mkfutures(), reduce = function() NULL), error = identity)
print(res)
stopifnot(inherits(res, "error"),
          grepl("at least one argument", conditionMessage(res)))

message("*** value() - 'reduce' validation ... DONE")


message("*** value() - 'reduce' with 'inorder' ...")

## Reducing in order and out of order gives the same sum
stopifnot(identical(value(mkfutures(), reduce = "+", inorder = TRUE), 10L))
stopifnot(identical(value(mkfutures(), reduce = "+", inorder = FALSE), 10L))

## Reducing an empty set returns the initial value
stopifnot(identical(value(list(), reduce = structure("+", init = 0L)), 0L))

## ... and without a reduce function it returns an empty list
stopifnot(length(value(list())) == 0L)

message("*** value() - 'reduce' with 'inorder' ... DONE")


message("*** value() - 'idxs' subsetting ...")

## Numeric indices
stopifnot(identical(unname(unlist(value(mkfutures(), idxs = c(1L, 3L)))),
                    c(1L, 3L)))

## Named indices
stopifnot(identical(unname(unlist(value(mkfutures(), idxs = c("a", "c")))),
                    c(1L, 3L)))

## Indices out of range
res <- tryCatch(value(mkfutures(), idxs = 99L), error = identity)
print(res)
stopifnot(inherits(res, "error"),
          grepl("out of range", conditionMessage(res)))

## Named subsetting of an unnamed list
fs <- list(future(1L), future(2L))
res <- tryCatch(value(fs, idxs = "a"), error = identity)
print(res)
stopifnot(inherits(res, "error"))

## An empty set of indices selects nothing
stopifnot(length(value(mkfutures(), idxs = integer(0))) == 0L)

## The same subsetting works for 'listenv' objects
mklistenv <- function() {
  x <- listenv()
  x$a <- future(10L)
  x$b <- future(20L)
  x$c <- future(30L)
  x
}

stopifnot(identical(unname(unlist(value(mklistenv(), idxs = c(1L, 3L)))),
                    c(10L, 30L)))
stopifnot(identical(unname(unlist(value(mklistenv(), idxs = c("a", "c")))),
                    c(10L, 30L)))

## ... including the boundary cases
stopifnot(length(value(mklistenv(), idxs = integer(0))) == 0L)

res <- tryCatch(value(mklistenv(), idxs = 99L), error = identity)
print(res)
stopifnot(inherits(res, "error"), grepl("out of range", conditionMessage(res)))

## Without 'idxs' a listenv works too
stopifnot(identical(unname(unlist(value(mklistenv()))), c(10L, 20L, 30L)))

message("*** value() - 'idxs' subsetting ... DONE")


message("*** value() - argument validation ...")

## 'interrupt' must not be TRUE when 'cancel' is FALSE
res <- tryCatch(value(mkfutures(), cancel = FALSE, interrupt = TRUE),
                error = identity)
print(res)
stopifnot(inherits(res, "error"),
          grepl("must not be TRUE", conditionMessage(res)))

## 'cancel = FALSE' on its own is fine
stopifnot(length(value(mkfutures(), cancel = FALSE)) == 4L)

message("*** value() - argument validation ... DONE")


message("*** value() - 'recursive' ...")

## 'recursive' may be given as a logical or a number
stopifnot(length(value(mkfutures(), recursive = FALSE)) == 4L)
stopifnot(length(value(mkfutures(), recursive = TRUE)) == 4L)
stopifnot(length(value(mkfutures(), recursive = 0)) == 4L)

message("*** value() - 'recursive' ... DONE")


message("*** value() - with debug output ...")

local({
  oopts <- options(future.debug = TRUE)
  on.exit(options(oopts))
  stopifnot(length(value(mkfutures())) == 4L)
  stopifnot(identical(value(mkfutures(), reduce = "+"), 10L))
  stopifnot(identical(value(mkfutures(), reduce = "+", inorder = FALSE), 10L))
})

message("*** value() - with debug output ... DONE")

plan(sequential)
