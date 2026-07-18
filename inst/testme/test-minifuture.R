#' @tags minifuture sequential

library(future)

message("*** minifuture() ...")

plan(sequential)

## A minimal future behaves like a regular one for self-contained expressions
f <- minifuture(42L)
stopifnot(inherits(f, "Future"))
stopifnot(identical(value(f), 42L))

## Globals are not identified automatically, so they must be given explicitly
a <- 3L
f <- minifuture(2L * a, globals = "a")
stopifnot(identical(value(f), 6L))

## Also works with a list of globals
f <- minifuture(2L * b, globals = list(b = 4L))
stopifnot(identical(value(f), 8L))

## An already substituted expression can be passed as is
expr <- quote(6L * 7L)
f <- minifuture(expr, substitute = FALSE)
stopifnot(identical(value(f), 42L))

## Errors are propagated as for regular futures
f <- minifuture(stop("Oops!"))
res <- tryCatch(value(f), error = identity)
print(res)
stopifnot(inherits(res, "error"))

message("*** minifuture() ... DONE")
