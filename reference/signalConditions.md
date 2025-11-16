# Signals Captured Conditions

Captured conditions that meet the `include` and `exclude` requirements
are signaled *in the order as they were captured*.

## Usage

``` r
signalConditions(
  future,
  include = "condition",
  exclude = NULL,
  resignal = TRUE,
  ...
)
```

## Arguments

- future:

  A resolved
  [Future](https://future.futureverse.org/reference/Future-class.md).

- include:

  A character string of
  [condition](https://rdrr.io/r/base/conditions.html) classes to signal.

- exclude:

  A character string of
  [condition](https://rdrr.io/r/base/conditions.html) classes *not* to
  signal.

- resignal:

  If TRUE, then already signaled conditions are signaled again,
  otherwise not.

- ...:

  Not used.

## Value

Returns the
[Future](https://future.futureverse.org/reference/Future-class.md) where
conditioned that were signaled have been flagged to have been signaled.

## See also

Conditions are signaled by
[`signalCondition()`](https://rdrr.io/r/base/conditions.html).
