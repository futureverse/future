# Resolve one or more futures synchronously

This function provides an efficient mechanism for waiting for multiple
futures in a container (e.g. list or environment) to be resolved while
in the meanwhile retrieving values of already resolved futures.

## Usage

``` r
resolve(
  x,
  idxs = NULL,
  recursive = 0,
  result = FALSE,
  stdout = FALSE,
  signal = FALSE,
  force = FALSE,
  sleep = getOption("future.wait.interval", 0.01),
  ...
)
```

## Arguments

- x:

  A [Future](https://future.futureverse.org/reference/Future-class.md)
  to be resolved, or a list, an environment, or a list environment of
  futures to be resolved.

- idxs:

  (optional) integer or logical index specifying the subset of elements
  to check.

- recursive:

  A non-negative number specifying how deep of a recursion should be
  done. If TRUE, an infinite recursion is used. If FALSE or zero, no
  recursion is performed.

- result:

  (internal) If TRUE, the results are *retrieved*, otherwise not. Note
  that this only collects the results from the parallel worker, which
  can help lower the overall latency if there are multiple concurrent
  futures. This does *not* return the collected results.

- stdout:

  (internal) If TRUE, captured standard output is relayed, otherwise
  not.

- signal:

  (internal) If TRUE, captured
  [conditions](https://rdrr.io/r/base/conditions.html) are relayed,
  otherwise not.

- force:

  (internal) If TRUE, captured standard output and captured
  [conditions](https://rdrr.io/r/base/conditions.html) already relayed
  are relayed again, otherwise not.

- sleep:

  Number of seconds to wait before checking if futures have been
  resolved since last time.

- ...:

  Not used.

## Value

Returns `x` (regardless of subsetting or not). If `signal` is TRUE and
one of the futures produces an error, then that error is produced.

## Details

This function is resolves synchronously, i.e. it blocks until `x` and
any containing futures are resolved.

## See also

To resolve a future *variable*, first retrieve its
[Future](https://future.futureverse.org/reference/Future-class.md)
object using
[`futureOf()`](https://future.futureverse.org/reference/futureOf.md),
e.g. `resolve(futureOf(x))`.
