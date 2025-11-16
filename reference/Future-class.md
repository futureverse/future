# A future represents a value that will be available at some point in the future

A *future* is an abstraction for a *value* that may available at some
point in the future. A future can either be `unresolved` or `resolved`,
a state which can be checked with
[`resolved()`](https://future.futureverse.org/reference/resolved.md). As
long as it is *unresolved*, the value is not available. As soon as it is
*resolved*, the value is available via
[`value()`](https://future.futureverse.org/reference/value.md).

## Usage

``` r
Future(
  expr = NULL,
  envir = parent.frame(),
  substitute = TRUE,
  stdout = TRUE,
  conditions = "condition",
  globals = list(),
  packages = NULL,
  seed = FALSE,
  lazy = FALSE,
  gc = FALSE,
  earlySignal = FALSE,
  label = NULL,
  ...
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
  [`substitute()`](https://rdrr.io/r/base/substitute.html):ed, otherwise
  not.

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

  A character string of conditions classes to be captured and relayed.
  The default is to relay all conditions, including messages and
  warnings. To drop all conditions, use `conditions = character(0)`.
  Errors are always relayed. Attribute `exclude` can be used to ignore
  specific classes, e.g.
  `conditions = structure("condition", exclude = "message")` will
  capture all `condition` classes except those that inherits from the
  `message` class. Using `conditions = structure(..., drop = TRUE)`
  causes any captured conditions to be dropped from the future object as
  soon as it has been relayed, e.g. by `value(f)`. This can help
  decrease the overall memory consumed by captured conditions across
  futures. Using `conditions = NULL` (not recommended) avoids
  intercepting conditions, except from errors; behavior of such
  unhandled conditions depends on the future backend and the environment
  from which R runs.

- globals:

  (optional) a logical, a character vector, or a named list to control
  how globals are handled. For details, see section 'Globals used by
  future expressions' in the help for
  [`future()`](https://future.futureverse.org/reference/future.md).

- packages:

  (optional) a character vector specifying packages to be attached in
  the R environment evaluating the future.

- seed:

  (optional) If TRUE, the random seed, that is, the state of the random
  number generator (RNG) will be set such that statistically sound
  random numbers are produced (also during parallelization). If FALSE
  (default), it is assumed that the future expression does neither need
  nor use random numbers generation. To use a fixed random seed, specify
  a L'Ecuyer-CMRG seed (seven integer) or a regular RNG seed (a single
  integer). If the latter, then a L'Ecuyer-CMRG seed will be
  automatically created based on the given seed. Furthermore, if FALSE,
  then the future will be monitored to make sure it does not use random
  numbers. If it does and depending on the value of option
  [future.rng.onMisuse](https://future.futureverse.org/reference/zzz-future.options.md),
  the check is ignored, an informative warning, or error will be
  produced. If `seed` is NULL, then the effect is as with `seed = FALSE`
  but without the RNG check being performed.

- lazy:

  If FALSE (default), the future is resolved eagerly (starting
  immediately), otherwise not.

- gc:

  If TRUE, the garbage collector run (in the process that evaluated the
  future) only after the value of the future is collected. Exactly when
  the values are collected may depend on various factors such as number
  of free workers and whether `earlySignal` is TRUE (more frequently) or
  FALSE (less frequently). *Some future backends may ignore this
  argument.*

- earlySignal:

  Specified whether conditions should be signaled as soon as possible or
  not.

- label:

  A character string label attached to the future.

- ...:

  Additional named elements of the future.

## Value

`Future()` returns an object of class `Future`.

## Details

A Future object is itself an
[environment](https://rdrr.io/r/base/environment.html).

## See also

One function that creates a Future is
[`future()`](https://future.futureverse.org/reference/future.md). It
returns a Future that evaluates an R expression in the future. An
alternative approach is to use the `%<-%` infix assignment operator,
which creates a future from the right-hand-side (RHS) R expression and
assigns its future value to a variable as a
*[promise](https://rdrr.io/r/base/delayedAssign.html)*.
