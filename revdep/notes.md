# Notes

## Setup

```r
options(Ncpus = 6L)
install.packages("remotes")
remotes::install_github("r-lib/revdepcheck")
```

```sh
## Used by R itself
$ revdep/run.R --preinstall RCurl XML
```


## Pre-installation

In order to run these checks successfully on a machine _without internet
access_, make sure to first populate the 'crancache' cache by pre-installing
all packages to be tested plus a few more.

```sh
$ scl enable devtoolset-4 "revdep/run.R --preinstall blavaan"

## All packages to be tested
$ revdep/run.R --preinstall-children
```


## Testing

### Packages that require Internet

The following packages will fail when tested in 'offline' mode because
their examples or tests require a working internet connection:

* BatchGetSymbols
* datapackage.r
* GetBCBData
* greenSD
* GSODR
* hackeRnews
* iml
* tableschema.r
* tsfeatures


### Packages that fail due to spotty internet downloads

* pgxRpi



### Packages that fail if tested in parallel

The following packages will fail when tested in parallel, because they
compete with themselves for resources.  For example, several Bioconductor
package assumes their BiocFileCache folder is empty, or no other R
processes are writing to it at the same time.

Workaround is to clear file caches and check one package at the time;

```sh
rm -rf ~/.cache/R/
R_REVDEPCHECK_NUM_WORKERS=1 revdep/run.R
```




### More 'multisession' workers than connectes

Also, the below packages fail on hosts with many CPUs, because
they use `availableCores()` in their vignettes, which falls back
to `detectCores() when built via `R CMD check`.

The workaround is to check with:

```
R_PARALLELLY_AVAILABLECORES_MAX=96 revdep/run.R
```

Note that this will be automatically limited to two (2) in
**parallelly** (>= 1.46.0).

Problematic packages:

* ale
* dar
* gtfs2emis
* gtfs2gps
* mistyR
* signeR
* simIDM
* uci


### Uses `detectCores()`

The following packages uses 'multisession' and defaults to
`parallel::detectCores()` workers. This fails on machines with > 125
CPU cores. 

The workaround is to check these package on a machine with fewer cores
and setting R option 'parallelly.maxWorkers.localhost=c(100,100)' as;

```sh
R_PARALLELLY_MAXWORKERS_LOCALHOST="100,100" revdep/run.R
```


### Overusing multithreading packages

* xpect

The workaround is to use:

```sh
OMP_NUM_THREADS=2 OPENBLAS_NUM_THREADS=2 MKL_NUM_THREADS=2 GOTO_NUM_THREADS=2 revdep/run.R
```


Problematic packages:

* fmeffects
* FracFixR
