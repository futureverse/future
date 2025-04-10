#' Mandelbrot convergence counts
#'
#' @return Returns an integer matrix (of class Mandelbrot) with
#' non-negative counts.
#'
#' @examples
#' counts <- mandelbrot(xmid = -0.75, ymid = 0, side = 3)
#' str(counts)
#' \dontrun{
#' plot(counts)
#' }
#' 
#' \dontrun{
#' demo("mandelbrot", package = "future", ask = FALSE)
#' }
#'
#' @author The internal Mandelbrot algorithm was inspired by and
#' adopted from similar GPL code of Martin Maechler available
#' from ftp://stat.ethz.ch/U/maechler/R/ on 2005-02-18 (sic!).
#'
#' @aliases as.raster.Mandelbrot plot.Mandelbrot mandelbrot_tiles
#' @keywords internal
#'
#' @export
mandelbrot <- function(...) UseMethod("mandelbrot")


#' @param Z               A complex matrix for which convergence
#'                        counts should be calculated.
#'
#' @param maxIter         Maximum number of iterations per bin.
#'
#' @param tau             A threshold; the radius when calling
#'                        divergence (Mod(z) > tau).
#'
#' @param xmid,ymid,side,resolution Alternative specification of
#'                        the complex plane `Z`, where
#'                        `mean(Re(Z)) == xmid`,
#'                        `mean(Im(Z)) == ymid`,
#'                        `diff(range(Re(Z))) == side`,
#'                        `diff(range(Im(Z))) == side`, and
#'                        `dim(Z) == c(resolution, resolution)`.
#'
#' @rdname mandelbrot
#' @export
mandelbrot.matrix <- function(Z, maxIter = 200L, tau = 2.0, ...) {
  stop_if_not(is.matrix(Z), mode(Z) == "complex")

  ## By default, assume none of the elements will converge
  counts <- matrix(maxIter, nrow = nrow(Z), ncol = ncol(Z))

  ## But as a start, mark all be non-diverged
  idx_of_non_diverged <- seq_along(Z)

  ## SPEEDUP: The Mandelbrot sequence will only be calculated on the
  ## "remaining set" of complex numbers that yet hasn't diverged.
  sZ <- Z ## The Mandelbrot sequence of the "remaining" set
  Zr <- Z ## The original complex number of the "remaining" set

  for (ii in seq_len(maxIter - 1L)) {
    sZ <- sZ * sZ + Zr

    ## Did any of the "remaining" points diverge?
    diverged <- (Mod(sZ) > tau)
    if (any(diverged)) {
      ## Record at what iteration divergence occurred
      counts[idx_of_non_diverged[diverged]] <- ii

      ## Early stopping?
      keep <- which(!diverged)
      if (length(keep) == 0) break

      ## Drop from remain calculations
      idx_of_non_diverged <- idx_of_non_diverged[keep]

      ## Update the "remaining" set of complex numbers
      sZ <- sZ[keep]
      Zr <- Zr[keep]
    }
  }

  attr(counts, "params") <- list(Z = Z, maxIter = maxIter, tau = tau)

  class(counts) <- c("Mandelbrot", class(counts))
  
  counts
}


#' @param xmid,ymid,side,resolution Alternative specification of
#'                        the complex plane `Z`, where
#'                        `mean(Re(Z)) == xmid`,
#'                        `mean(Im(Z)) == ymid`,
#'                        `diff(range(Re(Z))) == side`,
#'                        `diff(range(Im(Z))) == side`, and
#'                        `dim(Z) == c(resolution, resolution)`.
#'
#' @param maxIter         Maximum number of iterations per bin.
#'
#' @param tau             A threshold; the radius when calling
#'                        divergence (Mod(z) > tau).
#'
#' @rdname mandelbrot
#' @export
mandelbrot.numeric <- function(xmid = -0.75, ymid = 0.0, side = 3.0,
                               resolution = 400L, maxIter = 200L,
                               tau = 2.0, ...) {
  ## Validate arguments
  stop_if_not(side > 0) 
  resolution <- as.integer(resolution)
  stop_if_not(resolution > 0)

  maxIter <- as.integer(maxIter)
  stop_if_not(maxIter > 0)

  ## The nx-by-ny bins
  nx <- ny <- resolution

  ## Setup (x, y) bins
  xrange <- xmid + c(-1, 1) * side / 2
  yrange <- ymid + c(-1, 1) * side / 2
  x <- seq(from = xrange[1], to = xrange[2], length.out = nx)
  y <- seq(from = yrange[1], to = yrange[2], length.out = ny)

  ## Set of complex numbers to be investigated
  Z <- outer(y, x, FUN = function(y, x) complex(real = x, imaginary = y))

  mandelbrot(Z, maxIter = maxIter, tau = tau)
}


#' @export
#' @importFrom grDevices as.raster hsv
#' @keywords internal
as.raster.Mandelbrot <- function(x, ...) {
  maxIter <- attr(x, "params", exact = TRUE)[["maxIter"]]
  img <- hsv(h = x / maxIter, s = 1, v = 1)
  img[x == maxIter] <- "#000000"
  dim(img) <- dim(x)
  img <- t(img)
  img <- structure(img, class = "raster")
  img
}


#' @export
#' @importFrom grDevices as.raster
#' @importFrom graphics par plot
#' @keywords internal
plot.Mandelbrot <- function(x, y, ..., mar = c(0, 0, 0, 0)) {
  if (!is.null(mar)) {
    opar <- par(mar = c(0, 0, 0, 0))
    on.exit(par(opar))
  }
  plot(as.raster(x), ...)
}


#' @export
mandelbrot_tiles <- function(xmid = -0.75, ymid = 0.0, side = 3.0,
                             nrow = 2L, ncol = nrow,
                             resolution = 400L, truncate = TRUE) {
  ## Validate arguments
  stop_if_not(side > 0)
  resolution <- as.integer(resolution)
  stop_if_not(resolution > 0)

  ## The nx-by-ny bins
  nx <- ny <- resolution

  ## Bins per tile
  dx <- ceiling(nx / ncol)
  dy <- ceiling(ny / nrow)
  stop_if_not(dx > 0, dy > 0)

  ## Truncate so all tiles have identical dimensions?
  if (truncate) {
    nx <- ncol * dx
    ny <- nrow * dy
  }

  ## Setup (x, y) bins
  xrange <- xmid + c(-1, 1) * side / 2
  yrange <- ymid + c(-1, 1) * side / 2
  x <- seq(from = xrange[1], to = xrange[2], length.out = nx)
  y <- seq(from = yrange[1], to = yrange[2], length.out = ny)


  ## Generate tiles row by row
  res <- list()
  for (rr in seq_len(nrow)) {
    yrr <- if (rr < nrow) y[1:dy] else y
    y <- y[-(1:dy)]

    xrr <- x
    for (cc in seq_len(ncol)) {
      xcc <- if (cc < ncol) xrr[1:dx] else xrr
      xrr <- xrr[-(1:dx)]

      Ccc <- outer(yrr, xcc, FUN = function(y, x) {
        complex(real = x, imaginary = y)
      })
      attr(Ccc, "region") <- list(xrange = range(xcc), yrange = range(yrr))
      attr(Ccc, "tile") <- c(rr, cc)
      res <- c(res, list(Ccc))
    }
  }
  dim(res) <- c(nrow, ncol)

  res
}
