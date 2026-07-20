#' @tags utils-internal prune

library(future)

with_assert <- future:::with_assert
prune_call <- future:::prune_call
prune_debug <- future:::prune_debug
prune_fcns <- future:::prune_fcns
prune_fcn <- future:::prune_fcn

## NOTE: prune_pkg_code() itself is not tested here, because it rewrites the
## functions of the installed 'future' package, which would affect everything
## that runs after it in the same R session

message("*** with_assert() ...")

## The expression is evaluated, but returned invisibly
stopifnot(identical(with_assert(6L * 7L), 42L))
stopifnot(identical(withVisible(with_assert(1L))[["visible"]], FALSE))

message("*** with_assert() ... DONE")


message("*** prune_call() ...")

## Anything that is not a call is left as is
stopifnot(identical(prune_call(quote(x), name = "stop_if_not"), quote(x)))
stopifnot(identical(prune_call(42L, name = "stop_if_not"), 42L))

## Calls to other functions are left as is
expr <- quote(sum(1, 2))
stopifnot(identical(prune_call(expr, name = "stop_if_not"), expr))

## A call to the named function is dropped
stopifnot(is.null(prune_call(quote(stop_if_not(is.numeric(x))), name = "stop_if_not")))

## A call whose "function" is not a symbol is left as is,
## e.g. base::stop_if_not(...) where the first element is a call itself
expr <- quote(base::identity(1))
stopifnot(identical(prune_call(expr, name = "identity"), expr))

message("*** prune_call() ... DONE")


message("*** prune_debug() ...")

## Anything that is not a call is left as is
stopifnot(identical(prune_debug(quote(x)), quote(x)))
stopifnot(identical(prune_debug(42L), 42L))

## if (debug) ... is dropped
stopifnot(is.null(prune_debug(quote(if (debug) message("hi")))))

## if (<other>) ... is kept
expr <- quote(if (verbose) message("hi"))
stopifnot(identical(prune_debug(expr), expr))

## if (<non-symbol condition>) ... is kept
expr <- quote(if (is.numeric(x)) message("hi"))
stopifnot(identical(prune_debug(expr), expr))

## debug <- ... is replaced by 'debug <- FALSE'
stopifnot(identical(prune_debug(quote(debug <- TRUE)), quote(debug <- FALSE)))

## Assignments to other variables are kept
expr <- quote(verbose <- TRUE)
stopifnot(identical(prune_debug(expr), expr))

## Other calls are kept
expr <- quote(sum(1, 2))
stopifnot(identical(prune_debug(expr), expr))

message("*** prune_debug() ... DONE")


message("*** prune_fcns() ...")

## Each of the asserted functions is pruned
for (name in c("stop_if_not", "with_assert", "assert_no_positional_args_but_first",
               "assertValidConnection")) {
  expr <- as.call(list(as.symbol(name), quote(x)))
  stopifnot(is.null(prune_fcns(expr)))
}

## Debug statements are pruned too
stopifnot(is.null(prune_fcns(quote(if (debug) message("hi")))))

## Everything else survives
expr <- quote(sum(1, 2))
stopifnot(identical(prune_fcns(expr), expr))

message("*** prune_fcns() ... DONE")


message("*** prune_fcn() ...")

## A function whose body contains prunable calls is rewritten
env <- new.env()
env[["fcn"]] <- function(x) {
  stop_if_not(is.numeric(x))
  if (debug) message("debugging")
  x + 1L
}
attr(env[["fcn"]], "myattr") <- "kept"
res <- prune_fcn("fcn", envir = env)
stopifnot(isTRUE(res))

## The attributes are preserved, and the function still works
stopifnot(identical(attr(env[["fcn"]], "myattr"), "kept"))
stopifnot(identical(env[["fcn"]](1L), 2L))

## Pruning again changes nothing, so FALSE is returned
stopifnot(isFALSE(prune_fcn("fcn", envir = env)))

## A function without anything to prune is left alone
env[["plain"]] <- function(x) x + 1L
stopifnot(isFALSE(prune_fcn("plain", envir = env)))

## A name that does not exist, or is not a function, is ignored
stopifnot(isFALSE(prune_fcn("<no such function>", envir = env)))
env[["notafcn"]] <- 42L
stopifnot(isFALSE(prune_fcn("notafcn", envir = env)))

message("*** prune_fcn() ... DONE")
