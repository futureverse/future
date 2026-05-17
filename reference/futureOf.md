# Get the future of a future variable

Get the future of a future variable that has been created directly or
indirectly via
[`future()`](https://future.futureverse.org/reference/future.md).

## Usage

``` r
futureOf(
  var = NULL,
  envir = parent.frame(),
  mustExist = TRUE,
  default = NA,
  drop = FALSE
)
```

## Arguments

- var:

  the variable. If NULL, all futures in the environment are returned.

- envir:

  the environment where to search from.

- mustExist:

  If TRUE and the variable does not exist, then an informative error is
  thrown, otherwise `default` is returned.

- default:

  the default value if future was not found.

- drop:

  if TRUE and `var` is NULL, then returned list only contains futures,
  otherwise also `default` values.

## Value

A [Future](https://future.futureverse.org/reference/Future-class.md) (or
`default`). If `var` is NULL, then a named list of Future:s is returned.

## Examples

``` r
a %<-% { 1 }

f <- futureOf(a)
print(f)
#> SequentialFuture:
#> Label: <unnamed-12>
#> Expression:
#> {
#>     1
#> }
#> Globals: <none>
#> Packages: <none>
#> L'Ecuyer-CMRG RNG seed: <none> (seed = FALSE)
#> Capture standard output: TRUE
#> Capture condition classes: ‘condition’ (excluding ‘<none>’)
#> Immediate condition classes: ‘immediateCondition’
#> Lazy evaluation: FALSE
#> Local evaluation: TRUE
#> Early signaling: FALSE
#> Actions: [n=1] ‘run’
#> State: ‘finished’ ("Future was resolved successfully")
#> Resolved: TRUE
#> Unique identifier: 35c2dd59b0306a977060e5907af3c80c-12
#> Owner process: 35c2dd59b0306a977060e5907af3c80c
#> Class: ‘SequentialFuture’, ‘UniprocessFuture’, ‘Future’
#> Value: 39 bytes of class ‘numeric’
#> Duration: 0.002894878 secs (started 2026-05-16 23:22:06.818347)
#> Worker process: 35c2dd59b0306a977060e5907af3c80c

b %<-% { 2 }

f <- futureOf(b)
print(f)
#> SequentialFuture:
#> Label: <unnamed-13>
#> Expression:
#> {
#>     2
#> }
#> Globals: <none>
#> Packages: <none>
#> L'Ecuyer-CMRG RNG seed: <none> (seed = FALSE)
#> Capture standard output: TRUE
#> Capture condition classes: ‘condition’ (excluding ‘<none>’)
#> Immediate condition classes: ‘immediateCondition’
#> Lazy evaluation: FALSE
#> Local evaluation: TRUE
#> Early signaling: FALSE
#> Actions: [n=1] ‘run’
#> State: ‘finished’ ("Future was resolved successfully")
#> Resolved: TRUE
#> Unique identifier: 35c2dd59b0306a977060e5907af3c80c-13
#> Owner process: 35c2dd59b0306a977060e5907af3c80c
#> Class: ‘SequentialFuture’, ‘UniprocessFuture’, ‘Future’
#> Value: 39 bytes of class ‘numeric’
#> Duration: 0.002952814 secs (started 2026-05-16 23:22:06.830447)
#> Worker process: 35c2dd59b0306a977060e5907af3c80c

## All futures
fs <- futureOf()
print(fs)
#> $a
#> SequentialFuture:
#> Label: <unnamed-12>
#> Expression:
#> {
#>     1
#> }
#> Globals: <none>
#> Packages: <none>
#> L'Ecuyer-CMRG RNG seed: <none> (seed = FALSE)
#> Capture standard output: TRUE
#> Capture condition classes: ‘condition’ (excluding ‘<none>’)
#> Immediate condition classes: ‘immediateCondition’
#> Lazy evaluation: FALSE
#> Local evaluation: TRUE
#> Early signaling: FALSE
#> Actions: [n=1] ‘run’
#> State: ‘finished’ ("Future was resolved successfully")
#> Resolved: TRUE
#> Unique identifier: 35c2dd59b0306a977060e5907af3c80c-12
#> Owner process: 35c2dd59b0306a977060e5907af3c80c
#> Class: ‘SequentialFuture’, ‘UniprocessFuture’, ‘Future’
#> Value: 39 bytes of class ‘numeric’
#> Duration: 0.002894878 secs (started 2026-05-16 23:22:06.818347)
#> Worker process: 35c2dd59b0306a977060e5907af3c80c
#> 
#> $b
#> SequentialFuture:
#> Label: <unnamed-13>
#> Expression:
#> {
#>     2
#> }
#> Globals: <none>
#> Packages: <none>
#> L'Ecuyer-CMRG RNG seed: <none> (seed = FALSE)
#> Capture standard output: TRUE
#> Capture condition classes: ‘condition’ (excluding ‘<none>’)
#> Immediate condition classes: ‘immediateCondition’
#> Lazy evaluation: FALSE
#> Local evaluation: TRUE
#> Early signaling: FALSE
#> Actions: [n=1] ‘run’
#> State: ‘finished’ ("Future was resolved successfully")
#> Resolved: TRUE
#> Unique identifier: 35c2dd59b0306a977060e5907af3c80c-13
#> Owner process: 35c2dd59b0306a977060e5907af3c80c
#> Class: ‘SequentialFuture’, ‘UniprocessFuture’, ‘Future’
#> Value: 39 bytes of class ‘numeric’
#> Duration: 0.002952814 secs (started 2026-05-16 23:22:06.830447)
#> Worker process: 35c2dd59b0306a977060e5907af3c80c
#> 
#> $f
#> SequentialFuture:
#> Label: <unnamed-13>
#> Expression:
#> {
#>     2
#> }
#> Globals: <none>
#> Packages: <none>
#> L'Ecuyer-CMRG RNG seed: <none> (seed = FALSE)
#> Capture standard output: TRUE
#> Capture condition classes: ‘condition’ (excluding ‘<none>’)
#> Immediate condition classes: ‘immediateCondition’
#> Lazy evaluation: FALSE
#> Local evaluation: TRUE
#> Early signaling: FALSE
#> Actions: [n=1] ‘run’
#> State: ‘finished’ ("Future was resolved successfully")
#> Resolved: TRUE
#> Unique identifier: 35c2dd59b0306a977060e5907af3c80c-13
#> Owner process: 35c2dd59b0306a977060e5907af3c80c
#> Class: ‘SequentialFuture’, ‘UniprocessFuture’, ‘Future’
#> Value: 39 bytes of class ‘numeric’
#> Duration: 0.002952814 secs (started 2026-05-16 23:22:06.830447)
#> Worker process: 35c2dd59b0306a977060e5907af3c80c
#> 


## Futures part of environment
env <- new.env()
env$c %<-% { 3 }

f <- futureOf(env$c)
print(f)
#> SequentialFuture:
#> Label: <unnamed-14>
#> Expression:
#> {
#>     3
#> }
#> Globals: <none>
#> Packages: <none>
#> L'Ecuyer-CMRG RNG seed: <none> (seed = FALSE)
#> Capture standard output: TRUE
#> Capture condition classes: ‘condition’ (excluding ‘<none>’)
#> Immediate condition classes: ‘immediateCondition’
#> Lazy evaluation: FALSE
#> Local evaluation: TRUE
#> Early signaling: FALSE
#> Actions: [n=1] ‘run’
#> State: ‘finished’ ("Future was resolved successfully")
#> Resolved: TRUE
#> Unique identifier: 35c2dd59b0306a977060e5907af3c80c-14
#> Owner process: 35c2dd59b0306a977060e5907af3c80c
#> Class: ‘SequentialFuture’, ‘UniprocessFuture’, ‘Future’
#> Value: 39 bytes of class ‘numeric’
#> Duration: 0.00267458 secs (started 2026-05-16 23:22:06.842903)
#> Worker process: 35c2dd59b0306a977060e5907af3c80c

f2 <- futureOf(c, envir = env)
print(f2)
#> SequentialFuture:
#> Label: <unnamed-14>
#> Expression:
#> {
#>     3
#> }
#> Globals: <none>
#> Packages: <none>
#> L'Ecuyer-CMRG RNG seed: <none> (seed = FALSE)
#> Capture standard output: TRUE
#> Capture condition classes: ‘condition’ (excluding ‘<none>’)
#> Immediate condition classes: ‘immediateCondition’
#> Lazy evaluation: FALSE
#> Local evaluation: TRUE
#> Early signaling: FALSE
#> Actions: [n=1] ‘run’
#> State: ‘finished’ ("Future was resolved successfully")
#> Resolved: TRUE
#> Unique identifier: 35c2dd59b0306a977060e5907af3c80c-14
#> Owner process: 35c2dd59b0306a977060e5907af3c80c
#> Class: ‘SequentialFuture’, ‘UniprocessFuture’, ‘Future’
#> Value: 39 bytes of class ‘numeric’
#> Duration: 0.00267458 secs (started 2026-05-16 23:22:06.842903)
#> Worker process: 35c2dd59b0306a977060e5907af3c80c

f3 <- futureOf("c", envir = env)
print(f3)
#> SequentialFuture:
#> Label: <unnamed-14>
#> Expression:
#> {
#>     3
#> }
#> Globals: <none>
#> Packages: <none>
#> L'Ecuyer-CMRG RNG seed: <none> (seed = FALSE)
#> Capture standard output: TRUE
#> Capture condition classes: ‘condition’ (excluding ‘<none>’)
#> Immediate condition classes: ‘immediateCondition’
#> Lazy evaluation: FALSE
#> Local evaluation: TRUE
#> Early signaling: FALSE
#> Actions: [n=1] ‘run’
#> State: ‘finished’ ("Future was resolved successfully")
#> Resolved: TRUE
#> Unique identifier: 35c2dd59b0306a977060e5907af3c80c-14
#> Owner process: 35c2dd59b0306a977060e5907af3c80c
#> Class: ‘SequentialFuture’, ‘UniprocessFuture’, ‘Future’
#> Value: 39 bytes of class ‘numeric’
#> Duration: 0.00267458 secs (started 2026-05-16 23:22:06.842903)
#> Worker process: 35c2dd59b0306a977060e5907af3c80c

fs <- futureOf(envir = env)
print(fs)
#> $c
#> SequentialFuture:
#> Label: <unnamed-14>
#> Expression:
#> {
#>     3
#> }
#> Globals: <none>
#> Packages: <none>
#> L'Ecuyer-CMRG RNG seed: <none> (seed = FALSE)
#> Capture standard output: TRUE
#> Capture condition classes: ‘condition’ (excluding ‘<none>’)
#> Immediate condition classes: ‘immediateCondition’
#> Lazy evaluation: FALSE
#> Local evaluation: TRUE
#> Early signaling: FALSE
#> Actions: [n=1] ‘run’
#> State: ‘finished’ ("Future was resolved successfully")
#> Resolved: TRUE
#> Unique identifier: 35c2dd59b0306a977060e5907af3c80c-14
#> Owner process: 35c2dd59b0306a977060e5907af3c80c
#> Class: ‘SequentialFuture’, ‘UniprocessFuture’, ‘Future’
#> Value: 39 bytes of class ‘numeric’
#> Duration: 0.00267458 secs (started 2026-05-16 23:22:06.842903)
#> Worker process: 35c2dd59b0306a977060e5907af3c80c
#> 
```
