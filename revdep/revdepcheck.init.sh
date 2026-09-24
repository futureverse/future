#! /usr/bin/env bash

## Missing or outdated LaTeX packages
false && R --quiet --no-save <<EOF
    tinytex::install_tinytex(force = TRUE)
    message("TeX root: ", tinytex::tinytex_root())
    tinytex::tlmgr_update()

    # R package 'tramvs'
    tinytex::tlmgr_install(c(
      "doublestroke", # provides dsfont.sty
      "natbib", 
      "hyperref", 
      "geometry", 
      "amsfonts", 
      "amsmath", 
      "amscls",     # provides amsthm.sty
      "booktabs", 
      "multirow", 
      "wrapfig", 
      "float", 
      "colortbl", 
      "pdflscape", 
      "ulem", 
      "makecell", 
      "mathtools", 
      "xcolor", 
      "psnfss"      # provides pifont.sty
    ))

    # R package WeightedCluster
    tinytex::tlmgr_install(c(
      "ae",
      "babel-french",
      "ntgclass",
      "pgf",
      "textpos"
    ))

    # Other R packages
    tinytex::tlmgr_install(c(
      "apacite",         # ctsem
      "grfext",          # PeakSegDisk
      "nowidow",         # QDNAseq
      "pdfpages",        # ARPALData
      "setspace",        # gstat
      "wrapfig"          
    ))
EOF

## Non-default system dependencies
if command -v module &> /dev/null; then
    module try-load CBI libblosc         ## pizzarr
    module try-load CBI htslib           ## iscream
    module try-load CBI gdal netcdf proj ## terra
    module try-load CBI symphony         ## SYMPHONY
fi    


## ---------------------------------------------------------------------
## Phase 1
## ---------------------------------------------------------------------

## Add packages to check
revdep/run.R --add-children

## Drop packages failing on CRAN (2026-09-23)
revdep/run.R --rm dispositionEffect fmeffects

## Drop packages failing on Bioconductor (2026-09-23)
revdep/run.R --rm MineICA pgxRpi

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

# Too many cores /2026-09-23
pkgs_cores=()
#revdep/run.R --rm "${pkgs_cores[@]}"

## Too many cores due to detectCores /2026-09-23
pkgs_detectCores=(STARRS)
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
