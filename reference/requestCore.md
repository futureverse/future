# Request a core for multicore processing

If no cores are available, the current process blocks until a core is
available.

## Usage

``` r
requestCore(
  await,
  workers = availableCores(constraints = "multicore"),
  timeout,
  delta,
  alpha
)
```

## Arguments

- await:

  A function used to try to "collect" finished multicore subprocesses.

- workers:

  Total number of workers available.

- timeout:

  Maximum waiting time (in seconds) allowed before a timeout error is
  generated.

- delta:

  Then base interval (in seconds) to wait between each try.

- alpha:

  A multiplicative factor used to increase the wait interval after each
  try.

## Value

Invisible TRUE. If no cores are available after extensive waiting, then
a timeout error is thrown.
