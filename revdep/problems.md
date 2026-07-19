# altdoc (0.7.3)

* GitHub: <https://github.com/etiennebacher/altdoc>
* Email: <mailto:etienne.bacher@protonmail.com>
* GitHub mirror: <https://github.com/cran/altdoc>

Run `revdepcheck::revdep_details(, "altdoc")` for more info

## In both

*   checking for non-standard things in the check directory ... NOTE
     ```
     Found the following files/directories:
       ‘testpkg8661611a1ac1b’
     ```

# baseballr (1.6.0)

* GitHub: <https://github.com/BillPetti/baseballr>
* Email: <mailto:saiem.gilani@gmail.com>
* GitHub mirror: <https://github.com/cran/baseballr>

Run `revdepcheck::revdep_details(, "baseballr")` for more info

## In both

*   checking DESCRIPTION meta-information ... NOTE
     ```
       Missing dependency on R >= 4.1.0 because package code uses the pipe
       |> or function shorthand \(...) syntax added in R 4.1.0.
       File(s) using such syntax:
         ‘chadwick_installation.R’
     ```

# batchtools (0.9.18)

* GitHub: <https://github.com/mlr-org/batchtools>
* Email: <mailto:michellang@gmail.com>
* GitHub mirror: <https://github.com/cran/batchtools>

Run `revdepcheck::revdep_details(, "batchtools")` for more info

## In both

*   checking dependencies in R code ... NOTE
     ```
     ...
     dev3.wynton.ucsf.edu:pid904276.R: Unable to initialize verbs NIC /sys/class/infiniband/mlx5_0 (unit 0:0)
     dev3.wynton.ucsf.edu:pid904276: PSM3 can't open nic unit: 0 (err=23)
     dev3.wynton.ucsf.edu:pid904276.R: Unable to create send CQ of size 5080 on mlx5_0: Cannot allocate memory
     dev3.wynton.ucsf.edu:pid904276.R: Unable to initialize verbs NIC /sys/class/infiniband/mlx5_0 (unit 0:0)
     --------------------------------------------------------------------------
     No OpenFabrics connection schemes reported that they were able to be
     used on a specific port.  As such, the openib BTL (OpenFabrics
     support) will be disabled for this port.
     
       Local host:           dev3
       Local device:         mlx5_0
       Local port:           1
       CPCs attempted:       rdmacm, udcm
     --------------------------------------------------------------------------
     dev3.wynton.ucsf.edu:pid904276: PSM3 can't open nic unit: 0 (err=23)
     dev3.wynton.ucsf.edu:pid904276.R: Unable to create send CQ of size 5080 on mlx5_0: Cannot allocate memory
     dev3.wynton.ucsf.edu:pid904276.R: Unable to initialize verbs NIC /sys/class/infiniband/mlx5_0 (unit 0:0)
     --------------------------------------------------------------------------
     Open MPI failed an OFI Libfabric library call (fi_endpoint).  This is highly
     unusual; your job may behave unpredictably (and/or abort) after this.
     
       Local host: dev3
       Location: mtl_ofi_component.c:513
       Error: Invalid argument (22)
     --------------------------------------------------------------------------
     ```

*   checking for detritus in the temp directory ... NOTE
     ```
     Found the following files/directories:
       ‘ompi.dev3.34002’
     ```

# bayesian (1.0.1)

* GitHub: <https://github.com/hsbadr/bayesian>
* Email: <mailto:badr@jhu.edu>
* GitHub mirror: <https://github.com/cran/bayesian>

Run `revdepcheck::revdep_details(, "bayesian")` for more info

## In both

*   checking S3 generic/method consistency ... NOTE
     ```
     Mismatches for apparent methods not registered:
     check_args:
       function(object, call)
     check_args.bayesian:
       function(object)
     See section ‘Registering S3 methods’ in the ‘Writing R Extensions’
     manual.
     ```

# BayesPET (0.1.0)

* Email: <mailto:xinyi.he@uth.tmc.edu>
* GitHub mirror: <https://github.com/cran/BayesPET>

Run `revdepcheck::revdep_details(, "BayesPET")` for more info

## In both

*   checking whether package ‘BayesPET’ can be installed ... ERROR
     ```
     Installation failed.
     See ‘/scratch/henrik/revdep/future/checks/BayesPET/new/BayesPET.Rcheck/00install.out’ for details.
     ```

## Installation

### Devel

```
* installing *source* package ‘BayesPET’ ...
** this is package ‘BayesPET’ version ‘0.1.0’
** package ‘BayesPET’ successfully unpacked and MD5 sums checked
** using staged installation
Error in loadNamespace(x) : there is no package called ‘rstantools’
Calls: loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
Execution halted
ERROR: configuration failed for package ‘BayesPET’
* removing ‘/scratch/henrik/revdep/future/checks/BayesPET/new/BayesPET.Rcheck/BayesPET’


```
### CRAN

```
* installing *source* package ‘BayesPET’ ...
** this is package ‘BayesPET’ version ‘0.1.0’
** package ‘BayesPET’ successfully unpacked and MD5 sums checked
** using staged installation
Error in loadNamespace(x) : there is no package called ‘rstantools’
Calls: loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
Execution halted
ERROR: configuration failed for package ‘BayesPET’
* removing ‘/scratch/henrik/revdep/future/checks/BayesPET/old/BayesPET.Rcheck/BayesPET’


```
# caretSDM (1.9.7)

* GitHub: <https://github.com/luizesser/caretSDM>
* Email: <mailto:luizesser@gmail.com>
* GitHub mirror: <https://github.com/cran/caretSDM>

Run `revdepcheck::revdep_details(, "caretSDM")` for more info

## In both

*   checking examples ... ERROR
     ```
     ...
     Warning in CPL_write_gdal(mat, file, driver, options, type, dims, from,  :
       GDAL Error 1: PROJ: proj_as_wkt: DatumEnsemble can only be exported to WKT2:2019
     Warning in CPL_write_gdal(mat, file, driver, options, type, dims, from,  :
       GDAL Error 1: PROJ: proj_as_wkt: DatumEnsemble can only be exported to WKT2:2019
     Warning in CPL_gdalwarp(source, destination, options, oo, doo, config_options,  :
       GDAL Error 1: Cannot compute bounding box of cutline. Cannot find source SRS
     Error in `value[[3L]]()`:
     ✖ GDAL warp failed.
     In index: 1.
     Backtrace:
          ▆
       1. ├─caretSDM::add_predictors(sa, bioc)
       2. └─caretSDM:::add_predictors.stars(sa, bioc) at caretSDM/R/add_predictors.R:83:3
       3.   └─caretSDM:::.add_predictors(...) at caretSDM/R/add_predictors.R:109:3
       4.     ├─caretSDM::sdm_area(...) at caretSDM/R/add_predictors.R:123:3
       5.     └─caretSDM:::sdm_area.stars(...) at caretSDM/R/sdm_area.R:121:3
       6.       ├─dplyr::select(...) at caretSDM/R/sdm_area.R:283:5
       7.       └─caretSDM:::.sdm_area_from_stars_using_gdal(...) at caretSDM/R/sdm_area.R:283:5
       8.         └─base::tryCatch(...) at caretSDM/R/sdm_area.R:379:3
       9.           └─base (local) tryCatchList(expr, classes, parentenv, handlers)
      10.             └─base (local) tryCatchOne(expr, names, parentenv, handlers[[1L]])
      11.               └─value[[3L]](cond)
      12.                 └─cli::cli_abort(c(x = "GDAL warp failed.", i = e$message)) at caretSDM/R/sdm_area.R:430:7
      13.                   └─rlang::abort(...)
     Execution halted
     ```

*   checking tests ...
     ```
     ...
         9.             └─cli::cli_abort(c(x = "GDAL warp failed.", i = e$message)) at caretSDM/R/sdm_area.R:430:7
        10.               └─rlang::abort(...)
       ── Error ('test-train_sdm.R:4:3'): (code run outside of `test_that()`) ─────────
       Error in `value[[3L]](cond)`: x GDAL warp failed.
       In index: 1.
       Backtrace:
            ▆
         1. ├─caretSDM::add_predictors(sa, bioc) at test-train_sdm.R:4:3
         2. └─caretSDM:::add_predictors.stars(sa, bioc) at caretSDM/R/add_predictors.R:83:3
         3.   └─caretSDM:::.add_predictors(...) at caretSDM/R/add_predictors.R:109:3
         4.     ├─caretSDM::sdm_area(...) at caretSDM/R/add_predictors.R:123:3
         5.     └─caretSDM:::sdm_area.stars(...) at caretSDM/R/sdm_area.R:121:3
         6.       ├─dplyr::select(...) at caretSDM/R/sdm_area.R:283:5
         7.       └─caretSDM:::.sdm_area_from_stars_using_gdal(...) at caretSDM/R/sdm_area.R:283:5
         8.         └─base::tryCatch(...) at caretSDM/R/sdm_area.R:379:3
         9.           └─base (local) tryCatchList(expr, classes, parentenv, handlers)
        10.             └─base (local) tryCatchOne(expr, names, parentenv, handlers[[1L]])
        11.               └─value[[3L]](cond)
        12.                 └─cli::cli_abort(c(x = "GDAL warp failed.", i = e$message)) at caretSDM/R/sdm_area.R:430:7
        13.                   └─rlang::abort(...)
       
       [ FAIL 18 | WARN 63 | SKIP 75 | PASS 304 ]
       Error:
       ! Test failures.
       Execution halted
     ```

# ceRNAnetsim (1.24.0)

