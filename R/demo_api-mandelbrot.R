#' Mandelbrot convergence counts
#'
#' @return Returns an integer matrix (of class Mandelbrot) with
#' non-negative counts (\eqn{C}).
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
#' @references
#' Mandelbrot set, \url{https://en.wikipedia.org/wiki/Mandelbrot_set}, 2026
#' 
#' @aliases as.raster.Mandelbrot plot.Mandelbrot mandelbrot_tiles
#' @keywords internal
#'
#' @export
mandelbrot <- function(...) UseMethod("mandelbrot")


#' @param Z               A complex matrix (\eqn{Z}) for which convergence
#'                        counts (\eqn{C})) should be calculated.
#'
#' @param maxIter         Maximum number of iterations (\eqn{c^{max}}) per bin.
#'
#' @param tau             A threshold (\eqn{\tau}); the radius when calling
#'                        divergence (\eqn{|z_{i}| > \tau}).
#'
#' @section Escape time algorithm:
#' The convergence counts are calculated using the standard escape-time
#' algorithm for the Mandelbrot set: for each complex number \eqn{c}, the
#' sequence \eqn{z_{i+1} \leftarrow z_{i}^2 + c} (starting at \eqn{z_{0} = c})
#' is iterated until either its modulus (\eqn{|z_{i}|}) exceeds the escape
#' radius \eqn{\tau} (`tau`) or the maximum number of iterations (\eqn{c^{max}})
#' have been reached. The count (\eqn{c_{i}}) recorded is the iteration at which
#' the sequence escaped, or \eqn{c^{max}} for points that never escaped.
#'
#' @rdname mandelbrot
#' @export
mandelbrot.matrix <- function(Z, maxIter = 200L, tau = 2.0, ...) {
  stop_if_not(
    is.matrix(Z), mode(Z) == "complex",
    is.numeric(maxIter), is.finite(maxIter), maxIter >= 1,
    is.numeric(tau), is.finite(tau), tau > 0
  )
  maxIter <- as.integer(maxIter)

  params <- list(Z = Z, maxIter = maxIter, tau = tau)
  
  ## Escape-time algorithm. Points that never escape keep the count 'maxIter'
  counts <- matrix(maxIter, nrow = nrow(Z), ncol = ncol(Z))

  ## For efficiency, iterate only over the points that have not yet escaped.
  ## 'active' holds the linear indices of those points in 'Z'/'counts'.
  active <- seq_along(Z)
  C <- Z     # the constant 'c' for each still-active point
  for (ii in seq_len(maxIter - 1L)) {
    Z <- Z*Z + C

    ## Points whose modulus now exceeds the escape radius have diverged
    escaped <- (Mod(Z) > tau)
    if (any(escaped)) {
      counts[active[escaped]] <- ii
      if (all(escaped)) break
      active <- active[!escaped]
      Z <- Z[!escaped]
      C <- C[!escaped]
    }
  }

  attr(counts, "params") <- params

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
