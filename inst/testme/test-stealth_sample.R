#' @tags utils-internal rng

library(future)

stealth_sample <- future:::stealth_sample

message("*** stealth_sample() ...")

## Nothing to sample
stopifnot(identical(stealth_sample(1:10, size = 0L), integer(0)))
stopifnot(identical(stealth_sample(letters, size = 0L), character(0)))

## Nothing to randomize, because the population holds a single element
stopifnot(identical(stealth_sample(5L, size = 1L), 5L))
stopifnot(identical(stealth_sample(5L, size = 3L, replace = TRUE), rep(5L, times = 3L)))

## Cannot sample more than the population without replacement
res <- tryCatch(stealth_sample(5L, size = 3L, replace = FALSE), error = identity)
print(res)
stopifnot(inherits(res, "error"))

message("*** stealth_sample() ... DONE")


message("*** stealth_sample() - does not change the RNG state ...")

set.seed(42L)
seed0 <- .GlobalEnv[[".Random.seed"]]

x <- stealth_sample(1:10)
stopifnot(length(x) == 10L, !anyDuplicated(x), all(sort(x) == 1:10))
stopifnot(identical(.GlobalEnv[[".Random.seed"]], seed0))

x <- stealth_sample(1:10, size = 3L)
stopifnot(length(x) == 3L, all(x %in% 1:10))
stopifnot(identical(.GlobalEnv[[".Random.seed"]], seed0))

x <- stealth_sample(1:3, size = 10L, replace = TRUE)
stopifnot(length(x) == 10L, all(x %in% 1:3))
stopifnot(identical(.GlobalEnv[[".Random.seed"]], seed0))

## The random seed is still the one we set
set.seed(42L)
stopifnot(identical(.GlobalEnv[[".Random.seed"]], seed0))

message("*** stealth_sample() - does not change the RNG state ... DONE")


message("*** stealth_sample() - without a pre-existing RNG state ...")

## When there is no .Random.seed to begin with, there should be none left
## behind either
if (".Random.seed" %in% ls(envir = .GlobalEnv, all.names = TRUE)) {
  rm(list = ".Random.seed", envir = .GlobalEnv, inherits = FALSE)
}
stopifnot(!(".Random.seed" %in% ls(envir = .GlobalEnv, all.names = TRUE)))

x <- stealth_sample(1:10, size = 2L)
stopifnot(length(x) == 2L, all(x %in% 1:10))
stopifnot(!(".Random.seed" %in% ls(envir = .GlobalEnv, all.names = TRUE)))

message("*** stealth_sample() - without a pre-existing RNG state ... DONE")
