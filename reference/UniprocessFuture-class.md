# An uniprocess future is a future whose value will be resolved synchronously in the current process

An uniprocess future is a future whose value will be resolved
synchronously in the current process

## Usage

``` r
UniprocessFuture(expr = NULL, substitute = TRUE, envir = parent.frame(), ...)
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

`UniprocessFuture()` returns an object of class `UniprocessFuture`.
