# adestr

<details>

* Version: 1.0.0
* GitHub: NA
* Source code: https://github.com/cran/adestr
* Date/Publication: 2024-07-12 13:50:09 UTC
* Number of recursive dependencies: 135

Run `revdepcheck::revdep_details(, "adestr")` for more info

</details>

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
      Missing dependency on R >= 4.1.0 because package code uses the pipe
      |> or function shorthand \(...) syntax added in R 4.1.0.
      File(s) using such syntax:
        ‘IntervalEstimator-class.Rd’ ‘PValue-class.Rd’
        ‘PointEstimator-class.Rd’ ‘analyze.R’ ‘estimators.R’
        ‘evaluate_estimator.R’ ‘fisher_information.R’
        ‘integrate_over_sample_space.R’ ‘mle_distribution.R’ ‘n2c2_helpers.R’
        ‘plot.R’ ‘print.R’ ‘reference_implementation.R’
    ```

# AICcPermanova

<details>

* Version: 0.0.2
* GitHub: https://github.com/Sustainscapes/AICcPerm
* Source code: https://github.com/cran/AICcPermanova
* Date/Publication: 2023-04-11 13:40:06 UTC
* Number of recursive dependencies: 114

Run `revdepcheck::revdep_details(, "AICcPermanova")` for more info

</details>

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
      Missing dependency on R >= 4.1.0 because package code uses the pipe
      |> or function shorthand \(...) syntax added in R 4.1.0.
      File(s) using such syntax:
        ‘akaike_adjusted_rsq.R’ ‘filter_vif.R’ ‘fit_models.R’
        ‘select_models.R’
    ```

# alookr

<details>

* Version: 0.4.0
* GitHub: https://github.com/choonghyunryu/alookr
* Source code: https://github.com/cran/alookr
* Date/Publication: 2025-09-16 02:50:02 UTC
* Number of recursive dependencies: 149

Run `revdepcheck::revdep_details(, "alookr")` for more info

</details>

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘alookr-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: run_models
    > ### Title: Fit binary classification model
    > ### Aliases: run_models
    > 
    > ### ** Examples
    > 
    > library(dplyr)
    ...
     10. │   ├─purrr:::call_with_cleanup(...)
     11. │   └─alookr (local) .f(.x[[i]], ...)
     12. │     ├─future::value(.x)
     13. │     └─future:::value.Future(.x)
     14. │       └─future:::signalConditions(...)
     15. │         └─base::stop(condition)
     16. └─purrr (local) `<fn>`(`<smplErrr>`)
     17.   └─cli::cli_abort(...)
     18.     └─rlang::abort(...)
    Execution halted
    ```

# alphaci

<details>

* Version: 1.0.1
* GitHub: NA
* Source code: https://github.com/cran/alphaci
* Date/Publication: 2024-02-05 12:20:09 UTC
* Number of recursive dependencies: 73

Run `revdepcheck::revdep_details(, "alphaci")` for more info

</details>

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
      Missing dependency on R >= 4.1.0 because package code uses the pipe
      |> or function shorthand \(...) syntax added in R 4.1.0.
      File(s) using such syntax:
        ‘inference.R’ ‘transformers.R’ ‘variance.R’
    ```

# bamm

<details>

* Version: 0.5.0
* GitHub: https://github.com/luismurao/bamm
* Source code: https://github.com/cran/bamm
* Date/Publication: 2024-07-06 20:22:11 UTC
* Number of recursive dependencies: 110

Run `revdepcheck::revdep_details(, "bamm")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘crosstalk’ ‘plotly’
      All declared Imports should be used.
    ```

# baseballr

<details>

* Version: 1.6.0
* GitHub: https://github.com/BillPetti/baseballr
* Source code: https://github.com/cran/baseballr
* Date/Publication: 2024-01-16 12:50:02 UTC
* Number of recursive dependencies: 114

Run `revdepcheck::revdep_details(, "baseballr")` for more info

</details>

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
      Missing dependency on R >= 4.1.0 because package code uses the pipe
      |> or function shorthand \(...) syntax added in R 4.1.0.
      File(s) using such syntax:
        ‘chadwick_installation.R’
    ```

# ceRNAnetsim

<details>

* Version: 1.22.0
* GitHub: https://github.com/selcenari/ceRNAnetsim
* Source code: https://github.com/cran/ceRNAnetsim
* Date/Publication: 2025-10-29
* Number of recursive dependencies: 94

Run `revdepcheck::revdep_details(, "ceRNAnetsim")` for more info

</details>

## In both

*   checking R code for possible problems ... NOTE
    ```
    find_node_perturbation: no visible binding for global variable
      ‘perturbation_efficiency’
    find_node_perturbation: no visible binding for global variable
      ‘perturbed_count’
    simulate: no visible binding for global variable ‘avg_count_current’
    simulate: no visible binding for global variable ‘avg_count_pre’
    Undefined global functions or variables:
      avg_count_current avg_count_pre perturbation_efficiency
      perturbed_count
    ```

# Certara.RsNLME.ModelExecutor

<details>

* Version: 3.0.2
* GitHub: NA
* Source code: https://github.com/cran/Certara.RsNLME.ModelExecutor
* Date/Publication: 2025-03-19 14:50:01 UTC
* Number of recursive dependencies: 111

Run `revdepcheck::revdep_details(, "Certara.RsNLME.ModelExecutor")` for more info

</details>

## In both

*   checking R code for possible problems ... NOTE
    ```
    .run_shiny_RsNLME : server: no visible global function definition for
      ‘addTablesToColumnMapping’
    Undefined global functions or variables:
      addTablesToColumnMapping
    ```

# chevreulShiny

<details>

* Version: 1.2.0
* GitHub: https://github.com/cobriniklab/chevreulShiny
* Source code: https://github.com/cran/chevreulShiny
* Date/Publication: 2025-12-04
* Number of recursive dependencies: 267

Run `revdepcheck::revdep_details(, "chevreulShiny")` for more info

</details>

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
    License stub is invalid DCF.
    ```

# ChromSCape

<details>

* Version: 1.20.0
* GitHub: https://github.com/vallotlab/ChromSCape
* Source code: https://github.com/cran/ChromSCape
* Date/Publication: 2025-10-29
* Number of recursive dependencies: 228

Run `revdepcheck::revdep_details(, "ChromSCape")` for more info

</details>

## In both

*   checking dependencies in R code ... WARNING
    ```
    'loadNamespace' or 'requireNamespace' call not declared from: ‘flexdashboard’
    ```

*   checking for hidden files and directories ... NOTE
    ```
    Found the following hidden files and directories:
      .BBSoptions
    These were most likely included in error. See section ‘Package
    structure’ in the ‘Writing R Extensions’ manual.
    ```

*   checking R code for possible problems ... NOTE
    ```
    bams_to_matrix_indexes: no visible binding for global variable
      ‘files_dir_list’
    enrich_TF_ChEA3_genes: no visible binding for global variable
      ‘CheA3_TF_nTargets’
    filter_correlated_cell_scExp: no visible binding for global variable
      ‘run_tsne’
    generate_analysis: no visible global function definition for ‘head’
    generate_analysis: no visible binding for global variable ‘k’
    generate_analysis: no visible binding for global variable
      ‘clusterConsensus’
    ...
    subset_bam_call_peaks: no visible binding for global variable
      ‘merged_bam’
    Undefined global functions or variables:
      CheA3_TF_nTargets Component Fri_cyto Gain_or_Loss Gene TF V1 V2
      absolute_value cluster clusterConsensus cytoBand files_dir_list genes
      group head k merged_bam molecule ncells new_row orientation
      origin_value percent_active run_tsne sample_id total_counts
    Consider adding
      importFrom("utils", "head")
    to your NAMESPACE file.
    ```

# ClustIRR

<details>

* Version: 1.8.0
* GitHub: https://github.com/snaketron/ClustIRR
* Source code: https://github.com/cran/ClustIRR
* Date/Publication: 2025-10-29
* Number of recursive dependencies: 107

Run `revdepcheck::revdep_details(, "ClustIRR")` for more info

</details>

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
    Package listed in more than one of Depends, Imports, Suggests, Enhances:
      ‘ggplot2’
    A package should be listed in only one of these fields.
    ```

*   checking R code for possible problems ... NOTE
    ```
    get_ag_gene_hits: no visible binding for global variable ‘cells’
    get_ag_gene_hits: no visible binding for global variable ‘clones’
    get_ag_gene_hits: no visible binding for global variable ‘community’
    get_ag_gene_hits: no visible binding for global variable ‘ag’
    get_ag_species_hits: no visible binding for global variable ‘cells’
    get_ag_species_hits: no visible binding for global variable ‘clones’
    get_ag_species_hits: no visible binding for global variable ‘community’
    get_ag_species_hits: no visible binding for global variable ‘ag’
    get_beta_violin: no visible binding for global variable ‘spec’
    get_beta_violin: no visible binding for global variable ‘size’
    get_honeycombs: no visible binding for global variable ‘x_adj’
    get_honeycombs: no visible binding for global variable ‘y_adj’
    get_honeycombs: no visible binding for global variable ‘..count..’
    Undefined global functions or variables:
      ..count.. ag cells clones community size spec x_adj y_adj
    ```

# codalm

<details>

* Version: 0.1.2
* GitHub: https://github.com/jfiksel/codalm
* Source code: https://github.com/cran/codalm
* Date/Publication: 2021-07-26 18:40:02 UTC
* Number of recursive dependencies: 50

Run `revdepcheck::revdep_details(, "codalm")` for more info

</details>

## In both

*   checking Rd files ... NOTE
    ```
    checkRd: (-1) educFM.Rd:22: Lost braces in \itemize; meant \describe ?
    checkRd: (-1) educFM.Rd:23: Lost braces in \itemize; meant \describe ?
    checkRd: (-1) educFM.Rd:24: Lost braces in \itemize; meant \describe ?
    checkRd: (-1) educFM.Rd:25: Lost braces in \itemize; meant \describe ?
    checkRd: (-1) educFM.Rd:26: Lost braces in \itemize; meant \describe ?
    checkRd: (-1) educFM.Rd:27: Lost braces in \itemize; meant \describe ?
    checkRd: (-1) educFM.Rd:28: Lost braces in \itemize; meant \describe ?
    ```

# cSEM

<details>

* Version: 0.6.1
* GitHub: https://github.com/FloSchuberth/cSEM
* Source code: https://github.com/cran/cSEM
* Date/Publication: 2025-05-16 09:40:14 UTC
* Number of recursive dependencies: 144

Run `revdepcheck::revdep_details(, "cSEM")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘Rdpack’
      All declared Imports should be used.
    ```

# CSGo

<details>

* Version: 0.6.7
* GitHub: https://github.com/adsoncostanzifilho/CSGo
* Source code: https://github.com/cran/CSGo
* Date/Publication: 2021-05-07 18:50:02 UTC
* Number of recursive dependencies: 70

Run `revdepcheck::revdep_details(, "CSGo")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘extrafont’ ‘future’
      All declared Imports should be used.
    ```

# ctsem

<details>

* Version: 3.10.4
* GitHub: https://github.com/cdriveraus/ctsem
* Source code: https://github.com/cran/ctsem
* Date/Publication: 2025-06-30 16:40:11 UTC
* Number of recursive dependencies: 166

Run `revdepcheck::revdep_details(, "ctsem")` for more info

</details>

## In both

*   checking whether package ‘ctsem’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: namespace ‘colorspace’ is not available and has been replaced
    See ‘/scratch/henrik/revdep/future/checks/ctsem/new/ctsem.Rcheck/00install.out’ for details.
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error(s) in re-building vignettes:
      ...
    --- re-building ‘hierarchicalmanual.rnw’ using knitr_notangle
    Warning in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  :
      texi2dvi script/program not available, using emulation
    Error: processing vignette 'hierarchicalmanual.rnw' failed with diagnostics:
    unable to run pdflatex on 'hierarchicalmanual.tex'
    LaTeX errors:
    ! LaTeX Error: File `apacite.sty' not found.
    
    ...
    l.62 \bibliographystyle
                           {apacite}     % Set bibliography style^^M
    !  ==> Fatal error occurred, no output PDF file produced!
    --- failed re-building ‘hierarchicalmanual.rnw’
    
    SUMMARY: processing the following file failed:
      ‘hierarchicalmanual.rnw’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# disk.frame

<details>

* Version: 0.8.3
* GitHub: https://github.com/DiskFrame/disk.frame
* Source code: https://github.com/cran/disk.frame
* Date/Publication: 2023-08-24 16:20:10 UTC
* Number of recursive dependencies: 94

Run `revdepcheck::revdep_details(, "disk.frame")` for more info

</details>

## In both

*   checking Rd files ... NOTE
    ```
    checkRd: (-1) csv_to_disk.frame.Rd:56: Lost braces; missing escapes or markup?
        56 | strings, and you are encouraged to use {fasttime} to convert the strings to
           |                                        ^
    checkRd: (-1) purrr_as_mapper.Rd:10: Lost braces; missing escapes or markup?
        10 | \item{.f}{a normal function or purrr syntax function i.e. `~{ ...code...}`}
           |                                                             ^
    ```

