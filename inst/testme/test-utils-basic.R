#' @tags utils-internal

library(future)

isFALSE <- future:::isFALSE
isNA <- future:::isNA
assert_no_positional_args_but_first <- future:::assert_no_positional_args_but_first
stop_if_not <- future:::stop_if_not
trim <- future:::trim
comma <- future:::comma
commaq <- future:::commaq
hexpr <- future:::hexpr
envname <- future:::envname
inherits_from_namespace <- future:::inherits_from_namespace

message("*** utils-basic ...")


message("*** isFALSE() ...")

stopifnot(isFALSE(FALSE))
stopifnot(!isFALSE(TRUE))
stopifnot(!isFALSE(NA))
stopifnot(!isFALSE(c(FALSE, FALSE)))
stopifnot(!isFALSE(logical(0)))
stopifnot(!isFALSE(0))
stopifnot(!isFALSE("FALSE"))
stopifnot(!isFALSE(NULL))

message("*** isFALSE() ... DONE")


message("*** isNA() ...")

stopifnot(isNA(NA))
stopifnot(!isNA(NA_integer_))
stopifnot(!isNA(NA_character_))
stopifnot(!isNA(TRUE))
stopifnot(!isNA(c(NA, NA)))
stopifnot(!isNA(logical(0)))
stopifnot(!isNA(NULL))

message("*** isNA() ... DONE")


message("*** assert_no_positional_args_but_first() ...")

foo <- function(a, ...) {
  assert_no_positional_args_but_first()
  TRUE
}

## Only the first argument may be positional
stopifnot(foo(1))
stopifnot(foo(1, b = 2))
stopifnot(foo(1, b = 2, c = 3))

res <- tryCatch(foo(1, 2), error = identity)
print(res)
stopifnot(inherits(res, "error"),
          grepl("passed by name and not by position", conditionMessage(res)))

## A mix of named and positional is also an error
res <- tryCatch(foo(1, b = 2, 3), error = identity)
print(res)
stopifnot(inherits(res, "error"))

## Forwarded '...' are ignored, because they cannot be inspected here
bar <- function(...) foo(...)
stopifnot(bar(1, b = 2))

## ... also when '...' is passed alongside the first argument
baz <- function(a, ...) foo(a, ...)
stopifnot(baz(1))
stopifnot(baz(1, b = 2))
stopifnot(baz(1, 2))

message("*** assert_no_positional_args_but_first() ... DONE")


message("*** stop_if_not() ...")

stopifnot(is.null(stop_if_not(TRUE)))
stopifnot(is.null(stop_if_not(TRUE, TRUE, 1 == 1)))

res <- tryCatch(stop_if_not(FALSE), error = identity)
print(res)
stopifnot(inherits(res, "error"), grepl("is not TRUE", conditionMessage(res)))

res <- tryCatch(stop_if_not(NA), error = identity)
print(res)
stopifnot(inherits(res, "error"))

## Not of length one
res <- tryCatch(stop_if_not(c(TRUE, TRUE)), error = identity)
print(res)
stopifnot(inherits(res, "error"))

res <- tryCatch(stop_if_not(logical(0)), error = identity)
print(res)
stopifnot(inherits(res, "error"))

## The failing expression is reported
res <- tryCatch(stop_if_not(TRUE, 1 == 2), error = identity)
print(res)
stopifnot(inherits(res, "error"), grepl("1 == 2", conditionMessage(res)))

## A long expression is truncated
res <- tryCatch(stop_if_not(is.numeric("a") && is.character(1) &&
                            is.list(2) && is.function(3) && is.environment(4)),
                error = identity)
print(res)
stopifnot(inherits(res, "error"), grepl("....", conditionMessage(res),
                                        fixed = TRUE))

message("*** stop_if_not() ... DONE")


message("*** trim() ...")

stopifnot(identical(trim("  abc  "), "abc"))
stopifnot(identical(trim("\t\n\f\r abc \r\f\n\t"), "abc"))
stopifnot(identical(trim("abc"), "abc"))
stopifnot(identical(trim(""), ""))
stopifnot(identical(trim("a b"), "a b"))
stopifnot(identical(trim(c(" a ", " b ")), c("a", "b")))

message("*** trim() ... DONE")


message("*** comma() and commaq() ...")

stopifnot(identical(comma(c("a", "b")), "a, b"))
stopifnot(identical(comma(c("a", "b"), sep = "-"), "a-b"))
stopifnot(identical(comma("a"), "a"))
stopifnot(identical(comma(character(0)), ""))

stopifnot(identical(commaq(c("a", "b")),
                    paste(sQuote("a"), sQuote("b"), sep = ", ")))
stopifnot(identical(commaq(c("a", "b"), sep = "-"),
                    paste(sQuote("a"), sQuote("b"), sep = "-")))

message("*** comma() and commaq() ... DONE")


message("*** hexpr() ...")

expr <- quote(x <- 1)
code <- hexpr(expr)
print(code)
stopifnot(is.character(code), length(code) == 1L)

## A long expression is abbreviated
expr <- quote({
  a <- 1
  b <- 2
  c <- 3
  d <- 4
  e <- 5
  f <- 6
  g <- 7
  h <- 8
  i <- 9
  j <- 10
})
code <- hexpr(expr)
print(code)
stopifnot(is.character(code), length(code) == 1L,
          grepl("...", code, fixed = TRUE))

message("*** hexpr() ... DONE")


message("*** envname() ...")

stopifnot(identical(envname(globalenv()), "R_GlobalEnv"))
stopifnot(identical(envname(emptyenv()), "R_EmptyEnv"))
stopifnot(identical(envname(baseenv()), "base"))
stopifnot(identical(envname(asNamespace("stats")), "stats"))

## A package environment on the search() path drops the 'package:' prefix
stopifnot(identical(envname(as.environment("package:stats")), "stats"))

## An anonymous environment falls back to its address
name <- envname(new.env())
print(name)
stopifnot(is.character(name), length(name) == 1L, !is.na(name))

## An environment with attributes prints on multiple lines; only the
## first one, which holds the address, is used
env <- new.env()
attr(env, "myattr") <- 1L
stopifnot(length(capture.output(print.default(env))) > 1L)
name <- envname(env)
print(name)
stopifnot(is.character(name), length(name) == 1L, !is.na(name),
          !grepl("myattr", name))

## Non-environments give NA
stopifnot(identical(envname(42L), NA_character_))
stopifnot(identical(envname(NULL), NA_character_))

message("*** envname() ... DONE")


message("*** inherits_from_namespace() ...")

stopifnot(inherits_from_namespace(asNamespace("stats")))
stopifnot(inherits_from_namespace(environment(stats::var)))

## Primitive functions have a NULL environment
stopifnot(is.null(environment(sum)))
stopifnot(inherits_from_namespace(environment(sum)))

stopifnot(!inherits_from_namespace(globalenv()))

## An environment chain that ends in emptyenv() without a namespace
stopifnot(!inherits_from_namespace(emptyenv()))
stopifnot(!inherits_from_namespace(new.env(parent = emptyenv())))

message("*** inherits_from_namespace() ... DONE")

message("*** utils-basic ... DONE")
