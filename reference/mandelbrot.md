# Mandelbrot convergence counts

Mandelbrot convergence counts

## Usage

``` r
mandelbrot(...)

# S3 method for class 'matrix'
mandelbrot(Z, maxIter = 200L, tau = 2, ...)

# S3 method for class 'numeric'
mandelbrot(
  xmid = -0.75,
  ymid = 0,
  side = 3,
  resolution = 400L,
  maxIter = 200L,
  tau = 2,
  ...
)
```

## Arguments

- Z:

  A complex matrix for which convergence counts should be calculated.

- maxIter:

  Maximum number of iterations per bin.

- tau:

  A threshold; the radius when calling divergence (Mod(z) \> tau).

- xmid, ymid, side, resolution:

  Alternative specification of the complex plane `Z`, where
  `mean(Re(Z)) == xmid`, `mean(Im(Z)) == ymid`,
  `diff(range(Re(Z))) == side`, `diff(range(Im(Z))) == side`, and
  `dim(Z) == c(resolution, resolution)`.

## Value

Returns an integer matrix (of class Mandelbrot) with non-negative
counts.

## Author

The internal Mandelbrot algorithm was inspired by and adopted from
similar GPL code of Martin Maechler available from
ftp://stat.ethz.ch/U/maechler/R/ on 2005-02-18 (sic!).

## Examples

``` r
counts <- mandelbrot(xmid = -0.75, ymid = 0, side = 3)
str(counts)
#>  'Mandelbrot' int [1:400, 1:400] 1 1 1 1 1 1 1 1 1 1 ...
#>  - attr(*, "params")=List of 3
#>   ..$ Z      : cplx [1:400, 1:400] -2.25-1.5i -2.25-1.49i -2.25-1.48i ...
#>   ..$ maxIter: int 200
#>   ..$ tau    : num 2
if (FALSE) { # \dontrun{
plot(counts)
} # }

if (FALSE) { # \dontrun{
demo("mandelbrot", package = "future", ask = FALSE)
} # }
```
