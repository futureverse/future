# Create a cluster future whose value will be resolved asynchronously in a parallel process

*WARNING: This function must never be called. It may only be used with
[`plan()`](https://future.futureverse.org/reference/plan.md)*

## Usage

``` r
cluster(
  ...,
  workers = availableWorkers(constraints = "connections"),
  persistent = FALSE
)
```

## Arguments

- workers:

  A [`cluster`](https://rdrr.io/r/parallel/makeCluster.html) object, a
  character vector of host names, a positive numeric scalar, or a
  function. If a character vector or a numeric scalar, a `cluster`
  object is created using
  [`makeClusterPSOCK`](https://parallelly.futureverse.org/reference/makeClusterPSOCK.html)`(workers)`.
  If a function, it is called without arguments *when the future is
  created* and its value is used to configure the workers. The function
  should return any of the above types. If `workers == 1`, then all
  processing using done in the current/main R session and we therefore
  fall back to using a sequential future. To override this fallback, use
  `workers = I(1)`.

- persistent:

  If FALSE, the evaluation environment is cleared from objects prior to
  the evaluation of the future.

- ...:

  Not used.

## Details

A cluster future is a future that uses cluster evaluation, which means
that its *value is computed and resolved in parallel in another
process*.

This function is must *not* be called directly. Instead, the typical
usages are:

    # Evaluate futures via a single background R process on the local machine
    plan(cluster, workers = I(1))

    # Evaluate futures via two background R processes on the local machine
    plan(cluster, workers = 2)

    # Evaluate futures via a single R process on another machine on on the
    # local area network (LAN)
    plan(cluster, workers = "raspberry-pi")

    # Evaluate futures via a single R process running on a remote machine
    plan(cluster, workers = "pi.example.org")

    # Evaluate futures via four R processes, one running on the local machine,
    # two running on LAN machine 'n1' and one on a remote machine
    plan(cluster, workers = c("localhost", "n1", "n1", "pi.example.org"))

## See also

For alternative future backends, see the 'A Future for R: Available
Future Backends' vignette and
<https://www.futureverse.org/backends.html>.

## Examples

``` r
# \donttest{

## Use cluster futures
cl <- parallel::makeCluster(2, timeout = 60)
plan(cluster, workers = cl)

## A global variable
a <- 0

## Create future (explicitly)
f <- future({
  b <- 3
  c <- 2
  a * b * c
})

## A cluster future is evaluated in a separate process.
## Regardless, changing the value of a global variable will
## not affect the result of the future.
a <- 7
print(a)
#> [1] 7

v <- value(f)
print(v)
#> [1] 0
stopifnot(v == 0)

## CLEANUP
parallel::stopCluster(cl)

# }
```
