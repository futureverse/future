# Get all futures in a container

Gets all futures in an environment, a list, or a list environment and
returns an object of the same class (and dimensions). Non-future
elements are returned as is.

## Usage

``` r
futures(x, ...)
```

## Arguments

- x:

  An environment, a list, or a list environment.

- ...:

  Not used.

## Value

An object of same type as `x` and with the same names and/or dimensions,
if set.

## Details

This function is useful for retrieve futures that were created via
future assignments (`%<-%`) and therefore stored as promises. This
function turns such promises into standard `Future` objects.
