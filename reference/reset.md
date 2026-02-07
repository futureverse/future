# Reset a finished, failed, canceled, or interrupted future to a lazy future

A future that has successfully completed, was
[canceled](https://future.futureverse.org/reference/cancel.md) or
interrupted, or has failed due to an error, can be relaunched after
resetting it.

## Usage

``` r
reset(x, ...)
```

## Arguments

- x:

  A Future.

- ...:

  Not used.

## Value

`reset()` returns a lazy, vanilla
[Future](https://future.futureverse.org/reference/Future-class.md) that
can be relaunched. Resetting a running future results in a
[FutureError](https://future.futureverse.org/reference/FutureCondition.md).

## Details

A lazy, vanilla
[Future](https://future.futureverse.org/reference/Future-class.md) can
be reused in another R session. For instance, if we do:

    library(future)
    a <- 2
    f <- future(42 * a, lazy = TRUE)
    saveRDS(f, "myfuture.rds")

Then we can read and evaluate the future in another R session using:

    library(future)
    f <- readRDS("myfuture.rds")
    v <- value(f)
    print(v)
    #> [1] 84

## Examples

``` r
## Like mean(), but fails 90% of the time
shaky_mean <- function(x) {
  if (as.double(Sys.time()) %% 1 < 0.90) stop("boom")
  mean(x)
}

x <- rnorm(100)

## Calculate the mean of 'x' with a risk of failing randomly
f <- future({ shaky_mean(x) })

## Relaunch until success
repeat({
  v <- tryCatch(value(f), error = identity)
  if (!inherits(v, "error")) break
  message("Resetting failed future, and retry in 0.1 seconds")
  f <- reset(f)
  Sys.sleep(0.1)
})
#> Resetting failed future, and retry in 0.1 seconds
#> Resetting failed future, and retry in 0.1 seconds
#> Resetting failed future, and retry in 0.1 seconds
#> Resetting failed future, and retry in 0.1 seconds
#> Resetting failed future, and retry in 0.1 seconds
#> Resetting failed future, and retry in 0.1 seconds
#> Resetting failed future, and retry in 0.1 seconds
cat("mean:", v, "\n")
#> mean: 0.03014631 
```
