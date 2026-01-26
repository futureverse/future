# Cancel a future

Cancels futures, with the option to interrupt running ones.

## Usage

``` r
cancel(x, interrupt = TRUE, ...)
```

## Arguments

- x:

  A Future.

- interrupt:

  If TRUE, running futures are interrupted, if the future backend
  supports it.

- ...:

  All arguments used by the S3 methods.

## Value

`cancel()` returns (invisibly) the canceled
[Future](https://future.futureverse.org/reference/Future-class.md)s
after flagging them as "canceled" and possibly interrupting them as
well.

Canceling a lazy or a finished future has no effect.

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

## Cancel the future that is not yet resolved
r <- resolved(fs)
cancel(fs[!r])

## Get the value of the resolved future
f <- fs[r]
v <- value(f)
message("Result: ", v)
#> Result: 42

## The value of the canceled future is an error
try(v <- value(fs[!r]))
#> Error : Future (<unnamed-3>) of class MultisessionFuture was canceled (pid 268119) [future <unnamed-3> (a6bb7de2250cf692f6e42fa4fa0e0c36-3); on a6bb7de2250cf692f6e42fa4fa0e0c36@hb-x1-2023<267764> at 2026-01-25 16:30:12.307337]

## Shut down parallel workers
plan(sequential)
```
