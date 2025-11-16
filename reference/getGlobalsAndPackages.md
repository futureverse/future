# Retrieves global variables of an expression and their associated packages

Retrieves global variables of an expression and their associated
packages

## Usage

``` r
getGlobalsAndPackages(
  expr,
  envir = parent.frame(),
  tweak = tweakExpression,
  globals = TRUE,
  locals = getOption("future.globals.globalsOf.locals", TRUE),
  resolve = getOption("future.globals.resolve"),
  persistent = FALSE,
  maxSize = getOption("future.globals.maxSize", 500 * 1024^2),
  onReference = getOption("future.globals.onReference", "ignore"),
  ...
)
```

## Arguments

- expr:

  An R expression whose globals should be found.

- envir:

  The environment from which globals should be searched.

- tweak:

  (optional) A function that takes an expression and returned a modified
  one.

- globals:

  (optional) a logical, a character vector, a named list, or a
  [Globals](https://globals.futureverse.org/reference/Globals.html)
  object. If TRUE, globals are identified by code inspection based on
  `expr` and `tweak` searching from environment `envir`. If FALSE, no
  globals are used. If a character vector, then globals are identified
  by lookup based their names `globals` searching from environment
  `envir`. If a named list or a Globals object, the globals are used as
  is.

- locals:

  Should globals part of any "local" environment of a function be
  included or not?

- resolve:

  If TRUE, any future that is a global variables (or part of one) is
  resolved and replaced by a "constant" future.

- persistent:

  If TRUE, non-existing globals (= identified in expression but not
  found in memory) are always silently ignored and assumed to be
  existing in the evaluation environment. If FALSE, non-existing globals
  are by default ignored, but may also trigger an informative error if
  option future.globals.onMissing in `"error"` (should only be used for
  troubleshooting).

- maxSize:

  The maximum allowed total size (in bytes) of globals—for the purpose
  of preventing too large exports / transfers happening by mistake. If
  the total size of the global objects are greater than this limit, an
  informative error message is produced. If `maxSize = +Inf`, then this
  assertion is skipped. (Default: 500 MiB).

- ...:

  Not used.

## Value

A named list with elements `expr` (the tweaked expression), `globals` (a
named list of class
[FutureGlobals](https://future.futureverse.org/reference/FutureGlobals.md))
and `packages` (a character string).

## See also

Internally,
[`globalsOf()`](https://globals.futureverse.org/reference/globalsOf.html)
is used to identify globals and associated packages from the expression.
