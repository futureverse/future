#' @tags utils-internal options

library(future)

setOption <- future:::setOption
update_package_option <- future:::update_package_option

## A dedicated, non-existing option and its environment variable
name <- "future.test.myoption"
env <- "R_FUTURE_TEST_MYOPTION"

reset <- function() {
  opts <- list(NULL)
  names(opts) <- name
  options(opts)
  Sys.unsetenv(env)
}
reset()

message("*** setOption() ...")

## setOption() returns the previous value, invisibly
old <- setOption(name, "alpha")
print(old)
stopifnot(is.null(old))
stopifnot(identical(getOption(name), "alpha"))

old <- setOption(name, "beta")
print(old)
stopifnot(identical(old, "alpha"))
stopifnot(identical(getOption(name), "beta"))

## Setting NULL removes the option
setOption(name, NULL)
stopifnot(is.null(getOption(name)))

message("*** setOption() ... DONE")


message("*** update_package_option() ...")

message("- an already set option is kept, unless force = TRUE")

setOption(name, "preset")
Sys.setenv(R_FUTURE_TEST_MYOPTION = "fromenv")
stopifnot(identical(update_package_option(name), "preset"))
stopifnot(identical(update_package_option(name, force = TRUE), "fromenv"))
reset()


message("- environment variable not set")

## No default => NULL and the option remains unset
stopifnot(is.null(update_package_option(name)))
stopifnot(is.null(getOption(name)))

## With a default => the default is set as the option
stopifnot(identical(update_package_option(name, default = "fallback"),
                    "fallback"))
stopifnot(identical(getOption(name), "fallback"))
reset()

## Also with debug output
res <- update_package_option(name, debug = TRUE)
stopifnot(is.null(res))
reset()


message("- an empty environment variable falls back to the default")

Sys.setenv(R_FUTURE_TEST_MYOPTION = "")
stopifnot(is.null(update_package_option(name)))
stopifnot(is.null(getOption(name)))
stopifnot(identical(update_package_option(name, default = "fallback"),
                    "fallback"))
reset()

## A blank value is empty only after trimming
Sys.setenv(R_FUTURE_TEST_MYOPTION = "   ")
stopifnot(is.null(update_package_option(name)))
## ... whereas without trimming it is kept as-is
stopifnot(identical(update_package_option(name, trim = FALSE), "   "))
reset()


message("- trimming")

Sys.setenv(R_FUTURE_TEST_MYOPTION = "  hello  ")
stopifnot(identical(update_package_option(name), "hello"))
reset()

Sys.setenv(R_FUTURE_TEST_MYOPTION = "  hello  ")
stopifnot(identical(update_package_option(name, trim = FALSE), "  hello  "))
reset()


message("- splitting")

Sys.setenv(R_FUTURE_TEST_MYOPTION = "a,b,c")
stopifnot(identical(update_package_option(name, split = ","),
                    c("a", "b", "c")))
reset()

## Each element is trimmed too
Sys.setenv(R_FUTURE_TEST_MYOPTION = " a , b , c ")
stopifnot(identical(update_package_option(name, split = ","),
                    c("a", "b", "c")))
reset()

Sys.setenv(R_FUTURE_TEST_MYOPTION = " a , b ")
stopifnot(identical(update_package_option(name, split = ",", trim = FALSE),
                    c(" a ", " b ")))
reset()


message("- coercion")

Sys.setenv(R_FUTURE_TEST_MYOPTION = "42")
stopifnot(identical(update_package_option(name, mode = "integer"), 42L))
reset()

Sys.setenv(R_FUTURE_TEST_MYOPTION = "42")
stopifnot(identical(update_package_option(name, mode = "double"), 42))
reset()

Sys.setenv(R_FUTURE_TEST_MYOPTION = "TRUE")
stopifnot(identical(update_package_option(name, mode = "logical"), TRUE))
reset()

Sys.setenv(R_FUTURE_TEST_MYOPTION = "1,2,3")
stopifnot(identical(update_package_option(name, mode = "integer", split = ","),
                    c(1L, 2L, 3L)))
reset()

## Coercion with debug output
Sys.setenv(R_FUTURE_TEST_MYOPTION = "42")
stopifnot(identical(update_package_option(name, mode = "integer",
                                          debug = TRUE), 42L))
reset()


message("- disallowed values")

## Coercion that produces NAs is an error
Sys.setenv(R_FUTURE_TEST_MYOPTION = "not-a-number")
res <- tryCatch(update_package_option(name, mode = "integer"), error = identity)
print(res)
stopifnot(inherits(res, "error"),
          grepl("would result in missing values", conditionMessage(res)))

## ... unless 'NA' is not disallowed
res <- update_package_option(name, mode = "integer", disallow = NULL)
print(res)
stopifnot(is.na(res))
reset()

## Non-positive values
Sys.setenv(R_FUTURE_TEST_MYOPTION = "0")
res <- tryCatch(update_package_option(name, mode = "integer",
                                      disallow = c("NA", "non-positive")),
                error = identity)
print(res)
stopifnot(inherits(res, "error"),
          grepl("non-positive value", conditionMessage(res)))

reset()

## ... but a positive value passes
Sys.setenv(R_FUTURE_TEST_MYOPTION = "1")
stopifnot(identical(update_package_option(name, mode = "integer",
                                          disallow = c("NA", "non-positive")),
                    1L))
reset()

## Negative values
Sys.setenv(R_FUTURE_TEST_MYOPTION = "-1")
res <- tryCatch(update_package_option(name, mode = "integer",
                                      disallow = c("NA", "negative")),
                error = identity)
print(res)
stopifnot(inherits(res, "error"),
          grepl("negative value", conditionMessage(res)))
reset()

## Zero is not negative
Sys.setenv(R_FUTURE_TEST_MYOPTION = "0")
stopifnot(identical(update_package_option(name, mode = "integer",
                                          disallow = c("NA", "negative")), 0L))
reset()

## The 'disallow' checks for numbers do not apply to character values
Sys.setenv(R_FUTURE_TEST_MYOPTION = "-1")
stopifnot(identical(update_package_option(name,
                                          disallow = c("NA", "negative")),
                    "-1"))
reset()

message("*** update_package_option() ... DONE")
