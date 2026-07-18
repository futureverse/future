#' @tags rng
#' @tags sequential

library(future)

message("*** rng - seed = structure(FALSE, onMisuse = ...) ...")

plan(sequential)

message("- onMisuse = 'error'")
f <- future(sample.int(2L), seed = structure(FALSE, onMisuse = "error"))
res <- tryCatch(value(f), RngFutureCondition = identity)
stopifnot(
  inherits(res, "error"),
  inherits(res, "RngFutureError")
)

message("- onMisuse = 'warning'")
f <- future(sample.int(2L), seed = structure(FALSE, onMisuse = "warning"))
res <- tryCatch(value(f), RngFutureCondition = identity)
stopifnot(
  inherits(res, "warning"),
  inherits(res, "RngFutureWarning")
)

message("- onMisuse = 'ignore'")
f <- future(sample.int(2L), seed = structure(FALSE, onMisuse = "ignore"))
res <- tryCatch(value(f), RngFutureCondition = identity)
stopifnot(
  !inherits(res, "condition"),
  is.integer(res)
)

message("- attribute takes precedence over option 'future.rng.onMisuse'")
oopts <- options(future.rng.onMisuse = "error")
f <- future(sample.int(2L), seed = structure(FALSE, onMisuse = "ignore"))
res <- tryCatch(value(f), RngFutureCondition = identity)
stopifnot(!inherits(res, "condition"))

options(future.rng.onMisuse = "ignore")
f <- future(sample.int(2L), seed = structure(FALSE, onMisuse = "error"))
res <- tryCatch(value(f), RngFutureCondition = identity)
stopifnot(inherits(res, "RngFutureError"))
options(oopts)

message("- no RNG misuse, no condition")
f <- future(42, seed = structure(FALSE, onMisuse = "error"))
res <- tryCatch(value(f), RngFutureCondition = identity)
stopifnot(identical(res, 42))

message("- invalid 'onMisuse' attributes are rejected")
res <- tryCatch({
  future(42, seed = structure(FALSE, onMisuse = "unknown"))
}, error = identity)
stopifnot(inherits(res, "error"))

res <- tryCatch({
  future(42, seed = structure(FALSE, onMisuse = 42))
}, error = identity)
stopifnot(inherits(res, "error"))

res <- tryCatch({
  future(42, seed = structure(FALSE, onMisuse = c("error", "warning")))
}, error = identity)
stopifnot(inherits(res, "error"))

message("*** rng - seed = structure(FALSE, onMisuse = ...) ... DONE")
