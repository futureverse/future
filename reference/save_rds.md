# Robustly Saves an Object to RDS File Atomically

Robustly Saves an Object to RDS File Atomically

## Usage

``` r
save_rds(object, pathname, ...)
```

## Arguments

- object:

  The R object to be save.

- pathname:

  RDS file to written.

- ...:

  (optional) Additional arguments passed to
  [`base::saveRDS()`](https://rdrr.io/r/base/readRDS.html).

## Value

The pathname of the RDS written.

## Details

Uses [base::saveRDS](https://rdrr.io/r/base/readRDS.html) internally but
writes the object atomically by first writing to a temporary file which
is then renamed.
