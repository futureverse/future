# Create a future assignment

`x %<-% value` (also known as a "future assignment") and
`futureAssign("x", value)` create a
[Future](https://future.futureverse.org/reference/Future-class.md) that
evaluates the expression (`value`) and binds it to variable `x` (as a
[promise](https://rdrr.io/r/base/delayedAssign.html)). The expression is
evaluated in parallel in the background. Later on, when `x` is first
queried, the value of the future is automatically retrieved as if it
were a regular variable and `x` is materialized as a regular value.

## Usage

``` r
futureAssign(
  x,
  value,
  envir = parent.frame(),
  substitute = TRUE,
  lazy = FALSE,
  seed = FALSE,
  globals = TRUE,
  packages = NULL,
  stdout = TRUE,
  conditions = "condition",
  label = NULL,
  ...,
  assign.env = envir
)

x %<-% value

fassignment %globals% globals
fassignment %packages% packages

fassignment %seed% seed

fassignment %stdout% capture

fassignment %conditions% capture

fassignment %lazy% lazy

fassignment %label% label

fassignment %plan% strategy

fassignment %tweak% tweaks
```

## Arguments

- x:

  the name of a future variable, which will hold the value of the future
  expression (as a promise).

- value:

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
  future expressions' in the help for
  [`future()`](https://future.futureverse.org/reference/future.md).

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

- assign.env:

  The [environment](https://rdrr.io/r/base/environment.html) to which
  the variable should be assigned.

- fassignment:

  The future assignment, e.g. `x %<-% { expr }`.

- capture:

  If TRUE, the standard output will be captured, otherwise not.

- strategy:

  The backend controlling how the future is resolved. See
  [`plan()`](https://future.futureverse.org/reference/plan.md) for
  further details.

- tweaks:

  A named list (or vector) with arguments that should be changed
  relative to the current backend.

- ...:

  Additional arguments passed to
  [`Future()`](https://future.futureverse.org/reference/Future-class.md).

## Value

`futureAssign()` and `x %<-% expr` returns the
[Future](https://future.futureverse.org/reference/Future-class.md)
invisibly, e.g. `f <- futureAssign("x", expr)` and `f <- (x %<-% expr)`.

## Details

For a future created via a future assignment, `x %<-% value` or
`futureAssign("x", value)`, the value is bound to a promise, which when
queried will internally call
[`value()`](https://future.futureverse.org/reference/value.md) on the
future and which will then be resolved into a regular variable bound to
that value. For example, with future assignment `x %<-% value`, the
first time variable `x` is queried the call blocks if, and only if, the
future is not yet resolved. As soon as it is resolved, and any
succeeding queries, querying `x` will immediately give the value.

The future assignment construct `x %<-% value` is not a formal
assignment per se, but a binary infix operator on objects `x` and
expression `value`. However, by using non-standard evaluation, this
construct can emulate an assignment operator similar to `x <- value`.
Due to R's precedence rules of operators, future expressions often need
to be explicitly bracketed, e.g. `x %<-% { a + b }`.

## Adjust future arguments of a future assignment

[`future()`](https://future.futureverse.org/reference/future.md) and
`futureAssign()` take several arguments that can be used to explicitly
specify what global variables and packages the future should use. They
can also be used to override default behaviors of the future, e.g.
whether output should be relayed or not. When using a future assignment,
these arguments can be specified via corresponding assignment
expression. For example, `x %<-% { rnorm(10) } %seed% TRUE` corresponds
to `futureAssign("x", { rnorm(10) }, seed = TRUE)`. Here are several
examples.

To explicitly specify variables and functions that a future assignment
should use, use `%globals%`. To explicitly specify which packages need
to be attached for the evaluation to succeed, use `%packages%`. For
example,

    > x <- rnorm(1000)
    > y %<-% { median(x) } %globals% list(x = x) %packages% "stats"
    > y
    [1] -0.03956372

The [`median()`](https://rdrr.io/r/stats/median.html) function is part
of the 'stats' package.

To declare that you will generate random numbers, use `%seed%`, e.g.

    > x %<-% { rnorm(3) } %seed% TRUE
    > x
    [1] -0.2590562 -1.2262495  0.8858702

To disable relaying of standard output (e.g.
[`print()`](https://rdrr.io/r/base/print.html),
[`cat()`](https://rdrr.io/r/base/cat.html), and
[`str()`](https://rdrr.io/r/utils/str.html)), while keeping relaying of
conditions (e.g. [`message()`](https://rdrr.io/r/base/message.html) and

    > x %<-% { cat("Hello\n"); message("Hi there"); 42 } %stdout% FALSE
    > y <- 13
    > z <- x + y
    Hi there
    > z
    [1] 55

To disable relaying of conditions, use `%conditions%`, e.g.

    > x %<-% { cat("Hello\n"); message("Hi there"); 42 } %conditions% character(0)
    > y <- 13
    > z <- x + y
    Hello
    > z
    [1] 55

    > x %<-% { print(1:10); message("Hello"); 42 } %stdout% FALSE
    > y <- 13
    > z <- x + y
    Hello
    > z
    [1] 55

To create a future without launching it such that it will only be
processed if the value is really needed, use `%lazy%`, e.g.

    > x %<-% { Sys.sleep(5); 42 } %lazy% TRUE
    > y <- sum(1:10)
    > system.time(z <- x + y)
      user  system elapsed
      0.004   0.000   5.008
    > z
    [1] 97

## Error handling

Because future assignments are promises, errors produced by the future
expression will not be signaled until the value of the future is
requested. For example, if you create a future assignment that produces
an error, you will not be affected by the error until you "touch" the
future-assignment variable. For example,

    > x %<-% { stop("boom") }
    > y <- sum(1:10)
    > z <- x + y
    Error in eval(quote({ : boom

## Use alternative future backend for future assignment

Futures are evaluated on the future backend that the user has specified
by [`plan()`](https://future.futureverse.org/reference/plan.md). With
regular futures, we can temporarily use another future backend by
wrapping our code in `with(plan(...), { ... })`, or temporarily inside a
function using `with(plan(...), local = TRUE)`. To achieve the same for
a specific future assignment, use `%plan%`, e.g.

    > plan(multisession)
    > x %<-% { 42 }
    > y %<-% { 13 } %plan% sequential
    > z <- x + y
    > z
    [1] 55

Here `x` is resolved in the background via the
[multisession](https://future.futureverse.org/reference/multisession.md)
backend, whereas `y` is resolved sequentially in the main R session.

## Getting the future object of a future assignment

The underlying
[Future](https://future.futureverse.org/reference/Future-class.md) of a
future variable `x` can be retrieved without blocking using
`f <- `[`futureOf`](https://future.futureverse.org/reference/futureOf.md)`(x)`,
e.g.

    > x %<-% { stop("boom") }
    > f_x <- futureOf(x)
    > resolved(f_x)
    [1] TRUE
    > x
    Error in eval(quote({ : boom
    > value(f_x)
    Error in eval(quote({ : boom

Technically, both the future and the variable (promise) are assigned at
the same time to environment `assign.env` where the name of the future
is `.future_<name>`.