* GitHub: <https://github.com/selcenari/ceRNAnetsim>
* Email: <mailto:selcenarii@gmail.com>

Run `revdepcheck::revdep_details(, "ceRNAnetsim")` for more info

## In both

*   checking R code for possible problems ... NOTE
     ```
     find_node_perturbation: no visible binding for global variable
       ‘perturbation_efficiency’
       (/scratch/henrik/revdep/future/checks/ceRNAnetsim/new/ceRNAnetsim.Rcheck/00_pkg_src/ceRNAnetsim/R/find_node_perturbation.R:80-85)
     find_node_perturbation: no visible binding for global variable
       ‘perturbed_count’
       (/scratch/henrik/revdep/future/checks/ceRNAnetsim/new/ceRNAnetsim.Rcheck/00_pkg_src/ceRNAnetsim/R/find_node_perturbation.R:80-85)
     simulate: no visible binding for global variable ‘avg_count_current’
       (/scratch/henrik/revdep/future/checks/ceRNAnetsim/new/ceRNAnetsim.Rcheck/00_pkg_src/ceRNAnetsim/R/simulate.R:53-78)
     simulate: no visible binding for global variable ‘avg_count_pre’
       (/scratch/henrik/revdep/future/checks/ceRNAnetsim/new/ceRNAnetsim.Rcheck/00_pkg_src/ceRNAnetsim/R/simulate.R:53-78)
     simulate: no visible binding for global variable ‘avg_count_current’
       (/scratch/henrik/revdep/future/checks/ceRNAnetsim/new/ceRNAnetsim.Rcheck/00_pkg_src/ceRNAnetsim/R/simulate.R:80)
     simulate: no visible binding for global variable ‘avg_count_pre’
       (/scratch/henrik/revdep/future/checks/ceRNAnetsim/new/ceRNAnetsim.Rcheck/00_pkg_src/ceRNAnetsim/R/simulate.R:80)
     simulate: no visible binding for global variable ‘avg_count_current’
       (/scratch/henrik/revdep/future/checks/ceRNAnetsim/new/ceRNAnetsim.Rcheck/00_pkg_src/ceRNAnetsim/R/simulate.R:86-110)
     simulate: no visible binding for global variable ‘avg_count_pre’
       (/scratch/henrik/revdep/future/checks/ceRNAnetsim/new/ceRNAnetsim.Rcheck/00_pkg_src/ceRNAnetsim/R/simulate.R:86-110)
     simulate: no visible binding for global variable ‘avg_count_current’
       (/scratch/henrik/revdep/future/checks/ceRNAnetsim/new/ceRNAnetsim.Rcheck/00_pkg_src/ceRNAnetsim/R/simulate.R:112)
     simulate: no visible binding for global variable ‘avg_count_pre’
       (/scratch/henrik/revdep/future/checks/ceRNAnetsim/new/ceRNAnetsim.Rcheck/00_pkg_src/ceRNAnetsim/R/simulate.R:112)
     Undefined global functions or variables:
       avg_count_current avg_count_pre perturbation_efficiency
       perturbed_count
     ```

# chevreulShiny (1.4.0)

* GitHub: <https://github.com/cobriniklab/chevreulShiny>
* Email: <mailto:kevin.stachelek@gmail.com>

Run `revdepcheck::revdep_details(, "chevreulShiny")` for more info

## In both

*   checking DESCRIPTION meta-information ... NOTE
     ```
     License stub is invalid DCF.
     ```

# chopin (0.9.9-5)

* GitHub: <https://github.com/ropensci/chopin>
* Email: <mailto:geoissong@gmail.com>
* GitHub mirror: <https://github.com/cran/chopin>

Run `revdepcheck::revdep_details(, "chopin")` for more info

## In both

*   checking re-building of vignette outputs ... ERROR
     ```
     ...
     ✖ Input sf object should be able to be converted to polygons.
     ---
     Backtrace:
         ▆
      1. ├─base::suppressWarnings(...)
      2. │ └─base::withCallingHandlers(...)
      3. └─chopin::par_pad_grid(ncpoints_tr, mode = "h3", res = 4L, padding = 10000)
      4.   └─chopin::par_make_h3(x = input, res = res) at chopin/R/gridding.R:136:5
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     
     Error: processing vignette 'v03_par_pad_grid.Rmd' failed with diagnostics:
     ✖ Input sf object should be able to be converted to polygons.
     --- failed re-building ‘v03_par_pad_grid.Rmd’
     
     --- re-building ‘v04_climate_examples.Rmd’ using rmarkdown
     --- finished re-building ‘v04_climate_examples.Rmd’
     
     --- re-building ‘v05_targets.Rmd’ using rmarkdown
     --- finished re-building ‘v05_targets.Rmd’
     
     SUMMARY: processing the following file failed:
       ‘v03_par_pad_grid.Rmd’
     
     Error: Vignette re-building failed.
     Execution halted
     ```

# ChromSCape (1.22.0)

* GitHub: <https://github.com/vallotlab/ChromSCape>
* Email: <mailto:pacome.pr@gmail.com>

Run `revdepcheck::revdep_details(, "ChromSCape")` for more info

## In both

*   checking for hidden files and directories ... NOTE
     ```
     Found the following hidden files and directories:
       .BBSoptions
     These were most likely included in error. See section ‘Package
     structure’ in the ‘Writing R Extensions’ manual.
     ```

*   checking R code for possible problems ... NOTE
     ```
     ...
     plot_top_TF_scExp: no visible binding for global variable ‘TF’
       (/scratch/henrik/revdep/future/checks/ChromSCape/new/ChromSCape.Rcheck/00_pkg_src/ChromSCape/R/plotting_functions.R:1212-1215)
     plot_top_TF_scExp: no visible binding for global variable ‘TF’
       (/scratch/henrik/revdep/future/checks/ChromSCape/new/ChromSCape.Rcheck/00_pkg_src/ChromSCape/R/plotting_functions.R:1216-1222)
     plot_top_TF_scExp: no visible binding for global variable ‘TF’
       (/scratch/henrik/revdep/future/checks/ChromSCape/new/ChromSCape.Rcheck/00_pkg_src/ChromSCape/R/plotting_functions.R:1225-1228)
     plot_top_TF_scExp: no visible binding for global variable ‘TF’
       (/scratch/henrik/revdep/future/checks/ChromSCape/new/ChromSCape.Rcheck/00_pkg_src/ChromSCape/R/plotting_functions.R:1229-1235)
     rebin_helper: no visible binding for global variable ‘new_row’
       (/scratch/henrik/revdep/future/checks/ChromSCape/new/ChromSCape.Rcheck/00_pkg_src/ChromSCape/R/preprocessing_filtering_reduction.R:869-870)
     rebin_helper: no visible binding for global variable ‘origin_value’
       (/scratch/henrik/revdep/future/checks/ChromSCape/new/ChromSCape.Rcheck/00_pkg_src/ChromSCape/R/preprocessing_filtering_reduction.R:869-870)
     rebin_matrix: no visible binding for global variable ‘group’
       (/scratch/henrik/revdep/future/checks/ChromSCape/new/ChromSCape.Rcheck/00_pkg_src/ChromSCape/R/preprocessing_filtering_reduction.R:1007)
     subset_bam_call_peaks: no visible binding for global variable
       ‘merged_bam’
       (/scratch/henrik/revdep/future/checks/ChromSCape/new/ChromSCape.Rcheck/00_pkg_src/ChromSCape/R/peak_calling.R:118-119)
     Undefined global functions or variables:
       CheA3_TF_nTargets Component Fri_cyto Gain_or_Loss Gene TF V1 V2
       absolute_value cluster clusterConsensus cytoBand files_dir_list genes
       group head k merged_bam molecule ncells new_row orientation
       origin_value percent_active run_tsne sample_id total_counts
     Consider adding
       importFrom("utils", "head")
     to your NAMESPACE file.
     ```

# conformalInference.fd (1.1.1)

* GitHub: <https://github.com/ryantibs/conformal>
* Email: <mailto:paolo.vergottini@gmail.com>
* GitHub mirror: <https://github.com/cran/conformalInference.fd>

Run `revdepcheck::revdep_details(, "conformalInference.fd")` for more info

## In both

*   checking S3 generic/method consistency ... NOTE
     ```
     Mismatches for apparent methods not registered:
     max:
       function(..., na.rm)
     max.lol:
       function(l)
     
     min:
       function(..., na.rm)
     min.lol:
       function(l)
     See section ‘Registering S3 methods’ in the ‘Writing R Extensions’
     manual.
     ```

# CrcBiomeScreen (1.0.0)

* GitHub: <https://github.com/omicsForestry/CrcBiomeScreen>
* Email: <mailto:ngzh5554@leeds.ac.uk>

Run `revdepcheck::revdep_details(, "CrcBiomeScreen")` for more info

## In both

*   checking for non-standard things in the check directory ... NOTE
     ```
     Found the following files/directories:
       ‘roc.curve.rf.RF_TSS_toydata_Validation.pdf’
     ```

# cSEM (0.6.1)

* GitHub: <https://github.com/FloSchuberth/cSEM>
* Email: <mailto:f.schuberth@utwente.nl>
* GitHub mirror: <https://github.com/cran/cSEM>

Run `revdepcheck::revdep_details(, "cSEM")` for more info

## In both

*   checking dependencies in R code ... NOTE
     ```
     Namespace in Imports field not imported from: ‘Rdpack’
       All declared Imports should be used.
     ```

# dispositionEffect (1.0.1)

