#! /usr/bin/env bash

## Missing or outdated LaTeX packages
false && R --quiet --no-save <<EOF
    tinytex::install_tinytex(force = TRUE)
    message("TeX root: ", tinytex::tinytex_root())
    tinytex::tlmgr_update()
    tinytex::tlmgr_install("apacite")  # ctsem
    tinytex::tlmgr_install("textpos")  # WeightedCluster
    tinytex::tlmgr_install("nowidow")  # QDNAseq
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

## Drop packages failing on CRAN (2026-03-27)
revdep/run.R --rm aramappings dispositionEffect EpiForsk sovereign

## Drop packages failing on Bioconductor (2026-03-13)
revdep/run.R --rm dar MineICA pgxRpi

## Drop packages no longer on CRAN (2026-03-27)
revdep/run.R --rm mbbe oncomsm

## Drop packages failing on Bioconductor (2026-03-07)
# revdep/run.R --rm ...

## Missing tools
revdep/run.R --rm proffer  # requires 'RProtoBuf' -> ProtoBuf library

## Fails to install
revdep/run.R --rm BayesPET TriDimRegression  # there is no package called ‘rstantools’

## Fails to check
revdep/run.R --rm httpgd                # caught segfault
revdep/run.R --rm mapme.biodiversity    # unstable results
revdep/run.R --rm greenSD               # GDAL not build with libcurl
revdep/run.R --rm receptiviti           # vignette "`dt` must be size 1, not 3"
revdep/run.R --rm shinyOAuth            # HTTP 503 Service Unavailable
revdep/run.R --rm SpaDES.core           # Error in linesWithDefModule[[1]]:linesWithDefModule[[2]]
revdep/run.R --rm targets               # 'tarchetypes' not available
revdep/run.R --rm tsmarch               ## "Segmentation fault"

## Errors for unknown reason
## 'iscream' fails with "error in evaluating the argument 'obj' in selecting a method
## for function 'unname': 'file_test("-x", bin)' is not TRUE" despite having 'tabix'
## on the PATH /2026-03-13 
revdep/run.R --rm iscream

## Requires sequential processing due to clashes, e.g. port and cache 
pkgs_seq=(dipsaus fiery robust2sls)
revdep/run.R --rm "${pkgs_seq[@]}"

## Too many cores
pkgs_limit=(fmeffects scStability)
revdep/run.R --rm "${pkgs_limit[@]}"

## Too many cores due to detectCores
pkgs_detectCores=(FracFixR lavDiag)
revdep/run.R --rm "${pkgs_detectCores[@]}"

## Run revdep check
revdep/run.R


## ---------------------------------------------------------------------
## Phase 2
## ---------------------------------------------------------------------
## Limit CPU use
revdep/run.R --add "${pkgs_limit[@]}"
OMP_NUM_THREADS=4 NSLOTS=4 revdep/run.R

## Sequential
revdep/run.R --add "${pkgs_seq[@]}"
NSLOTS=1 revdep/run.R