# dispositionEffect

<details>

* Version: 1.0.1
* GitHub: https://github.com/marcozanotti/dispositionEffect
* Source code: https://github.com/cran/dispositionEffect
* Date/Publication: 2022-05-30 07:50:02 UTC
* Number of recursive dependencies: 130

Run `revdepcheck::revdep_details(, "dispositionEffect")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
      1/4 mismatches
      [2] 34 - 28 == 6
      ── Failure ('test-realized_duration.R:122:2'): realized_duration works (realized_only = TRUE) ──
      Expected `realized_duration(...)` to equal `c(...)`.
      Differences:
      1/4 mismatches
    ...
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

# EFAtools

<details>

* Version: 0.6.1
* GitHub: https://github.com/mdsteiner/EFAtools
* Source code: https://github.com/cran/EFAtools
* Date/Publication: 2025-07-30 14:10:02 UTC
* Number of recursive dependencies: 88

Run `revdepcheck::revdep_details(, "EFAtools")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘progress’
      All declared Imports should be used.
    ```

# envi

<details>

* Version: 1.0.1
* GitHub: https://github.com/lance-waller-lab/envi
* Source code: https://github.com/cran/envi
* Date/Publication: 2025-08-29 13:10:02 UTC
* Number of recursive dependencies: 151

Run `revdepcheck::revdep_details(, "envi")` for more info

</details>

## In both

*   checking whether package ‘envi’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: no DISPLAY variable so Tk is not available
    See ‘/scratch/henrik/revdep/future/checks/envi/new/envi.Rcheck/00install.out’ for details.
    ```

# FastRet

<details>

* Version: 1.1.4
* GitHub: https://github.com/spang-lab/FastRet
* Source code: https://github.com/cran/FastRet
* Date/Publication: 2025-02-10 18:30:02 UTC
* Number of recursive dependencies: 188

Run `revdepcheck::revdep_details(, "FastRet")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
      > test-selective_measuring.R: [1;30m2025-12-08 13:07:48.90[0m Scaling features by coefficients of Ridge Regression model
      > test-selective_measuring.R: [1;30m2025-12-08 13:07:48.91[0m Applying PAM clustering
      > test-adjust_frm.R: [1;30m2025-12-08 13:07:48.93[0m Starting model Adjustment
      > test-adjust_frm.R: [1;30m2025-12-08 13:07:48.94[0m dim(original_data): 442 x 126
      > test-adjust_frm.R: [1;30m2025-12-08 13:07:48.94[0m dim(new_data): 25 x 3
      > test-adjust_frm.R: [1;30m2025-12-08 13:07:48.94[0m predictors: 1, 2
    ...
      Backtrace:
          ▆
       1. └─FastRet:::fit_gbtree(df, verbose = 0) at test-fit_gbtree.R:16:5
       2.   └─FastRet:::fit_gbtree_grid(...)
       3.     └─xgboost::xgb.train(...)
      
      [ FAIL 3 | WARN 5 | SKIP 0 | PASS 19 ]
      Error:
      ! Test failures.
      Execution halted
    ```

# fastRhockey

<details>

* Version: 0.4.0
* GitHub: https://github.com/sportsdataverse/fastRhockey
* Source code: https://github.com/cran/fastRhockey
* Date/Publication: 2022-10-25 20:55:15 UTC
* Number of recursive dependencies: 108

Run `revdepcheck::revdep_details(, "fastRhockey")` for more info

</details>

## In both

*   checking Rd files ... NOTE
    ```
    checkRd: (-1) update_nhl_db.Rd:51-53: Lost braces in \itemize; meant \describe ?
    checkRd: (-1) update_nhl_db.Rd:54-57: Lost braces in \itemize; meant \describe ?
    checkRd: (-1) update_phf_db.Rd:51-53: Lost braces in \itemize; meant \describe ?
    checkRd: (-1) update_phf_db.Rd:54-57: Lost braces in \itemize; meant \describe ?
    ```

# fdacluster

<details>

* Version: 0.4.1
* GitHub: https://github.com/astamm/fdacluster
* Source code: https://github.com/cran/fdacluster
* Date/Publication: 2025-01-14 16:50:09 UTC
* Number of recursive dependencies: 126

Run `revdepcheck::revdep_details(, "fdacluster")` for more info

</details>

## In both

*   checking whether package ‘fdacluster’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      baseDissimilarityClass.cpp:39:28: warning: ‘bool arma::is_finite(eT, const typename arma_scalar_only<eT>::result*) [with eT = double; typename arma_scalar_only<eT>::result = double]’ is deprecated: change arma::is_finite(val) to std::isfinite(val) [-Wdeprecated-declarations]
      baseDissimilarityClass.cpp:39:57: warning: ‘bool arma::is_finite(const Base<typename T1::elem_type, T1>&) [with T1 = subview<double>; typename T1::elem_type = double]’ is deprecated: change arma::is_finite(X) to X.is_finite() [-Wdeprecated-declarations]
      baseDissimilarityClass.cpp:53:28: warning: ‘bool arma::is_finite(eT, const typename arma_scalar_only<eT>::result*) [with eT = double; typename arma_scalar_only<eT>::result = double]’ is deprecated: change arma::is_finite(val) to std::isfinite(val) [-Wdeprecated-declarations]
      baseDissimilarityClass.cpp:53:57: warning: ‘bool arma::is_finite(const Base<typename T1::elem_type, T1>&) [with T1 = subview<double>; typename T1::elem_type = double]’ is deprecated: change arma::is_finite(X) to X.is_finite() [-Wdeprecated-declarations]
      lowessCenterClass.cpp:41:28: warning: ‘bool arma::is_finite(eT, const typename arma_scalar_only<eT>::result*) [with eT = double; typename arma_scalar_only<eT>::result = double]’ is deprecated: change arma::is_finite(val) to std::isfinite(val) [-Wdeprecated-declarations]
      lowessCenterClass.cpp:41:64: warning: ‘bool arma::is_finite(eT, const typename arma_scalar_only<eT>::result*) [with eT = double; typename arma_scalar_only<eT>::result = double]’ is deprecated: change arma::is_finite(val) to std::isfinite(val) [-Wdeprecated-declarations]
      polyCenterClass.cpp:39:28: warning: ‘bool arma::is_finite(eT, const typename arma_scalar_only<eT>::result*) [with eT = double; typename arma_scalar_only<eT>::result = double]’ is deprecated: change arma::is_finite(val) to std::isfinite(val) [-Wdeprecated-declarations]
      polyCenterClass.cpp:39:64: warning: ‘bool arma::is_finite(eT, const typename arma_scalar_only<eT>::result*) [with eT = double; typename arma_scalar_only<eT>::result = double]’ is deprecated: change arma::is_finite(val) to std::isfinite(val) [-Wdeprecated-declarations]
    See ‘/scratch/henrik/revdep/future/checks/fdacluster/new/fdacluster.Rcheck/00install.out’ for details.
    ```

*   checking DESCRIPTION meta-information ... NOTE
    ```
      Missing dependency on R >= 4.2.0 because package code uses the pipe
      placeholder syntax added in R 4.2.0.
      File(s) using such syntax:
        ‘caps-plot.R’ ‘utils.R’
    ```

# flowGraph

<details>

* Version: 1.18.0
* GitHub: https://github.com/aya49/flowGraph
* Source code: https://github.com/cran/flowGraph
* Date/Publication: 2025-10-30
* Number of recursive dependencies: 90

Run `revdepcheck::revdep_details(, "flowGraph")` for more info

</details>

## In both

*   checking R code for possible problems ... NOTE
    ```
    get_child: no visible binding for global variable ‘no_cores’
    get_paren: no visible binding for global variable ‘no_cores’
    ms_psig: no visible binding for global variable ‘meta’
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

# fmeffects

<details>

* Version: 0.1.4
* GitHub: https://github.com/holgstr/fmeffects
* Source code: https://github.com/cran/fmeffects
* Date/Publication: 2024-11-05 18:50:02 UTC
* Number of recursive dependencies: 182

Run `revdepcheck::revdep_details(, "fmeffects")` for more info

</details>

## In both

*   checking re-building of vignette outputs ... ERROR
    ```
    Error(s) in re-building vignettes:
      ...
    --- re-building ‘fme_theory.Rmd’ using rmarkdown
    [WARNING] Deprecated: --highlight-style. Use --syntax-highlighting instead.
    --- finished re-building ‘fme_theory.Rmd’
    
    --- re-building ‘fmeffects.Rmd’ using rmarkdown
    
    Quitting from fmeffects.Rmd:121-127 [unnamed-chunk-11]
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ...
    ℹ In index: 1.
    Caused by error in `.__Task__col_roles()`:
    ! Assertion on 'names(rhs)' failed: Names must be a permutation of set {'feature','target','name','order','stratum','group','offset','weights_learner','weights_measure'}, but has extra elements {'always_included'}.
    --- failed re-building ‘fmeffects.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘fmeffects.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# forecastML

<details>

* Version: 0.9.0
* GitHub: https://github.com/nredell/forecastML
* Source code: https://github.com/cran/forecastML
* Date/Publication: 2020-05-07 15:10:17 UTC
* Number of recursive dependencies: 98

Run `revdepcheck::revdep_details(, "forecastML")` for more info

</details>

## In both

*   checking re-building of vignette outputs ... ERROR
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘combine_forecasts.Rmd’ using rmarkdown
    [WARNING] Deprecated: --highlight-style. Use --syntax-highlighting instead.
    --- finished re-building ‘combine_forecasts.Rmd’
    
    --- re-building ‘custom_functions.Rmd’ using rmarkdown
    [WARNING] Deprecated: --highlight-style. Use --syntax-highlighting instead.
    --- finished re-building ‘custom_functions.Rmd’
    
    --- re-building ‘grouped_forecast.Rmd’ using rmarkdown
    ...
    
    --- re-building ‘package_overview.Rmd’ using rmarkdown
    [WARNING] Deprecated: --highlight-style. Use --syntax-highlighting instead.
    --- finished re-building ‘package_overview.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘grouped_forecast.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘dtplyr’
      All declared Imports should be used.
    ```

# FracFixR

<details>

* Version: 1.0.0
* GitHub: NA
* Source code: https://github.com/cran/FracFixR
* Date/Publication: 2025-10-21 17:40:02 UTC
* Number of recursive dependencies: 72

Run `revdepcheck::revdep_details(, "FracFixR")` for more info

</details>

## In both

*   checking re-building of vignette outputs ... ERROR
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘FracFixR-intro.Rmd’ using rmarkdown
    
    Quitting from FracFixR-intro.Rmd:92-98 [run_fracfixr]
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    <error/rlang_error>
    Error in `checkNumberOfLocalWorkers()`:
    ! Attempting to set up 255 localhost parallel workers with only 5 CPU cores available for this R process (per 'N/A'), which could result in a 5100% load. The hard limit is set to 300%. Overusing the CPUs has negative impact on the current R process, but also on all other processes of yours and others running on the same machine. See help("parallelly.maxWorkers.localhost", package = "parallelly") for further explanations and how to override the hard limit that triggered this error
    ---
    Backtrace:
    ...
    
    Error: processing vignette 'FracFixR-intro.Rmd' failed with diagnostics:
    Attempting to set up 255 localhost parallel workers with only 5 CPU cores available for this R process (per 'N/A'), which could result in a 5100% load. The hard limit is set to 300%. Overusing the CPUs has negative impact on the current R process, but also on all other processes of yours and others running on the same machine. See help("parallelly.maxWorkers.localhost", package = "parallelly") for further explanations and how to override the hard limit that triggered this error
    --- failed re-building ‘FracFixR-intro.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘FracFixR-intro.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# GeDS

<details>

* Version: 0.3.3
* GitHub: https://github.com/emilioluissaenzguillen/GeDS
* Source code: https://github.com/cran/GeDS
* Date/Publication: 2025-06-30 07:10:06 UTC
* Number of recursive dependencies: 76

Run `revdepcheck::revdep_details(, "GeDS")` for more info

</details>

## In both

