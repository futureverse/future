# Place a sticky-globals environment immediately after the global environment

Place a sticky-globals environment immediately after the global
environment

## Usage

``` r
sticky_globals(erase = FALSE, name = "future:sticky_globals", pos = 2L)
```

## Arguments

- erase:

  (logical) If TRUE, the environment is erased, otherwise not.

- name:

  (character) The name of the environment on the
  [base::search](https://rdrr.io/r/base/search.html) path.

- pos:

  (integer) The position on the search path where the environment should
  be positioned. If `pos == 0L`, then the environment is detached, if it
  exists.

## Value

(invisible; environment) The environment.
