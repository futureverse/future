# Writes and Reads 'immediateCondition' RDS Files

Writes and Reads 'immediateCondition' RDS Files

## Usage

``` r
readImmediateConditions(
  path = immediateConditionsPath(rootPath = rootPath),
  rootPath = tempdir(),
  pattern = "[.]rds$",
  include = getOption("future.relay.immediate", "immediateCondition"),
  signal = FALSE,
  remove = TRUE
)

saveImmediateCondition(
  cond,
  path = immediateConditionsPath(rootPath = rootPath),
  rootPath = tempdir()
)
```

## Arguments

- path:

  (character string) The folder where the RDS files are.

- pattern:

  (character string) A regular expression selecting the RDS files to be
  read.

- include:

  (character vector) The class or classes of the objects to be kept.

- signal:

  (logical) If TRUE, the condition read are signaled.

- remove:

  (logical) If TRUE, the RDS files used are removed on exit.

- cond:

  A condition of class `immediateCondition`.

## Value

`readImmediateConditions()` returns an unnamed
[base::list](https://rdrr.io/r/base/list.html) of named lists with
elements `condition` and `signaled`, where the `condition` elements hold
`immediateCondition` objects.

`saveImmediateCondition()` returns, invisibly, the pathname of the RDS
written.
