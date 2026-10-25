# Cancel one or more futures

Cancels futures, with the option to interrupt running ones. A canceled
future is invalid, e.g. calling
[`value()`](https://future.futureverse.org/reference/value.md) on it
produces an error. `cancel()` is vectorized, i.e. accepts a set of
futures to be canceled.

## Usage

``` r
cancel(x, interrupt = TRUE, ...)
```

## Arguments

- x:

  A [Future](https://future.futureverse.org/reference/Future-class.md),
  a list, an environment, or a list environment
  ([listenv](https://listenv.futureverse.org/reference/listenv.html)).
  Lists and environments may hold a mix of futures and non-future
  elements, and may be nested, e.g. a list of lists of futures; every
  future found, at any depth, is canceled.

- interrupt:

  If TRUE, running futures are interrupted, if the future backend
  supports it.

- ...:

  All arguments used by the S3 methods.

## Value

`cancel()` returns (invisibly) `x` after canceling every
[Future](https://future.futureverse.org/reference/Future-class.md)
therein, that is, after flagging each one as "canceled" and possibly
interrupting it as well. If `x` is not a future, or holds non-futures,
such elements are unaffected.

## Details

A canceled future is invalid. Calling
[`value()`](https://future.futureverse.org/reference/value.md) on it
produces a
[FutureCanceledError](https://future.futureverse.org/reference/FutureCondition.md),
which inherits from
[FutureInterruptError](https://future.futureverse.org/reference/FutureCondition.md).
A
[FutureInterruptError](https://future.futureverse.org/reference/FutureCondition.md)
can happen also for external reasons. The cancelation error is signaled
regardless of:

- `interrupt`, that is, also when `interrupt = FALSE`, or when the
  future backend does not support interrupts;

- the state of the future, that is, if it is non-launched, running,
  finished;

- the future would have produced a value or an error or not.

If the future is not interrupted, its parallel worker keeps processing
it until it is done, when the result is collected and immediately
discarded.

To keep the value of a future that is already resolved, which still
canceling others, use something like `cancel(fs[!resolved(fs)])`.

Canceling an already canceled future, or an interrupted one has no
effect. Neither has canceling a future that was dropped using
`value(..., drop = TRUE)`.

## See also

A canceled future can be
[`reset()`](https://future.futureverse.org/reference/reset.md) to a
lazy, vanilla future such that it can be relaunched, possibly on another
future backend.

## Examples

``` r
## Set up two parallel workers
plan(multisession, workers = 2)

## Launch two long running futures
fs <- lapply(c(1, 2), function(duration) {
  future({
    Sys.sleep(duration)
    42
  })
})

## Wait until at least one of the futures is resolved
while (!any(resolved(fs))) Sys.sleep(0.1)

## Cancel futures that are not yet resolved
r <- resolved(fs)
cancel(fs[!r])

## Get the value of the resolved future
f <- fs[r]
v <- value(f)
message("Result: ", v)
#> Result: 42

## The value of the canceled future is an error
try(v <- value(fs[!r]))
#> Error : Future (<unnamed-3>) of class MultisessionFuture was canceled (pid 2308536) [future <unnamed-3> (4d54f2a08904c778e075e565cae604ca-3); on 4d54f2a08904c778e075e565cae604ca@hb-x1-2023<2308226> at 2026-10-25 14:52:52.333944]

## Shut down parallel workers
plan(sequential)
```