* GitHub: <https://github.com/marcozanotti/dispositionEffect>
* Email: <mailto:zanottimarco17@gmail.com>
* GitHub mirror: <https://github.com/cran/dispositionEffect>

Run `revdepcheck::revdep_details(, "dispositionEffect")` for more info

## In both

*   checking tests ...
     ```
     ...
       ── Failure ('test-realized_duration.R:152:2'): realized_duration works (realized_only = TRUE) ──
       Expected `realized_duration(...)` to equal `c(...)`.
       Differences:
       1/4 mismatches
       [2] 34 - 28 == 6
       ── Failure ('test-realized_duration.R:155:2'): realized_duration works (realized_only = TRUE) ──
       Expected `realized_duration(...)` to equal `c(...)`.
       Differences:
       1/4 mismatches
       [1] 34 - 28 == 6
       ── Failure ('test-realized_duration.R:158:2'): realized_duration works (realized_only = TRUE) ──
       Expected `realized_duration(...)` to equal `c(...)`.
       Differences:
       1/4 mismatches
       [2] 34 - 28 == 6
       ── Failure ('test-realized_duration.R:161:2'): realized_duration works (realized_only = TRUE) ──
       Expected `realized_duration(...)` to equal `c(...)`.
       Differences:
       1/4 mismatches
       [1] 34 - 28 == 6
       
       [ FAIL 36 | WARN 0 | SKIP 0 | PASS 331 ]
       Error:
       ! Test failures.
       Execution halted
     ```

# envi (1.0.1)

* GitHub: <https://github.com/lance-waller-lab/envi>
* Email: <mailto:ian.buller@alumni.emory.edu>
* GitHub mirror: <https://github.com/cran/envi>

Run `revdepcheck::revdep_details(, "envi")` for more info

## In both

*   checking whether package ‘envi’ can be installed ... WARNING
     ```
     Found the following significant warnings:
       Warning: no DISPLAY variable so Tk is not available
     See ‘/scratch/henrik/revdep/future/checks/envi/new/envi.Rcheck/00install.out’ for details.
     ```

# fastRhockey (0.4.0)

* GitHub: <https://github.com/sportsdataverse/fastRhockey>
* Email: <mailto:saiem.gilani@gmail.com>
* GitHub mirror: <https://github.com/cran/fastRhockey>

Run `revdepcheck::revdep_details(, "fastRhockey")` for more info

## In both

*   checking Rd files ... NOTE
     ```
     checkRd: (-1) update_nhl_db.Rd:51-53: Lost braces in \itemize; meant \describe ?
     checkRd: (-1) update_nhl_db.Rd:54-57: Lost braces in \itemize; meant \describe ?
     checkRd: (-1) update_phf_db.Rd:51-53: Lost braces in \itemize; meant \describe ?
     checkRd: (-1) update_phf_db.Rd:54-57: Lost braces in \itemize; meant \describe ?
     ```

# flowGraph (1.20.0)

* GitHub: <https://github.com/aya49/flowGraph>
* Email: <mailto:aya43@sfu.ca>

Run `revdepcheck::revdep_details(, "flowGraph")` for more info

## In both

*   checking R code for possible problems ... NOTE
     ```
     get_child: no visible binding for global variable ‘no_cores’
       (/scratch/henrik/revdep/future/checks/flowGraph/new/flowGraph.Rcheck/00_pkg_src/flowGraph/R/00_flowGraphSubset_constructor.R:181-187)
     get_paren: no visible binding for global variable ‘no_cores’
       (/scratch/henrik/revdep/future/checks/flowGraph/new/flowGraph.Rcheck/00_pkg_src/flowGraph/R/00_flowGraphSubset_constructor.R:222-229)
     ms_psig: no visible binding for global variable ‘meta’
       (/scratch/henrik/revdep/future/checks/flowGraph/new/flowGraph.Rcheck/00_pkg_src/flowGraph/R/00_flowGraphSubset_constructor.R:296)
     Undefined global functions or variables:
       meta no_cores
     ```

*   checking Rd files ... NOTE
     ```
     checkRd: (-1) fg_get_graph.Rd:13: Lost braces
         13 | A list containing two data frames (\code{v} and ]code{e})
            |                                                      ^
     checkRd: (-1) ggdf.Rd:22: Lost braces
         22 | code{ggdf} adds to the data frames \code{v} and \code{e} in slot
            |     ^
     ```

*   checking for non-standard things in the check directory ... NOTE
     ```
     Found the following files/directories:
       ‘temp’ ‘tmp’
     ```

# future.batchtools (0.22.0)

* GitHub: <https://github.com/futureverse/future.batchtools>
* Email: <mailto:henrikb@braju.com>
* GitHub mirror: <https://github.com/cran/future.batchtools>

Run `revdepcheck::revdep_details(, "future.batchtools")` for more info

## In both

*   checking for non-standard things in the check directory ... NOTE
     ```
     Found the following files/directories:
       ‘.future-set-during-startup’
     ```

# geocmeans (0.3.4)

* GitHub: <https://github.com/JeremyGelb/geocmeans>
* Email: <mailto:jeremy.gelb@ucs.inrs.ca>
* GitHub mirror: <https://github.com/cran/geocmeans>

Run `revdepcheck::revdep_details(, "geocmeans")` for more info

## In both

*   checking re-building of vignette outputs ... ERROR
     ```
     ...
     ! method not available for GDAL: 3.0.4
     ---
     Backtrace:
          ▆
       1. ├─base::withVisible(knit_print(x, ...))
       2. ├─knitr::knit_print(x, ...)
       3. └─tmap:::knit_print.tmap(x, ...)
       4.   └─tmap:::print.tmap(x, knit = TRUE, options = options, ...)
       5.     └─tmap:::step4_plot(...)
       6.       ├─base::do.call(tmaptools::bb, c(list(x = full_bbox(crs)), bbo_args))
       7.       └─tmap:::full_bbox(crs)
       8.         ├─sf::st_bbox(sf::st_transform(sf::st_bbox(), crs = crs))
       9.         ├─sf::st_transform(sf::st_bbox(), crs = crs)
      10.         └─sf:::st_transform.bbox(sf::st_bbox(), crs = crs)
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     
     Error: processing vignette 'introduction.Rmd' failed with diagnostics:
     method not available for GDAL: 3.0.4
     --- failed re-building ‘introduction.Rmd’
     
     SUMMARY: processing the following file failed:
       ‘introduction.Rmd’
     
     Error: Vignette re-building failed.
     Execution halted
     ```

# googleTagManageR (0.2.0)

* Email: <mailto:r@jamescottrill.co.uk>
* GitHub mirror: <https://github.com/cran/googleTagManageR>

Run `revdepcheck::revdep_details(, "googleTagManageR")` for more info

## In both

*   checking dependencies in R code ... NOTE
     ```
     Namespaces in Imports field not imported from:
       ‘assertthat’ ‘future’ ‘httr’
       All declared Imports should be used.
     ```

# infercnv (1.28.0)

* GitHub: <https://github.com/broadinstitute/inferCNV>
* Email: <mailto:cgeorges@broadinstitute.org>

Run `revdepcheck::revdep_details(, "infercnv")` for more info

## In both

*   checking dependencies in R code ... NOTE
     ```
     Unexported object imported by a ':::' call: ‘HiddenMarkov:::makedensity’
       See the note in ?`:::` about the use of this operator.
     ```

*   checking Rd files ... NOTE
     ```
     checkRd: (-1) run.Rd:268: Lost braces; missing escapes or markup?
        268 | \item{require_DE_all_normals}{If mask_nonDE_genes is set, those genes will be masked only if they are are found as DE according to test.use and mask_nonDE_pval in each of the comparisons to normal cells options: {"any", "most", "all"} (default: "any")
            |                                                                                                                                                                                                                     ^
     ```

# InPAS (2.20.0)

* Email: <mailto:jou@morgridge.org>

Run `revdepcheck::revdep_details(, "InPAS")` for more info

## In both

*   checking package dependencies ... ERROR
     ```
     Package required but not available: ‘depmixS4’
     
     See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
     manual.
     ```

# ivmte (1.4.0)

* Email: <mailto:jkcshea@uchicago.edu>
* GitHub mirror: <https://github.com/cran/ivmte>

Run `revdepcheck::revdep_details(, "ivmte")` for more info

## In both

*   checking Rd files ... NOTE
     ```
     checkRd: (-1) sTsls.Rd:17: Lost braces; missing escapes or markup?
         17 | \item{pi}{the matrix E[XZ']E[ZZ']^{-1}}
            |                                   ^
     checkRd: (-1) sTslsSplines.Rd:20: Lost braces; missing escapes or markup?
         20 | \item{pi}{matrix, corresponds to E[XZ']E[ZZ']^{-1}, the first stage
            |                                               ^
     ```

# MAI (1.18.0)

* GitHub: <https://github.com/KechrisLab/MAI>
* Email: <mailto:Jonathan.Dekermanjian@CUAnschutz.edu>

Run `revdepcheck::revdep_details(, "MAI")` for more info

## In both

*   checking top-level files ... NOTE
     ```
     File
       LICENSE
     is not mentioned in the DESCRIPTION file.
     ```

# mapme.biodiversity (0.9.6)

* GitHub: <https://github.com/mapme-initiative/mapme.biodiversity>
* Email: <mailto:zivan.karaman@gmail.com>
* GitHub mirror: <https://github.com/cran/mapme.biodiversity>

Run `revdepcheck::revdep_details(, "mapme.biodiversity")` for more info

## In both

