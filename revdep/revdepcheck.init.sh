#! /usr/bin/env bash

## Missing or outdated LaTeX packages
false && R --quiet --no-save <<EOF
    tinytex::install_tinytex(force = TRUE)
    message("TeX root: ", tinytex::tinytex_root())
    tinytex::tlmgr_update()
    tinytex::tlmgr_install("nowidow")  # QDNAseq
    tinytex::tlmgr_install("wrapfig")  # tramvs
    tinytex::tlmgr_install("apacite")  # ctsem
    tinytex::tlmgr_install("textpos")  # WeightedCluster
EOF

## Add packages to check
revdep/run.R --add-children

## Drop packages failing on CRAN (2026-03-07)
revdep/run.R --rm delimtools dispositionEffect EpiForsk spStack

## Drop packages no longer on CRAN (2026-03-07)
revdep/run.R --rm forecastML mbbe oncomsm

## Drop packages failing on Bioconductor (2026-03-07)
revdep/run.R --rm dar MineICA pgxRpi

## Too many cores
# NSLOTS=112 revdep/run.R --add ale couplr fmeffects gtfs2emis gtfs2gps signeR simIDM
# NSLOTS=112 revdep/run.R --add simIDM WeightedCluster
