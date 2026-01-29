# Get future-specific session information and validate current backend

Get future-specific session information and validate current backend

## Usage

``` r
futureSessionInfo(test = TRUE, anonymize = TRUE)
```

## Arguments

- test:

  If TRUE, one or more futures are created to query workers and validate
  their information.

- anonymize:

  If TRUE, user names and host names are anonymized.

## Value

Nothing.

## Examples

``` r
plan(multisession, workers = 2)
futureSessionInfo()
#> *** Package versions
#> future 1.69.0.9003, parallelly 1.46.1.9004, parallel 4.5.2, globals 0.18.0.9004, listenv 0.10.0.9002
#> 
#> *** Allocations
#> availableCores():
#>            system /proc/self/status             nproc 
#>                 8                 8                 8 
#> availableWorkers():
#> $nproc
#> [1] "localhost" "localhost" "localhost" "localhost" "localhost" "localhost"
#> [7] "localhost" "localhost"
#> 
#> $system
#> [1] "localhost" "localhost" "localhost" "localhost" "localhost" "localhost"
#> [7] "localhost" "localhost"
#> 
#> *** Settings
#> - future.plan=<not set>
#> - future.fork.multithreading.enable=<not set>
#> - future.globals.maxSize=<not set>
#> - future.globals.onReference=<not set>
#> - future.resolve.recursive=<not set>
#> - future.rng.onMisuse=<not set>
#> - future.wait.timeout=<not set>
#> - future.wait.interval=<not set>
#> - future.wait.alpha=<not set>
#> - future.startup.script=FALSE
#> 
#> *** Backends
#> Number of workers: 2
#> List of future strategies:
#> 1. multisession:
#>    - args: function (..., workers = 2)
#>    - tweaked: TRUE
#>    - call: plan(multisession, workers = 2)
#> 
#> *** Basic tests
#> Main R session details:
#>      pid     r sysname           release
#> 1 825241 4.5.2   Linux 6.14.0-37-generic
#>                                                            version nodename
#> 1 #37~24.04.1-Ubuntu SMP PREEMPT_DYNAMIC Thu Nov 20 10:25:38 UTC 2  host001
#>   machine   login    user effective_user
#> 1  x86_64 user001 user001        user001
#> Worker R session details:
#>   worker    pid     r sysname           release
#> 1      1 826272 4.5.2   Linux 6.14.0-37-generic
#> 2      2 826271 4.5.2   Linux 6.14.0-37-generic
#>                                                            version nodename
#> 1 #37~24.04.1-Ubuntu SMP PREEMPT_DYNAMIC Thu Nov 20 10:25:38 UTC 2  host001
#> 2 #37~24.04.1-Ubuntu SMP PREEMPT_DYNAMIC Thu Nov 20 10:25:38 UTC 2  host001
#>   machine   login    user effective_user
#> 1  x86_64 user001 user001        user001
#> 2  x86_64 user001 user001        user001
#> Number of unique worker PIDs: 2 (as expected)
plan(sequential)
```
