#' @tags UniprocessFuture sequential

library(future)

message("*** UniprocessFuture ...")

message("*** UniprocessFuture() ...")

## 'substitute = FALSE' takes the expression as-is
f <- UniprocessFuture(expr = quote(6 * 7), substitute = FALSE,
                      globals = list())
print(class(f))
stopifnot(inherits(f, "UniprocessFuture"), inherits(f, "Future"))
stopifnot(identical(f[["state"]], "created"))

## 'substitute = TRUE' (the default) quotes the expression
g <- UniprocessFuture(6 * 7, globals = list())
stopifnot(inherits(g, "UniprocessFuture"))
stopifnot(identical(g[["expr"]], f[["expr"]]))

message("*** UniprocessFuture() ... DONE")


message("*** run() ...")

f <- UniprocessFuture(expr = quote(6 * 7), substitute = FALSE,
                      globals = list())
f <- run(f)
stopifnot(identical(f[["state"]], "finished"))
stopifnot(identical(value(f), 42))

## A future can only be launched once
res <- tryCatch(run(f), error = identity)
print(res)
stopifnot(inherits(res, "FutureError"),
          grepl("can only be launched once", conditionMessage(res)))

## Same with future.debug enabled
oopts <- options(future.debug = TRUE)
f <- UniprocessFuture(expr = quote(1 + 1), substitute = FALSE,
                      globals = list())
f <- run(f)
stopifnot(identical(value(f), 2))
options(oopts)

message("*** run() ... DONE")


message("*** result() ...")

## result() on a not-yet-launched future runs it
f <- UniprocessFuture(expr = quote(6 * 7), substitute = FALSE,
                      globals = list())
stopifnot(identical(f[["state"]], "created"))
r <- result(f)
print(class(r))
stopifnot(inherits(r, "FutureResult"))
stopifnot(identical(f[["state"]], "finished"))

## A second call returns the already collected result
r2 <- result(f)
stopifnot(identical(r2, r))

## The 'earlySignal' setting is restored after result() launched the future
f <- UniprocessFuture(expr = quote(1 + 1), substitute = FALSE,
                      globals = list(), earlySignal = TRUE)
stopifnot(isTRUE(f[["earlySignal"]]))
r <- result(f)
stopifnot(inherits(r, "FutureResult"), isTRUE(f[["earlySignal"]]))

## A stored FutureError is re-thrown
f <- UniprocessFuture(expr = quote(1 + 1), substitute = FALSE,
                      globals = list())
f[["result"]] <- FutureError("a stored error")
res <- tryCatch(result(f), error = identity)
print(res)
stopifnot(inherits(res, "FutureError"),
          grepl("a stored error", conditionMessage(res)))

## A result that is neither NULL nor a FutureResult is unexpected
f <- UniprocessFuture(expr = quote(1 + 1), substitute = FALSE,
                      globals = list())
f <- run(f)
f[["result"]] <- NULL
f[["state"]] <- "finished"
res <- tryCatch(result(f), error = identity)
print(res)
stopifnot(inherits(res, "FutureError"))
## The unexpected-result error is remembered
stopifnot(inherits(f[["result"]], "FutureError"))

message("*** result() ... DONE")


message("*** resolved() ...")

## A non-lazy future that has been resolved
f <- UniprocessFuture(expr = quote(6 * 7), substitute = FALSE,
                      globals = list())
f <- run(f)
stopifnot(isTRUE(resolved(f)))

## A lazy future is forced by resolved(), so that polling terminates
f <- UniprocessFuture(expr = quote(6 * 7), substitute = FALSE,
                      globals = list(), lazy = TRUE)
stopifnot(isTRUE(f[["lazy"]]), identical(f[["state"]], "created"))
stopifnot(isTRUE(resolved(f)))
stopifnot(identical(f[["state"]], "finished"))
stopifnot(identical(value(f), 42))

message("*** resolved() ... DONE")

message("*** UniprocessFuture ... DONE")
