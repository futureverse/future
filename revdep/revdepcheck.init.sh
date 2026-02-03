#! /usr/bin/env bash

## Add packages to check
revdep/run.R --add-children

## Drop packages failing on CRAN (2026-01-31)
revdep/run.R --rm arkdb dispositionEffect forecastML mbbe

## Drop packages failing on Bioconductor (2026-01-31)
revdep/run.R --rm dar ISAnalytics MineICA pgxRpi RFLOMICS SCArray.sat scLANE

## Too many cores
# NSLOTS=112 revdep/run.R --add ale couplr fmeffects gtfs2emis gtfs2gps signeR simIDM
# NSLOTS=112 revdep/run.R --add simIDM WeightedCluster