*   checking tests ...
     ```
     ...
                            (right here) ------^
       Backtrace:
            ▆
         1. ├─mapme.biodiversity::make_footprints(tifs, what = "raster") at test-get_resources.R:72:3
         2. │ └─purrr::map2(srcs, oo, function(src, opt) .raster_footprint(src, opt)) at mapme.biodiversity/R/spatial-utils.R:146:5
         3. │   └─purrr:::map2_("list", .x, .y, .f, ..., .progress = .progress)
         4. │     ├─purrr:::with_indexed_errors(...)
         5. │     │ └─base::withCallingHandlers(...)
         6. │     ├─purrr:::call_with_cleanup(...)
         7. │     └─mapme.biodiversity (local) .f(.x[[i]], .y[[i]], ...)
         8. │       └─mapme.biodiversity:::.raster_footprint(src, opt) at mapme.biodiversity/R/spatial-utils.R:146:5
         9. │         └─mapme.biodiversity:::.raster_info(src, oo) at mapme.biodiversity/R/spatial-utils.R:291:3
        10. │           └─jsonlite::parse_json(info) at mapme.biodiversity/R/spatial-utils.R:315:3
        11. │             └─jsonlite:::parse_and_simplify(...)
        12. │               └─jsonlite:::parseJSON(txt, bigint_as_char)
        13. │                 └─jsonlite:::parse_string(txt, bigint_as_char)
        14. └─base::.handleSimpleError(...)
        15.   └─purrr (local) h(simpleError(msg, call))
        16.     └─cli::cli_abort(...)
        17.       └─rlang::abort(...)
       
       [ FAIL 2 | WARN 0 | SKIP 44 | PASS 526 ]
       Error:
       ! Test failures.
       Execution halted
     ```

*   checking whether package ‘mapme.biodiversity’ can be installed ... WARNING
     ```
     Found the following significant warnings:
       Warning: GDAL system library version (3.0.4) < 3.7.0
     See ‘/scratch/henrik/revdep/future/checks/mapme.biodiversity/new/mapme.biodiversity.Rcheck/00install.out’ for details.
     ```

*   checking whether the namespace can be loaded with stated dependencies ... NOTE
     ```
     Warning: GDAL system library version (3.0.4) < 3.7.0
     
     A namespace must be able to be loaded with just the base namespace
     loaded: otherwise if the namespace gets loaded by a saved object, the
     session will be unable to start.
     
     Probably some imports need to be declared in the NAMESPACE file.
     ```

# mikropml (1.7.0)

* GitHub: <https://github.com/SchlossLab/mikropml>
* Email: <mailto:sovacool@umich.edu>
* GitHub mirror: <https://github.com/cran/mikropml>

Run `revdepcheck::revdep_details(, "mikropml")` for more info

## In both

*   checking dependencies in R code ... NOTE
     ```
     Namespace in Imports field not imported from: ‘methods’
       All declared Imports should be used.
     ```

# mistyR (1.20.0)

* GitHub: <https://github.com/saezlab/mistyR>
* Email: <mailto:jovan.tanevski@uni-heidelberg.de>

Run `revdepcheck::revdep_details(, "mistyR")` for more info

## In both

*   checking R code for possible problems ... NOTE
     ```
     ...
     plot_view_contributions: no visible binding for global variable ‘view’
       (/scratch/henrik/revdep/future/checks/mistyR/new/mistyR.Rcheck/00_pkg_src/mistyR/R/plots.R:131-137)
     run_misty : <anonymous>: no visible binding for global variable ‘p’
       (/scratch/henrik/revdep/future/checks/mistyR/new/mistyR.Rcheck/00_pkg_src/mistyR/R/misty.R:256-264)
     run_misty : <anonymous>: no visible binding for global variable
       ‘intra.RMSE’
       (/scratch/henrik/revdep/future/checks/mistyR/new/mistyR.Rcheck/00_pkg_src/mistyR/R/misty.R:328-356)
     run_misty : <anonymous>: no visible binding for global variable
       ‘multi.RMSE’
       (/scratch/henrik/revdep/future/checks/mistyR/new/mistyR.Rcheck/00_pkg_src/mistyR/R/misty.R:328-356)
     run_misty : <anonymous>: no visible binding for global variable
       ‘intra.R2’
       (/scratch/henrik/revdep/future/checks/mistyR/new/mistyR.Rcheck/00_pkg_src/mistyR/R/misty.R:328-356)
     run_misty : <anonymous>: no visible binding for global variable
       ‘multi.R2’
       (/scratch/henrik/revdep/future/checks/mistyR/new/mistyR.Rcheck/00_pkg_src/mistyR/R/misty.R:328-356)
     svm_model: no visible binding for global variable ‘index’
       (/scratch/henrik/revdep/future/checks/mistyR/new/mistyR.Rcheck/00_pkg_src/mistyR/R/model-functions.R:422-446)
     Undefined global functions or variables:
       .PT Importance Predictor Target fraction index intra.R2 intra.RMSE
       measure multi.R2 multi.RMSE nsamples p prediction sd target total ts
       value view
     Consider adding
       importFrom("stats", "sd", "ts")
     to your NAMESPACE file.
     ```

*   checking Rd files ... NOTE
     ```
     checkRd: (-1) collect_results.Rd:32: Lost braces; missing escapes or markup?
         32 |             for all performance measures for each {target} over all samples.}
            |                                                   ^
     ```

*   checking for non-standard things in the check directory ... NOTE
     ```
     Found the following files/directories:
       ‘results’
     ```

# mlr3summary (0.1.2)

* GitHub: <https://github.com/mlr-org/mlr3summary>
* Email: <mailto:dandls.datascience@gmail.com>
* GitHub mirror: <https://github.com/cran/mlr3summary>

Run `revdepcheck::revdep_details(, "mlr3summary")` for more info

## In both

*   checking Rd cross-references ... NOTE
     ```
     Unknown package ‘fastshap’ in Rd xrefs
     ```

# multiverse (0.6.2)

* GitHub: <https://github.com/MUCollective/multiverse>
* Email: <mailto:abhraneel@u.northwestern.edu>
* GitHub mirror: <https://github.com/cran/multiverse>

Run `revdepcheck::revdep_details(, "multiverse")` for more info

## In both

*   checking DESCRIPTION meta-information ... NOTE
     ```
       Missing dependency on R >= 4.1.0 because package code uses the pipe
       |> or function shorthand \(...) syntax added in R 4.1.0.
       File(s) using such syntax:
         ‘accessors.R’ ‘export_json.R’ ‘extract.R’
     ```

# nfl4th (1.0.7)

* GitHub: <https://github.com/nflverse/nfl4th>
* Email: <mailto:bbaldwin206@gmail.com>
* GitHub mirror: <https://github.com/cran/nfl4th>

Run `revdepcheck::revdep_details(, "nfl4th")` for more info

## In both

*   checking whether startup messages can be suppressed ... NOTE
     ```
     ! GitHub.com seems offline, and `options(nfl4th.keep_games)` is not set to TRUE. Deleting the games cache, and predictions may not be available without an internet connection.
     
     It looks like this package (or a package it requires) has a startup
     message which cannot be suppressed: see ?packageStartupMessage.
     ```

# OutSeekR (1.1.0)

* Email: <mailto:pboutros@sbpdiscovery.org>
* GitHub mirror: <https://github.com/cran/OutSeekR>

Run `revdepcheck::revdep_details(, "OutSeekR")` for more info

## In both

*   checking dependencies in R code ... NOTE
     ```
     Namespaces in Imports field not imported from:
       ‘future’ ‘truncnorm’
       All declared Imports should be used.
     ```

# partR2 (0.9.2)

* GitHub: <https://github.com/mastoffel/partR2>
* Email: <mailto:martin.adam.stoffel@gmail.com>
* GitHub mirror: <https://github.com/cran/partR2>

Run `revdepcheck::revdep_details(, "partR2")` for more info

## In both

*   checking dependencies in R code ... NOTE
     ```
     Namespace in Imports field not imported from: ‘methods’
       All declared Imports should be used.
     ```

# pgxRpi (1.7.0)

* GitHub: <https://github.com/progenetix/pgxRpi>
* Email: <mailto:hangjia.zhao@uzh.ch>

Run `revdepcheck::revdep_details(, "pgxRpi")` for more info

## In both

*   checking tests ...
     ```
     ...
       
       ══ Failed tests ════════════════════════════════════════════════════════════════
       ── Failure ('test_variants.R:28:5'): retrieve variants with pgxseg ─────────────
       Expected `http_type(r)` to equal "text/plain".
       Differences:
       1/1 mismatches
       x[1]: "text/html"
       y[1]: "text/plain"
       ── Failure ('test_variants.R:29:5'): retrieve variants with pgxseg ─────────────
       Expected `... <- NULL` not to throw any errors.
       Actually got a <simpleError> with message:
         cannot open the connection to 'https://progenetix.org/services/pgxsegvariants/?biosampleIds=pgxbs-kftvlaih,pgxbs-kftvjgcc'
       ── Error ('test_variants.R:30:5'): retrieve variants with pgxseg ───────────────
       Error in `eval(code, test_env)`: object 'result' not found
       Backtrace:
           ▆
        1. ├─testthat::expect_gt(nrow(result), 0) at test_variants.R:30:5
        2. │ └─testthat::quasi_label(enquo(object), label)
        3. │   └─rlang::eval_bare(expr, quo_get_env(quo))
        4. └─base::nrow(result)
       
       [ FAIL 3 | WARN 1 | SKIP 0 | PASS 38 ]
       Error:
       ! Test failures.
       Execution halted
     ```

