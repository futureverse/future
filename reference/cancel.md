# Cancel one or more futures

Cancels futures, with the option to interrupt running ones. `cancel()`
is vectorized, i.e. accepts a collection of futures to be canceled.

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
interrupting it as well.

Canceling a lazy or a finished future has no effect. Elements of `x`
that are neither futures nor collections of futures are left untouched.

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
#> Error : Future (<unnamed-3>) of class MultisessionFuture was canceled (pid 364504) [future <unnamed-3> (97194439f4d4ad8cd977fe30c9424cc4-3); on 97194439f4d4ad8cd977fe30c9424cc4@hb-x1-2023<364180> at 2026-10-23 22:33:08.688139]

## Shut down parallel workers
plan(sequential)
```
