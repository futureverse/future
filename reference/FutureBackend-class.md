# Configure a backend that controls how and where futures are evaluated

*This functionality is only for developers who wish to implement their
own future backend. End-users and package developers use futureverse,
does not need to know about these functions.*

If you are looking for available future backends to choose from, please
see the 'A Future for R: Available Future Backends' vignette and
<https://www.futureverse.org/backends.html>.

## Usage

``` r
FutureBackend(
  ...,
  earlySignal = FALSE,
  gc = FALSE,
  maxSizeOfObjects = getOption("future.globals.maxSize", +Inf),
  interrupts = TRUE,
  hooks = FALSE
)

launchFuture(backend, future, ...)

listFutures(backend, ...)

interruptFuture(backend, future, ...)

validateFutureGlobals(backend, future, ...)

stopWorkers(backend, ...)

MultiprocessFutureBackend(
  ...,
  wait.timeout = getOption("future.wait.timeout", 24 * 60 * 60),
  wait.interval = getOption("future.wait.interval", 0.01),
  wait.alpha = getOption("future.wait.alpha", 1.01)
)

ClusterFutureBackend(
  workers = availableWorkers(constraints = "connections"),
  gc = TRUE,
  earlySignal = FALSE,
  interrupts = FALSE,
  persistent = FALSE,
  ...
)

MulticoreFutureBackend(
  workers = availableCores(constraints = "multicore"),
  maxSizeOfObjects = +Inf,
  ...
)

SequentialFutureBackend(..., maxSizeOfObjects = +Inf)

MultisessionFutureBackend(
  workers = availableCores(constraints = "connections-16"),
  rscript_libs = .libPaths(),
  interrupts = TRUE,
  gc = FALSE,
  earlySignal = FALSE,
  ...
)
```

## Arguments

- earlySignal:

  Overrides the default behavior on whether futures should resignal
  ("relay") conditions captured as soon as possible, or delayed, for
  instance, until
  [`value()`](https://future.futureverse.org/reference/value.md) is
  called on the future. (Default: `FALSE`)

- gc:

  Overrides the default behavior of whether futures should trigger
  garbage collection via [`gc()`](https://rdrr.io/r/base/gc.html) on the
  parallel worker after the value has been collected from the worker.
  This can help to release memory sooner than letting R itself on the
  parallel worker decided when it is needed. Releasing memory sooner can
  help to fit more parallel workers on a machine with limited amount of
  total memory. (Default: `FALSE`)

- maxSizeOfObjects:

  The maximum allowed total size, in bytes, of all objects to and from
  the parallel worker allows. This can help to protect against
  unexpectedly large data transfers between the parent process and the
  parallel workers - data that is often transferred over the network,
  which sometimes also includes the internet. For instance, if you sit
  at home and have set up a future backend with workers running remotely
  at your university or company, then you might want to use this
  protection to avoid transferring giga- or terabytes of data without
  noticing. (Default: \\500 \cdot 1024^2\\ bytes = 500 MiB, unless
  overridden by a FutureBackend subclass, or by R option
  [future.globals.maxSize](https://future.futureverse.org/reference/zzz-future.options.md)
  (sic!))

- interrupts:

  If FALSE, attempts to interrupt futures will not take place on this
  backend, even if the backend supports it. This is useful when, for
  instance, it takes a long time to interrupt a future.

- backend:

  a FutureBackend.

- future:

  a [Future](https://future.futureverse.org/reference/Future-class.md)
  to be started.

- wait.timeout:

  Number of seconds before timing out.

- wait.interval:

  Baseline number of seconds between retries.

- wait.alpha:

  Scale factor increasing waiting interval after each attempt.

- workers:

  ...

- persistent:

  (deprecated) ...

- ...:

  (optional) not used.

## Value

`FutureBackend()` returns a FutureBackend object, which inherits an
environment. Specific future backends are defined by subclasses
implementing the FutureBackend API.

`launchFuture()` returns the launched `Future` object.

`interruptFuture()` returns the interrupted `Future` object, if
supported, other the unmodified future.

`stopWorkers()` returns TRUE if the workers were shut down, otherwise
FALSE.

## Details

The `ClusterFutureBackend` is selected by
`plan(cluster, workers = workers)`.

The `MulticoreFutureBackend` backend is selected by
`plan(multicore, workers = workers)`.

The `SequentialFutureBackend` is selected by `plan(sequential)`.

The `MultisessionFutureBackend` backend is selected by
`plan(multisession, workers = workers)`.

## The FutureBackend API

The `FutureBackend` class specifies FutureBackend API, that all backends
must implement and comply to. Specifically,

## See also

For alternative future backends, see the 'A Future for R: Available
Future Backends' vignette and
<https://www.futureverse.org/backends.html>.

For alternative future backends, see the 'A Future for R: Available
Future Backends' vignette and
<https://www.futureverse.org/backends.html>.