*   checking re-building of vignette outputs ... ERROR
     ```
     ...
         ▆
      1. └─pgxRpi::segtoFreq(segdata, cnv_column_idx = 6, cohort_name = "c1")
      2.   └─base::colSums(bin.dup.data1) at pgxRpi/R/segtoFreq.R:57:9
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     
     Error: processing vignette 'Introduction_3_access_cnv_frequency.Rmd' failed with diagnostics:
     'x' must be an array of at least two dimensions
     --- failed re-building ‘Introduction_3_access_cnv_frequency.Rmd’
     
     --- re-building ‘Introduction_4_process_pgxseg.Rmd’ using rmarkdown
     The magick package is required to crop "/scratch/henrik/revdep/future/checks/pgxRpi/new/pgxRpi.Rcheck/vign_test/pgxRpi/vignettes/Introduction_4_process_pgxseg_files/figure-html/unnamed-chunk-6-1.png" but not available.
     The magick package is required to crop "/scratch/henrik/revdep/future/checks/pgxRpi/new/pgxRpi.Rcheck/vign_test/pgxRpi/vignettes/Introduction_4_process_pgxseg_files/figure-html/unnamed-chunk-7-1.png" but not available.
     The magick package is required to crop "/scratch/henrik/revdep/future/checks/pgxRpi/new/pgxRpi.Rcheck/vign_test/pgxRpi/vignettes/Introduction_4_process_pgxseg_files/figure-html/unnamed-chunk-8-1.png" but not available.
     The magick package is required to crop "/scratch/henrik/revdep/future/checks/pgxRpi/new/pgxRpi.Rcheck/vign_test/pgxRpi/vignettes/Introduction_4_process_pgxseg_files/figure-html/unnamed-chunk-13-1.png" but not available.
     The magick package is required to crop "/scratch/henrik/revdep/future/checks/pgxRpi/new/pgxRpi.Rcheck/vign_test/pgxRpi/vignettes/Introduction_4_process_pgxseg_files/figure-html/unnamed-chunk-14-1.png" but not available.
     The magick package is required to crop "/scratch/henrik/revdep/future/checks/pgxRpi/new/pgxRpi.Rcheck/vign_test/pgxRpi/vignettes/Introduction_4_process_pgxseg_files/figure-html/unnamed-chunk-15-1.png" but not available.
     The magick package is required to crop "/scratch/henrik/revdep/future/checks/pgxRpi/new/pgxRpi.Rcheck/vign_test/pgxRpi/vignettes/Introduction_4_process_pgxseg_files/figure-html/unnamed-chunk-16-1.png" but not available.
     --- finished re-building ‘Introduction_4_process_pgxseg.Rmd’
     
     SUMMARY: processing the following files failed:
       ‘Introduction_2_query_variants.Rmd’
       ‘Introduction_3_access_cnv_frequency.Rmd’
     
     Error: Vignette re-building failed.
     Execution halted
     ```

*   checking R code for possible problems ... NOTE
     ```
     pgxSegprocess: no visible binding for global variable
       ‘followup_state_id’
       (/scratch/henrik/revdep/future/checks/pgxRpi/new/pgxRpi.Rcheck/00_pkg_src/pgxRpi/R/pgxSegprocess.R:58)
     Undefined global functions or variables:
       followup_state_id
     ```

# photosynthesis (2.1.5)

* GitHub: <https://github.com/cdmuir/photosynthesis>
* Email: <mailto:cdmuir@wisc.edu>
* GitHub mirror: <https://github.com/cran/photosynthesis>

Run `revdepcheck::revdep_details(, "photosynthesis")` for more info

## In both

*   checking DESCRIPTION meta-information ... NOTE
     ```
       Missing dependency on R >= 4.1.0 because package code uses the pipe
       |> or function shorthand \(...) syntax added in R 4.1.0.
       File(s) using such syntax:
         ‘bake-par.R’ ‘bake.R’ ‘calculated-parameters.R’ ‘conductance.R’
         ‘constants.R’ ‘enviro-par.R’ ‘fit_aq_response.R’
         ‘fit_aq_response2.Rd’ ‘fit_photosynthesis.R’ ‘fit_r_light.R’
         ‘fit_r_light2.Rd’ ‘leaf-par.R’ ‘make_parameters.R’ ‘models.R’
         ‘parameter_names.R’ ‘photosynthesis.R’ ‘read_licor.R’
         ‘simulate_error.R’ ‘simulate_error.Rd’ ‘utils.R’
     ```

# powRICLPM (0.2.1)

* GitHub: <https://github.com/JeroenDMulder/powRICLPM>
* Email: <mailto:j.d.mulder@uu.nl>
* GitHub mirror: <https://github.com/cran/powRICLPM>

Run `revdepcheck::revdep_details(, "powRICLPM")` for more info

## In both

*   checking DESCRIPTION meta-information ... NOTE
     ```
       Missing dependency on R >= 4.1.0 because package code uses the pipe
       |> or function shorthand \(...) syntax added in R 4.1.0.
       File(s) using such syntax:
         ‘save.R’
     ```

# Prostar (1.44.0)

* GitHub: <https://github.com/edyp-lab/Prostar>
* Email: <mailto:samuel.wieczorek@cea.fr>

Run `revdepcheck::revdep_details(, "Prostar")` for more info

## In both

*   checking for hidden files and directories ... NOTE
     ```
     Found the following hidden files and directories:
       docs/.nojekyll
     These were most likely included in error. See section ‘Package
     structure’ in the ‘Writing R Extensions’ manual.
     ```

*   checking dependencies in R code ... NOTE
     ```
     Namespaces in Imports field not imported from:
       ‘DT’ ‘R.utils’ ‘RColorBrewer’ ‘XML’ ‘colourpicker’ ‘future’ ‘ggplot2’
       ‘gtools’ ‘markdown’ ‘rclipboard’ ‘sass’ ‘shinyTree’ ‘shinyWidgets’
       All declared Imports should be used.
     ```

*   checking files in ‘vignettes’ ... NOTE
     ```
     The following files look like leftovers/mistakes:
       ‘Prostar_UserManual.log’
     Please remove them from your package.
     ```

# pseudohouseholds (0.1.1)

* GitHub: <https://github.com/chris31415926535/pseudohouseholds>
* Email: <mailto:christopher.a.belanger@gmail.com>
* GitHub mirror: <https://github.com/cran/pseudohouseholds>

Run `revdepcheck::revdep_details(, "pseudohouseholds")` for more info

## In both

*   checking DESCRIPTION meta-information ... NOTE
     ```
       Missing dependency on R >= 4.1.0 because package code uses the pipe
       |> or function shorthand \(...) syntax added in R 4.1.0.
       File(s) using such syntax:
         ‘pseudohouseholds.R’
     ```

# reems (0.1.0)

* Email: <mailto:felix.weitkaemper@german-uds.de>
* GitHub mirror: <https://github.com/cran/reems>

Run `revdepcheck::revdep_details(, "reems")` for more info

## In both

*   checking tests ...
     ```
     ...
       
       ══ Failed tests ════════════════════════════════════════════════════════════════
       ── Error ('test-eems.plots.R:32:5'): eems.plots() writes output when called with map overlay ──
       Error in `st_make_valid.sfc(raw0)`: package lwgeom required, please install it first
       Backtrace:
            ▆
         1. ├─sp::spTransform(map_africa, sp::CRS(projection_mercator)) at test-eems.plots.R:32:5
         2. └─sp::spTransform(map_africa, sp::CRS(projection_mercator))
         3.   ├─methods::as(...)
         4.   │ └─methods:::.class1(object)
         5.   ├─sf::st_transform(sf::st_as_sf(x), sf::st_crs(CRSobj))
         6.   ├─sf::st_as_sf(x)
         7.   └─sf:::st_as_sf.Spatial(x)
         8.     ├─sf::st_as_sfc(sp::geometry(x), ...)
         9.     └─sf:::st_as_sfc.SpatialPolygons(sp::geometry(x), ...)
        10.       └─base::lapply(slot(x, "polygons"), process_pl_comment)
        11.         └─sf (local) FUN(X[[i]], ...)
        12.           ├─sf::st_union(st_make_valid(raw0))
        13.           ├─sf::st_make_valid(raw0)
        14.           └─sf:::st_make_valid.sfc(raw0)
       
       [ FAIL 1 | WARN 0 | SKIP 0 | PASS 34 ]
       Error:
       ! Test failures.
       Execution halted
     ```

# remiod (1.0.2)

* GitHub: <https://github.com/xsswang/remiod>
* Email: <mailto:xwang@imedacs.com>
* GitHub mirror: <https://github.com/cran/remiod>

Run `revdepcheck::revdep_details(, "remiod")` for more info

## In both

*   checking S3 generic/method consistency ... NOTE
     ```
     Mismatches for apparent methods not registered:
     rep:
       function(x, ...)
     rep.data.frame:
       function(x, times)
     See section ‘Registering S3 methods’ in the ‘Writing R Extensions’
     manual.
     ```

# SCArray.sat (1.12.0)

* GitHub: <https://github.com/AbbVie-ComputationalGenomics/SCArray>
* Email: <mailto:xiuwen.zheng@abbvie.com>

Run `revdepcheck::revdep_details(, "SCArray.sat")` for more info

## In both

*   checking dependencies in R code ... NOTE
     ```
     Unexported objects imported by ':::' calls:
       ‘Seurat:::DEmethods_counts’ ‘Seurat:::DEmethods_nocorrect’
       ‘Seurat:::FastExpMean’ ‘Seurat:::FastLogVMR’ ‘Seurat:::NBResiduals’
       ‘Seurat:::UpdateKey’ ‘Seurat:::ValidateDataForMerge’
       See the note in ?`:::` about the use of this operator.
     ```

