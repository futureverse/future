#' @tags utils-internal whichIndex

message("*** whichIndex() ...")

dims <- list(
  c(1),
  c(1, 1),
  c(2),
  c(2, 1),
  c(3, 4, 3)
)

for (dim in dims) {
  printf("Dimensions: (%s)\n", paste(dim, collapse = ", "))
  dimnames <- lapply(dim, FUN = function(n) letters[seq_len(n)])
  X <- array(seq_len(prod(dim)), dim = dim, dimnames = dimnames)
  print(X)

  idxs <- unique(round(seq(from = 1L, to = length(X), length.out = 5)))
  print(idxs)
  stopifnot(all(X[idxs] == idxs))

  ## (a) By matrix and dimindices
  I <- arrayInd(idxs, .dim = dim(X))
  print(I)
  idxs2 <- whichIndex(I, dim = dim(X))
  print(idxs2)
  stopifnot(all(idxs2 == idxs))

  ## (b) By matrix and dimnames
  N <- array(NA_character_, dim = dim(I))
  for (kk in seq_len(ncol(N))) {
    N[, kk] <- dimnames[[kk]][I[, kk]]
  }
  print(N)
  idxs3 <- whichIndex(N, dim = dim(X), dimnames = dimnames(X))
  print(idxs3)
  stopifnot(all(idxs3 == idxs))

  ## (b) By data.frame
  D <- as.data.frame(I)
  for (cc in seq(from = 1L, to = ncol(D))) D[[cc]] <- N[, cc]
  print(D)
  idxs4 <- whichIndex(D, dim = dim(X), dimnames = dimnames(X))
  print(idxs4)
  stopifnot(all(idxs4 == idxs))
}


## Exceptions
dim <- c(2, 3)
ndim <- length(dim)
dimnames <- lapply(dim, FUN = function(n) letters[seq_len(n)])

I <- matrix(c(1, 1, 2, 4), ncol = ndim)
res <- try(idxs <- whichIndex(I, dim = dim, dimnames = dimnames), silent = TRUE)
stopifnot(inherits(res, "try-error"))

I <- matrix(c(0, 0), ncol = ndim)
res <- try(idxs <- whichIndex(I, dim = dim, dimnames = dimnames), silent = TRUE)
stopifnot(inherits(res, "try-error"))

I <- matrix(c("a", "q"), ncol = ndim)
res <- try(idxs <- whichIndex(I, dim = dim, dimnames = dimnames), silent = TRUE)
stopifnot(inherits(res, "try-error"))

D <- data.frame(a = c(1, 1), b = c(2, 4))
res <- try(idxs <- whichIndex(D, dim = dim, dimnames = dimnames), silent = TRUE)
stopifnot(inherits(res, "try-error"))

D <- data.frame(a = c("a", "q"), b = c(1, 2), stringsAsFactors = FALSE)
res <- try(idxs <- whichIndex(D, dim = dim, dimnames = dimnames), silent = TRUE)
stopifnot(inherits(res, "try-error"))

message("*** whichIndex() ... DONE")

