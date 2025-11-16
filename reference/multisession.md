# Create a multisession future whose value will be resolved asynchronously in a parallel R session

*WARNING: This function must never be called. It may only be used with
[`plan()`](https://future.futureverse.org/reference/plan.md)*

## Usage

``` r
multisession(
  ...,
  workers = availableCores(constraints = "connections-16"),
  rscript_libs = .libPaths()
)
```

## Arguments

- workers:

  The number of parallel processes to use. If a function, it is called
  without arguments *when the future is created* and its value is used
  to configure the workers. If `workers == 1`, then all processing using
  done in the current/main R session and we therefore fall back to using
  a sequential future. To override this fallback, use `workers = I(1)`.

- rscript_libs:

  A character vector of R package library folders that the workers
  should use. The default is
  [`.libPaths()`](https://rdrr.io/r/base/libPaths.html) so that
  multisession workers inherits the same library path as the main R
  session. To avoid this, use
  `plan(multisession, ..., rscript_libs = NULL)`. *Important: Note that
  the library path is set on the workers when they are created, i.e.
  when `plan(multisession)` is called. Any changes to
  [`.libPaths()`](https://rdrr.io/r/base/libPaths.html) in the main R
  session after the workers have been created will have no effect.* This
  is passed down as-is to
  [`parallelly::makeClusterPSOCK()`](https://parallelly.futureverse.org/reference/makeClusterPSOCK.html).

- ...:

  Additional arguments passed to
  [`Future()`](https://future.futureverse.org/reference/Future-class.md).

## Value

A MultisessionFuture. If `workers == 1`, then all processing is done in
the current/main R session and we therefore fall back to using a lazy
future. To override this fallback, use `workers = I(1)`.

## Details

A multisession future is a future that uses multisession evaluation,
which means that its *value is computed and resolved in parallel in
another R session*.

This function is must *not* be called directly. Instead, the typical
usages are:

    # Evaluate futures in parallel on the local machine via as many background
    # processes as available to the current R process
    plan(multisession)

    # Evaluate futures in parallel on the local machine via two background
    # processes
    plan(multisession, workers = 2)

The background R sessions (the "workers") are created using
[`makeClusterPSOCK()`](https://future.futureverse.org/reference/re-exports.md).

For the total number of R sessions available including the current/main
R process, see
[`parallelly::availableCores()`](https://parallelly.futureverse.org/reference/availableCores.html).

A multisession future is a special type of cluster future.

## See also

For processing in multiple forked R sessions, see
[multicore](https://future.futureverse.org/reference/multicore.md)
futures.

Use
[`parallelly::availableCores()`](https://parallelly.futureverse.org/reference/availableCores.html)
to see the total number of cores that are available for the current R
session.

## Examples

``` r
# \donttest{

## Use multisession futures
plan(multisession)

## A global variable
a <- 0

## Create future (explicitly)
f <- future({
  b <- 3
  c <- 2
  a * b * c
})

## A multisession future is evaluated in a separate R session.
## Changing the value of a global variable will not affect
## the result of the future.
a <- 7
print(a)
#> [1] 7

v <- value(f)
print(v)
#> [1] 0
stopifnot(v == 0)

## Explicitly close multisession workers by switching plan
plan(sequential)
# }
```
