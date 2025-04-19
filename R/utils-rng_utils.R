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
#' `next_random_seed(seed)` get the next random seed after forwarding the
#' RNG state on step.
#'
#' `set_random_seed(seed)` sets a new value on `.Random.seed`, and invisibly
#' returns the _old_ seed.  If `seed = NULL`, then the `.Random.seed` is
#' removed.
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
  env[[".Random.seed"]]
}


#' @rdname random_seed_utils
#' @noRd
next_random_seed <- function(seed = get_random_seed()) {
  sample.int(n = 1L, size = 1L, replace = FALSE)
  seed_next <- get_random_seed()
  
  ## Assert RNG state changed
  stop_if_not(identical(seed_next, seed))
  
  invisible(seed_next)
}


#' @rdname random_seed_utils
#' @noRd
set_random_seed <- function(seed, kind = NULL, set_kind) {
  env <- globalenv()
  old_seed <- env[[".Random.seed"]]
  if (is.null(seed)) {
    if (!is.null(kind)) {
      set_kind(kind)
    }
    rm(list = ".Random.seed", envir = env, inherits = FALSE)
  } else {
    env[[".Random.seed"]] <- seed
  }
  invisible(old_seed)
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
    on.exit(set_random_seed(oseed, kind = okind, set_kind = RNGkind), add = TRUE)

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
    on.exit(set_random_seed(oseed, kind = okind, set_kind = RNGkind), add = TRUE)
    
    ## ... based on 'seed'
    set.seed(seed)
    return(get_random_seed())
  }
  
  stopf("Argument 'seed' must be L'Ecuyer-CMRG RNG seed as returned by parallel::nextRNGStream() or an single integer: %s", capture.output(str(seed)))
}


# @param kind ...
# @param set_kind ...
# @param next_stream ...
# @param is_seed ...
# @param as_seed ...
# @param \ldots  ...
#
#' @importFrom parallel nextRNGStream nextRNGSubStream
parallel_rng_kind <- local({
  config <- list(
              kind = "L'Ecuyer-CMRG",
          set_kind = RNGkind,
       next_stream = nextRNGStream,
    next_substream = nextRNGSubStream,
           is_seed = is_lecyer_cmrg_seed,
           as_seed = as_lecyer_cmrg_seed
  )
  
  function(kind = NULL, set_kind, next_stream, next_substream, is_seed, as_seed, ...) {
    if (is.null(kind)) return(config)
    
    stopifnot(
      is.function(set_kind),
      is.function(next_stream),
      is.function(next_substream),
      is.function(is_seed),
      is.function(as_seed)
    )
  
    config <<- list(
                kind = kind,
            set_kind = set_kind,
         next_stream = next_stream,
      next_substream = next_substream,
             is_seed = is_seed,
             as_seed = as_seed
    )
  
    config
  }
}) ## parallel_rng_kind()



