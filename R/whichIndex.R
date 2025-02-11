whichIndex <- function(I, dim, dimnames = NULL) {
  ndim <- length(dim)
  stop_if_not((is.matrix(I) || is.data.frame(I)), ncol(I) == ndim)
  if (!is.null(dimnames)) stop_if_not(length(dimnames) == ndim)
  if (ndim == 0L) return(integer(0L))

  if (is.data.frame(I)) {
    ## Convert each column to indices
    I2 <- array(NA_integer_, dim = dim(I))
    for (kk in 1:ndim) {
      idxs <- I[[kk]]
      if (is.numeric(idxs)) {
        if (any(idxs < 1 | idxs > dim[kk])) {
          stop("Index out of range")
        }
      } else {
        idxs <- as.character(idxs)
        idxs <- match(idxs, dimnames[[kk]])
        if (anyNA(idxs)) {
          unknown <- I[is.na(idxs), kk]
          stopf("Unknown indices: %s", hpaste(sQuote(unknown)))
        }
      }
      I2[, kk] <- idxs
    }
    I <- I2
    I2 <- NULL
  } else if (is.numeric(I)) {
    for (kk in 1:ndim) {
      idxs <- I[, kk]
      if (any(idxs < 1 | idxs > dim[kk])) {
        stop("Index out of range")
      }
    }
  } else {
    ## Convert dimnames to dimindices
    I2 <- array(NA_integer_, dim = dim(I))
    for (kk in 1:ndim) {
      ## Could be, say, factor
      idxs <- I[, kk]
      idxs <- as.character(idxs)
      idxs <- match(idxs, dimnames[[kk]])
      if (anyNA(idxs)) {
        unknown <- I[is.na(idxs), kk]
        stopf("Unknown indices: %s", hpaste(sQuote(unknown)))
      }
      I2[, kk] <- idxs
    }
    I <- I2
    I2 <- NULL
  }

  ## Nothing more to do?
  if (ndim == 1) return(I[, 1L])

  base <- cumprod(dim[-ndim])
  for (kk in 2:ndim) {
    I[, kk] <- (I[, kk] - 1) * base[kk - 1L]
  }
  rowSums(I)
}
