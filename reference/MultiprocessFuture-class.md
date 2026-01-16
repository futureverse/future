# A multiprocess future is a future whose value will be resolved asynchronously in a parallel process

A multiprocess future is a future whose value will be resolved
asynchronously in a parallel process

## Usage

``` r
MultiprocessFuture(expr = NULL, substitute = TRUE, envir = parent.frame(), ...)
```

## Arguments

- expr:

  An R [expression](https://rdrr.io/r/base/expression.html).

- substitute:

  If TRUE, argument `expr` is
  [`substitute()`](https://rdrr.io/r/base/substitute.html):d, otherwise
  not.

- envir:

  The [environment](https://rdrr.io/r/base/environment.html) from where
  global objects should be identified.

- ...:

  Additional named elements passed to
  [`Future()`](https://future.futureverse.org/reference/Future-class.md).

## Value

`MultiprocessFuture()` returns an object of class `MultiprocessFuture`.