*   checking R code for possible problems ... NOTE
     ```
     CreateAssayObject2: no visible global function definition for
       ‘CreateAssay5Object’
       (/scratch/henrik/revdep/future/checks/SCArray.sat/new/SCArray.sat.Rcheck/00_pkg_src/SCArray.sat/R/Methods.R:182)
     Undefined global functions or variables:
       CreateAssay5Object
     ```

# Seqtometry (1.0.0)

* GitHub: <https://github.com/HawigerLab/Seqtometry>
* Email: <mailto:robert.kousnetsov@health.slu.edu>

Run `revdepcheck::revdep_details(, "Seqtometry")` for more info

## In both

*   checking examples ... WARNING
     ```
     Found the following significant warnings:
     
       Warning in .local(x, ...) : 'quickPerCellQC' is deprecated.
       Warning in .local(x, ...) : 'normalizeCounts' is deprecated.
       Warning in .local(x, ...) : 'quickPerCellQC' is deprecated.
       Warning in .local(x, ...) : 'normalizeCounts' is deprecated.
     Deprecated functions may be defunct as soon as of the next release of
     R.
     See ?Deprecated.
     ```

*   checking R code for possible problems ... NOTE
     ```
     score: warning in assert_list(signatures, type = "character"): partial
       argument match of 'type' to 'types'
       (/scratch/henrik/revdep/future/checks/Seqtometry/new/Seqtometry.Rcheck/00_pkg_src/Seqtometry/R/score.R:58)
     ```

# shiny (1.14.0)

* GitHub: <https://github.com/rstudio/shiny>
* Email: <mailto:carson@posit.co>
* GitHub mirror: <https://github.com/cran/shiny>

Run `revdepcheck::revdep_details(, "shiny")` for more info

## In both

*   checking tests ...
     ```
     ...
         'test-stacks.R:249:3', 'test-stacks.R:267:3', 'test-stacks.R:288:3',
         'test-stacks.R:309:3', 'test-stacks.R:329:3', 'test-tabPanel.R:46:1',
         'test-tabPanel.R:66:1', 'test-tabPanel.R:73:1', 'test-tabPanel.R:83:1',
         'test-test-server.R:292:3', 'test-timer.R:4:1', 'test-utils.R:210:3',
         'test-zzz-st2-download.R:1:1'
       • Refactor test for next release (1): 'test-test-shinyAppTemplate.R:3:1'
       
       ══ Failed tests ════════════════════════════════════════════════════════════════
       ── Failure ('test-otel-label.R:33:3'): otel_span_label_reactive generates correct labels ──
       Expected `result` to equal "reactive event <anonymous>".
       Differences:
       `actual`:   "reactive event fn_name"    
       `expected`: "reactive event <anonymous>"
       
       ── Failure ('test-otel-label.R:150:3'): otel_span_label_observer generates correct labels ──
       Expected `result` to equal "observe event <anonymous>".
       Differences:
       `actual`:   "observe event fn_name"    
       `expected`: "observe event <anonymous>"
       
       
       [ FAIL 2 | WARN 2 | SKIP 40 | PASS 2313 ]
       Error:
       ! Test failures.
       Execution halted
     ```

# sigminer (2.3.1)

* GitHub: <https://github.com/ShixiangWang/sigminer>
* Email: <mailto:w_shixiang@163.com>
* GitHub mirror: <https://github.com/cran/sigminer>

Run `revdepcheck::revdep_details(, "sigminer")` for more info

## In both

*   checking DESCRIPTION meta-information ... NOTE
     ```
       Missing dependency on R >= 4.1.0 because package code uses the pipe
       |> or function shorthand \(...) syntax added in R 4.1.0.
       File(s) using such syntax:
         ‘show_group_enrichment.R’
     ```

# signeR (2.14.0)

* GitHub: <https://github.com/TojalLab/signeR>
* Email: <mailto:renan.valieris@accamargo.org.br>

Run `revdepcheck::revdep_details(, "signeR")` for more info

## In both

*   checking whether package ‘signeR’ can be installed ... NOTE
     ```
     Found the following notes/warnings:
       SystemRequirements specified C++14: support has been removed
     See ‘/scratch/henrik/revdep/future/checks/signeR/new/signeR.Rcheck/00install.out’ for details.
     ```

*   checking C++ specification ... NOTE
     ```
       Obsolete C++14 standard request will be ignored
     ```

*   checking R code for possible problems ... NOTE
     ```
     ...
     ExposureClassifyCV,ANY-character: no visible binding for global
       variable ‘Col’
       (/scratch/henrik/revdep/future/checks/signeR/new/signeR.Rcheck/00_pkg_src/signeR/R/SignExp_learning.R:367-371)
     ExposureClassifyCV,ANY-character: no visible binding for global
       variable ‘Frequency’
       (/scratch/henrik/revdep/future/checks/signeR/new/signeR.Rcheck/00_pkg_src/signeR/R/SignExp_learning.R:367-371)
     ExposureClassifyCV,ANY-character: no visible binding for global
       variable ‘Row’
       (/scratch/henrik/revdep/future/checks/signeR/new/signeR.Rcheck/00_pkg_src/signeR/R/SignExp_learning.R:367-371)
     ExposureCorrelation,SignExp-numeric: no visible binding for global
       variable ‘Feature’
       (/scratch/henrik/revdep/future/checks/signeR/new/signeR.Rcheck/00_pkg_src/signeR/R/SignExp_tests.R:569-575)
     ExposureCorrelation,SignExp-numeric: no visible binding for global
       variable ‘exposure’
       (/scratch/henrik/revdep/future/checks/signeR/new/signeR.Rcheck/00_pkg_src/signeR/R/SignExp_tests.R:569-575)
     ExposureCorrelation,matrix-numeric: no visible binding for global
       variable ‘Feature’
       (/scratch/henrik/revdep/future/checks/signeR/new/signeR.Rcheck/00_pkg_src/signeR/R/SignExp_tests.R:461-467)
     ExposureCorrelation,matrix-numeric: no visible binding for global
       variable ‘exposure’
       (/scratch/henrik/revdep/future/checks/signeR/new/signeR.Rcheck/00_pkg_src/signeR/R/SignExp_tests.R:461-467)
     Undefined global functions or variables:
       . Col Feature Frequency Reference_Allele Row Samples Signatures
       Tumor_Seq_Allele1 Tumor_Seq_Allele2 Variant_Type conf.high conf.low
       estimate exposure fc p.value project sig sig_test term
     ```

*   checking Rd files ... NOTE
     ```
     prepare_Rd: cosmic_data.Rd:91-93: Dropping empty section \details
     prepare_Rd: cosmic_data.Rd:98-100: Dropping empty section \references
     prepare_Rd: cosmic_data.Rd:101-102: Dropping empty section \examples
     prepare_Rd: tcga_similarities.Rd:96-98: Dropping empty section \details
     prepare_Rd: tcga_similarities.Rd:99-101: Dropping empty section \source
     prepare_Rd: tcga_similarities.Rd:102-104: Dropping empty section \references
     prepare_Rd: tcga_similarities.Rd:105-106: Dropping empty section \examples
     prepare_Rd: tcga_tumors.Rd:18-20: Dropping empty section \details
     prepare_Rd: tcga_tumors.Rd:21-23: Dropping empty section \source
     prepare_Rd: tcga_tumors.Rd:24-26: Dropping empty section \references
     prepare_Rd: tcga_tumors.Rd:27-28: Dropping empty section \examples
     ```

*   checking for non-standard things in the check directory ... NOTE
     ```
     Found the following files/directories:
       ‘tmp.pdf’
     ```

# simhelpers (0.3.1)

* GitHub: <https://github.com/meghapsimatrix/simhelpers>
* Email: <mailto:megha.j456@gmail.com>
* GitHub mirror: <https://github.com/cran/simhelpers>

Run `revdepcheck::revdep_details(, "simhelpers")` for more info

## In both

*   checking DESCRIPTION meta-information ... NOTE
     ```
       Missing dependency on R >= 4.1.0 because package code uses the pipe
       |> or function shorthand \(...) syntax added in R 4.1.0.
       File(s) using such syntax:
         ‘bootstrap-projection.R’ ‘bootstrap_CIs.Rd’ ‘bundle_sim.R’
         ‘calc_coverage.R’ ‘calc_rejection.R’ ‘extrapolate_coverage.Rd’
         ‘utilities.R’
     ```

# spanishoddata (0.2.6)

* GitHub: <https://github.com/rOpenSpain/spanishoddata>
* Email: <mailto:kotov.egor@gmail.com>
* GitHub mirror: <https://github.com/cran/spanishoddata>

Run `revdepcheck::revdep_details(, "spanishoddata")` for more info

## In both