*   checking whether package ‘GeDS’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: no DISPLAY variable so Tk is not available
    See ‘/scratch/henrik/revdep/future/checks/GeDS/new/GeDS.Rcheck/00install.out’ for details.
    ```

# googleComputeEngineR

<details>

* Version: 0.3.0
* GitHub: https://github.com/cloudyr/googleComputeEngineR
* Source code: https://github.com/cran/googleComputeEngineR
* Date/Publication: 2019-05-04 22:40:02 UTC
* Number of recursive dependencies: 59

Run `revdepcheck::revdep_details(, "googleComputeEngineR")` for more info

</details>

## In both

*   checking Rd files ... NOTE
    ```
    checkRd: (-1) docker_cmd.gce_instance.Rd:21: Lost braces; missing escapes or markup?
        21 | \item{nvidia}{If true will use \code{nvidia-docker} instead of {docker}}
           |                                                                ^
    checkRd: (-1) gce_list_disks.Rd:11: Lost braces; missing escapes or markup?
        11 | \item{filter}{Sets a filter expression for filtering listed resources, in the form filter={expression}}
           |                                                                                           ^
    checkRd: (-1) gce_list_disks_all.Rd:11: Lost braces; missing escapes or markup?
        11 | \item{filter}{Sets a filter expression for filtering listed resources, in the form filter={expression}}
           |                                                                                           ^
    checkRd: (-1) gce_list_firewall_rules.Rd:11: Lost braces; missing escapes or markup?
    ...
           |                                                                                           ^
    checkRd: (-1) gce_list_networks.Rd:11: Lost braces; missing escapes or markup?
        11 | \item{filter}{Sets a filter expression for filtering listed resources, in the form filter={expression}}
           |                                                                                           ^
    checkRd: (-1) gce_list_zone_op.Rd:11: Lost braces; missing escapes or markup?
        11 | \item{filter}{Sets a filter expression for filtering listed resources, in the form filter={expression}}
           |                                                                                           ^
    checkRd: (-1) gce_list_zones.Rd:13: Lost braces; missing escapes or markup?
        13 | \item{filter}{Sets a filter expression for filtering listed resources, in the form filter={expression}}
           |                                                                                           ^
    ```

# googleTagManageR

<details>

* Version: 0.2.0
* GitHub: NA
* Source code: https://github.com/cran/googleTagManageR
* Date/Publication: 2022-04-16 18:12:29 UTC
* Number of recursive dependencies: 66

Run `revdepcheck::revdep_details(, "googleTagManageR")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘assertthat’ ‘future’ ‘httr’
      All declared Imports should be used.
    ```

# greenSD

<details>

* Version: 0.1.1
* GitHub: https://github.com/billbillbilly/greenSD
* Source code: https://github.com/cran/greenSD
* Date/Publication: 2025-10-30 19:50:02 UTC
* Number of recursive dependencies: 121

Run `revdepcheck::revdep_details(, "greenSD")` for more info

</details>

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘greenSD-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: sample_values
    > ### Title: Sample greenspace-realted data from Greenspace Seasonality Data
    > ###   Cube, ESA WorldCover 10m Annual Composites Dataset, or Sentinel-2-l2a
    > ###   images.
    > ### Aliases: sample_values
    > 
    > ### ** Examples
    ...
    1023                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                Matamoros, Torre\x97n, Viesca, G\x97mez Palacio, Lerdo
    1024                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          Aquiles Serd\x87n, Chihuahua
    1025                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Ju\x87rez, El Paso
    1026                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            Hermosillo
    1027                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Mexicali, Imperial
    1028                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Tijuana, San Diego
    > boundary <- check_urban_boundary(uid = 11)
    Warning: GDAL/OGR not compiled with libcurl support, remote requests not supported. (GDAL error 6)
    Error: Cannot open "https://raw.githubusercontent.com/billbillbilly/greenSD/main/scripts/city_urban_boundaries.geojson"; The file doesn't seem to exist.
    Execution halted
    ```

# greta

<details>

* Version: 0.5.0
* GitHub: https://github.com/greta-dev/greta
* Source code: https://github.com/cran/greta
* Date/Publication: 2024-11-12 06:40:02 UTC
* Number of recursive dependencies: 142

