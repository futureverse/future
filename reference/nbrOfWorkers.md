# Get the number of workers available

Get the number of workers available

## Usage

``` r
nbrOfWorkers(evaluator = NULL)

nbrOfFreeWorkers(evaluator = NULL, background = FALSE, ...)
```

## Arguments

- evaluator:

  A future evaluator function. If NULL (default), the current evaluator
  as returned by
  [`plan()`](https://future.futureverse.org/reference/plan.md) is used.

- background:

  If TRUE, only workers that can process a future in the background are
  considered. If FALSE, also workers running in the main R process are
  considered, e.g. when using the 'sequential' backend.

- ...:

  Not used; reserved for future use.

## Value

`nbrOfWorkers()` returns a positive number in \\{1, 2, 3, ...}\\, which
for some future backends may also be `+Inf`.

`nbrOfFreeWorkers()` returns a non-negative number in \\{0, 1, 2, 3,
...}\\ which is less than or equal to `nbrOfWorkers()`.

## Examples

``` r
plan(multisession)
nbrOfWorkers()  ## == availableCores()
#> [1] 8

plan(sequential)
nbrOfWorkers()  ## == 1
#> [1] 1
```
