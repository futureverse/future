# A representation of a set of globals used with futures

A representation of a set of globals used with futures

## Usage

``` r
FutureGlobals(object = list(), resolved = FALSE, total_size = NA_real_, ...)
```

## Arguments

- object:

  A named list.

- resolved:

  A logical indicating whether these globals have been scanned for and
  resolved futures or not.

- total_size:

  The total size of all globals, if known.

- ...:

  Not used.

## Value

An object of class `FutureGlobals`.

## Details

This class extends the
[Globals](https://globals.futureverse.org/reference/Globals.html) class
by adding attributes `resolved` and `total_size`.
