# Gets the length of an object without dispatching

Gets the length of an object without dispatching

## Usage

``` r
.length(x)
```

## Arguments

- x:

  Any R object.

## Value

A non-negative integer.

## Details

This function returns `length(unclass(x))`, but tries to avoid calling
`unclass(x)` unless necessary.

## See also

[`.subset()`](https://rdrr.io/r/base/base-internal.html) and
[`.subset2()`](https://rdrr.io/r/base/base-internal.html).
