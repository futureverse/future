# Create a future

Creates a future that evaluates an R expression or a future that calls
an R function with a set of arguments. How, when, and where these
futures are evaluated can be configured using
[`plan()`](https://future.futureverse.org/reference/plan.md) such that
they are evaluated in parallel on, for instance, the current machine, on
a remote machine, or via a job queue on a compute cluster. Importantly,
any R code using futures remains the same regardless of these settings
and there is no need to modify the code when switching from, say,
sequential to parallel processing.

## Usage

``` r
future(
  expr,
  envir = parent.frame(),
  substitute = TRUE,
  lazy = FALSE,
  seed = FALSE,
  globals = TRUE,
  packages = NULL,
  stdout = TRUE,
  conditions = "condition",
  label = NULL,
  ...
)

futureCall(
  FUN,
  args = list(),
  envir = parent.frame(),
  lazy = FALSE,
  seed = FALSE,
  globals = TRUE,
  packages = NULL,
  stdout = TRUE,
  conditions = "condition",
  label = NULL,
  ...
)

minifuture(
  expr,
  substitute = TRUE,
  globals = NULL,
  packages = NULL,
  stdout = NA,
  conditions = NULL,
  seed = NULL,
  ...,
  envir = parent.frame()
)
```

## Arguments

- expr:

  An R [expression](https://rdrr.io/r/base/expression.html).

- envir:

  The [environment](https://rdrr.io/r/base/environment.html) from where
  global objects should be identified.

- substitute:

  If TRUE, argument `expr` is
  [`substitute()`](https://rdrr.io/r/base/substitute.html):d, otherwise
  not.

- lazy:

  If FALSE (default), the future is resolved eagerly (starting
  immediately), otherwise not.

- seed:

  (optional) If TRUE, the random seed, that is, the state of the random
  number generator (RNG) will be set such that statistically sound
  random numbers are produced (also during parallelization). If FALSE
  (default), it is assumed that the future expression neither needs nor
  uses random number generation. To use a fixed random seed, specify a
  L'Ecuyer-CMRG seed (seven integers) or a regular RNG seed (a single
  integer). If the latter, then a L'Ecuyer-CMRG seed will be
  automatically created based on the given seed. Furthermore, if FALSE,
  then the future will be monitored to make sure it does not use random
  numbers. If it does and depending on the value of option
  [future.rng.onMisuse](https://future.futureverse.org/reference/zzz-future.options.md),
  the check is ignored, an informative warning, or error will be
  produced. If `seed` is NULL, then the effect is as with `seed = FALSE`
  but without the RNG check being performed.

- globals:

  (optional) a logical, a character vector, or a named list to control
  how globals are handled. For details, see section 'Globals used by
  future expressions' in the help for `future()`.

- packages:

  (optional) a character vector specifying packages to be attached in
  the R environment evaluating the future.

- stdout:

  If TRUE (default), then the standard output is captured, and
  re-outputted when
  [`value()`](https://future.futureverse.org/reference/value.md) is
  called. If FALSE, any output is silenced (by sinking it to the null
  device as it is outputted). Using
  `stdout = structure(TRUE, drop = TRUE)` causes the captured standard
  output to be dropped from the future object as soon as it has been
  relayed. This can help decrease the overall memory consumed by
  captured output across futures. Using `stdout = NA` fully avoids
  intercepting the standard output; behavior of such unhandled standard
  output depends on the future backend.

- conditions:

  A character string of condition classes to be captured and relayed.
  The default is to relay all conditions, including messages and
  warnings. To drop all conditions, use `conditions = character(0)`.
  Errors are always relayed. Attribute `exclude` can be used to ignore
  specific classes, e.g.
  `conditions = structure("condition", exclude = "message")` will
  capture all `condition` classes except those that inherit from the
  `message` class. Using `conditions = structure(..., drop = TRUE)`
  causes any captured conditions to be dropped from the future object as
  soon as they have been relayed, e.g. by `value(f)`. This can help
  decrease the overall memory consumed by captured conditions across
  futures. Using `conditions = NULL` (not recommended) avoids
  intercepting conditions, except from errors; behavior of such
  unhandled conditions depends on the future backend and the environment
  from which R runs.

- label:

  A character string label attached to the future.

- FUN:

  A [function](https://rdrr.io/r/base/function.html) to be evaluated.

- args:

  A [list](https://rdrr.io/r/base/list.html) of arguments passed to
  function `FUN`.

- ...:

  Additional arguments passed to
  [`Future()`](https://future.futureverse.org/reference/Future-class.md).

## Value

`future()` returns
[Future](https://future.futureverse.org/reference/Future-class.md) that
evaluates expression `expr`.

`futureCall()` returns a
[Future](https://future.futureverse.org/reference/Future-class.md) that
calls function `FUN` with arguments `args`.

`minifuture(expr)` creates a future with minimal overhead, by disabling
user-friendly behaviors, e.g. automatic identification of global
variables and packages needed, and relaying of output. Unless you have
good reasons for using this function, please use `future()` instead.
This function exists mainly for the purpose of profiling and identifying
which automatic features of `future()` introduce extra overhead.

## Details

The state of a future is either unresolved or resolved. The value of a
future can be retrieved using
`v <- `[`value`](https://future.futureverse.org/reference/value.md)`(f)`.
Querying the value of a non-resolved future will *block* the call until
the future is resolved. It is possible to check whether a future is
resolved or not without blocking by using
[`resolved`](https://future.futureverse.org/reference/resolved.md)`(f)`.
It is possible to
[`cancel()`](https://future.futureverse.org/reference/cancel.md) a
future that is being resolved. Failed, canceled, and interrupted futures
can be [`reset()`](https://future.futureverse.org/reference/reset.md) to
a lazy, vanilla future that can be relaunched.

The `futureCall()` function works analogously to
[`do.call()`](https://rdrr.io/r/base/do.call.html), which calls a
function with a set of arguments. The difference is that
[`do.call()`](https://rdrr.io/r/base/do.call.html) returns the value of
the call whereas `futureCall()` returns a future.

## Eager or lazy evaluation

By default, a future is resolved using *eager* evaluation
(`lazy = FALSE`). This means that the expression starts to be evaluated
as soon as the future is created.

As an alternative, the future can be resolved using *lazy* evaluation
(`lazy = TRUE`). This means that the expression will only be evaluated
when the value of the future is requested. *Note that this means that
the expression may not be evaluated at all - it is guaranteed to be
evaluated if the value is requested*.

## Globals used by future expressions

Global objects (short *globals*) are objects (e.g. variables and
functions) that are needed in order for the future expression to be
evaluated while not being local objects that are defined by the future
expression. For example, in

      a <- 42
      f <- future({ b <- 2; a * b })

variable `a` is a global of future assignment `f` whereas `b` is a local
variable. In order for the future to be resolved successfully (and
correctly), all globals need to be gathered when the future is created
such that they are available whenever and wherever the future is
resolved.

The default behavior (`globals = TRUE`), is that globals are
automatically identified and gathered. More precisely, globals are
identified via code inspection of the future expression `expr` and their
values are retrieved with environment `envir` as the starting point
(basically via `get(global, envir = envir, inherits = TRUE)`). *In most
cases, such automatic collection of globals is sufficient and less
tedious and error prone than if they are manually specified*.

However, for full control, it is also possible to explicitly specify
exactly which globals are by providing their names as a character
vector. In the above example, we could use

      a <- 42
      f <- future({ b <- 2; a * b }, globals = "a")

Yet another alternative is to explicitly also specify their values using
a named list as in

      a <- 42
      f <- future({ b <- 2; a * b }, globals = list(a = a))

or

      f <- future({ b <- 2; a * b }, globals = list(a = 42))

Specifying globals explicitly avoids the overhead added from
automatically identifying the globals and gathering their values.
Furthermore, if we know that the future expression does not make use of
any global variables, we can disable the automatic search for globals by
using

      f <- future({ a <- 42; b <- 2; a * b }, globals = FALSE)

Future expressions often make use of functions from one or more
packages. As long as these functions are part of the set of globals, the
future package will make sure that those packages are attached when the
future is resolved. Because there is no need for such globals to be
frozen or exported, the future package will not export them, which
reduces the amount of transferred objects. For example, in

      x <- rnorm(1000)
      f <- future({ median(x) })

variable `x` and [`median()`](https://rdrr.io/r/stats/median.html) are
globals, but only `x` is exported whereas
[`median()`](https://rdrr.io/r/stats/median.html), which is part of the
stats package, is not exported. Instead it is made sure that the stats
package is on the search path when the future expression is evaluated.
Effectively, the above becomes

      x <- rnorm(1000)
      f <- future({
        library(stats)
        median(x)
      })

To manually specify this, one can either do

      x <- rnorm(1000)
      f <- future({
        median(x)
      }, globals = list(x = x, median = stats::median)

or

      x <- rnorm(1000)
      f <- future({
        library(stats)
        median(x)
      }, globals = list(x = x))

Both are effectively the same.

Although rarely needed, a combination of automatic identification and
manual specification of globals is supported via attributes `add` (to
add false negatives) and `ignore` (to ignore false positives) on value
`TRUE`. For example, with
`globals = structure(TRUE, ignore = "b", add = "a")` any globals
automatically identified, except `b`, will be used, in addition to
global `a`.

## See also

How, when, and where futures are resolved is determined by the *future
backend*, which can be set by the end user using the
[`plan()`](https://future.futureverse.org/reference/plan.md) function.

## Author

The future logo was designed by Dan LaBar and tweaked by Henrik
Bengtsson.

## Examples

``` r
## Evaluate futures in parallel
plan(multisession)

## Data
x <- rnorm(100)
y <- 2 * x + 0.2 + rnorm(100)
w <- 1 + x ^ 2


## EXAMPLE: Regular assignments (evaluated sequentially)
fitA <- lm(y ~ x, weights = w)      ## with offset
fitB <- lm(y ~ x - 1, weights = w)  ## without offset
fitC <- {
  w <- 1 + abs(x)  ## Different weights
  lm(y ~ x, weights = w)
}
print(fitA)
#> 
#> Call:
#> lm(formula = y ~ x, weights = w)
#> 
#> Coefficients:
#> (Intercept)            x  
#>       0.338        1.977  
#> 
print(fitB)
#> 
#> Call:
#> lm(formula = y ~ x - 1, weights = w)
#> 
#> Coefficients:
#>     x  
#> 1.993  
#> 
print(fitC)
#> 
#> Call:
#> lm(formula = y ~ x, weights = w)
#> 
#> Coefficients:
#> (Intercept)            x  
#>      0.3408       1.9513  
#> 


## EXAMPLE: Future assignments (evaluated in parallel)
fitA %<-% lm(y ~ x, weights = w)      ## with offset
fitB %<-% lm(y ~ x - 1, weights = w)  ## without offset
fitC %<-% {
  w <- 1 + abs(x)
  lm(y ~ x, weights = w)
}
print(fitA)
#> 
#> Call:
#> lm(formula = y ~ x, weights = w)
#> 
#> Coefficients:
#> (Intercept)            x  
#>      0.3408       1.9513  
#> 
print(fitB)
#> 
#> Call:
#> lm(formula = y ~ x - 1, weights = w)
#> 
#> Coefficients:
#>     x  
#> 1.971  
#> 
print(fitC)
#> 
#> Call:
#> lm(formula = y ~ x, weights = w)
#> 
#> Coefficients:
#> (Intercept)            x  
#>      0.3408       1.9513  
#> 


## EXAMPLE: Explicitly create futures (evaluated in parallel)
## and retrieve their values
fA <- future( lm(y ~ x, weights = w) )
fB <- future( lm(y ~ x - 1, weights = w) )
fC <- future({
  w <- 1 + abs(x)
  lm(y ~ x, weights = w)
})
fitA <- value(fA)
fitB <- value(fB)
fitC <- value(fC)
print(fitA)
#> 
#> Call:
#> lm(formula = y ~ x, weights = w)
#> 
#> Coefficients:
#> (Intercept)            x  
#>      0.3408       1.9513  
#> 
print(fitB)
#> 
#> Call:
#> lm(formula = y ~ x - 1, weights = w)
#> 
#> Coefficients:
#>     x  
#> 1.971  
#> 
print(fitC)
#> 
#> Call:
#> lm(formula = y ~ x, weights = w)
#> 
#> Coefficients:
#> (Intercept)            x  
#>      0.3408       1.9513  
#> 

## EXAMPLE: futureCall() and do.call()
x <- 1:100
y0 <- do.call(sum, args = list(x))
print(y0)
#> [1] 5050

f1 <- futureCall(sum, args = list(x))
y1 <- value(f1)
print(y1)
#> [1] 5050
```
