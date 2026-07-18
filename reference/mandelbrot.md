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

  A complex matrix (\\Z\\) for which convergence counts (\\C\\) should
  be calculated.

- maxIter:

  Maximum number of iterations (\\c^{max}\\) per bin.

- tau:

  A threshold (\\\tau\\); the radius when calling divergence
  (\\\|z\_{i}\| \> \tau\\).

- xmid, ymid, side, resolution:

  Alternative specification of the complex plane `Z`, where
  `mean(Re(Z)) == xmid`, `mean(Im(Z)) == ymid`,
  `diff(range(Re(Z))) == side`, `diff(range(Im(Z))) == side`, and
  `dim(Z) == c(resolution, resolution)`.

## Value

Returns an integer matrix (of class Mandelbrot) with non-negative counts
(\\C\\).

## Escape time algorithm

The convergence counts are calculated using the standard escape-time
algorithm for the Mandelbrot set: for each complex number \\c\\, the
sequence \\z\_{i+1} \leftarrow z\_{i}^2 + c\\ (starting at \\z\_{0} =
c\\) is iterated until either its modulus (\\\|z\_{i}\|\\) exceeds the
escape radius \\\tau\\ (`tau`) or the maximum number of iterations
(\\c^{max}\\) has been reached. The count (\\c\_{i}\\) recorded is the
iteration at which the sequence escaped, or \\c^{max}\\ for points that
never escaped.

## References

Mandelbrot set, <https://en.wikipedia.org/wiki/Mandelbrot_set>, 2026

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
