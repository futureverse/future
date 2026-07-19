#' @tags rng rng-utils utils-internal

library(future)

make_rng_seeds <- future:::make_rng_seeds
with_stealth_rng <- future:::with_stealth_rng
parallel_rng_kind <- future:::parallel_rng_kind
is_valid_random_seed <- future:::is_valid_random_seed
next_random_seed <- future:::next_random_seed
is_lecyer_cmrg_seed <- future:::is_lecyer_cmrg_seed

set.seed(42L)

message("*** make_rng_seeds() - no seeds ...")

## seed = NULL and seed = FALSE both mean "do not use RNGs"
stopifnot(is.null(make_rng_seeds(3L, seed = NULL)))
stopifnot(is.null(make_rng_seeds(3L, seed = FALSE)))

message("*** make_rng_seeds() - no seeds ... DONE")


message("*** make_rng_seeds() - generated seeds ...")

## seed = TRUE generates 'count' independent seeds
seeds <- make_rng_seeds(3L, seed = TRUE)
stopifnot(is.list(seeds), length(seeds) == 3L)
stopifnot(all(vapply(seeds, is_lecyer_cmrg_seed, logical(1L))))
## They are all different
stopifnot(length(unique(lapply(seeds, identity))) == 3L)

## A scalar seed works too, and is reproducible
seeds1 <- make_rng_seeds(2L, seed = 42L)
seeds2 <- make_rng_seeds(2L, seed = 42L)
stopifnot(identical(seeds1, seeds2), length(seeds1) == 2L)

## count = 0 gives an empty list
seeds0 <- make_rng_seeds(0L, seed = TRUE)
stopifnot(is.list(seeds0), length(seeds0) == 0L)

message("*** make_rng_seeds() - generated seeds ... DONE")


message("*** make_rng_seeds() - pre-generated seeds ...")

## A list of valid seeds of the right length is returned as is
valid <- make_rng_seeds(2L, seed = TRUE)
stopifnot(identical(make_rng_seeds(2L, seed = valid), valid))

## ... but the length must match 'count'
res <- tryCatch(make_rng_seeds(3L, seed = valid), error = identity)
print(res)
stopifnot(inherits(res, "error"))

## Seeds of differing lengths are rejected
bad <- list(valid[[1]], valid[[2]][-1])
res <- tryCatch(make_rng_seeds(2L, seed = bad), error = identity)
print(res)
stopifnot(inherits(res, "error"))

## Scalar integers are not valid .Random.seed values
res <- tryCatch(make_rng_seeds(2L, seed = list(1L, 2L)), error = identity)
print(res)
stopifnot(inherits(res, "error"))

## Non-integer seeds are rejected
res <- tryCatch(make_rng_seeds(2L, seed = list(c(1.5, 2.5), c(3.5, 4.5))),
                error = identity)
print(res)
stopifnot(inherits(res, "error"))

## Integer vectors that are not valid random seeds are rejected
## NOTE: c(999L, ...) is invalid because 999 is not a known RNG kind
res <- tryCatch(make_rng_seeds(2L, seed = list(c(999L, 1L, 2L), c(999L, 3L, 4L))),
                error = identity)
print(res)
stopifnot(inherits(res, "error"))

message("*** make_rng_seeds() - pre-generated seeds ... DONE")


message("*** make_rng_seeds() - invalid 'count' ...")

for (count in list("3", NA_integer_, -1L)) {
  res <- tryCatch(make_rng_seeds(count, seed = TRUE), error = identity)
  print(res)
  stopifnot(inherits(res, "error"))
}

message("*** make_rng_seeds() - invalid 'count' ... DONE")


message("*** make_rng_seeds() - with debug output ...")

local({
  oopts <- options(future.debug = TRUE)
  on.exit(options(oopts))
  seeds <- make_rng_seeds(2L, seed = TRUE)
  stopifnot(length(seeds) == 2L)
  valid <- make_rng_seeds(2L, seed = seeds)
  stopifnot(identical(valid, seeds))
})

message("*** make_rng_seeds() - with debug output ... DONE")


message("*** is_valid_random_seed() ...")

seed <- get_random_seed()
stopifnot(isTRUE(is_valid_random_seed(seed)))
## NOTE: c(999L, ...) is invalid because 999 is not a known RNG kind
stopifnot(isFALSE(is_valid_random_seed(c(999L, 1L, 2L))))
## The RNG state is left untouched
stopifnot(identical(get_random_seed(), seed))

message("*** is_valid_random_seed() ... DONE")


message("*** next_random_seed() ...")

seed <- next_random_seed()
stopifnot(!is.null(seed), identical(seed, get_random_seed()))

message("*** next_random_seed() ... DONE")


message("*** with_stealth_rng() ...")

## The RNG state is unchanged by the evaluated expression
set.seed(42L)
seed <- get_random_seed()
x <- with_stealth_rng(sample.int(100L, size = 3L))
stopifnot(length(x) == 3L)
stopifnot(identical(get_random_seed(), seed))

## The expression is evaluated in the caller's environment
y <- 41L
stopifnot(identical(with_stealth_rng(y + 1L), 42L))

## An already substituted expression can be passed
expr <- quote(sample.int(10L, size = 2L))
z <- with_stealth_rng(expr, substitute = FALSE)
stopifnot(length(z) == 2L)
stopifnot(identical(get_random_seed(), seed))

## When there is no RNG state to begin with, none is left behind
set_random_seed(NULL)
stopifnot(is.null(get_random_seed()))
x <- with_stealth_rng(sample.int(100L, size = 2L))
stopifnot(length(x) == 2L, is.null(get_random_seed()))

set_random_seed(seed)

message("*** with_stealth_rng() ... DONE")


message("*** parallel_rng_kind() ...")

## Without arguments the current configuration is returned
config <- parallel_rng_kind()
stopifnot(is.list(config))
stopifnot(identical(config[["kind"]], "L'Ecuyer-CMRG"))
for (name in c("set_kind", "next_stream", "next_substream", "is_seed", "as_seed")) {
  stopifnot(is.function(config[[name]]))
}

## The configuration can be replaced, and restored again
local({
  on.exit(do.call(parallel_rng_kind, args = config))
  new_config <- parallel_rng_kind(
    kind = "<custom>",
    set_kind = config[["set_kind"]],
    next_stream = config[["next_stream"]],
    next_substream = config[["next_substream"]],
    is_seed = config[["is_seed"]],
    as_seed = config[["as_seed"]]
  )
  stopifnot(identical(new_config[["kind"]], "<custom>"))
  stopifnot(identical(parallel_rng_kind()[["kind"]], "<custom>"))
})

## Restored
stopifnot(identical(parallel_rng_kind()[["kind"]], "L'Ecuyer-CMRG"))

## Non-function arguments are rejected
res <- tryCatch(parallel_rng_kind(kind = "<bad>", set_kind = 42L,
                                  next_stream = config[["next_stream"]],
                                  next_substream = config[["next_substream"]],
                                  is_seed = config[["is_seed"]],
                                  as_seed = config[["as_seed"]]), error = identity)
print(res)
stopifnot(inherits(res, "error"))
stopifnot(identical(parallel_rng_kind()[["kind"]], "L'Ecuyer-CMRG"))

message("*** parallel_rng_kind() ... DONE")