*   checking tests ...
     ```
     ...
       Data directory successfully set to: /scratch/hb/RtmpOqdXpM/working_dir/RtmpTDIap2/file37cf8a6af30817/new2
       Saving _problems/test-get-zones-coverage-109.R
       [ FAIL 1 | WARN 4 | SKIP 5 | PASS 361 ]
       
       ══ Skipped tests (5) ═══════════════════════════════════════════════════════════
       • On CRAN (5): 'test-download-coverage.R:300:3',
         'test-download-coverage.R:336:3', 'test-download-coverage.R:375:3',
         'test-live-integration.R:6:3', 'test-quick-get.R:3:3'
       
       ══ Failed tests ════════════════════════════════════════════════════════════════
       ── Error ('test-get-zones-coverage.R:109:3'): spod_clean_zones_v1 handles invalid geometries ──
       Error in `st_make_valid.sfc(st_geometry(x), ...)`: package lwgeom required, please install it first
       Backtrace:
           ▆
        1. └─spanishoddata:::spod_clean_zones_v1("dummy_path.shp", "districts") at test-get-zones-coverage.R:109:3
        2.   ├─sf::st_make_valid(zones_sf[invalid_geometries, ]) at spanishoddata/R/get-zones.R:223:5
        3.   └─sf:::st_make_valid.sf(zones_sf[invalid_geometries, ])
        4.     ├─sf::st_set_geometry(x, st_make_valid(st_geometry(x), ...))
        5.     ├─sf::st_make_valid(st_geometry(x), ...)
        6.     └─sf:::st_make_valid.sfc(st_geometry(x), ...)
       
       [ FAIL 1 | WARN 4 | SKIP 5 | PASS 361 ]
       Error:
       ! Test failures.
       Execution halted
     ```

# sparrpowR (0.2.9)

* GitHub: <https://github.com/machiela-lab/sparrpowR>
* Email: <mailto:ian.buller@alumni.emory.edu>
* GitHub mirror: <https://github.com/cran/sparrpowR>

Run `revdepcheck::revdep_details(, "sparrpowR")` for more info

## In both

*   checking whether package ‘sparrpowR’ can be installed ... WARNING
     ```
     Found the following significant warnings:
       Warning: no DISPLAY variable so Tk is not available
     See ‘/scratch/henrik/revdep/future/checks/sparrpowR/new/sparrpowR.Rcheck/00install.out’ for details.
     ```

# sperrorest (3.0.5)

* GitHub: <https://github.com/giscience-fsu/sperrorest>
* Email: <mailto:alexander.brenning@uni-jena.de>
* GitHub mirror: <https://github.com/cran/sperrorest>

Run `revdepcheck::revdep_details(, "sperrorest")` for more info

## In both

*   checking Rd files ... NOTE
     ```
     ...
            |                                          ^
     checkRd: (-1) partition_kmeans.Rd:41: Lost braces; missing escapes or markup?
         41 | if \code{TRUE} (used internally by other {sperrorest} functions), return a
            |                                          ^
     checkRd: (-1) partition_tiles.Rd:78: Lost braces; missing escapes or markup?
         78 | if \code{TRUE} (used internally by other {sperrorest} functions), return a
            |                                          ^
     checkRd: (-1) sperrorest.Rd:55: Lost braces; missing escapes or markup?
         55 | \code{formula} and \code{data} argument, which are provided by {sperrorest})}
            |                                                                ^
     checkRd: (-1) sperrorest.Rd:63: Lost braces; missing escapes or markup?
         63 | {sperrorest}).}
            | ^
     checkRd: (-1) sperrorest.Rd:135: Lost braces; missing escapes or markup?
        135 | A list (object of class {sperrorest}) with (up to) six components:
            |                         ^
     checkRd: (-1) sperrorest.Rd:148: Lost braces; missing escapes or markup?
        148 | information about the {sperrorest} package version
            |                       ^
     checkRd: (-1) summary.sperroresterror.Rd:5: Lost braces; missing escapes or markup?
          5 | \title{Summarize error statistics obtained by {sperrorest}}
            |                                               ^
     checkRd: (-1) summary.sperrorestimportance.Rd:5: Lost braces; missing escapes or markup?
          5 | \title{Summarize variable importance statistics obtained by {sperrorest}}
            |                                                             ^
     ```

# sRACIPE (2.4.0)

* GitHub: <https://github.com/lusystemsbio/sRACIPE>
* Email: <mailto:m.lu@northeastern.edu>

Run `revdepcheck::revdep_details(, "sRACIPE")` for more info

## In both

*   checking C++ specification ... NOTE
     ```
       Obsolete C++11 standard request will be ignored
     ```

*   checking DESCRIPTION meta-information ... NOTE
     ```
     License stub is invalid DCF.
     ```

*   checking R code for possible problems ... NOTE
     ```
     sracipeConvergeDist,RacipeSE: no visible global function definition for
       ‘polygon’
       (/scratch/henrik/revdep/future/checks/sRACIPE/new/sRACIPE.Rcheck/00_pkg_src/sRACIPE/R/methods.R:1085-1087)
     Undefined global functions or variables:
       polygon
     Consider adding
       importFrom("graphics", "polygon")
     to your NAMESPACE file.
     ```

*   checking Rd files ... NOTE
     ```
     checkRd: (-1) sracipeHeatmapSimilarity.Rd:31: Lost braces
         31 | If clusterCut is missing, hierarchical clustering using /code{ward.D2}
            |                                                              ^
     checkRd: (-1) sracipeHeatmapSimilarity.Rd:32: Lost braces
         32 | and /code{distance  = (1-cor(x, method = "spear"))/2} will be used to 
            |          ^
     ```

# survstan (0.0.7.1)

* GitHub: <https://github.com/fndemarqui/survstan>
* Email: <mailto:fndemarqui@est.ufmg.br>
* GitHub mirror: <https://github.com/cran/survstan>

Run `revdepcheck::revdep_details(, "survstan")` for more info

## In both

*   checking dependencies in R code ... NOTE
     ```
     Namespaces in Imports field not imported from:
       ‘RcppParallel’ ‘rstantools’
       All declared Imports should be used.
     ```

# synergyfinder (3.20.0)

* Email: <mailto:shuyu.zheng@helsinki.fi>

Run `revdepcheck::revdep_details(, "synergyfinder")` for more info

## In both

*   checking dependencies in R code ... WARNING
     ```
     '::' or ':::' import not declared from: ‘scales’
     Namespaces in Imports field not imported from:
       ‘future’ ‘gstat’ ‘nleqslv’ ‘sp’ ‘tidyverse’
       All declared Imports should be used.
     ```

*   checking R code for possible problems ... NOTE
     ```
     ...
       (/scratch/henrik/revdep/future/checks/synergyfinder/new/synergyfinder.Rcheck/00_pkg_src/synergyfinder/R/calculate_synergy_score.R:371-389)
     ZIP : <anonymous>: no visible global function definition for ‘:=’
       (/scratch/henrik/revdep/future/checks/synergyfinder/new/synergyfinder.Rcheck/00_pkg_src/synergyfinder/R/calculate_synergy_score.R:371-389)
     ZIP: no visible binding for global variable ‘.’
       (/scratch/henrik/revdep/future/checks/synergyfinder/new/synergyfinder.Rcheck/00_pkg_src/synergyfinder/R/calculate_synergy_score.R:393-395)
     ZIP: no visible binding for global variable ‘ZIP_fit’
       (/scratch/henrik/revdep/future/checks/synergyfinder/new/synergyfinder.Rcheck/00_pkg_src/synergyfinder/R/calculate_synergy_score.R:411-413)
     ZIP: no visible binding for global variable ‘ZIP_ref’
       (/scratch/henrik/revdep/future/checks/synergyfinder/new/synergyfinder.Rcheck/00_pkg_src/synergyfinder/R/calculate_synergy_score.R:411-413)
     ZIP: no visible binding for global variable ‘ZIP_synergy’
       (/scratch/henrik/revdep/future/checks/synergyfinder/new/synergyfinder.Rcheck/00_pkg_src/synergyfinder/R/calculate_synergy_score.R:411-413)
     Undefined global functions or variables:
       . := Bliss_ref HSA_ref ZIP_fit ZIP_ref ZIP_synergy adjust angle
       block_id color conc1 conc2 css data dev.list dev.off end head id
       input_type label left maxn metric n nn pred predict r response
       response_CI95 response_mean response_origin response_origin_CI95
       response_origin_mean response_origin_sd response_origin_sem
       response_sd response_sem right start synergy t.test text theta value
       x y
     Consider adding
       importFrom("grDevices", "dev.list", "dev.off")
       importFrom("graphics", "text")
       importFrom("stats", "end", "predict", "start", "t.test")
       importFrom("utils", "data", "head")
     to your NAMESPACE file.
     ```

*   checking Rd files ... NOTE
     ```
     checkRd: (-1) FitDoseResponse.Rd:54: Lost braces
         54 | href{https://onlinelibrary.wiley.com/doi/book/10.1002/0471725315}{Nonlinear
            |     ^
     checkRd: (-1) FitDoseResponse.Rd:54-55: Lost braces
         54 | href{https://onlinelibrary.wiley.com/doi/book/10.1002/0471725315}{Nonlinear
            |                                                                  ^
     checkRd: (-1) FitDoseResponse.Rd:55: Escaped LaTeX specials: \&
     checkRd: (-1) PlotBarometer.Rd:118: Lost braces
        118 | href{https://www.frontiersin.org/articles/10.3389/fphar.2015.00181/full}{What
            |     ^
     checkRd: (-1) PlotBarometer.Rd:118-119: Lost braces
        118 | href{https://www.frontiersin.org/articles/10.3389/fphar.2015.00181/full}{What
            |                                                                         ^
     checkRd: (-1) PlotDoseResponseCurve.Rd:84: Lost braces
         84 | link[drc]{plot.drc} function. For example, use xlim = c(0.5, 500) or
            |          ^
     ```

# telegramR (0.0.1)

* GitHub: <https://github.com/RomanKyrychenko/telegramR>
* Email: <mailto:roman.kyrychenko@helsinki.fi>
* GitHub mirror: <https://github.com/cran/telegramR>

