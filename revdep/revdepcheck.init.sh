#! /usr/bin/env bash

## Missing or outdated LaTeX packages
false && R --quiet --no-save <<EOF
    tinytex::install_tinytex(force = TRUE)
    message("TeX root: ", tinytex::tinytex_root())
    tinytex::tlmgr_update()
    tinytex::tlmgr_install("a4")       # WeightedCluster
    tinytex::tlmgr_install("apacite")  # ctsem
    tinytex::tlmgr_install("grfext")   # PeakSegDisk
    tinytex::tlmgr_install("nowidow")  # QDNAseq
    tinytex::tlmgr_install("pdfpages") # ARPALData
    tinytex::tlmgr_install("setspace") # gstat
    tinytex::tlmgr_install("textpos")  # WeightedCluster
    tinytex::tlmgr_install("wrapfig")  # tramvs
EOF

## Non-default system dependencies
if command -v module &> /dev/null; then
    module try-load CBI libblosc  ## pizzarr
    module try-load CBI htslib    ## iscream
fi    


## ---------------------------------------------------------------------
## Phase 1
## ---------------------------------------------------------------------

## Add packages to check
revdep/run.R --add-children

## Drop packages failing on CRAN (2026-07-19)
revdep/run.R --rm dispositionEffect

## Drop packages failing on Bioconductor (2026-07-19)
revdep/run.R --rm dar MineICA pgxRpi

## Drop packages no longer on CRAN (2026-07-19)
#revdep/run.R --rm ...

## Drop packages failing on Bioconductor (2026-03-07)
# revdep/run.R --rm ...

## Fails to install
revdep/run.R --rm BayesPET TriDimRegression  # there is no package called ‘rstantools’

## Fails to check
revdep/run.R --rm mapme.biodiversity    # unstable results
revdep/run.R --rm zarrr                 # requires 'blosc', which requires 'blosc-devel'

## Requires sequential processing due to clashes, e.g. port and cache 
pkgs_seq=(dipsaus fiery robust2sls)
revdep/run.R --rm "${pkgs_seq[@]}"

## Too many threads /2026-04-16
pkgs_threads=()
#revdep/run.R --rm "${pkgs_threads[@]}"

# Too many cores /2026-04-16
## FIXME: Some of these package should be moved to 'pkgs_treads'
pkgs_cores=()
revdep/run.R --rm "${pkgs_cores[@]}"

## Too many cores due to detectCores
pkgs_detectCores=()
revdep/run.R --rm "${pkgs_detectCores[@]}"

## Run revdep check
revdep/run.R


## ---------------------------------------------------------------------
## Phase 2
## ---------------------------------------------------------------------
## Set: Too many threads
revdep/run.R --add "${pkgs_threads[@]}"
OMP_NUM_THREADS=4 revdep/run.R

## Set: Too many cores
revdep/run.R --add "${pkgs_cores[@]}"
OMP_NUM_THREADS=4 NSLOTS=4 revdep/run.R

## Sequential
revdep/run.R --add "${pkgs_seq[@]}"
NSLOTS=1 revdep/run.R
