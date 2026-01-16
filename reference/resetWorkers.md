# Free up active background workers

Free up active background workers

## Usage

``` r
resetWorkers(x, ...)
```

## Arguments

- x:

  A FutureStrategy.

- ...:

  Not used.

## Details

This function will resolve any active futures that are currently being
evaluated on background workers.

## Examples

``` r
resetWorkers(plan())
```
