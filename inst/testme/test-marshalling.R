#' @tags utils-internal marshalling non-exportable
#' @tags detritus-files

library(future)

find_references <- future:::find_references
reference_filters <- future:::reference_filters
assert_no_references <- future:::assert_no_references

message("*** marshalling ...")

## A connection is a non-exportable reference, whereas an environment
## is a reference that is ignored by the default filters
tmp_file <- tempfile()
con <- file(tmp_file, open = "wb")


message("*** find_references() ...")

## Objects without references
stopifnot(length(find_references(list(a = 1, b = "2"))) == 0L)
stopifnot(length(find_references(NULL)) == 0L)
stopifnot(length(find_references(sum)) == 0L)

## Environments are dropped by the default 'ignore_envirs' filter
stopifnot(length(find_references(new.env())) == 0L)
stopifnot(length(find_references(list(a = new.env(), b = new.env()))) == 0L)

## Connections are reported
refs <- find_references(con)
print(refs)
stopifnot(is.list(refs), length(refs) == 1L)

## first_only = TRUE stops after the first reference found
refs <- find_references(list(a = con, b = con), first_only = FALSE)
print(refs)
stopifnot(length(refs) == 2L)

refs <- find_references(list(a = con, b = con), first_only = TRUE)
print(refs)
stopifnot(length(refs) == 1L)

## Environments are skipped also when mixed with true references
refs <- find_references(list(e = new.env(), c = con), first_only = TRUE)
print(refs)
stopifnot(length(refs) == 1L)

message("*** find_references() ... DONE")


message("*** reference_filters() ...")

filters0 <- reference_filters(action = "get")
print(names(filters0))
stopifnot(is.list(filters0), "ignore_envirs" %in% names(filters0))

## Appending a filter puts it last
reference_filters(action = "append",
                  keep_all = function(ref, typeof, class, ...) TRUE)
filters <- reference_filters(action = "get")
print(names(filters))
stopifnot(identical(names(filters), c("ignore_envirs", "keep_all")))

## Prepending a filter puts it first
reference_filters(action = "prepend",
                  first = function(ref, typeof, class, ...) TRUE)
filters <- reference_filters(action = "get")
print(names(filters))
stopifnot(identical(names(filters), c("first", "ignore_envirs", "keep_all")))

## Setting replaces the complete set of filters
reference_filters(action = "set",
                  only = function(ref, typeof, class, ...) TRUE)
filters <- reference_filters(action = "get")
print(names(filters))
stopifnot(identical(names(filters), "only"))

## With the default 'ignore_envirs' filter gone, environments are
## reported as references too
stopifnot(length(find_references(new.env())) == 1L)

## An environment carrying a class exercises the case where the class of
## the reference differs from its storage type
env <- new.env()
class(env) <- "myclass"
msg <- assert_no_references(list(env = env), action = "string")
print(msg)
stopifnot(grepl(sQuote("environment"), msg, fixed = TRUE),
          grepl(sQuote("myclass"), msg, fixed = TRUE))

## Resetting restores the default filters
reference_filters(action = "reset")
filters <- reference_filters(action = "get")
print(names(filters))
stopifnot(identical(names(filters), names(filters0)))

## A filter that drops everything means no references are ever reported
reference_filters(action = "prepend",
                  drop_all = function(ref, typeof, class, ...) FALSE)
stopifnot(length(find_references(con)) == 0L)
reference_filters(action = "reset")
stopifnot(length(find_references(con)) == 1L)

message("*** reference_filters() ... DONE")


message("*** assert_no_references() ...")

## No references => NULL, regardless of 'action'
for (action in c("error", "warning", "message", "string")) {
  stopifnot(is.null(assert_no_references(list(a = 1), action = action)))
}

## action = "string" returns the message
msg <- assert_no_references(list(con = con), action = "string")
print(msg)
stopifnot(is.character(msg), length(msg) == 1L,
          grepl("non-exportable reference", msg))

## The offending global is identified by name and class
stopifnot(grepl(sQuote("con"), msg, fixed = TRUE),
          grepl(sQuote("file"), msg, fixed = TRUE))

## An unnamed list cannot identify the global
msg <- assert_no_references(list(con), action = "string")
print(msg)
stopifnot(grepl("<unknown>", msg))

## source = "value" gives a different message
msg <- assert_no_references(con, action = "string", source = "value")
print(msg)
stopifnot(grepl("resolved future", msg))

## action = "error"
res <- tryCatch(assert_no_references(list(con = con), action = "error"),
                error = identity)
print(res)
stopifnot(inherits(res, "FutureError"),
          grepl("non-exportable reference", conditionMessage(res)))

## action = "warning"
res <- withCallingHandlers({
  tryCatch(assert_no_references(list(con = con), action = "warning"),
           warning = identity)
}, warning = function(w) invokeRestart("muffleWarning"))
print(res)
stopifnot(inherits(res, "FutureWarning"),
          grepl("non-exportable reference", conditionMessage(res)))

## action = "message"
res <- withCallingHandlers({
  tryCatch(assert_no_references(list(con = con), action = "message"),
           message = identity)
}, message = function(m) invokeRestart("muffleMessage"))
print(res)
stopifnot(inherits(res, "FutureMessage"),
          grepl("non-exportable reference", conditionMessage(res)))

## The 'where' attribute of a Globals object is not searched
globals <- structure(list(a = 1), class = "Globals",
                     where = list(a = new.env()))
stopifnot(is.null(assert_no_references(globals, action = "string")))

## ... but true references among the globals are still detected
globals <- structure(list(con = con), class = "Globals",
                     where = list(con = new.env()))
msg <- assert_no_references(globals, action = "string")
print(msg)
stopifnot(grepl("non-exportable reference", msg))

## Invalid 'action' and 'source' are rejected
res <- tryCatch(assert_no_references(list(con = con), action = "unknown"),
                error = identity)
print(res)
stopifnot(inherits(res, "error"))

res <- tryCatch(assert_no_references(list(con = con), action = "string",
                                     source = "unknown"), error = identity)
print(res)
stopifnot(inherits(res, "error"))

message("*** assert_no_references() ... DONE")

## Clean up, so that we do not leave a stray connection behind
close(con)
file.remove(tmp_file)

## The default filters must be in effect when we leave
stopifnot(identical(names(reference_filters(action = "get")),
                    names(filters0)))

message("*** marshalling ... DONE")
