# Create a multicore future whose value will be resolved asynchronously in a forked parallel process

*WARNING: This function must never be called. It may only be used with
[`plan()`](https://future.futureverse.org/reference/plan.md)*

## Usage

``` r
multicore(..., workers = availableCores(constraints = "multicore"))
```

## Arguments

- workers:

  The number of parallel processes to use. If a function, it is called
  without arguments *when the future is created* and its value is used
  to configure the workers. If `workers == 1`, then all processing using
  done in the current/main R session and we therefore fall back to using
  a sequential future. To override this fallback, use `workers = I(1)`.

- ...:

  Not used.

## Details

A multicore future is a future that uses multicore evaluation, which
means that its *value is computed and resolved in parallel in another
process*.

This function is must *not* be called directly. Instead, the typical
usages are:

    # Evaluate futures in parallel on the local machine via as many forked
    # processes as available to the current R process
    plan(multicore)

    # Evaluate futures in parallel on the local machine via two forked processes
    plan(multicore, workers = 2)

## Support for forked ("multicore") processing

Not all operating systems support process forking and thereby not
multicore futures. For instance, forking is not supported on Microsoft
Windows. Moreover, process forking may break some R environments such as
RStudio. Because of this, the future package disables process forking
also in such cases. See
[`parallelly::supportsMulticore()`](https://parallelly.futureverse.org/reference/supportsMulticore.html)
for details. Trying to create multicore futures on non-supported systems
or when forking is disabled will result in multicore futures falling
back to becoming
[sequential](https://future.futureverse.org/reference/sequential.md)
futures. If used in RStudio, there will be an informative warning:

    > plan(multicore)
    Warning message:
    In supportsMulticoreAndRStudio(...) :
      [ONE-TIME WARNING] Forked processing ('multicore') is not supported when
    running R from RStudio because it is considered unstable. For more details,
    how to control forked processing or not, and how to silence this warning in
    future R sessions, see ?parallelly::supportsMulticore

## See also

For processing in multiple background R sessions, see
[multisession](https://future.futureverse.org/reference/multisession.md)
futures.

For alternative future backends, see the 'A Future for R: Available
Future Backends' vignette and
<https://www.futureverse.org/backends.html>.

Use
[`parallelly::availableCores()`](https://parallelly.futureverse.org/reference/availableCores.html)
to see the total number of cores that are available for the current R
session. Use
[`availableCores`](https://parallelly.futureverse.org/reference/availableCores.html)`("multicore") > 1L`
to check whether multicore futures are supported or not on the current
system.

## Examples

``` r
## Use multicore futures
plan(multicore)

## A global variable
a <- 0

## Create future (explicitly)
f <- future({
  b <- 3
  c <- 2
  a * b * c
})

## A multicore future is evaluated in a separate forked
## process.  Changing the value of a global variable
## will not affect the result of the future.
a <- 7
print(a)
#> [1] 7

v <- value(f)
print(v)
#> [1] 0
stopifnot(v == 0)
```