Run `revdepcheck::revdep_details(, "greta")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Package required and available but unsuitable version: ‘tensorflow’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# gsynth

<details>

* Version: 1.2.1
* GitHub: NA
* Source code: https://github.com/cran/gsynth
* Date/Publication: 2021-08-06 07:50:05 UTC
* Number of recursive dependencies: 60

Run `revdepcheck::revdep_details(, "gsynth")` for more info

</details>

## In both

*   checking C++ specification ... NOTE
    ```
      Specified C++11: please drop specification unless essential
    ```

# hero

<details>

* Version: 0.6
* GitHub: NA
* Source code: https://github.com/cran/hero
* Date/Publication: 2023-07-15 21:10:09 UTC
* Number of recursive dependencies: 159

Run `revdepcheck::revdep_details(, "hero")` for more info

</details>

## In both

*   checking Rd files ... NOTE
    ```
    checkRd: (-1) hero.Rd:67-68: Lost braces
        67 | then \code{\link[pbapply]{pblapply}} is used. If code{package ==
           |                                                      ^
    checkRd: (-1) hero.Rd:69: Lost braces
        69 | code{package == "Rmpi"}, then \code{\link[Rmpi]{mpi.applyLB}} is used.}
           |     ^
    ```

# infercnv

<details>

* Version: 1.26.0
* GitHub: https://github.com/broadinstitute/inferCNV
* Source code: https://github.com/cran/infercnv
* Date/Publication: 2025-10-29
* Number of recursive dependencies: 199

Run `revdepcheck::revdep_details(, "infercnv")` for more info

</details>

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

# InPAS

<details>

* Version: 2.18.1
* GitHub: NA
* Source code: https://github.com/cran/InPAS
* Date/Publication: 2025-11-25
* Number of recursive dependencies: 164

Run `revdepcheck::revdep_details(, "InPAS")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    There are ::: calls to the package's namespace in its code. A package
      almost never needs to use ::: for its own objects:
      ‘adjust_distalCPs’ ‘adjust_proximalCPs’ ‘adjust_proximalCPsByNBC’
      ‘adjust_proximalCPsByPWM’ ‘calculate_mse’ ‘find_valleyBySpline’
      ‘get_PAscore’ ‘get_PAscore2’ ‘remove_convergentUTR3s’
      ‘search_distalCPs’ ‘search_proximalCPs’
    ```

*   checking Rd metadata ... NOTE
    ```
    Invalid package aliases in Rd file 'InPAS.Rd':
      ‘-package’
    ```

*   checking Rd \usage sections ... NOTE
    ```
    Documented arguments not in \usage in Rd file 'get_UTR3TotalCov.Rd':
      ‘gcCompensationensation’
    
    Functions with \usage entries need to have the appropriate \alias
    entries, and all their arguments documented.
    The \usage entries must correspond to syntactically valid R code.
    See chapter ‘Writing R documentation files’ in the ‘Writing R
    Extensions’ manual.
    ```

# interflex

<details>

* Version: 1.2.6
* GitHub: NA
* Source code: https://github.com/cran/interflex
* Date/Publication: 2021-05-18 11:40:02 UTC
* Number of recursive dependencies: 101

Run `revdepcheck::revdep_details(, "interflex")` for more info

</details>

## In both

*   checking C++ specification ... NOTE
    ```
      Specified C++11: please drop specification unless essential
    ```

# ISAnalytics

<details>

* Version: 1.20.0
* GitHub: https://github.com/calabrialab/ISAnalytics
* Source code: https://github.com/cran/ISAnalytics
* Date/Publication: 2025-10-29
* Number of recursive dependencies: 177

Run `revdepcheck::revdep_details(, "ISAnalytics")` for more info

</details>

## In both

*   checking Rd files ... NOTE
    ```
    checkRd: (-1) refGenes_hg19.Rd:21: Lost braces; missing escapes or markup?
        21 | \item Download from {http://hgdownload.soe.ucsc.edu/goldenPath/hg19/database/}
           |                     ^
    ```

# ivmte

<details>

* Version: 1.4.0
* GitHub: NA
* Source code: https://github.com/cran/ivmte
* Date/Publication: 2021-09-17 12:20:07 UTC
* Number of recursive dependencies: 127

Run `revdepcheck::revdep_details(, "ivmte")` for more info

</details>

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

# JointAI

<details>

* Version: 1.0.6
* GitHub: https://github.com/nerler/JointAI
* Source code: https://github.com/cran/JointAI
* Date/Publication: 2024-04-02 18:25:00 UTC
* Number of recursive dependencies: 137

Run `revdepcheck::revdep_details(, "JointAI")` for more info

</details>

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
      Missing dependency on R >= 4.1.0 because package code uses the pipe
      |> or function shorthand \(...) syntax added in R 4.1.0.
      File(s) using such syntax:
        ‘helpfunctions_melt.R’
    ```

# kappaGold

<details>

* Version: 0.4.0
* GitHub: NA
* Source code: https://github.com/cran/kappaGold
* Date/Publication: 2024-12-09 22:50:02 UTC
* Number of recursive dependencies: 49

Run `revdepcheck::revdep_details(, "kappaGold")` for more info

</details>

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
      Missing dependency on R >= 4.1.0 because package code uses the pipe
      |> or function shorthand \(...) syntax added in R 4.1.0.
      File(s) using such syntax:
        ‘kappa_inference.R’
    ```

# ldmppr

<details>

* Version: 1.0.4
* GitHub: https://github.com/lanedrew/ldmppr
* Source code: https://github.com/cran/ldmppr
* Date/Publication: 2025-02-24 21:00:02 UTC
* Number of recursive dependencies: 128

Run `revdepcheck::revdep_details(, "ldmppr")` for more info

</details>

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘ldmppr-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: predict_marks
    > ### Title: Predict values from the mark distribution
    > ### Aliases: predict_marks
    > 
    > ### ** Examples
    > 
    > # Simulate a realization
    ...
    > # Load the example mark model
    > file_path <- system.file("extdata", "example_mark_model.rds", package = "ldmppr")
    > example_mark_model <- readRDS(file_path)
    > 
    > # Unbundle the model
    > mark_model <- bundle::unbundle(example_mark_model)
    Error in xgboost::xgb.load.raw(object, as_booster = TRUE) : 
      unused argument (as_booster = TRUE)
    Calls: <Anonymous> ... <Anonymous> -> unbundle -> unbundle.bundle -> <Anonymous>
    Execution halted
    ```

*   checking re-building of vignette outputs ... ERROR
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘ldmppr_howto.Rmd’ using rmarkdown
    
    Quitting from ldmppr_howto.Rmd:100-130 [train_mark_model]
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    <error/rlang_error>
    Error in `xgboost::xgb.load.raw()`:
    ! unused argument (as_booster = TRUE)
    ---
    Backtrace:
    ...
    
    Error: processing vignette 'ldmppr_howto.Rmd' failed with diagnostics:
    unused argument (as_booster = TRUE)
    --- failed re-building ‘ldmppr_howto.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘ldmppr_howto.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# ldsr

<details>

* Version: 0.0.2
* GitHub: https://github.com/ntthung/ldsr
* Source code: https://github.com/cran/ldsr
* Date/Publication: 2020-05-04 14:40:09 UTC
* Number of recursive dependencies: 67

Run `revdepcheck::revdep_details(, "ldsr")` for more info

</details>

## In both

*   checking C++ specification ... NOTE
    ```
      Specified C++11: please drop specification unless essential
    ```

# MAI

<details>

* Version: 1.16.0
* GitHub: https://github.com/KechrisLab/MAI
* Source code: https://github.com/cran/MAI
* Date/Publication: 2025-10-29
* Number of recursive dependencies: 175

Run `revdepcheck::revdep_details(, "MAI")` for more info

</details>

## In both

*   checking top-level files ... NOTE
    ```
    File
      LICENSE
    is not mentioned in the DESCRIPTION file.
    ```

# malariaAtlas

<details>

* Version: 1.6.4
* GitHub: https://github.com/malaria-atlas-project/malariaAtlas
* Source code: https://github.com/cran/malariaAtlas
* Date/Publication: 2025-06-11 11:00:06 UTC
* Number of recursive dependencies: 118

Run `revdepcheck::revdep_details(, "malariaAtlas")` for more info

</details>

## In both

*   checking re-building of vignette outputs ... ERROR
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘overview.Rmd’ using rmarkdown
    
    Quitting from overview.Rmd:199-201 [unnamed-chunk-25]
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    <error/rlang_error>
    Error:
    ! Cannot open "/scratch/henrik/943230/Rtmp2SPJZq/file865372b6afe3f.json"; The source could be corrupt or not supported. See `st_drivers()` for a list of supported formats.
    ---
    Backtrace:
    ...
    
    Error: processing vignette 'overview.Rmd' failed with diagnostics:
    Cannot open "/scratch/henrik/943230/Rtmp2SPJZq/file865372b6afe3f.json"; The source could be corrupt or not supported. See `st_drivers()` for a list of supported formats.
    --- failed re-building ‘overview.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘overview.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# mapme.biodiversity

<details>

* Version: 0.9.5
* GitHub: https://github.com/mapme-initiative/mapme.biodiversity
* Source code: https://github.com/cran/mapme.biodiversity
* Date/Publication: 2025-10-06 07:00:02 UTC
* Number of recursive dependencies: 101

Run `revdepcheck::revdep_details(, "mapme.biodiversity")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
      > library(mapme.biodiversity)
      > 
      > options(pillar.advice = FALSE)
      > mapme_options(verbose = FALSE)
      > test_check("mapme.biodiversity")
      You agreed to abide to ACLED's Terms of Use (https://acleddata.com/terms-of-use/).
    ...
      Expected `nrow(x2)` to equal 2.
      Differences:
        `actual`: 1.0
      `expected`: 2.0
      
      
      [ FAIL 2 | WARN 0 | SKIP 43 | PASS 543 ]
      Error:
      ! Test failures.
      Execution halted
    ```

# mbbe

<details>

* Version: 0.1.0
* GitHub: https://github.com/certara/mbbe
* Source code: https://github.com/cran/mbbe
* Date/Publication: 2024-02-03 11:20:02 UTC
* Number of recursive dependencies: 80

Run `revdepcheck::revdep_details(, "mbbe")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Complete output:
      > # This file is part of the standard setup for testthat.
      > # It is recommended that you do not modify it.
      > #
      > # Where should you do additional test configuration?
      > # Learn more about the roles of various files in:
      > # * https://r-pkgs.org/testing-design.html#sec-tests-files-overview
    ...
          ▆
       1. └─testthat::with_mock(...) at test-check_requirements.R:39:3
       2.   └─lifecycle::deprecate_stop("3.2.0", "with_mock()", "with_mocked_bindings()")
       3.     └─lifecycle:::deprecate_stop0(msg)
       4.       └─rlang::cnd_signal(...)
      
      [ FAIL 1 | WARN 0 | SKIP 0 | PASS 11 ]
      Error:
      ! Test failures.
      Execution halted
    ```

# mice

<details>

* Version: 3.18.0
* GitHub: https://github.com/amices/mice
* Source code: https://github.com/cran/mice
* Date/Publication: 2025-05-27 10:40:02 UTC
* Number of recursive dependencies: 132

Run `revdepcheck::revdep_details(, "mice")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Complete output:
      > library(testthat)
      > library(mice)
      
      Attaching package: 'mice'
      
      The following object is masked from 'package:stats':
    ...
       5. └─tidyr:::complete.data.frame(toenail, ID, visit)
       6.   ├─tidyr::expand(data, ...)
       7.   └─tidyr:::expand.data.frame(data, ...)
       8.     └─tidyr:::grid_dots(..., `_data` = data)
       9.       └─rlang::eval_tidy(dot, data = mask)
      
      [ FAIL 1 | WARN 0 | SKIP 2 | PASS 379 ]
      Error:
      ! Test failures.
      Execution halted
    ```

# mikropml

<details>

* Version: 1.7.0
* GitHub: https://github.com/SchlossLab/mikropml
* Source code: https://github.com/cran/mikropml
* Date/Publication: 2025-10-29 03:30:02 UTC
* Number of recursive dependencies: 180

Run `revdepcheck::revdep_details(, "mikropml")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘methods’
      All declared Imports should be used.
    ```

# MineICA

<details>

* Version: 1.49.0
* GitHub: NA
* Source code: https://github.com/cran/MineICA
* Date/Publication: 2025-10-07
* Number of recursive dependencies: 219

Run `revdepcheck::revdep_details(, "MineICA")` for more info

</details>

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘MineICA-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: plotCorGraph
    > ### Title: Plots graph using
    > ### Aliases: plotCorGraph
    > 
    > ### ** Examples
    > 
    > dat1 <- data.frame(matrix(rnorm(10000),ncol=10,nrow=1000))
    ...
     1. └─MineICA::plotCorGraph(...)
     2.   └─igraph::layout.fruchterman.reingold(...)
     3.     ├─igraph:::do_call(layout_with_fr, .args = c(list(...), params))
     4.     │ └─base::eval(call, .env)
     5.     │   └─base::eval(call, .env)
     6.     └─igraph::layout_with_fr(...)
     7.       └─lifecycle::deprecate_stop("0.8.0", "layout_with_fr(area = )")
     8.         └─lifecycle:::deprecate_stop0(msg)
     9.           └─rlang::cnd_signal(...)
    Execution halted
    ```

*   checking dependencies in R code ... WARNING
    ```
    Namespace in Imports field not imported from: ‘lumiHumanAll.db’
      All declared Imports should be used.
    Packages in Depends field not imported from:
      ‘GOstats’ ‘Hmisc’ ‘JADE’ ‘RColorBrewer’ ‘Rgraphviz’ ‘annotate’
      ‘biomaRt’ ‘cluster’ ‘colorspace’ ‘fastICA’ ‘foreach’ ‘ggplot2’
      ‘graph’ ‘gtools’ ‘igraph’ ‘marray’ ‘mclust’ ‘methods’ ‘plyr’ ‘scales’
      ‘xtable’
      These packages need to be imported from (in the NAMESPACE file)
      for when this namespace is loaded but not attached.
    Missing or unexported object: ‘GOstats::geneIdsByCategory’
    ':::' calls which should be '::':
      ‘Biobase:::annotation<-’ ‘Biobase:::validMsg’ ‘fpc:::pamk’
      ‘lumi:::getChipInfo’ ‘mclust:::adjustedRandIndex’
      See the note in ?`:::` about the use of this operator.
    Unexported object imported by a ':::' call: ‘Biobase:::isValidVersion’
      See the note in ?`:::` about the use of this operator.
    ```

*   checking Rd cross-references ... WARNING
    ```
    Missing link(s) in Rd file 'Alist.Rd':
      ‘class-IcaSet’
    
    Missing link(s) in Rd file 'Slist.Rd':
      ‘class-IcaSet’
    
    Missing link(s) in Rd file 'class-IcaSet.Rd':
      ‘class-IcaSet’
    
    Missing link(s) in Rd file 'getComp.Rd':
      ‘class-IcaSet’
    
    Missing link(s) in Rd file 'runAn.Rd':
      ‘[Category:class-GOHyperGParams]{GOHyperGParams}’
    
    See section 'Cross-references' in the 'Writing R Extensions' manual.
    ```

*   checking for missing documentation entries ... WARNING
    ```
    Undocumented S4 classes:
      ‘MineICAParams’
    All user-level objects in a package (including S4 classes and methods)
    should have documentation entries.
    See chapter ‘Writing R documentation files’ in the ‘Writing R
    Extensions’ manual.
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘MineICA.Rnw’ using Sweave
    Loading required package: BiocGenerics
    Loading required package: generics
    
    Attaching package: ‘generics’
    
    The following objects are masked from ‘package:base’:
    
        as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
    ...
    l.23 \usepackage
                    {subfig}^^M
    !  ==> Fatal error occurred, no output PDF file produced!
    --- failed re-building ‘MineICA.Rnw’
    
    SUMMARY: processing the following file failed:
      ‘MineICA.Rnw’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

*   checking DESCRIPTION meta-information ... NOTE
    ```
    Packages listed in more than one of Depends, Imports, Suggests, Enhances:
      ‘biomaRt’ ‘GOstats’ ‘cluster’ ‘mclust’ ‘igraph’
    A package should be listed in only one of these fields.
    ```

*   checking R code for possible problems ... NOTE
    ```
    addGenesToGoReport: no visible global function definition for
      ‘conditional’
    addGenesToGoReport: no visible global function definition for
      ‘sigCategories’
    annot2Color: no visible global function definition for ‘brewer.pal’
    annot2Color: no visible global function definition for ‘heat_hcl’
    annot2Color: no visible global function definition for ‘terrain_hcl’
    annot2Color: no visible global function definition for ‘cm.colors’
    annot2Color: no visible global function definition for ‘rainbow_hcl’
    annotFeatures: no visible global function definition for ‘na.omit’
    ...
      importFrom("methods", "callNextMethod", "new", "validObject")
      importFrom("stats", "aggregate", "as.dendrogram", "as.dist",
                 "as.hclust", "chisq.test", "cor", "cor.test", "cutree",
                 "dist", "hclust", "kmeans", "kruskal.test", "lm", "median",
                 "na.omit", "order.dendrogram", "p.adjust", "quantile",
                 "reorder", "shapiro.test", "wilcox.test")
      importFrom("utils", "capture.output", "combn", "read.table",
                 "write.table")
    to your NAMESPACE file (and ensure that your DESCRIPTION Imports field
    contains 'methods').
    ```

*   checking Rd files ... NOTE
    ```
    checkRd: (-1) clusterFastICARuns.Rd:47: Lost braces
        47 |   \item{...}{Additional parameters for code{funClus}}
           |                                            ^
    checkRd: (-1) clusterFastICARuns.Rd:52: Lost braces
        52 |   item{W}{the estimated unmixing matrix}, \item{Iq}{Iq
           |       ^
    checkRd: (-1) clusterFastICARuns.Rd:52: Lost braces
        52 |   item{W}{the estimated unmixing matrix}, \item{Iq}{Iq
           |          ^
    checkRd: (-1) plotDensOneAnnotInAllComp.Rd:104: Lost braces
    ...
           |                                 ^
    checkRd: (-1) runICA.Rd:44: Lost braces
        44 |   item{W}{the estimated unmixing matrix}}
           |       ^
    checkRd: (-1) runICA.Rd:44: Lost braces
        44 |   item{W}{the estimated unmixing matrix}}
           |          ^
    checkRd: (-1) writeProjByComp.Rd:38: Lost braces
        38 | their annotations, please remember to modify code{genesPath(params)}, or
           |                                                  ^
    ```

# mistyR

<details>

* Version: 1.18.0
* GitHub: https://github.com/saezlab/mistyR
* Source code: https://github.com/cran/mistyR
* Date/Publication: 2025-10-29
* Number of recursive dependencies: 150

Run `revdepcheck::revdep_details(, "mistyR")` for more info

</details>

## In both

*   checking R code for possible problems ... NOTE
    ```
    aggregate_results: no visible binding for global variable ‘measure’
    aggregate_results: no visible binding for global variable ‘target’
    aggregate_results: no visible binding for global variable ‘value’
    aggregate_results: no visible binding for global variable ‘sd’
    aggregate_results: no visible binding for global variable ‘view’
    aggregate_results: no visible binding for global variable ‘.PT’
    aggregate_results: no visible binding for global variable ‘Importance’
    aggregate_results_subset: no visible binding for global variable ‘view’
    aggregate_results_subset: no visible binding for global variable ‘.PT’
    aggregate_results_subset: no visible binding for global variable
    ...
    run_misty : <anonymous>: no visible binding for global variable
      ‘multi.R2’
    svm_model: no visible binding for global variable ‘index’
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

# mlr3resampling

<details>

* Version: 2025.11.19
* GitHub: https://github.com/tdhock/mlr3resampling
* Source code: https://github.com/cran/mlr3resampling
* Date/Publication: 2025-11-20 19:10:02 UTC
* Number of recursive dependencies: 101

Run `revdepcheck::revdep_details(, "mlr3resampling")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    c4-n43:pid784059: PSM3 can't open nic unit: 0 (err=23)
    c4-n43:pid784059.R: Unable to create UDP socket for ens13f0np0: Address family not supported by protocol
    c4-n43:pid784059.R: Unable to initialize sockets NIC /sys/class/net/ens13f0np0 (unit 0:0)
    c4-n43:pid784059: PSM3 can't open nic unit: 0 (err=23)
    c4-n43:pid784059.R: Unable to create UDP socket for ens13f0np0: Address family not supported by protocol
    c4-n43:pid784059.R: Unable to initialize sockets NIC /sys/class/net/ens13f0np0 (unit 0:0)
    c4-n43:pid784059: PSM3 can't open nic unit: 1 (err=23)
    c4-n43:pid784059.R: Unable to create UDP socket for ens13f1np1: Address family not supported by protocol
    c4-n43:pid784059.R: Unable to initialize sockets NIC /sys/class/net/ens13f1np1 (unit 1:0)
    c4-n43:pid784059: PSM3 can't open nic unit: 0 (err=23)
    ...
    c4-n43:pid784059.R: Unable to create UDP socket for ens13f1np1: Address family not supported by protocol
    c4-n43:pid784059.R: Unable to initialize sockets NIC /sys/class/net/ens13f1np1 (unit 1:0)
    --------------------------------------------------------------------------
    Open MPI failed an OFI Libfabric library call (fi_endpoint).  This is highly
    unusual; your job may behave unpredictably (and/or abort) after this.
    
      Local host: c4-n43
      Location: mtl_ofi_component.c:513
      Error: Invalid argument (22)
    --------------------------------------------------------------------------
    ```

# mlr3tuning

<details>

* Version: 1.5.0
* GitHub: https://github.com/mlr-org/mlr3tuning
* Source code: https://github.com/cran/mlr3tuning
* Date/Publication: 2025-11-07 12:40:09 UTC
* Number of recursive dependencies: 100

Run `revdepcheck::revdep_details(, "mlr3tuning")` for more info

</details>

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘mlr3tuning-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: mlr_tuners_internal
    > ### Title: Hyperparameter Tuning with Internal Tuning
    > ### Aliases: mlr_tuners_internal TunerBatchInternal
    > 
    > ### ** Examples
    > 
    > ## Don't show: 
    ...
      Argument 'objective' is only for custom objectives. For built-in objectives, pass the objective under 'params'. This warning will become an error in a future version.
    Warning in check.deprecation(deprecated_train_params, match.call(), ...) :
      Passed invalid function arguments: eval_metric, nthread, num_class. These should be passed as a list to argument 'params'. Conversion from argument to 'params' entry will be done automatically, but this behavior will become an error in a future version.
    Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed to '",  :
      Parameter 'watchlist' has been renamed to 'evals'. This warning will become an error in a future version.
    Warning in check.custom.obj(params, objective) :
      Argument 'objective' is only for custom objectives. For built-in objectives, pass the objective under 'params'. This warning will become an error in a future version.
    Error in names(x) <- nm : attempt to set an attribute on NULL
    Calls: withAutoprint ... tryCatchList -> tryCatchOne -> <Anonymous> -> onError
    Execution halted
    ```

# modeltime

<details>

* Version: 1.3.2
* GitHub: https://github.com/business-science/modeltime
* Source code: https://github.com/cran/modeltime
* Date/Publication: 2025-08-28 23:40:09 UTC
* Number of recursive dependencies: 237

Run `revdepcheck::revdep_details(, "modeltime")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
        'test-algo-seasonal_decomp_ets.R:10:5',
        'test-algo-seasonal_reg_tbats.R:20:5', 'test-algo-seasonal_reg_tbats.R:35:5',
        'test-algo-seasonal_reg_tbats.R:93:5', 'test-algo-temporal_hierarchy.R:8:5',
        'test-algo-window_reg.R:24:5', 'test-algo-window_reg.R:69:5',
        'test-algo-window_reg.R:100:5', 'test-algo-window_reg.R:153:5',
        'test-algo-window_reg.R:206:5', 'test-algo-window_reg.R:241:5',
    ...
       5. │   └─parsnip:::xy_xy(...)
       6. │     └─parsnip:::eval_mod(...)
       7. │       └─rlang::eval_tidy(e, env = envir, ...)
       8. └─modeltime::prophet_xgboost_fit_impl(...)
       9.   └─modeltime::xgboost_predict(fit_xgboost, newdata = xreg_tbl)
      
      [ FAIL 1 | WARN 0 | SKIP 80 | PASS 0 ]
      Error:
      ! Test failures.
      Execution halted
    ```

*   checking re-building of vignette outputs ... ERROR
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘getting-started-with-modeltime.Rmd’ using rmarkdown
    
    Quitting from getting-started-with-modeltime.Rmd:162-171 [unnamed-chunk-9]
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    <error/rlang_error>
    Error in `switch()`:
    ! EXPR must be a length 1 vector
    ---
    Backtrace:
    ...
    
    Error: processing vignette 'getting-started-with-modeltime.Rmd' failed with diagnostics:
    EXPR must be a length 1 vector
    --- failed re-building ‘getting-started-with-modeltime.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘getting-started-with-modeltime.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# multiverse

<details>

* Version: 0.6.2
* GitHub: https://github.com/MUCollective/multiverse
* Source code: https://github.com/cran/multiverse
* Date/Publication: 2024-10-07 23:20:03 UTC
* Number of recursive dependencies: 133

Run `revdepcheck::revdep_details(, "multiverse")` for more info

</details>

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
      Missing dependency on R >= 4.1.0 because package code uses the pipe
      |> or function shorthand \(...) syntax added in R 4.1.0.
      File(s) using such syntax:
        ‘accessors.R’ ‘export_json.R’ ‘extract.R’
    ```

# nixtlar

<details>

* Version: 0.6.2
* GitHub: https://github.com/Nixtla/nixtlar
* Source code: https://github.com/cran/nixtlar
* Date/Publication: 2024-10-28 23:10:02 UTC
* Number of recursive dependencies: 87

Run `revdepcheck::revdep_details(, "nixtlar")` for more info

</details>

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
      Missing dependency on R >= 4.1.0 because package code uses the pipe
      |> or function shorthand \(...) syntax added in R 4.1.0.
      File(s) using such syntax:
        ‘get_model_params.R’ ‘level_from_quantiles.R’ ‘make_request.R’
        ‘nixtla_client_cross_validation.R’ ‘nixtla_client_detect_anomalies.R’
        ‘nixtla_client_forecast.R’ ‘nixtla_client_historic.R’
        ‘nixtla_client_plot.R’ ‘nixtla_validate_api_key.R’
        ‘validate_exogenous.R’
    ```

# outliers.ts.oga

<details>

* Version: 1.1.1
* GitHub: NA
* Source code: https://github.com/cran/outliers.ts.oga
* Date/Publication: 2025-09-03 14:50:02 UTC
* Number of recursive dependencies: 155

Run `revdepcheck::revdep_details(, "outliers.ts.oga")` for more info

</details>

## In both

*   checking whether package ‘outliers.ts.oga’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: no DISPLAY variable so Tk is not available
    See ‘/scratch/henrik/revdep/future/checks/outliers.ts.oga/new/outliers.ts.oga.Rcheck/00install.out’ for details.
    ```

# PAMpal

<details>

* Version: 1.4.4
* GitHub: NA
* Source code: https://github.com/cran/PAMpal
* Date/Publication: 2025-03-04 00:20:02 UTC
* Number of recursive dependencies: 120

Run `revdepcheck::revdep_details(, "PAMpal")` for more info

</details>

## In both

*   checking whether package ‘PAMpal’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: no DISPLAY variable so Tk is not available
    See ‘/scratch/henrik/revdep/future/checks/PAMpal/new/PAMpal.Rcheck/00install.out’ for details.
    ```

# PAMscapes

<details>

* Version: 0.14.5
* GitHub: NA
* Source code: https://github.com/cran/PAMscapes
* Date/Publication: 2025-08-31 15:00:02 UTC
* Number of recursive dependencies: 128

Run `revdepcheck::revdep_details(, "PAMscapes")` for more info

</details>

## In both

*   checking whether package ‘PAMscapes’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: no DISPLAY variable so Tk is not available
    See ‘/scratch/henrik/revdep/future/checks/PAMscapes/new/PAMscapes.Rcheck/00install.out’ for details.
    ```

# pareg

<details>

* Version: 1.8.0
* GitHub: https://github.com/cbg-ethz/pareg
* Source code: https://github.com/cran/pareg
* Date/Publication: 2024-04-30
* Number of recursive dependencies: 323

Run `revdepcheck::revdep_details(, "pareg")` for more info

</details>

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘pareg-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: as.data.frame.pareg
    > ### Title: as.data.frame for an object of class 'pareg'.
    > ### Aliases: as.data.frame.pareg
    > 
    > ### ** Examples
    > 
    > df_genes <- data.frame(
    ...
        Found existing installation: pip 25.0.1
        Uninstalling pip-25.0.1:
          Successfully uninstalled pip-25.0.1
    Successfully installed pip-25.3 setuptools-80.9.0 wheel-0.45.1
    Installing packages: 'tensorflow==2.10.0', 'tensorflow-probability==0.14.0'
    + /c4/home/henrik/.cache/R/basilisk/1.22.0/pareg/1.8.0/pareg/bin/python -m pip install --upgrade --no-user 'tensorflow==2.10.0' 'tensorflow-probability==0.14.0'
    ERROR: Could not find a version that satisfies the requirement tensorflow==2.10.0 (from versions: 2.16.0rc0, 2.16.1, 2.16.2, 2.17.0rc0, 2.17.0rc1, 2.17.0, 2.17.1, 2.18.0rc0, 2.18.0rc1, 2.18.0rc2, 2.18.0, 2.18.1, 2.19.0rc0, 2.19.0, 2.19.1, 2.20.0rc0, 2.20.0)
    ERROR: No matching distribution found for tensorflow==2.10.0
    Error: Error installing package(s): "'tensorflow==2.10.0'", "'tensorflow-probability==0.14.0'"
    Execution halted
    ```

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Complete output:
      > library(testthat)
      > library(pareg)
      Loading required package: tensorflow
      Loading required package: tfprobability
      
      
    ...
          Found existing installation: pip 25.0.1
          Uninstalling pip-25.0.1:
            Successfully uninstalled pip-25.0.1
      Successfully installed pip-25.3 setuptools-80.9.0 wheel-0.45.1
      Installing packages: 'tensorflow==2.10.0', 'tensorflow-probability==0.14.0'
      + /c4/home/henrik/.cache/R/basilisk/1.22.0/pareg/1.8.0/pareg/bin/python -m pip install --upgrade --no-user 'tensorflow==2.10.0' 'tensorflow-probability==0.14.0'
      ERROR: Could not find a version that satisfies the requirement tensorflow==2.10.0 (from versions: 2.16.0rc0, 2.16.1, 2.16.2, 2.17.0rc0, 2.17.0rc1, 2.17.0, 2.17.1, 2.18.0rc0, 2.18.0rc1, 2.18.0rc2, 2.18.0, 2.18.1, 2.19.0rc0, 2.19.0, 2.19.1, 2.20.0rc0, 2.20.0)
      ERROR: No matching distribution found for tensorflow==2.10.0
      Error: Error installing package(s): "'tensorflow==2.10.0'", "'tensorflow-probability==0.14.0'"
      Execution halted
    ```

*   checking re-building of vignette outputs ... ERROR
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘pareg.Rmd’ using rmarkdown
    The magick package is required to crop "/scratch/henrik/revdep/future/checks/pareg/new/pareg.Rcheck/vign_test/pareg/vignettes/pareg_files/figure-html/unnamed-chunk-4-1.png" but not available.
    The magick package is required to crop "/scratch/henrik/revdep/future/checks/pareg/new/pareg.Rcheck/vign_test/pareg/vignettes/pareg_files/figure-html/unnamed-chunk-5-1.png" but not available.
    Requirement already satisfied: pip in /c4/home/henrik/.cache/R/basilisk/1.22.0/pareg/1.8.0/pareg/lib/python3.12/site-packages (25.0.1)
    Collecting pip
      Using cached pip-25.3-py3-none-any.whl.metadata (4.7 kB)
    Collecting wheel
      Using cached wheel-0.45.1-py3-none-any.whl.metadata (2.3 kB)
    Collecting setuptools
    ...
    --- re-building ‘pathway_similarities.Rmd’ using rmarkdown
    The magick package is required to crop "/scratch/henrik/revdep/future/checks/pareg/new/pareg.Rcheck/vign_test/pareg/vignettes/pathway_similarities_files/figure-html/unnamed-chunk-2-1.png" but not available.
    The magick package is required to crop "/scratch/henrik/revdep/future/checks/pareg/new/pareg.Rcheck/vign_test/pareg/vignettes/pathway_similarities_files/figure-html/unnamed-chunk-3-1.png" but not available.
    --- finished re-building ‘pathway_similarities.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘pareg.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

*   checking for portable file names ... NOTE
    ```
    Found the following non-portable file paths:
      pareg/inst/scripts/synthetic_benchmark/resources/multi_config_workflow/config_ablation_study/config.yaml
      pareg/inst/scripts/synthetic_benchmark/resources/multi_config_workflow/config_ablation_study/params.csv
      pareg/inst/scripts/synthetic_benchmark/resources/multi_config_workflow/config_dispersion_fitting/config.yaml
      pareg/inst/scripts/synthetic_benchmark/resources/multi_config_workflow/config_dispersion_fitting/params.csv
      pareg/inst/scripts/synthetic_benchmark/resources/multi_config_workflow/config_real_datasets/config.yaml
      pareg/inst/scripts/synthetic_benchmark/resources/multi_config_workflow/config_real_datasets/params.csv
      pareg/inst/scripts/synthetic_benchmark/resources/multi_config_workflow/config_regularization_effect/config.yaml
      pareg/inst/scripts/synthetic_benchmark/resources/multi_config_workflow/config_regularization_effect/params.csv
      pareg/inst/scripts/synthetic_benchmark/resources/multi_config_workflow/config_regularization_parameter/config.yaml
    ...
      pareg/inst/scripts/synthetic_benchmark/resources/multi_config_workflow/config_response_distribution/params.csv
      pareg/inst/scripts/synthetic_benchmark/resources/multi_config_workflow/config_similarity_measures/config.yaml
      pareg/inst/scripts/synthetic_benchmark/resources/multi_config_workflow/config_similarity_measures/params.csv
      pareg/inst/scripts/synthetic_benchmark/resources/multi_config_workflow/workflow/scripts/compare_rocauc_vs_loss.R
      pareg/inst/scripts/synthetic_benchmark/resources/multi_config_workflow/config_regularization_parameter
    
    Tarballs are only required to store paths of up to 100 bytes and cannot
    store those of more than 256 bytes, with restrictions including to 100
    bytes for the final component.
    See section ‘Package structure’ in the ‘Writing R Extensions’ manual.
    ```

*   checking whether package ‘pareg’ can be installed ... NOTE
    ```
    Found the following notes/warnings:
      Non-staged installation was used
    See ‘/scratch/henrik/revdep/future/checks/pareg/new/pareg.Rcheck/00install.out’ for details.
    ```

# partR2

<details>

* Version: 0.9.2
* GitHub: https://github.com/mastoffel/partR2
* Source code: https://github.com/cran/partR2
* Date/Publication: 2024-03-04 13:20:02 UTC
* Number of recursive dependencies: 92

Run `revdepcheck::revdep_details(, "partR2")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘methods’
      All declared Imports should be used.
    ```

# pavo

<details>

* Version: 2.9.0
* GitHub: https://github.com/rmaia/pavo
* Source code: https://github.com/cran/pavo
* Date/Publication: 2023-09-24 10:10:02 UTC
* Number of recursive dependencies: 98

Run `revdepcheck::revdep_details(, "pavo")` for more info

</details>

## In both

*   checking whether package ‘pavo’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: no DISPLAY variable so Tk is not available
    See ‘/scratch/henrik/revdep/future/checks/pavo/new/pavo.Rcheck/00install.out’ for details.
    ```

# pgxRpi

<details>

* Version: 1.6.0
* GitHub: https://github.com/progenetix/pgxRpi
* Source code: https://github.com/cran/pgxRpi
* Date/Publication: 2025-10-29
* Number of recursive dependencies: 166

Run `revdepcheck::revdep_details(, "pgxRpi")` for more info

</details>

## In both

*   checking R code for possible problems ... NOTE
    ```
    pgxSegprocess: no visible binding for global variable
      ‘followup_state_id’
    Undefined global functions or variables:
      followup_state_id
    ```

# photosynthesis

<details>

* Version: 2.1.5
* GitHub: https://github.com/cdmuir/photosynthesis
* Source code: https://github.com/cran/photosynthesis
* Date/Publication: 2024-11-24 19:40:02 UTC
* Number of recursive dependencies: 117

Run `revdepcheck::revdep_details(, "photosynthesis")` for more info

</details>

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

# powRICLPM

<details>

* Version: 0.2.1
* GitHub: https://github.com/JeroenDMulder/powRICLPM
* Source code: https://github.com/cran/powRICLPM
* Date/Publication: 2024-10-26 13:50:03 UTC
* Number of recursive dependencies: 65

Run `revdepcheck::revdep_details(, "powRICLPM")` for more info

</details>

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
      Missing dependency on R >= 4.1.0 because package code uses the pipe
      |> or function shorthand \(...) syntax added in R 4.1.0.
      File(s) using such syntax:
        ‘save.R’
    ```

# Prostar

<details>

* Version: 1.42.0
* GitHub: https://github.com/edyp-lab/Prostar
* Source code: https://github.com/cran/Prostar
* Date/Publication: 2025-10-29
* Number of recursive dependencies: 186

Run `revdepcheck::revdep_details(, "Prostar")` for more info

</details>

## In both

*   checking whether package ‘Prostar’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: replacing previous import ‘future::reset’ by ‘shinyjs::reset’ when loading ‘Prostar’
    See ‘/scratch/henrik/revdep/future/checks/Prostar/new/Prostar.Rcheck/00install.out’ for details.
    ```

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
      ‘DT’ ‘R.utils’ ‘RColorBrewer’ ‘XML’ ‘colourpicker’ ‘gtools’
      ‘markdown’ ‘rclipboard’ ‘sass’ ‘shinyTree’ ‘shinyWidgets’
      All declared Imports should be used.
    ```

*   checking files in ‘vignettes’ ... NOTE
    ```
    The following files look like leftovers/mistakes:
      ‘Prostar_UserManual.log’
    Please remove them from your package.
    ```

# pseudohouseholds

<details>

* Version: 0.1.1
* GitHub: https://github.com/chris31415926535/pseudohouseholds
* Source code: https://github.com/cran/pseudohouseholds
* Date/Publication: 2023-07-19 09:30:02 UTC
* Number of recursive dependencies: 97

Run `revdepcheck::revdep_details(, "pseudohouseholds")` for more info

</details>

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
      Missing dependency on R >= 4.1.0 because package code uses the pipe
      |> or function shorthand \(...) syntax added in R 4.1.0.
      File(s) using such syntax:
        ‘pseudohouseholds.R’
    ```

# qape

<details>

* Version: 2.1
* GitHub: NA
* Source code: https://github.com/cran/qape
* Date/Publication: 2023-08-21 14:10:12 UTC
* Number of recursive dependencies: 41

Run `revdepcheck::revdep_details(, "qape")` for more info

</details>

## In both

*   checking Rd files ... NOTE
    ```
    checkRd: (-1) srswrRe.Rd:10: Lost braces
        10 |   \item{listRanef}{{\emph{ranef(model)}} object where {\emph{model}} is an { \emph{lmer}} object.}
           |                                                                            ^
    ```

# QDNAseq

<details>

* Version: 1.46.0
* GitHub: https://github.com/ccagc/QDNAseq
* Source code: https://github.com/cran/QDNAseq
* Date/Publication: 2025-10-29
* Number of recursive dependencies: 95

Run `revdepcheck::revdep_details(, "QDNAseq")` for more info

</details>

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘QDNAseq.Rnw’ using Sweave
    EM algorithm started ... 
    
    Warning in allprior/tot :
      Recycling array of length 1 in vector-array arithmetic is deprecated.
      Use c() or as.vector() instead.
    Warning in allprior/tot :
      Recycling array of length 1 in vector-array arithmetic is deprecated.
      Use c() or as.vector() instead.
    ...
    l.197 \RequirePackage
                         {parnotes}^^M
    !  ==> Fatal error occurred, no output PDF file produced!
    --- failed re-building ‘QDNAseq.Rnw’
    
    SUMMARY: processing the following file failed:
      ‘QDNAseq.Rnw’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# receptiviti

<details>

* Version: 0.2.0
* GitHub: https://github.com/Receptiviti/receptiviti-r
* Source code: https://github.com/cran/receptiviti
* Date/Publication: 2025-06-07 15:10:02 UTC
* Number of recursive dependencies: 64

Run `revdepcheck::revdep_details(, "receptiviti")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Complete output:
      > library(testthat)
      > library(receptiviti)
      > 
      > test_check("receptiviti")
      Saving _problems/test-receptiviti-18.R
      [ FAIL 1 | WARN 0 | SKIP 4 | PASS 5 ]
    ...
       4. │     ├─testthat (local) .capture(...)
       5. │     │ └─base::withCallingHandlers(...)
       6. │     └─rlang::eval_bare(quo_get_expr(.quo), quo_get_env(.quo))
       7. └─receptiviti::receptiviti(...)
       8.   └─receptiviti:::manage_request(...)
      
      [ FAIL 1 | WARN 0 | SKIP 4 | PASS 5 ]
      Error:
      ! Test failures.
      Execution halted
    ```

# recforest

<details>

* Version: 1.0.0
* GitHub: NA
* Source code: https://github.com/cran/recforest
* Date/Publication: 2024-12-05 18:30:02 UTC
* Number of recursive dependencies: 124

Run `revdepcheck::revdep_details(, "recforest")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
       3. └─testthat::expect_equal(...) at test-train_forest.R:285:5
      ── Failure ('test-train_forest.R:301:5'): train_forest and predict_forest works with method GL ──
      Expected `trained_forest$tree_metrics` to equal `list(...)`.
      Differences:
        `actual[[1]]$c_index`: 0.794279
      `expected[[1]]$c_index`: 0.794180
    ...
      Backtrace:
          ▆
       1. ├─withr::with_seed(...) at test-train_forest.R:251:3
       2. │ └─withr::with_preserve_seed(...)
       3. └─testthat::expect_equal(...) at test-train_forest.R:323:5
      
      [ FAIL 3 | WARN 0 | SKIP 1 | PASS 61 ]
      Error:
      ! Test failures.
      Execution halted
    ```

# regmedint

<details>

* Version: 1.0.1
* GitHub: https://github.com/kaz-yos/regmedint
* Source code: https://github.com/cran/regmedint
* Date/Publication: 2024-01-13 00:50:02 UTC
* Number of recursive dependencies: 153

Run `revdepcheck::revdep_details(, "regmedint")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
      [ FAIL 4 | WARN 0 | SKIP 2 | PASS 4128 ]
      
      ══ Skipped tests (2) ═══════════════════════════════════════════════════════════
      • empty test (2): 'test-01_regmedint_class_ui.R:402:9',
        'test-01_regmedint_class_ui.R:421:9'
      
    ...
          ▆
       1. └─testthat::with_mock(...) at test-05_calc_myreg.R:235:9
       2.   └─lifecycle::deprecate_stop("3.2.0", "with_mock()", "with_mocked_bindings()")
       3.     └─lifecycle:::deprecate_stop0(msg)
       4.       └─rlang::cnd_signal(...)
      
      [ FAIL 4 | WARN 0 | SKIP 2 | PASS 4128 ]
      Error:
      ! Test failures.
      Execution halted
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘Deriv’
      All declared Imports should be used.
    ```

# rsi

<details>

* Version: 0.3.2
* GitHub: https://github.com/Permian-Global-Research/rsi
* Source code: https://github.com/cran/rsi
* Date/Publication: 2025-01-22 03:20:02 UTC
* Number of recursive dependencies: 75

Run `revdepcheck::revdep_details(, "rsi")` for more info

</details>

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
      Missing dependency on R >= 4.1.0 because package code uses the pipe
      |> or function shorthand \(...) syntax added in R 4.1.0.
      File(s) using such syntax:
        ‘calculate_indices.Rd’ ‘get_stac_data.R’ ‘get_stac_data.Rd’
        ‘landsat_mask_function.Rd’
    ```

# SCArray.sat

<details>

* Version: 1.9.0
* GitHub: https://github.com/AbbVie-ComputationalGenomics/SCArray
* Source code: https://github.com/cran/SCArray.sat
* Date/Publication: 2025-10-07
* Number of recursive dependencies: 177

Run `revdepcheck::revdep_details(, "SCArray.sat")` for more info

</details>

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘SCArray.sat-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: RunPCA
    > ### Title: Run PCA
    > ### Aliases: RunPCA RunPCA.SCArrayAssay RunPCA.SC_GDSMatrix
    > ### Keywords: methods GDS
    > 
    > ### ** Examples
    > 
    ...
      |                                                                      
      |                                                                |   0%
      |                                                                      
      |================================================================| 100%
    > d <- ScaleData(d)
    Warning: The following arguments are not used: layer
    Centering and scaling data matrix (SC_GDSMatrix [250x850])
    Warning: The new data doesn't have the same number of features as the current data
    Error: Attempting to add a different number of cells or features
    Execution halted
    ```

*   checking re-building of vignette outputs ... ERROR
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘SCArray.sat.Rmd’ using rmarkdown
    
      |                                                                      
      |                                                                |   0%
      |                                                                      
      |================================================================| 100%
    
    Quitting from SCArray.sat.Rmd:78-101 [unnamed-chunk-2]
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ...
    
    Error: processing vignette 'SCArray.sat.Rmd' failed with diagnostics:
    Attempting to add a different number of cells or features
    --- failed re-building ‘SCArray.sat.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘SCArray.sat.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

*   checking dependencies in R code ... NOTE
    ```
    Unexported objects imported by ':::' calls:
      ‘Seurat:::DEmethods_counts’ ‘Seurat:::DEmethods_nocorrect’
      ‘Seurat:::FastExpMean’ ‘Seurat:::FastLogVMR’ ‘Seurat:::NBResiduals’
      ‘Seurat:::UpdateKey’ ‘Seurat:::ValidateDataForMerge’
      See the note in ?`:::` about the use of this operator.
    ```

# shinyOAuth

<details>

* Version: 0.1.4
* GitHub: https://github.com/lukakoning/shinyOAuth
* Source code: https://github.com/cran/shinyOAuth
* Date/Publication: 2025-11-24 20:10:02 UTC
* Number of recursive dependencies: 76

Run `revdepcheck::revdep_details(, "shinyOAuth")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
        4. │     ├─testthat (local) .capture(...)
        5. │     │ └─base::withCallingHandlers(...)
        6. │     └─rlang::eval_bare(quo_get_expr(.quo), quo_get_env(.quo))
        7. └─shinyOAuth::oauth_provider_oidc_discover(issuer = issuer, jwks_host_issuer_match = TRUE)
        8.   └─shinyOAuth:::.discover_fetch_response(req, issuer)
        9.     └─shinyOAuth:::err_http(c(x = "Failed to fetch OIDC discovery document"), resp, context = list(issuer = issuer))
    ...
        [shinyOAuth] - HTTP request failed
        x Failed to fetch OIDC discovery document
        x Status 503: Service Unavailable.
        i URL: http://127.0.0.1:40113/.well-known/openid-configuration
        i Trace ID: Z8Pi2b5AGXNA
      
      [ FAIL 23 | WARN 0 | SKIP 12 | PASS 671 ]
      Error:
      ! Test failures.
      Execution halted
    ```

# sigminer

<details>

* Version: 2.3.1
* GitHub: https://github.com/ShixiangWang/sigminer
* Source code: https://github.com/cran/sigminer
* Date/Publication: 2024-05-11 08:50:02 UTC
* Number of recursive dependencies: 221

Run `revdepcheck::revdep_details(, "sigminer")` for more info

</details>

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
      Missing dependency on R >= 4.1.0 because package code uses the pipe
      |> or function shorthand \(...) syntax added in R 4.1.0.
      File(s) using such syntax:
        ‘show_group_enrichment.R’
    ```

# signeR

<details>

* Version: 2.12.0
* GitHub: https://github.com/TojalLab/signeR
* Source code: https://github.com/cran/signeR
* Date/Publication: 2025-10-29
* Number of recursive dependencies: 243

Run `revdepcheck::revdep_details(, "signeR")` for more info

</details>

## In both

*   checking C++ specification ... NOTE
    ```
      Specified C++14: please drop specification unless essential
    ```

*   checking R code for possible problems ... NOTE
    ```
    covariate: no visible binding for global variable ‘.’
    cox_as_data_frame2: no visible binding for global variable ‘term’
    cox_as_data_frame2: no visible binding for global variable ‘estimate’
    cox_as_data_frame2: no visible binding for global variable ‘conf.low’
    cox_as_data_frame2: no visible binding for global variable ‘conf.high’
    cox_as_data_frame2: no visible binding for global variable ‘p.value’
    explorepage: no visible binding for global variable ‘.’
    genCountMatrixFromMAF: no visible binding for global variable
      ‘Variant_Type’
    genCountMatrixFromMAF: no visible binding for global variable
    ...
    ExposureCorrelation,SignExp-numeric: no visible binding for global
      variable ‘exposure’
    ExposureCorrelation,matrix-numeric: no visible binding for global
      variable ‘Feature’
    ExposureCorrelation,matrix-numeric: no visible binding for global
      variable ‘exposure’
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

# simhelpers

<details>

* Version: 0.3.1
* GitHub: https://github.com/meghapsimatrix/simhelpers
* Source code: https://github.com/cran/simhelpers
* Date/Publication: 2025-01-10 21:50:02 UTC
* Number of recursive dependencies: 94

Run `revdepcheck::revdep_details(, "simhelpers")` for more info

</details>

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

# SmCCNet

<details>

* Version: 2.0.3
* GitHub: https://github.com/KechrisLab/SmCCNet
* Source code: https://github.com/cran/SmCCNet
* Date/Publication: 2024-04-16 05:20:02 UTC
* Number of recursive dependencies: 165

Run `revdepcheck::revdep_details(, "SmCCNet")` for more info

</details>

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘SmCCNet_Vignette_AutoSmCCNet.Rmd’ using rmarkdown
    [WARNING] Deprecated: --highlight-style. Use --syntax-highlighting instead.
    ! LaTeX Error: File `ucharcat.sty' not found.
    
    ! Emergency stop.
    <read *> 
    
    Error: processing vignette 'SmCCNet_Vignette_AutoSmCCNet.Rmd' failed with diagnostics:
    LaTeX failed to compile /scratch/henrik/revdep/future/checks/SmCCNet/new/SmCCNet.Rcheck/vign_test/SmCCNet/vignettes/SmCCNet_Vignette_AutoSmCCNet.tex. See https://yihui.org/tinytex/r/#debugging for debugging tips. See SmCCNet_Vignette_AutoSmCCNet.log for more info.
    ...
    Error: processing vignette 'SmCCNet_Vignette_SingleOmics.Rmd' failed with diagnostics:
    LaTeX failed to compile /scratch/henrik/revdep/future/checks/SmCCNet/new/SmCCNet.Rcheck/vign_test/SmCCNet/vignettes/SmCCNet_Vignette_SingleOmics.tex. See https://yihui.org/tinytex/r/#debugging for debugging tips. See SmCCNet_Vignette_SingleOmics.log for more info.
    --- failed re-building ‘SmCCNet_Vignette_SingleOmics.Rmd’
    
    SUMMARY: processing the following files failed:
      ‘SmCCNet_Vignette_AutoSmCCNet.Rmd’ ‘SmCCNet_Vignette_MultiOmics.Rmd’
      ‘SmCCNet_Vignette_SingleOmics.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# solitude

<details>

* Version: 1.1.3
* GitHub: https://github.com/talegari/solitude
* Source code: https://github.com/cran/solitude
* Date/Publication: 2021-07-29 20:00:02 UTC
* Number of recursive dependencies: 126

Run `revdepcheck::revdep_details(, "solitude")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘R6’ ‘lgr’
      All declared Imports should be used.
    ```

# sparrpowR

<details>

* Version: 0.2.9
* GitHub: https://github.com/machiela-lab/sparrpowR
* Source code: https://github.com/cran/sparrpowR
* Date/Publication: 2025-08-29 13:20:02 UTC
* Number of recursive dependencies: 128

Run `revdepcheck::revdep_details(, "sparrpowR")` for more info

</details>

## In both

*   checking whether package ‘sparrpowR’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: no DISPLAY variable so Tk is not available
    See ‘/scratch/henrik/revdep/future/checks/sparrpowR/new/sparrpowR.Rcheck/00install.out’ for details.
    ```

# SPARSEMODr

<details>

* Version: 1.2.0
* GitHub: https://github.com/NAU-CCL/SPARSEMODr
* Source code: https://github.com/cran/SPARSEMODr
* Date/Publication: 2022-07-19 20:50:02 UTC
* Number of recursive dependencies: 120

Run `revdepcheck::revdep_details(, "SPARSEMODr")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘future’ ‘geosphere’ ‘lubridate’ ‘tidyverse’ ‘viridis’
      All declared Imports should be used.
    ```

# spdesign

<details>

* Version: 0.0.5
* GitHub: https://github.com/edsandorf/spdesign
* Source code: https://github.com/cran/spdesign
* Date/Publication: 2024-10-18 13:40:02 UTC
* Number of recursive dependencies: 59

Run `revdepcheck::revdep_details(, "spdesign")` for more info

</details>

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
      Missing dependency on R >= 4.1.0 because package code uses the pipe
      |> or function shorthand \(...) syntax added in R 4.1.0.
      File(s) using such syntax:
        ‘federov.R’
    ```

# sperrorest

<details>

* Version: 3.0.5
* GitHub: https://github.com/giscience-fsu/sperrorest
* Source code: https://github.com/cran/sperrorest
* Date/Publication: 2022-10-16 12:50:02 UTC
* Number of recursive dependencies: 72

Run `revdepcheck::revdep_details(, "sperrorest")` for more info

</details>

## In both

*   checking Rd files ... NOTE
    ```
    checkRd: (-1) partition_cv.Rd:36: Lost braces; missing escapes or markup?
        36 | if \code{TRUE} (used internally by other {sperrorest} functions), return a
           |                                          ^
    checkRd: (-1) partition_cv_strat.Rd:28: Lost braces; missing escapes or markup?
        28 | if \code{TRUE} (used internally by other {sperrorest} functions), return a
           |                                          ^
    checkRd: (-1) partition_factor.Rd:28: Lost braces; missing escapes or markup?
        28 | if \code{TRUE} (used internally by other {sperrorest} functions), return a
           |                                          ^
    checkRd: (-1) partition_factor_cv.Rd:43: Lost braces; missing escapes or markup?
    ...
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

# sRACIPE

<details>

* Version: 2.2.0
* GitHub: https://github.com/lusystemsbio/sRACIPE
* Source code: https://github.com/cran/sRACIPE
* Date/Publication: 2025-10-29
* Number of recursive dependencies: 96

Run `revdepcheck::revdep_details(, "sRACIPE")` for more info

</details>

## In both

*   checking C++ specification ... NOTE
    ```
      Specified C++11: please drop specification unless essential
    ```

*   checking DESCRIPTION meta-information ... NOTE
    ```
    License stub is invalid DCF.
    ```

*   checking R code for possible problems ... NOTE
    ```
    sracipeSimulate: no visible binding for global variable
      ‘configurationTmp’
    sracipeSimulate: no visible binding for global variable ‘outFileGETmp’
    sracipeSimulate: no visible binding for global variable
      ‘outFileParamsTmp’
    sracipeSimulate: no visible binding for global variable ‘outFileICTmp’
    sracipeSimulate: no visible binding for global variable
      ‘outFileConvergeTmp’
    sracipeConvergeDist,RacipeSE: no visible global function definition for
      ‘polygon’
    Undefined global functions or variables:
      configurationTmp outFileConvergeTmp outFileGETmp outFileICTmp
      outFileParamsTmp polygon
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

# stars

<details>

* Version: 0.6-8
* GitHub: https://github.com/r-spatial/stars
* Source code: https://github.com/cran/stars
* Date/Publication: 2025-02-01 18:50:02 UTC
* Number of recursive dependencies: 162

Run `revdepcheck::revdep_details(, "stars")` for more info

</details>

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
      Missing dependency on R >= 4.2.0 because package code uses the pipe
      placeholder syntax added in R 4.2.0.
      File(s) using such syntax:
        ‘prcomp.Rd’
    ```

# stppSim

<details>

* Version: 1.3.4
* GitHub: https://github.com/Manalytics/stppSim
* Source code: https://github.com/cran/stppSim
* Date/Publication: 2024-07-24 13:30:02 UTC
* Number of recursive dependencies: 129

Run `revdepcheck::revdep_details(, "stppSim")` for more info

</details>

## In both

*   checking whether package ‘stppSim’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: no DISPLAY variable so Tk is not available
    See ‘/scratch/henrik/revdep/future/checks/stppSim/new/stppSim.Rcheck/00install.out’ for details.
    ```

# survstan

<details>

* Version: 0.0.7.1
* GitHub: https://github.com/fndemarqui/survstan
* Source code: https://github.com/cran/survstan
* Date/Publication: 2024-04-12 16:50:02 UTC
* Number of recursive dependencies: 111

Run `revdepcheck::revdep_details(, "survstan")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘RcppParallel’ ‘rstantools’
      All declared Imports should be used.
    ```

# synergyfinder

<details>

* Version: 3.18.0
* GitHub: NA
* Source code: https://github.com/cran/synergyfinder
* Date/Publication: 2025-10-29
* Number of recursive dependencies: 209

Run `revdepcheck::revdep_details(, "synergyfinder")` for more info

</details>

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
    .Extract2DrugPlotData: no visible binding for global variable
      ‘input_type’
    .Extract2DrugPlotData: no visible binding for global variable
      ‘block_id’
    .Extract2DrugPlotData: no visible binding for global variable ‘value’
    .Extract2DrugPlotData: no visible binding for global variable ‘left’
    .Extract2DrugPlotData: no visible binding for global variable ‘right’
    .Extract2DrugPlotData: no visible binding for global variable ‘conc1’
    .Extract2DrugPlotData: no visible binding for global variable ‘conc2’
    .Extract2DrugPlotData: no visible binding for global variable ‘text’
    ...
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

# targeted

<details>

* Version: 0.6
* GitHub: https://github.com/kkholst/targeted
* Source code: https://github.com/cran/targeted
* Date/Publication: 2025-10-30 07:50:09 UTC
* Number of recursive dependencies: 159

Run `revdepcheck::revdep_details(, "targeted")` for more info

</details>

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘targeted-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: learner_xgboost
    > ### Title: Construct a learner
    > ### Aliases: learner_xgboost
    > 
    > ### ** Examples
    > 
    > n  <- 1e3
    ...
    Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed to '",  :
      Parameter 'data' has been renamed to 'x'. This warning will become an error in a future version.
    Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed to '",  :
      Parameter 'eta' has been renamed to 'learning_rate'. This warning will become an error in a future version.
    Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed to '",  :
      Parameter 'lambda' has been renamed to 'reg_lambda'. This warning will become an error in a future version.
    Error in (function (x, y, objective = NULL, nrounds = 100L, max_depth = NULL,  : 
      argument "y" is missing, with no default
    Calls: <Anonymous> ... <Anonymous> -> process.y.margin.and.objective -> NROW
    Execution halted
    ```

*   checking tests ...
    ```
      Running ‘tinytest.R’
     ERROR
    Running the tests in ‘tests/tinytest.R’ failed.
    Last 50 lines of output:
      test_learner_stratify.R.......    0 tests    
      test_learner_stratify.R.......    0 tests    
      test_learner_stratify.R.......    0 tests    
      test_learner_stratify.R.......    3 tests [0;32mOK[0m 
      test_learner_stratify.R.......    3 tests [0;32mOK[0m 
      test_learner_stratify.R.......    5 tests [0;32mOK[0m [0;36m32ms[0m
    ...
      In addition: Warning messages:
      1: In throw_err_or_depr_msg("Passed unrecognized parameters: ", paste(head(names_unrecognized),  :
        Passed unrecognized parameters: verbose. This warning will become an error in a future version.
      2: In throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed to '",  :
        Parameter 'data' has been renamed to 'x'. This warning will become an error in a future version.
      3: In throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed to '",  :
        Parameter 'eta' has been renamed to 'learning_rate'. This warning will become an error in a future version.
      4: In throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed to '",  :
        Parameter 'lambda' has been renamed to 'reg_lambda'. This warning will become an error in a future version.
      Execution halted
    ```

*   checking re-building of vignette outputs ... ERROR
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘predictionclass.Rmd’ using rmarkdown
    
    Quitting from predictionclass.Rmd:143-145 [unnamed-chunk-5]
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    <error/rlang_error>
    Error:
    ! argument "y" is missing, with no default
    ---
    Backtrace:
    ...
    --- failed re-building ‘predictionclass.Rmd’
    
    --- re-building ‘riskregression.Rmd’ using rmarkdown
    --- finished re-building ‘riskregression.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘predictionclass.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# tglkmeans

<details>

* Version: 0.5.5
* GitHub: https://github.com/tanaylab/tglkmeans
* Source code: https://github.com/cran/tglkmeans
* Date/Publication: 2024-05-15 08:40:02 UTC
* Number of recursive dependencies: 85

Run `revdepcheck::revdep_details(, "tglkmeans")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘doRNG’
      All declared Imports should be used.
    ```

# tramvs

<details>

* Version: 0.0-8
* GitHub: NA
* Source code: https://github.com/cran/tramvs
* Date/Publication: 2025-11-18 18:00:02 UTC
* Number of recursive dependencies: 106

Run `revdepcheck::revdep_details(, "tramvs")` for more info

</details>

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error(s) in re-building vignettes:
      ...
    --- re-building ‘tramvs.Rnw’ using knitr
    Warning in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  :
      texi2dvi script/program not available, using emulation
    Error: processing vignette 'tramvs.Rnw' failed with diagnostics:
    unable to run pdflatex on 'tramvs.tex'
    LaTeX errors:
    ! LaTeX Error: File `wrapfig.sty' not found.
    
    ...
    l.68 \usepackage
                    {float}^^M
    !  ==> Fatal error occurred, no output PDF file produced!
    --- failed re-building ‘tramvs.Rnw’
    
    SUMMARY: processing the following file failed:
      ‘tramvs.Rnw’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# TriDimRegression

<details>

* Version: 1.0.3
* GitHub: https://github.com/alexander-pastukhov/tridim-regression
* Source code: https://github.com/cran/TriDimRegression
* Date/Publication: 2025-10-09 16:50:02 UTC
* Number of recursive dependencies: 91

Run `revdepcheck::revdep_details(, "TriDimRegression")` for more info

</details>

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
# tsdistributions

<details>

* Version: 1.0.3
* GitHub: https://github.com/tsmodels/tsdistributions
* Source code: https://github.com/cran/tsdistributions
* Date/Publication: 2025-04-17 09:50:02 UTC
* Number of recursive dependencies: 72

Run `revdepcheck::revdep_details(, "tsdistributions")` for more info

</details>

## In both

*   checking re-building of vignette outputs ... ERROR
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘estimation_demo.Rmd’ using rmarkdown
    [WARNING] Deprecated: --highlight-style. Use --syntax-highlighting instead.
    --- finished re-building ‘estimation_demo.Rmd’
    
    --- re-building ‘location_scale_distributions.Rmd’ using rmarkdown
    [WARNING] Deprecated: --highlight-style. Use --syntax-highlighting instead.
    ! Undefined control sequence.
    l.56 \NewDocumentCommand
                            \citeproctext{}{} 
    ...
    
    --- re-building ‘spd_demo.Rmd’ using rmarkdown
    [WARNING] Deprecated: --highlight-style. Use --syntax-highlighting instead.
    --- finished re-building ‘spd_demo.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘location_scale_distributions.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# tsgarch

<details>

* Version: 1.0.3
* GitHub: https://github.com/tsmodels/tsgarch
* Source code: https://github.com/cran/tsgarch
* Date/Publication: 2024-10-12 00:50:02 UTC
* Number of recursive dependencies: 104

Run `revdepcheck::revdep_details(, "tsgarch")` for more info

</details>

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
      Missing dependency on R >= 4.1.0 because package code uses the pipe
      |> or function shorthand \(...) syntax added in R 4.1.0.
      File(s) using such syntax:
        ‘benchmark.R’ ‘print.R’
    ```

# tsmarch

<details>

* Version: 1.0.0
* GitHub: https://github.com/tsmodels/tsmarch
* Source code: https://github.com/cran/tsmarch
* Date/Publication: 2024-11-18 13:30:02 UTC
* Number of recursive dependencies: 159

Run `revdepcheck::revdep_details(, "tsmarch")` for more info

</details>

## In both

*   checking re-building of vignette outputs ... ERROR
    ```
    Error(s) in re-building vignettes:
      ...
    --- re-building ‘feasible_multivariate_garch.Rmd’ using rmarkdown
    [WARNING] Deprecated: --highlight-style. Use --syntax-highlighting instead.
    ! Undefined control sequence.
    l.97 \NewDocumentCommand
                            \citeproctext{}{} 
    
    Error: processing vignette 'feasible_multivariate_garch.Rmd' failed with diagnostics:
    LaTeX failed to compile /scratch/henrik/revdep/future/checks/tsmarch/new/tsmarch.Rcheck/vign_test/tsmarch/vignettes/feasible_multivariate_garch.tex. See https://yihui.org/tinytex/r/#debugging for debugging tips. See feasible_multivariate_garch.log for more info.
    ...
    
    --- re-building ‘tsmarch_demo.Rmd’ using rmarkdown
    [WARNING] Deprecated: --highlight-style. Use --syntax-highlighting instead.
    --- finished re-building ‘tsmarch_demo.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘feasible_multivariate_garch.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# txshift

<details>

* Version: 0.3.8
* GitHub: https://github.com/nhejazi/txshift
* Source code: https://github.com/cran/txshift
* Date/Publication: 2022-02-09 22:30:02 UTC
* Number of recursive dependencies: 102

Run `revdepcheck::revdep_details(, "txshift")` for more info

</details>

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

# vmeasur

<details>

* Version: 0.1.4
* GitHub: NA
* Source code: https://github.com/cran/vmeasur
* Date/Publication: 2021-11-11 19:00:02 UTC
* Number of recursive dependencies: 122

Run `revdepcheck::revdep_details(, "vmeasur")` for more info

</details>

## In both

*   checking whether package ‘vmeasur’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: no DISPLAY variable so Tk is not available
    See ‘/scratch/henrik/revdep/future/checks/vmeasur/new/vmeasur.Rcheck/00install.out’ for details.
    ```

# WeightedCluster

<details>

* Version: 1.8-1
* GitHub: NA
* Source code: https://github.com/cran/WeightedCluster
* Date/Publication: 2024-12-10 22:00:02 UTC
* Number of recursive dependencies: 72

Run `revdepcheck::revdep_details(, "WeightedCluster")` for more info

</details>

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘BigDataSA.Rmd’ using rmarkdown
    [WARNING] Deprecated: --highlight-style. Use --syntax-highlighting instead.
    --- finished re-building ‘BigDataSA.Rmd’
    
    --- re-building ‘ClusterExternalValidSA.Rmd’ using rmarkdown
    [WARNING] Deprecated: --highlight-style. Use --syntax-highlighting instead.
    --- finished re-building ‘ClusterExternalValidSA.Rmd’
    
    --- re-building ‘ClusterValidSA.Rmd’ using rmarkdown
    ...
    l.85 \usepackage
                    {tikz}^^M
    !  ==> Fatal error occurred, no output PDF file produced!
    --- failed re-building ‘WeightedClusterPreview.Rnw’
    
    SUMMARY: processing the following files failed:
      ‘WeightedClusterFR.Rnw’ ‘WeightedClusterPreview.Rnw’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# wru

<details>

* Version: 3.0.3
* GitHub: https://github.com/kosukeimai/wru
* Source code: https://github.com/cran/wru
* Date/Publication: 2024-05-24 18:00:02 UTC
* Number of recursive dependencies: 94

Run `revdepcheck::revdep_details(, "wru")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘future’ ‘tidyr’
      All declared Imports should be used.
    ```

# XNAString

<details>

* Version: 1.15.0
* GitHub: NA
* Source code: https://github.com/cran/XNAString
* Date/Publication: 2024-10-29
* Number of recursive dependencies: 108

Run `revdepcheck::revdep_details(, "XNAString")` for more info

</details>

## In both

*   checking whether package ‘XNAString’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/scratch/henrik/revdep/future/checks/XNAString/new/XNAString.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘XNAString’ ...
** this is package ‘XNAString’ version ‘1.15.0’
** using staged installation
** libs
using C++ compiler: ‘g++ (GCC) 13.3.1 20240611 (Red Hat 13.3.1-2)’
using C++11
gcc -std=gnu2x -I"/software/c4/cbi/software/_rocky8/R-4.5.2-gcc13/lib64/R/include" -DNDEBUG -Dlibcaf_core_shared_EXPORTS -I../src -I../src -I'/scratch/henrik/revdep/future/library/XNAString/Rcpp/include' -I/usr/local/include    -fpic  -g -O2  -c ViennaRNA/utils/cpu.c -o ViennaRNA/utils/cpu.o
gcc -std=gnu2x -I"/software/c4/cbi/software/_rocky8/R-4.5.2-gcc13/lib64/R/include" -DNDEBUG -Dlibcaf_core_shared_EXPORTS -I../src -I../src -I'/scratch/henrik/revdep/future/library/XNAString/Rcpp/include' -I/usr/local/include    -fpic  -g -O2  -c ViennaRNA/utils/msa_utils.c -o ViennaRNA/utils/msa_utils.o
gcc -std=gnu2x -I"/software/c4/cbi/software/_rocky8/R-4.5.2-gcc13/lib64/R/include" -DNDEBUG -Dlibcaf_core_shared_EXPORTS -I../src -I../src -I'/scratch/henrik/revdep/future/library/XNAString/Rcpp/include' -I/usr/local/include    -fpic  -g -O2  -c ViennaRNA/utils/structure_tree.c -o ViennaRNA/utils/structure_tree.o
gcc -std=gnu2x -I"/software/c4/cbi/software/_rocky8/R-4.5.2-gcc13/lib64/R/include" -DNDEBUG -Dlibcaf_core_shared_EXPORTS -I../src -I../src -I'/scratch/henrik/revdep/future/library/XNAString/Rcpp/include' -I/usr/local/include    -fpic  -g -O2  -c ViennaRNA/utils/higher_order_functions.c -o ViennaRNA/utils/higher_order_functions.o
...
      |      ^~~~~~~~
ViennaRNA/datastructures/lists.c:284:1: error: conflicting types for ‘lst_mergesort’; have ‘void(LIST *, int (*)(void *, void *))’
  284 | lst_mergesort (LIST * l, int (*cmp_func) (void *, void *))
      | ^~~~~~~~~~~~~
../src/ViennaRNA/datastructures/lists.h:63:6: note: previous declaration of ‘lst_mergesort’ with type ‘void(LIST *, int (*)(void))’
   63 | void lst_mergesort (LIST * l, int (*cmp_func) ());
      |      ^~~~~~~~~~~~~
make: *** [/software/c4/cbi/software/_rocky8/R-4.5.2-gcc13/lib64/R/etc/Makeconf:202: ViennaRNA/datastructures/lists.o] Error 1
ERROR: compilation failed for package ‘XNAString’
* removing ‘/scratch/henrik/revdep/future/checks/XNAString/new/XNAString.Rcheck/XNAString’


```
### CRAN

```
* installing *source* package ‘XNAString’ ...
** this is package ‘XNAString’ version ‘1.15.0’
** using staged installation
** libs
using C++ compiler: ‘g++ (GCC) 13.3.1 20240611 (Red Hat 13.3.1-2)’
using C++11
gcc -std=gnu2x -I"/software/c4/cbi/software/_rocky8/R-4.5.2-gcc13/lib64/R/include" -DNDEBUG -Dlibcaf_core_shared_EXPORTS -I../src -I../src -I'/scratch/henrik/revdep/future/library/XNAString/Rcpp/include' -I/usr/local/include    -fpic  -g -O2  -c ViennaRNA/utils/cpu.c -o ViennaRNA/utils/cpu.o
gcc -std=gnu2x -I"/software/c4/cbi/software/_rocky8/R-4.5.2-gcc13/lib64/R/include" -DNDEBUG -Dlibcaf_core_shared_EXPORTS -I../src -I../src -I'/scratch/henrik/revdep/future/library/XNAString/Rcpp/include' -I/usr/local/include    -fpic  -g -O2  -c ViennaRNA/utils/msa_utils.c -o ViennaRNA/utils/msa_utils.o
gcc -std=gnu2x -I"/software/c4/cbi/software/_rocky8/R-4.5.2-gcc13/lib64/R/include" -DNDEBUG -Dlibcaf_core_shared_EXPORTS -I../src -I../src -I'/scratch/henrik/revdep/future/library/XNAString/Rcpp/include' -I/usr/local/include    -fpic  -g -O2  -c ViennaRNA/utils/structure_tree.c -o ViennaRNA/utils/structure_tree.o
gcc -std=gnu2x -I"/software/c4/cbi/software/_rocky8/R-4.5.2-gcc13/lib64/R/include" -DNDEBUG -Dlibcaf_core_shared_EXPORTS -I../src -I../src -I'/scratch/henrik/revdep/future/library/XNAString/Rcpp/include' -I/usr/local/include    -fpic  -g -O2  -c ViennaRNA/utils/higher_order_functions.c -o ViennaRNA/utils/higher_order_functions.o
...
      |      ^~~~~~~~
ViennaRNA/datastructures/lists.c:284:1: error: conflicting types for ‘lst_mergesort’; have ‘void(LIST *, int (*)(void *, void *))’
  284 | lst_mergesort (LIST * l, int (*cmp_func) (void *, void *))
      | ^~~~~~~~~~~~~
../src/ViennaRNA/datastructures/lists.h:63:6: note: previous declaration of ‘lst_mergesort’ with type ‘void(LIST *, int (*)(void))’
   63 | void lst_mergesort (LIST * l, int (*cmp_func) ());
      |      ^~~~~~~~~~~~~
make: *** [/software/c4/cbi/software/_rocky8/R-4.5.2-gcc13/lib64/R/etc/Makeconf:202: ViennaRNA/datastructures/lists.o] Error 1
ERROR: compilation failed for package ‘XNAString’
* removing ‘/scratch/henrik/revdep/future/checks/XNAString/old/XNAString.Rcheck/XNAString’


```
