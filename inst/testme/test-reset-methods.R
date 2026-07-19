#' @tags reset sequential

library(future)

plan(sequential)

message("*** reset() - default ...")

## Objects that are not futures are returned as-is
stopifnot(identical(reset(42L), 42L))
stopifnot(identical(reset("abc"), "abc"))
stopifnot(is.null(reset(NULL)))

message("*** reset() - default ... DONE")


message("*** reset() - Future ...")

## A resolved future is reset to a lazy, not-yet-launched future
f <- future(6 * 7)
v <- value(f)
stopifnot(identical(f[["state"]], "finished"))
uuid <- f[["uuid"]]

g <- reset(f)
print(g[["state"]])
stopifnot(inherits(g, "Future"))
stopifnot(identical(g[["state"]], "created"))
stopifnot(isTRUE(g[["lazy"]]))
stopifnot(is.null(g[["result"]]))
stopifnot(!identical(g[["uuid"]], uuid))

## The reset future can be used again, and gives the same value
stopifnot(identical(value(g), 42))

## A not-yet-launched future can be reset too
f <- future(6 * 7, lazy = TRUE)
stopifnot(identical(f[["state"]], "created"))
g <- reset(f)
stopifnot(inherits(g, "Future"), identical(g[["state"]], "created"))

## A running future without a proper backend gives a warning and is
## returned unchanged
f <- future(6 * 7, lazy = TRUE)
f[["state"]] <- "running"
f[["backend"]] <- NULL
res <- withCallingHandlers({
  tryCatch(reset(f), warning = identity)
}, warning = function(w) invokeRestart("muffleWarning"))
print(res)
stopifnot(inherits(res, "FutureWarning"),
          grepl("Cannot reset a running future", conditionMessage(res)))

## ... whereas one with a backend is an error
f <- future(6 * 7, lazy = TRUE)
f[["state"]] <- "submitted"
f[["backend"]] <- structure(list(), class = c("SequentialFutureBackend",
                                              "FutureBackend"))
res <- tryCatch(reset(f), error = identity)
print(res)
stopifnot(inherits(res, "FutureError"),
          grepl("Cannot reset a submitted future", conditionMessage(res)))

message("*** reset() - Future ... DONE")


message("*** reset() - list ...")

fs <- list(a = future(1, lazy = TRUE), b = future(2, lazy = TRUE))
gs <- reset(fs)
print(names(gs))
stopifnot(is.list(gs), length(gs) == 2L, identical(names(gs), c("a", "b")))
stopifnot(all(vapply(gs, FUN = inherits, "Future", FUN.VALUE = FALSE)))

## An empty list is fine
stopifnot(length(reset(list())) == 0L)

message("*** reset() - list ... DONE")


message("*** reset() - environment ...")

env <- new.env()
env[["a"]] <- future(1, lazy = TRUE)
env[["b"]] <- future(2, lazy = TRUE)
gs <- reset(env)
print(names(gs))
stopifnot(is.list(gs), length(gs) == 2L)
stopifnot(all(sort(names(gs)) == c("a", "b")))
stopifnot(all(vapply(gs, FUN = inherits, "Future", FUN.VALUE = FALSE)))

## An environment without futures gives an empty result
stopifnot(length(reset(new.env())) == 0L)

message("*** reset() - environment ... DONE")

plan(sequential)
