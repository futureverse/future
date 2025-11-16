# Results from resolving a future

Results from resolving a future

## Usage

``` r
FutureResult(
  value = NULL,
  visible = TRUE,
  stdout = NULL,
  conditions = NULL,
  rng = FALSE,
  ...,
  uuid = NULL,
  started = .POSIXct(NA_real_),
  finished = Sys.time(),
  version = "1.8"
)

# S3 method for class 'FutureResult'
as.character(x, ...)

# S3 method for class 'FutureResult'
print(x, ...)
```

## Arguments

- value:

  The value of the future expression. If the expression was not fully
  resolved (e.g. an error) occurred, the the value is `NULL`.

- visible:

  If TRUE, the value was visible, otherwise invisible.

- conditions:

  A list of zero or more list elements each containing a captured
  [condition](https://rdrr.io/r/base/conditions.html) and possibly more
  meta data such as the call stack and a timestamp.

- rng:

  If TRUE, the `.Random.seed` was updated from resolving the future,
  otherwise not.

- started, finished:

  [POSIXct](https://rdrr.io/r/base/DateTimeClasses.html) timestamps when
  the evaluation of the future expression was started and finished.

- version:

  The version format of the results.

- ...:

  (optional) Additional named results to be returned.

## Value

An object of class FutureResult.

## Details

This function is only part of the *backend* Future API. This function is
*not* part of the frontend Future API.

## Note to developers

The FutureResult structure is *under development* and may change at
anytime, e.g. elements may be renamed or removed. Because of this,
please avoid accessing the elements directly in code. Feel free to reach
out if you need to do so in your code.
