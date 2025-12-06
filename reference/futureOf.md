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

  If TRUE and the variable does not exists, then an informative error is
  thrown, otherwise NA is returned.

- default:

  the default value if future was not found.

- drop:

  if TRUE and `var` is NULL, then returned list only contains futures,
  otherwise also `default` values.

## Value

A [Future](https://future.futureverse.org/reference/Future-class.md) (or
`default`). If `var` is NULL, then a named list of Future:s are
returned.

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
#> Early signaling (deprecated): FALSE
#> Environment: 0x5c2297687558
#> Actions: [n=1] ‘run’
#> State: ‘finished’ ("Future was resolved successfully")
#> Resolved: TRUE
#> Unique identifier: 8a0c140e2f1158d297a81a9712bc203d-12
#> Owner process: 8a0c140e2f1158d297a81a9712bc203d
#> Class: ‘SequentialFuture’, ‘UniprocessFuture’, ‘Future’
#> Value: 39 bytes of class ‘numeric’
#> Duration: 0.003284216 secs (started 2025-12-05 18:43:17.649421)
#> Worker process: 8a0c140e2f1158d297a81a9712bc203d

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
#> Early signaling (deprecated): FALSE
#> Environment: 0x5c2297687558
#> Actions: [n=1] ‘run’
#> State: ‘finished’ ("Future was resolved successfully")
#> Resolved: TRUE
#> Unique identifier: 8a0c140e2f1158d297a81a9712bc203d-13
#> Owner process: 8a0c140e2f1158d297a81a9712bc203d
#> Class: ‘SequentialFuture’, ‘UniprocessFuture’, ‘Future’
#> Value: 39 bytes of class ‘numeric’
#> Duration: 0.003184557 secs (started 2025-12-05 18:43:17.662009)
#> Worker process: 8a0c140e2f1158d297a81a9712bc203d

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
#> Early signaling (deprecated): FALSE
#> Environment: 0x5c2297687558
#> Actions: [n=1] ‘run’
#> State: ‘finished’ ("Future was resolved successfully")
#> Resolved: TRUE
#> Unique identifier: 8a0c140e2f1158d297a81a9712bc203d-12
#> Owner process: 8a0c140e2f1158d297a81a9712bc203d
#> Class: ‘SequentialFuture’, ‘UniprocessFuture’, ‘Future’
#> Value: 39 bytes of class ‘numeric’
#> Duration: 0.003284216 secs (started 2025-12-05 18:43:17.649421)
#> Worker process: 8a0c140e2f1158d297a81a9712bc203d
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
#> Early signaling (deprecated): FALSE
#> Environment: 0x5c2297687558
#> Actions: [n=1] ‘run’
#> State: ‘finished’ ("Future was resolved successfully")
#> Resolved: TRUE
#> Unique identifier: 8a0c140e2f1158d297a81a9712bc203d-13
#> Owner process: 8a0c140e2f1158d297a81a9712bc203d
#> Class: ‘SequentialFuture’, ‘UniprocessFuture’, ‘Future’
#> Value: 39 bytes of class ‘numeric’
#> Duration: 0.003184557 secs (started 2025-12-05 18:43:17.662009)
#> Worker process: 8a0c140e2f1158d297a81a9712bc203d
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
#> Early signaling (deprecated): FALSE
#> Environment: 0x5c2297687558
#> Actions: [n=1] ‘run’
#> State: ‘finished’ ("Future was resolved successfully")
#> Resolved: TRUE
#> Unique identifier: 8a0c140e2f1158d297a81a9712bc203d-13
#> Owner process: 8a0c140e2f1158d297a81a9712bc203d
#> Class: ‘SequentialFuture’, ‘UniprocessFuture’, ‘Future’
#> Value: 39 bytes of class ‘numeric’
#> Duration: 0.003184557 secs (started 2025-12-05 18:43:17.662009)
#> Worker process: 8a0c140e2f1158d297a81a9712bc203d
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
#> Early signaling (deprecated): FALSE
#> Environment: 0x5c2297687558
#> Actions: [n=1] ‘run’
#> State: ‘finished’ ("Future was resolved successfully")
#> Resolved: TRUE
#> Unique identifier: 8a0c140e2f1158d297a81a9712bc203d-14
#> Owner process: 8a0c140e2f1158d297a81a9712bc203d
#> Class: ‘SequentialFuture’, ‘UniprocessFuture’, ‘Future’
#> Value: 39 bytes of class ‘numeric’
#> Duration: 0.003000975 secs (started 2025-12-05 18:43:17.678066)
#> Worker process: 8a0c140e2f1158d297a81a9712bc203d

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
#> Early signaling (deprecated): FALSE
#> Environment: 0x5c2297687558
#> Actions: [n=1] ‘run’
#> State: ‘finished’ ("Future was resolved successfully")
#> Resolved: TRUE
#> Unique identifier: 8a0c140e2f1158d297a81a9712bc203d-14
#> Owner process: 8a0c140e2f1158d297a81a9712bc203d
#> Class: ‘SequentialFuture’, ‘UniprocessFuture’, ‘Future’
#> Value: 39 bytes of class ‘numeric’
#> Duration: 0.003000975 secs (started 2025-12-05 18:43:17.678066)
#> Worker process: 8a0c140e2f1158d297a81a9712bc203d

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
#> Early signaling (deprecated): FALSE
#> Environment: 0x5c2297687558
#> Actions: [n=1] ‘run’
#> State: ‘finished’ ("Future was resolved successfully")
#> Resolved: TRUE
#> Unique identifier: 8a0c140e2f1158d297a81a9712bc203d-14
#> Owner process: 8a0c140e2f1158d297a81a9712bc203d
#> Class: ‘SequentialFuture’, ‘UniprocessFuture’, ‘Future’
#> Value: 39 bytes of class ‘numeric’
#> Duration: 0.003000975 secs (started 2025-12-05 18:43:17.678066)
#> Worker process: 8a0c140e2f1158d297a81a9712bc203d

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
#> Early signaling (deprecated): FALSE
#> Environment: 0x5c2297687558
#> Actions: [n=1] ‘run’
#> State: ‘finished’ ("Future was resolved successfully")
#> Resolved: TRUE
#> Unique identifier: 8a0c140e2f1158d297a81a9712bc203d-14
#> Owner process: 8a0c140e2f1158d297a81a9712bc203d
#> Class: ‘SequentialFuture’, ‘UniprocessFuture’, ‘Future’
#> Value: 39 bytes of class ‘numeric’
#> Duration: 0.003000975 secs (started 2025-12-05 18:43:17.678066)
#> Worker process: 8a0c140e2f1158d297a81a9712bc203d
#> 
```