#' Produce Reproducible Seeds for Parallel Random Number Generation
#'
#' @param count The number of RNG seeds to produce.
#'
#' @param seed A logical specifying whether RNG seeds should be generated
#' or not.  (`seed = NULL` corresponds to `seed = FALSE`).
#' If a list, then it should be of length `count` and each element should
#' consist of a valid RNG seed.
#'
#' @return Returns a non-named list of `count` independent parallel random
#' seeds.
#' If `seed` is `NULL` or `FALSE`, then `NULL` is returned.
#' 
#' @example incl/make_rng_seeds.R
#'
#' @details
#' This function generates `count` independent parallel random seeds that
#' can be used as `.Random.seed` for parallel processing.  These seeds are
#' produced with help of `next_stream()` and `next_substream()` part of
#' `future:::parallel_rng_kind()`, by using a strategy that:
#'
#' ```r
#' seed <- <initial RNG seed>
#' for (ii in seq_len(count)) {
#'   seeds[[ii]] <- next_substream(seed)
#'   seed <- next_rng_stream(seed)
#' }
#' ```
#'
#' This function forwards the RNG state `1 + count` times if `seed = TRUE`.
#' 
#' @importFrom utils capture.output str
#' @noRd
make_rng_seeds <- function(count, seed = FALSE, rng_config = parallel_rng_kind()) {
  ## Don't use RNGs? (seed = {FALSE, NULL})
  if (is.null(seed)) return(NULL)
  if (is.logical(seed) && !is.na(seed) && !seed) return(NULL)

  stop_if_not(is.numeric(count), length(count) == 1L, !is.na(count),
              count >= 0L)

  debug <- getOption("future.debug", FALSE)

  ## Placeholder for all RNG stream seeds.
  seeds <- NULL
  
  # Use RNGs?
  if (debug) mdebug("Generating random seeds ...")

  ## A pregenerated sequence of random seeds?
  if (is.list(seed)) {
    if (debug) mdebugf("Using a pre-define stream of %d random seeds ...", count)

    seeds <- seed
    nseeds <- length(seeds)
    if (nseeds != count) {
      stopf("Argument 'seed' is a list, which specifies the sequence of seeds to be used for each element iterated over, but length(seed) != number of elements: %.0f != %.0f", nseeds, count)
    }

    ## Assert same type of RNG seeds?
    ns <- unique(unlist(lapply(seeds, FUN = length), use.names = FALSE))
    if (length(ns) != 1L) {
      stopf("The elements of the list specified in argument 'seed' are not all of the same lengths (did you really pass RNG seeds?): %s", hpaste(ns))
    }

    ## Did use specify scalar integers as meant for set.seed()?
    if (ns == 1L) {
      stop("Argument 'seed' is invalid. Pre-generated random seeds must be valid .Random.seed seeds, which means they should be all integers and consists of two or more elements, not just one")
    }

    types <- unlist(lapply(seeds, FUN = typeof), use.names = FALSE)
    if (!all(types == "integer")) {
      stopf("The elements of the list specified in argument 'seed' are not all integers (did you really pass RNG seeds?): %s", hpaste(unique(types)))
    }
    
    ## Check if valid random seeds are specified.
    ## For efficiency, only look at the first one.
    if (!is_valid_random_seed(seeds[[1]])) {
      stopf("The list in argument 'seed' does not seem to hold elements that are valid .Random.seed values: %s", capture.output(str(seeds[[1]])))
    }

    if (debug) {
      mdebugf("Using a pre-define stream of %d random seeds ... DONE", count)
      mdebug("Generating random seeds ... DONE")
    }
    
    return(seeds)
  }

  
  if (debug) mdebugf("Generating random seed streams for %d elements ...", count)

  
  next_stream <- rng_config[["next_stream"]]
  next_substream <- rng_config[["next_substream"]]
  
  ## Generate sequence of _all_ RNG seeds starting with an initial seed
  ## '.seed' that is based on argument 'seed'.
  .seed <- rng_config[["as_seed"]](seed)

  ## future_*apply() should return with the same RNG state regardless of
  ## future backend used. This is be done such that RNG kind is preserved
  ## and the seed is "forwarded" one step from what it was when this
  ## function was called. The forwarding is done by generating one random
  ## number. Note that this approach is also independent on the number of
  ## elements iterated over and the different FUN() calls.
  oseed <- next_random_seed()
  on.exit(set_random_seed(oseed))

  seeds <- vector("list", length = count)
  for (ii in seq_len(count)) {
    ## RNG substream seed used when calling FUN() for element(s) 'ii':
    ## This way each future can in turn generate further seeds, also
    ## recursively, with minimal risk of generating the same seeds as
    ## another future. This should make it safe to recursively call
    ## future_*apply(). /HB 2017-01-11
    seeds[[ii]] <- next_substream(.seed)
    
    ## Main random seed for next iteration (= ii + 1)
    .seed <- next_stream(.seed)
  }
  
  if (debug) {
    mdebugf("Generating random seed streams for %d elements ... DONE", count)
    mdebug("Generating random seeds ... DONE")
  }

  seeds
}


## Evaluates an R expression while preventing any changes to .Random.seed
with_stealth_rng <- function(expr, substitute = TRUE, envir = parent.frame(), ...) {
  if (substitute) expr <- substitute(expr)

  ## Record the original RNG state
  oseed <- .GlobalEnv[[".Random.seed"]]
  on.exit({
    if (is.null(oseed)) {
      if (exists(".Random.seed", envir = .GlobalEnv, inherits = FALSE)) {
        rm(list = ".Random.seed", envir = .GlobalEnv, inherits = FALSE)
      }
    } else {
      .GlobalEnv[[".Random.seed"]] <- oseed
    }
  })

  ## Evaluate the R expression with "random" RNG state
  if (!is.null(oseed)) {
    rm(list = ".Random.seed", envir = .GlobalEnv, inherits = FALSE)
  }
  eval(expr, envir = envir, enclos = baseenv())
}
