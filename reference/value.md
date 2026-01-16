# The value of a future or the values of all elements in a container

Gets the value of a future or the values of all elements (including
futures) in a container such as a list, an environment, or a list
environment. If one or more futures are unresolved, then this function
blocks until all queried futures are resolved.

## Usage

``` r
value(...)

# S3 method for class 'Future'
value(future, stdout = TRUE, signal = TRUE, drop = FALSE, ...)

# S3 method for class 'list'
value(
  x,
  idxs = NULL,
  recursive = 0,
  reduce = NULL,
  stdout = TRUE,
  signal = TRUE,
  cancel = TRUE,
  interrupt = cancel,
  inorder = TRUE,
  drop = FALSE,
  force = TRUE,
  sleep = getOption("future.wait.interval", 0.01),
  ...
)

# S3 method for class 'listenv'
value(
  x,
  idxs = NULL,
  recursive = 0,
  reduce = NULL,
  stdout = TRUE,
  signal = TRUE,
  cancel = TRUE,
  interrupt = cancel,
  inorder = TRUE,
  drop = FALSE,
  force = TRUE,
  sleep = getOption("future.wait.interval", 0.01),
  ...
)

# S3 method for class 'environment'
value(x, ...)
```

## Arguments

- future, x:

  A [Future](https://future.futureverse.org/reference/Future-class.md),
  an environment, a list, or a list environment.

- stdout:

  If TRUE, standard output captured while resolving futures is relayed,
  otherwise not.

- signal:

  If TRUE, [conditions](https://rdrr.io/r/base/conditions.html) captured
  while resolving futures are relayed, otherwise not.

- drop:

  If TRUE, resolved futures are minimized in size and invalidated as
  soon as their values have been collected and any output and conditions
  have been relayed. Combining `drop = TRUE` with `inorder = FALSE`
  reduces the memory use sooner, especially avoiding the risk of holding
  on to future values until the very end.

- idxs:

  (optional) integer or logical index specifying the subset of elements
  to check.

- recursive:

  A non-negative number specifying how deep of a recursion should be
  done. If TRUE, an infinite recursion is used. If FALSE or zero, no
  recursion is performed.

- reduce:

  An optional function for reducing all the values. Optional attribute
  `init` can be used to set initial value for the reduction. If not
  specified, the first value will be used as the initial value.
  Reduction of values is done as soon as possible, but always in the
  same order as `x`, unless `inorder` is FALSE.

- cancel, interrupt:

  If TRUE and `signal` is TRUE, non-resolved futures are canceled as
  soon as an error is detected in one of the futures, before signaling
  the error. Argument `interrupt` is passed to
  [`cancel()`](https://future.futureverse.org/reference/cancel.md)
  controlling whether non-resolved futures should also be interrupted.

- inorder:

  If TRUE, then standard output and conditions are relayed, and value
  reduction is done in the order the futures occur in `x`, but always as
  soon as possible. This is achieved by buffering the details until they
  can be released. By setting `inorder = FALSE`, no buffering takes
  place and everything is relayed and reduced as soon as a new future is
  resolved. Regardless, the values are always returned in the same order
  as `x`.

- force:

  (internal) If TRUE, captured standard output and captured
  [conditions](https://rdrr.io/r/base/conditions.html) already relayed
  are relayed again, otherwise not.

- sleep:

  Number of seconds to wait before checking if futures have been
  resolved since last time.

- ...:

  All arguments used by the S3 methods.

## Value

`value()` of a Future object returns the value of the future, which can
be any type of R object.

`value()` of a list, an environment, or a list environment returns an
object with the same number of elements and of the same class. Names and
dimension attributes are preserved, if available. All future elements
are replaced by their corresponding `value()` values. For all other
elements, the existing object is kept as-is.

If `signal` is TRUE and one of the futures produces an error, then that
error is relayed. Any remaining, non-resolved futures in `x` are
canceled, prior to signaling such an error. If the future was
interrupted, canceled, or the parallel worker terminated abruptly
("crashed"), then a
[FutureInterruptError](https://future.futureverse.org/reference/FutureCondition.md)
is signaled.

## Examples

``` r
## ------------------------------------------------------
## A single future
## ------------------------------------------------------
x <- sample(100, size = 50)
f <- future(mean(x))
v <- value(f)
message("The average of 50 random numbers in [1,100] is: ", v)
#> The average of 50 random numbers in [1,100] is: 49.58



## ------------------------------------------------------
## Ten futures
## ------------------------------------------------------
xs <- replicate(10, { list(sample(100, size = 50)) })
fs <- lapply(xs, function(x) { future(mean(x)) })

## The 10 values as a list (because 'fs' is a list)
vs <- value(fs)
message("The ten averages are:")
#> The ten averages are:
str(vs)
#> List of 10
#>  $ : num 52.1
#>  $ : num 50.8
#>  $ : num 48
#>  $ : num 52.8
#>  $ : num 50.9
#>  $ : num 49.1
#>  $ : num 51.1
#>  $ : num 51.1
#>  $ : num 48.1
#>  $ : num 47.1

## The 10 values as a vector (by manually unlisting)
vs <- value(fs)
vs <- unlist(vs)
message("The ten averages are: ", paste(vs, collapse = ", "))
#> The ten averages are: 52.1, 50.76, 48.02, 52.82, 50.9, 49.06, 51.08, 51.06, 48.08, 47.1

## The values as a vector (by reducing)
vs <- value(fs, reduce = c)
message("The ten averages are: ", paste(vs, collapse = ", "))
#> The ten averages are: 52.1, 50.76, 48.02, 52.82, 50.9, 49.06, 51.08, 51.06, 48.08, 47.1

## Calculate the sum of the averages (by reducing)
total <- value(fs, reduce = `+`)
message("The sum of the ten averages is: ", total)
#> The sum of the ten averages is: 500.98
```
