# Get the results of a resolved future

Get the results of a resolved future

## Usage

``` r
# S3 method for class 'Future'
result(future, ...)
```

## Arguments

- future:

  A [Future](https://future.futureverse.org/reference/Future-class.md).

- ...:

  Not used.

## Value

The
[FutureResult](https://future.futureverse.org/reference/FutureResult.md)
object. It may signal a
[FutureError](https://future.futureverse.org/reference/FutureCondition.md),
if there is a significant orchestration error. For example, if the
parallel worker process terminated abruptly ("crashed"), then a
[FutureInterruptError](https://future.futureverse.org/reference/FutureCondition.md)
is signaled.

## Details

This function is only part of the *backend* Future API. This function is
*not* part of the frontend Future API.
