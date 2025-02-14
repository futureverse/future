## A version of base::sample() that does not change .Random.seed
stealth_sample <- function(x, size = length(x), replace = FALSE, ...) {
  ## Nothing to do?
  if (size == 0L) return(x[integer(0)])

  ## Nothing to randomize?
  if (length(x) == 1L) {
    if (!replace && size > 1L) {
      stopf("Cannot take a sample (n = %d) larger than the population (m = %d) when 'replace = FALSE'", size, length(x))
    }
    return(rep(x, times = size))
  }
  
  oseed <- .GlobalEnv$.Random.seed
  on.exit({
    if (is.null(oseed)) {
      rm(list = ".Random.seed", envir = .GlobalEnv, inherits = FALSE)
    } else {
      .GlobalEnv$.Random.seed <- oseed
    }
  })

  ## Generate a psuedo-random random seed based on the current random
  ## state, current time, and the process ID
  time_offset <- format(Sys.time(), format = "%H%M%OS6") ## current time
  time_offset <- sub(".", "", time_offset, fixed = TRUE)
  time_offset <- strsplit(time_offset, split = "", fixed = TRUE)[[1]]
  time_offset <- sample(time_offset)  ## current RNG state
  time_offset <- paste(time_offset, collapse = "")
  time_offset <- as.numeric(time_offset)
  time_offset <- time_offset + Sys.getpid() ## process ID
  time_offset <- time_offset %% .Machine$integer.max
  set.seed(time_offset)

  sample(x, size = size, replace = replace, ...)
}
