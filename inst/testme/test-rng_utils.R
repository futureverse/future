#' @tags rng rng-utils

message("*** RNG ...")

set_random_seed(seed = NULL)
seed <- get_random_seed()
stopifnot(is.null(seed))

set_random_seed(seed = 42L)
seed <- get_random_seed()
stopifnot(identical(seed, 42L))

res <- tryCatch({
  seed <- as_lecyer_cmrg_seed(seed = FALSE)
}, error = identity)
print(res)
stopifnot(inherits(res, "error"))

seed <- as_lecyer_cmrg_seed(seed = 42L)
str(seed)
stopifnot(is_lecyer_cmrg_seed(seed))
set_random_seed(seed = seed)
stopifnot(identical(get_random_seed(), seed))

seed2 <- as_lecyer_cmrg_seed(seed = TRUE)
str(seed2)
stopifnot(identical(seed2, seed))

seed3 <- as_lecyer_cmrg_seed(seed = seed)
str(seed3)
stopifnot(identical(seed3, seed))

## A random seed
seed4 <- as_lecyer_cmrg_seed(seed = NA)
str(seed4)
stopifnot(is_lecyer_cmrg_seed(seed4))


message(" - exceptions ...")

## Invalid L'Ecuyer seed
seed_invalid <- seed + 1L
res <- tryCatch({
  seed <- as_lecyer_cmrg_seed(seed = seed_invalid)
}, error = identity)
print(res)
stopifnot(inherits(res, "error"))

## Invalid seed
res <- tryCatch({
  seed <- as_lecyer_cmrg_seed(seed = 1:2)
}, error = identity)
print(res)
stopifnot(inherits(res, "error"))

message(" - replicated RNG draws")

## Forward random seed
sample.int(n = 1L, size = 1L, replace = FALSE)
seed_org <- get_random_seed()
set.seed(42)

## Draw two random number from 1:100 one after the other
seed_before <- get_random_seed()
kind_before <- RNGkind()
x <- sample.int(100L, size = 5L)
y <- sample.int(100L, size = 5L)
seed_after <- get_random_seed()
kind_after <- RNGkind()
print(c(x, y))

## Draw two random number from 1:100 at once
set_random_seed(seed_before)
kind_before2 <- RNGkind()
z <- sample.int(100L, size = 10L)
seed_after2 <- get_random_seed()
kind_after2 <- RNGkind()
print(z)

## The RNG state is the same after the second ...
## run as after the first, two-step, approach
stopifnot(identical(seed_after2, seed_after))
stopifnot(identical(kind_before2, kind_before))
stopifnot(identical(kind_after2, kind_after))

## .... and the exact same set of random numbers where
## drawn [only true in R (>= 4.0.0)]
if (getRversion() >= "4.0.0") {
  stopifnot(identical(z, c(x, y)))
} else {
  stopifnot(identical(z[seq_along(x)], x))
}

set_random_seed(seed_org)
stopifnot(identical(get_random_seed(), seed_org))

message("*** RNG ... DONE")

