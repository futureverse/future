#! /usr/bin/env bash

if [[ -f revdep/data.sqlite ]]; then
    >&2 echo "ERROR: To wipe existing results, remove 'revdep/data.sqlite' first"
    exit 1
fi    

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
      "microtype",       # BayesFBHborrow
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


## Special case: 'lpsymphony' does not install with symphony loaded
if command -v module &> /dev/null; then
    if ! Rscript -e 'requireNamespace("lpsymphony")'; then
	module unload symphony
	Rscript -e 'crancache::install_packages("lpsymphony")'
	module load symphony
    fi
fi


## ---------------------------------------------------------------------
## Phase 1
## ---------------------------------------------------------------------

## Add packages to check
revdep/run.R --add-children

## Drop packages failing on CRAN (2026-10-25)
revdep/run.R --rm delimtools dispositionEffect nadir partR2 fmeffects WpProj

## Drop packages failing on Bioconductor (2026-10-05)
revdep/run.R --rm pgxRpi SCArray.sat scLANE synergyfinder

## Drop packages no longer on CRAN (2026-07-19)
#revdep/run.R --rm ...

## Drop packages no longer on Bioconductor (2026-10-05)
#revdep/run.R --rm ...

## Fails to install
revdep/run.R --rm BayesPET marcxmlr TriDimRegression  # there is no package called ‘rstantools’

## Fails to check
revdep/run.R --rm mapme.biodiversity    # unstable results

## Too many cores due to detectCores /2026-09-23
pkgs_detectCores=(STARRS)
if [[ ${#pkgs_detectCores[@]} -gt 0 ]]; then
    revdep/run.R --rm "${pkgs_detectCores[@]}"
fi

# Too many cores /2026-09-23
pkgs_cores=()
if [[ ${#pkgs_cores[@]} -gt 0 ]]; then
    revdep/run.R --rm "${pkgs_cores[@]}"
fi

## Too many threads /2026-04-16
pkgs_threads=()
if [[ ${#pkgs_threads[@]} -gt 0 ]]; then
    revdep/run.R --rm "${pkgs_threads[@]}"
fi    

## Requires sequential processing due to clashes, e.g. port and cache 
pkgs_seq=(couplr datacaged dipsaus fiery ggchangepoint robust2sls SimDesign spanishoddata)
if [[ ${#pkgs_seq[@]} -gt 0 ]]; then
    revdep/run.R --rm "${pkgs_seq[@]}"
fi

## Run revdep check
revdep/run.R


## ---------------------------------------------------------------------
## Phase 2
## ---------------------------------------------------------------------
## Set: Too many cores
if [[ ${#pkgs_cores[@]} -gt 0 ]]; then
    revdep/run.R --add "${pkgs_cores[@]}"
    OMP_NUM_THREADS=4 NSLOTS=4 revdep/run.R
fi    

## Set: Too many threads
if [[ ${#pkgs_threads[@]} -gt 0 ]]; then
    revdep/run.R --add "${pkgs_threads[@]}"
    OMP_NUM_THREADS=4 revdep/run.R
fi

## Sequential
revdep/run.R --add "${pkgs_seq[@]}"
if [[ ${#pkgs_seq[@]} -gt 0 ]]; then
    NSLOTS=1 revdep/run.R
fi
