# Run a future

Run a future

## Usage

``` r
# S3 method for class 'Future'
run(future, ...)
```

## Arguments

- future:

  A [Future](https://future.futureverse.org/reference/Future-class.md).

- ...:

  Not used.

## Value

The [Future](https://future.futureverse.org/reference/Future-class.md)
object.

## Details

This function can only be called once per future. Further calls will
result in an informative error. If a future is not run when its value is
queried, then it is run at that point.
