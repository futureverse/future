#' Tools for Working with Parallel Random Seeds
#'
#' @param seed A random seed
#'
#' @param kind A character string or NULL. If kind is a character string,
#' set \R's RNG to the kind desired. Use `"default"` to return to the \R
#' default.
#'
#' @return
#' `get_random_seed()` returns the _current_ `.Random.seed`.  If it does not
#' exists, it returns `NULL`.
#'
#' `set_random_seed(seed)` sets a new value on `.Random.seed`, and invisibly
#' returns the _old_ seed.  If `seed = NULL`, then the `.Random.seed` is
#' removed.
#'
#' `next_random_seed()` updates `.Random.seed` by drawning an dummy random
#' number internally, and invisibly returns the _new_ seed.
#'
#' `is_valid_random_seed(seed)` returns TRUE if `seed` is a valid random seed
#' of any RNG kind, otherwise FALSE.
#' This function does _not_ update `.Random.seed`.
#'
#' `is_lecyer_cmrg_seed(seed)` returns TRUE if `seed` is a valid random seed
#' of kind `L'Ecuyer-CMRG`, otherwise FALSE.
#' This function does _not_ update `.Random.seed`.
#'
#' `as_lecyer_cmrg_seed(seed)` returns `L'Ecuyer-CMRG` random seed based on
#' random seed `seed`.  If `seed` is already of the right RNG kind, then that
#' seed is returned as-is.  If a scalar, then a `L'Ecuyer-CMRG` random seed
#' is generated from that seed with the help of `set.seed()`.
#' This function does _not_ update `.Random.seed`.
#'
#' @example incl/random_seed_utils.R
#'
#' @seealso
#' For more information on random number generation (RNG) in R,
#' see [base::Random].
#'
#' @rdname random_seed_utils
#' @noRd
get_random_seed <- function() {
  env <- globalenv()
  env$.Random.seed
}

#' @rdname random_seed_utils
#' @noRd
set_random_seed <- function(seed, kind = NULL) {
  env <- globalenv()
  old_seed <- env$.Random.seed
  if (is.null(seed)) {
    if (!is.null(kind)) RNGkind(kind)
    rm(list = ".Random.seed", envir = env, inherits = FALSE)
  } else {
    env$.Random.seed <- seed
  }
  invisible(old_seed)
}

#' @rdname random_seed_utils
#' @noRd
next_random_seed <- function(seed = get_random_seed()) {
  sample.int(n = 1L, size = 1L, replace = FALSE)
  seed_next <- get_random_seed()
  stop_if_not(identical(seed_next, seed))
  invisible(seed_next)
}

#' @rdname random_seed_utils
#' @noRd
is_valid_random_seed <- function(seed) {
  oseed <- get_random_seed()
  on.exit(set_random_seed(oseed))
  env <- globalenv()
  env$.Random.seed <- seed
  res <- tryCatch({
    sample.int(n = 1L, size = 1L, replace = FALSE)
  }, simpleWarning = function(w) w)
  !inherits(res, "simpleWarning")
}

## For RNGkind("L'Ecuyer-CMRG") we should have (see help('RNGkind')):
##   .Random.seed <- c(rng.kind, n) where length(n) == 6L.
## From R source code: check for rng.kind %% 10000L == 407L
#' @rdname random_seed_utils
#' @noRd
is_lecyer_cmrg_seed <- function(seed) {
  is.numeric(seed) &&
    length(seed) == 7L &&
    all(is.finite(seed)) &&
    (seed[1] %% 10000L == 407L)
}

#' @rdname random_seed_utils
#' @importFrom utils capture.output
#' @noRd
as_lecyer_cmrg_seed <- function(seed) {
  ## Generate a L'Ecuyer-CMRG seed (existing or random)?
  if (is.logical(seed)) {
    stop_if_not(length(seed) == 1L)
    if (!is.na(seed) && !seed) {
      stopf("Argument 'seed' must be TRUE if logical: %s", seed)
    }

    oseed <- get_random_seed()

    ## Already a L'Ecuyer-CMRG seed?  Then use that as is.
    if (!is.na(seed) && seed) {
      if (is_lecyer_cmrg_seed(oseed)) return(oseed)
    }

    ## Generate a random L'Ecuyer-CMRG seed from the current RNG state
    okind <- RNGkind("L'Ecuyer-CMRG")[1]

    ## Make sure to not forward the RNG state or the RNG kind
    on.exit(set_random_seed(oseed, kind = okind), add = TRUE)

    return(get_random_seed())
  }

  stop_if_not(is.numeric(seed), all(is.finite(seed)))
  seed <- as.integer(seed)

  ## Already a L'Ecuyer-CMRG seed?
  if (is_lecyer_cmrg_seed(seed)) {
    return(seed)
  }

  ## Generate a new L'Ecuyer-CMRG seed?
  if (length(seed) == 1L) {
    ## Generate a random L'Ecuyer-CMRG seed from the current RNG state
    oseed <- get_random_seed()
    okind <- RNGkind("L'Ecuyer-CMRG")[1]

    ## Make sure to not forward the RNG state or the RNG kind
    on.exit(set_random_seed(oseed, kind = okind), add = TRUE)

    ## ... based on 'seed'
    set.seed(seed)
    return(get_random_seed())
  }

  stopf("Argument 'seed' must be L'Ecuyer-CMRG RNG seed as returned by parallel::nextRNGStream() or an single integer: %s", capture.output(str(seed)))
}