Run `revdepcheck::revdep_details(, "telegramR")` for more info

## In both

*   checking dependencies in R code ... NOTE
     ```
     Namespace in Imports field not imported from: ‘Rcpp’
       All declared Imports should be used.
     ```

# terra (1.9-34)

* GitHub: <https://github.com/rspatial/terra>
* Email: <mailto:r.hijmans@gmail.com>
* GitHub mirror: <https://github.com/cran/terra>

Run `revdepcheck::revdep_details(, "terra")` for more info

## In both

*   checking examples ... ERROR
     ```
     Running examples in ‘terra-Ex.R’ failed
     The error most likely occurred in:
     
     > ### Name: viewshed
     > ### Title: Compute a viewshed
     > ### Aliases: viewshed viewshed,SpatRaster-method
     > ### Keywords: spatial
     > 
     > ### ** Examples
     > 
     > 
     > f <- system.file("ex/elev.tif", package="terra")
     > r <- rast(f)
     > x <- project(r, "EPSG:2169")
     > p <- cbind(70300, 96982)
     > v <- viewshed(x, p, 0, 0, 0.85714)
     Error: [viewshed] viewshed is not available for your version of GDAL. Need 3.1 or higher
     Execution halted
     ```

*   checking tests ...
     ```
     ...
       test_pitfinder.R..............    0 tests    
       test_pitfinder.R..............    0 tests    
       test_pitfinder.R..............    0 tests    
       test_pitfinder.R..............    0 tests    
       test_pitfinder.R..............    0 tests    
       test_pitfinder.R..............    0 tests    
       test_pitfinder.R..............    0 tests    
       test_pitfinder.R..............    0 tests    
       test_pitfinder.R..............    0 tests    
       test_pitfinder.R..............    0 tests    
       test_pitfinder.R..............    0 tests    
       test_pitfinder.R..............    0 tests    
       test_pitfinder.R..............    1 tests [0;32mOK[0m [0;36m32ms[0m
       
       test_plot.R...................    0 tests    
       test_plot.R...................    0 tests    [0;36m56ms[0m
       
       test_project.R................    0 tests    
       test_project.R................    0 tests    
       test_project.R................    0 tests    
       test_project.R................    0 tests    
       test_project.R................    0 tests    
       test_project.R................    0 tests    
       test_project.R................    1 tests [0;32mOK[0m Error: GDAL >= 3 and PROJ >= 7.1 required
       Execution halted
     ```

# tramvs (0.0-9)

* Email: <mailto:lucasheinrich.kook@gmail.com>
* GitHub mirror: <https://github.com/cran/tramvs>

Run `revdepcheck::revdep_details(, "tramvs")` for more info

## In both

*   checking re-building of vignette outputs ... WARNING
     ```
     Error(s) in re-building vignettes:
       ...
     --- re-building ‘tramvs.Rnw’ using knitr
     Error: processing vignette 'tramvs.Rnw' failed with diagnostics:
     Running 'texi2dvi' on 'tramvs.tex' failed.
     LaTeX errors:
     ! LaTeX Error: File `tabu.sty' not found.
     
     Type X to quit or <RETURN> to proceed,
     or enter new name. (Default extension: sty)
     
     ! Emergency stop.
     <read *> 
              
     l.72 \usepackage
                     {threeparttable}^^M
     !  ==> Fatal error occurred, no output PDF file produced!
     --- failed re-building ‘tramvs.Rnw’
     
     SUMMARY: processing the following file failed:
       ‘tramvs.Rnw’
     
     Error: Vignette re-building failed.
     Execution halted
     ```

# TriDimRegression (1.0.3)

* GitHub: <https://github.com/alexander-pastukhov/tridim-regression>
* Email: <mailto:pastukhov.alexander@gmail.com>
* GitHub mirror: <https://github.com/cran/TriDimRegression>

Run `revdepcheck::revdep_details(, "TriDimRegression")` for more info

## In both

*   checking whether package ‘TriDimRegression’ can be installed ... ERROR
     ```
     Installation failed.
     See ‘/scratch/henrik/revdep/future/checks/TriDimRegression/new/TriDimRegression.Rcheck/00install.out’ for details.
     ```

## Installation

### Devel

```
* installing *source* package ‘TriDimRegression’ ...
** this is package ‘TriDimRegression’ version ‘1.0.3’
** package ‘TriDimRegression’ successfully unpacked and MD5 sums checked
** using staged installation
Error in loadNamespace(x) : there is no package called ‘rstantools’
Calls: loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
Execution halted
ERROR: configuration failed for package ‘TriDimRegression’
* removing ‘/scratch/henrik/revdep/future/checks/TriDimRegression/new/TriDimRegression.Rcheck/TriDimRegression’


```
### CRAN

```
* installing *source* package ‘TriDimRegression’ ...
** this is package ‘TriDimRegression’ version ‘1.0.3’
** package ‘TriDimRegression’ successfully unpacked and MD5 sums checked
** using staged installation
Error in loadNamespace(x) : there is no package called ‘rstantools’
Calls: loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
Execution halted
ERROR: configuration failed for package ‘TriDimRegression’
* removing ‘/scratch/henrik/revdep/future/checks/TriDimRegression/old/TriDimRegression.Rcheck/TriDimRegression’


```
# txshift (0.3.8)

* GitHub: <https://github.com/nhejazi/txshift>
* Email: <mailto:nh@nimahejazi.org>
* GitHub mirror: <https://github.com/cran/txshift>

Run `revdepcheck::revdep_details(, "txshift")` for more info

## In both

*   checking Rd files ... NOTE
     ```
     checkRd: (-1) est_g_exp.Rd:55: Lost braces; missing escapes or markup?
         55 |  {A - delta}, {A + delta}, and {A + 2 * delta}).
            |  ^
     checkRd: (-1) est_g_exp.Rd:55: Lost braces; missing escapes or markup?
         55 |  {A - delta}, {A + delta}, and {A + 2 * delta}).
            |               ^
     checkRd: (-1) est_g_exp.Rd:55: Lost braces; missing escapes or markup?
         55 |  {A - delta}, {A + delta}, and {A + 2 * delta}).
            |                                ^
     ```

# vmeasur (0.1.4)

* Email: <mailto:jhuc964@aucklanduni.ac.nz>
* GitHub mirror: <https://github.com/cran/vmeasur>

Run `revdepcheck::revdep_details(, "vmeasur")` for more info

## In both

*   checking whether package ‘vmeasur’ can be installed ... WARNING
     ```
     Found the following significant warnings:
       Warning: no DISPLAY variable so Tk is not available
     See ‘/scratch/henrik/revdep/future/checks/vmeasur/new/vmeasur.Rcheck/00install.out’ for details.
     ```

# WeightedCluster (2.0)

* Email: <mailto:matthias.studer@unige.ch>
* GitHub mirror: <https://github.com/cran/WeightedCluster>

Run `revdepcheck::revdep_details(, "WeightedCluster")` for more info

## In both

*   checking re-building of vignette outputs ... WARNING
     ```
     ...
     --- failed re-building ‘WeightedClusterFR.Rnw’
     
     --- re-building ‘WeightedClusterPreview.Rnw’ using knitr
     Error: processing vignette 'WeightedClusterPreview.Rnw' failed with diagnostics:
     Running 'texi2dvi' on 'WeightedClusterPreview.tex' failed.
     LaTeX errors:
     ! LaTeX Error: File `a4.sty' not found.
     
     Type X to quit or <RETURN> to proceed,
     or enter new name. (Default extension: sty)
     
     ! Emergency stop.
     <read *> 
              
     l.66 \usepackage
                     {ae}^^M
     !  ==> Fatal error occurred, no output PDF file produced!
     --- failed re-building ‘WeightedClusterPreview.Rnw’
     
     SUMMARY: processing the following files failed:
       ‘WeightedCluster.Rnw’ ‘WeightedClusterFR.Rnw’
       ‘WeightedClusterPreview.Rnw’
     
     Error: Vignette re-building failed.
     Execution halted
     ```

# wingen (2.2.0)

* GitHub: <https://github.com/AnushaPB/wingen>
* Email: <mailto:anusha.bishop@berkeley.edu>
* GitHub mirror: <https://github.com/cran/wingen>

Run `revdepcheck::revdep_details(, "wingen")` for more info

## In both

*   checking re-building of vignette outputs ... ERROR
     ```
     ...
     
     Quitting from wingen-vignette.Rmd:654-662 [mask results 1]
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     <error/rlang_error>
     Error:
     ! [resample] 
     ---
     Backtrace:
         ▆
      1. ├─terra::resample(rast(lotr_lyr), kgd)
      2. └─terra::resample(rast(lotr_lyr), kgd)
      3.   └─terra (local) .local(x, y, ...)
      4.     └─terra:::messages(x, "resample")
      5.       └─terra:::error(f, x@pntr$getError())
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     
     Error: processing vignette 'wingen-vignette.Rmd' failed with diagnostics:
     [resample] 
     --- failed re-building ‘wingen-vignette.Rmd’
     
     SUMMARY: processing the following file failed:
       ‘wingen-vignette.Rmd’
     
     Error: Vignette re-building failed.
     Execution halted
     ```

# zarr (0.4.2)

* GitHub: <https://github.com/R-CF/zarr>
* Email: <mailto:patrick@vanlaake.net>
* GitHub mirror: <https://github.com/cran/zarr>

Run `revdepcheck::revdep_details(, "zarr")` for more info

## In both

*   checking package dependencies ... ERROR
     ```
     Package required but not available: ‘blosc’
     
     See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
     manual.
     ```

