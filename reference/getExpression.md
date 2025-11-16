# Inject code for the next type of future to use for nested futures

Inject code for the next type of future to use for nested futures

## Usage

``` r
getExpression(future, ...)
```

## Arguments

- future:

  Current future.

- ...:

  Not used.

## Value

A future expression with code injected to set what type of future to use
for nested futures, iff any.

## Details

If there is no future backend specified after this one, the default is
to use
[sequential](https://future.futureverse.org/reference/sequential.md)
futures. This conservative approach protects against spawning off
recursive futures by mistake, especially
[multicore](https://future.futureverse.org/reference/multicore.md) and
[multisession](https://future.futureverse.org/reference/multisession.md)
ones. The default will also set `options(mc.cores = 1L)` (\*) so that no
parallel R processes are spawned off by functions such as
[`parallel::mclapply()`](https://rdrr.io/r/parallel/mclapply.html) and
friends.

Currently it is not possible to specify what type of nested futures to
be used, meaning the above default will always be used. See [Issue
\#37](https://github.com/futureverse/future/issues/37) for plans on
adding support for custom nested future types.

(\*) Ideally we would set `mc.cores = 0` but that will unfortunately
cause `mclapply()` and friends to generate an error saying "'mc.cores'
must be \>= 1". Ideally those functions should fall back to using the
non-multicore alternative in this case, e.g. `mclapply(...)` =\>
`lapply(...)`. See
<https://github.com/HenrikBengtsson/Wishlist-for-R/issues/7> for a
discussion on this.
