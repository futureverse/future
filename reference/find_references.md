# Get the first or all references of an R object

Get the first or all references of an R object

Assert that there are no references among the identified globals

## Usage

``` r
find_references(x, first_only = FALSE)

assert_no_references(
  x,
  action = c("error", "warning", "message", "string"),
  source = c("globals", "value")
)
```

## Arguments

- x:

  The R object to be checked.

- first_only:

  If `TRUE`, only the first reference is returned, otherwise all
  references.

- action:

  Type of action to take if a reference is found.

- source:

  Is the source of `x` the globals or the value of the future?

## Value

`find_references()` returns a list of zero or more references
identified.

If a reference is detected, an informative error, warning, message, or a
character string is produced, otherwise `NULL` is returned invisibly.
