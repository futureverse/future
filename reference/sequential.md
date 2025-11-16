# Create a sequential future whose value will be in the current R session

*WARNING: This function must never be called. It may only be used with
[`plan()`](https://future.futureverse.org/reference/plan.md)*

## Usage

``` r
sequential(..., envir = parent.frame())
```

## Arguments

- envir:

  The [environment](https://rdrr.io/r/base/environment.html) from where
  global objects should be identified.

- ...:

  Not used.

## Details

A sequential future is a future that is evaluated sequentially in the
current R session similarly to how R expressions are evaluated in R. The
only difference to R itself is that globals are validated by default
just as for all other types of futures in this package.

This function is must *not* be called directly. Instead, the typical
usages are:

    # Evaluate futures sequentially in the current R process
    plan(sequential)

## Examples

``` r
## Use sequential futures
plan(sequential)

## A global variable
a <- 0

## Create a sequential future
f <- future({
  b <- 3
  c <- 2
  a * b * c
})

## Since 'a' is a global variable in future 'f' which
## is eagerly resolved (default), this global has already
## been resolved / incorporated, and any changes to 'a'
## at this point will _not_ affect the value of 'f'.
a <- 7
print(a)
#> [1] 7

v <- value(f)
print(v)
#> [1] 0
stopifnot(v == 0)
```
