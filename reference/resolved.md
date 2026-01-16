# Check whether a future is resolved or not

Check whether a future is resolved or not

## Usage

``` r
# S3 method for class 'ClusterFuture'
resolved(x, timeout = NULL, ...)

# S3 method for class 'MulticoreFuture'
resolved(x, timeout = NULL, ...)

resolved(x, ...)

# Default S3 method
resolved(x, ...)

# S3 method for class 'list'
resolved(x, ...)

# S3 method for class 'environment'
resolved(x, ...)

# S3 method for class 'Future'
resolved(x, ...)
```

## Arguments

- x:

  A [Future](https://future.futureverse.org/reference/Future-class.md),
  a list, or an environment (which also includes [list
  environment](https://listenv.futureverse.org/reference/listenv.html)).

- timeout:

  (numeric) The maximum time (in seconds) for polling the worker for a
  response. If no response is available within this time limit, FALSE is
  returned assuming the future is still being processed. If NULL, the
  value defaults to `getOption("future.<type>.resolved.timeout")`, then
  `getOption("future.resolved.timeout")`, and finally 0.01 (seconds),
  where `<type>` corresponds to the type of future, e.g. `cluster` and
  `multicore`.

- ...:

  Not used.

## Value

A logical vector of the same length and dimensions as `x`. Each element
is TRUE unless the corresponding element is a non-resolved future in
case it is FALSE. It never signals an error.

The default method always returns TRUE.

## Details

`resolved()` attempts to launch a lazy future, if there is an available
worker, otherwise not.

`resolved()` methods must always return `TRUE` or `FALSE` values, must
always launch lazy futures, and must never block indefinitely. This is
because it should always be possible to poll futures until they are
resolved using `resolved()`, e.g.
`while (!all(resolved(futures))) Sys.sleep(5)`.

Each future backend must implement a `resolved()` method. It should
return either TRUE or FALSE, or throw a
[FutureError](https://future.futureverse.org/reference/FutureCondition.md)
(which indicates a significant, often unrecoverable infrastructure
problem, or an interrupt).

## Behavior of cluster and multisession futures

If all worker slots are occupied, `resolved()` for `ClusterFuture` and
`MultisessionFuture` will attempt to free one up by checking whether one
of the futures is *resolved*. If there is one, then its result is
collected in order to free up one worker slot.

`resolved()` for `ClusterFuture` may receive immediate condition
objects, rather than a
[FutureResult](https://future.futureverse.org/reference/FutureResult.md),
when polling the worker for results. In such cases, the condition object
is collected and another poll it performed. Up to 100 immediate
conditions may be collected this way per `resolved()` call, before
considering the future non-resolved and FALSE being returned.

## Behavior of multicore futures

`resolved()` for `MulticoreFuture` may receive immediate condition
objects, rather than a
[FutureResult](https://future.futureverse.org/reference/FutureResult.md),
when polling the worker for results. In such cases, *all* such condition
objects are collected, before considering the future non-resolved and
FALSE being returned.
