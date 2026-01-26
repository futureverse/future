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

# ctsem

<details>

* Version: 3.10.5
* GitHub: https://github.com/cdriveraus/ctsem
* Source code: https://github.com/cran/ctsem
* Date/Publication: 2026-01-20 06:10:27 UTC
* Number of recursive dependencies: 170

Run `revdepcheck::revdep_details(, "ctsem")` for more info

</details>

## In both

*   checking whether package ‘ctsem’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: namespace ‘colorspace’ is not available and has been replaced
    See ‘/c4/home/henrik/futureverse/future/revdep/checks/ctsem/new/ctsem.Rcheck/00install.out’ for details.
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

# dar

<details>

* Version: 1.6.0
* GitHub: https://github.com/MicrobialGenomics-IrsicaixaOrg/dar
* Source code: https://github.com/cran/dar
* Date/Publication: 2025-10-29
* Number of recursive dependencies: 388

Run `revdepcheck::revdep_details(, "dar")` for more info

</details>

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘dar-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: export_steps
    > ### Title: Export step parameters as json.
    > ### Aliases: export_steps
    > 
    > ### ** Examples
    > 
    > data(metaHIV_phy)
    ...
    Error in (function (.x, .f, ..., .progress = FALSE)  : ℹ In index: 1.
    Caused by error in `purrr::map()`:
    ℹ In index: 1.
    ℹ With name: RiskGroup2.
    Caused by error in `map()`:
    ℹ In index: 1.
    Caused by error in `loadNamespace()`:
    ! there is no package called ‘Maaslin2’
    Calls: prep ... furrr_map_template -> furrr_template -> <Anonymous> -> value.list
    Execution halted
    ```

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
       50. │ └─vars %>% purrr::set_names() %>% ...
       51. ├─purrr::map(...)
       52. │ └─purrr:::map_("list", .x, .f, ..., .progress = .progress)
       53. │   ├─purrr:::with_indexed_errors(...)
       54. │   │ └─base::withCallingHandlers(...)
       55. │   ├─purrr:::call_with_cleanup(...)
    ...
       92. │     └─rlang:::signal_abort(cnd, .file)
       93. │       └─base::signalCondition(cnd)
       94. └─purrr (local) `<fn>`(`<prrr_rr_>`)
       95.   └─cli::cli_abort(...)
       96.     └─rlang::abort(...)
      
      [ FAIL 2 | WARN 3 | SKIP 8 | PASS 95 ]
      Error:
      ! Test failures.
      Execution halted
    ```

*   checking re-building of vignette outputs ... ERROR
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘article.Rmd’ using rmarkdown
    
    Quitting from article.Rmd:164-168 [unnamed-chunk-5]
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    <error/purrr_error_indexed>
    Error:
    ℹ In index: 1.
    Caused by error in `purrr::map()`:
    ℹ In index: 1.
    ...
    Caused by error in `loadNamespace()`:
    ! there is no package called 'Maaslin2'
    --- failed re-building ‘import_export_recipes.Rmd’
    
    SUMMARY: processing the following files failed:
      ‘article.Rmd’ ‘bioinformatics_vignette.Rmd’ ‘dar.Rmd’
      ‘import_export_recipes.Rmd’
    
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
    See ‘/c4/home/henrik/futureverse/future/revdep/checks/envi/new/envi.Rcheck/00install.out’ for details.
    ```

# FastRet

<details>

* Version: 1.3.0
* GitHub: https://github.com/spang-lab/FastRet
* Source code: https://github.com/cran/FastRet
* Date/Publication: 2025-12-17 23:40:02 UTC
* Number of recursive dependencies: 181

Run `revdepcheck::revdep_details(, "FastRet")` for more info

</details>

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘FastRet-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: analyzeCDNames
    > ### Title: Analyze Chemical Descriptors Names
    > ### Aliases: analyzeCDNames
    > ### Keywords: internal
    > 
    > ### ** Examples
    > 
    > X <- analyzeCDNames(df = head(RP, 2), descriptors = CDNames[1:2])
    2026-01-25 15:48:17.86 Descriptor 1/2
    Error in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]) : 
      there is no package called ‘rJava’
    Calls: analyzeCDNames ... loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
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
    --- re-building ‘fme_theory.Rmd’ using rmarkdown
    [WARNING] Deprecated: --highlight-style. Use --syntax-highlighting instead.
    --- finished re-building ‘fme_theory.Rmd’
    
    --- re-building ‘fmeffects.Rmd’ using rmarkdown
    
    Quitting from fmeffects.Rmd:121-127 [unnamed-chunk-11]
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    <error/purrr_error_indexed>
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
    ! Attempting to set up 255 localhost parallel workers with only 5 CPU cores available for this R process (per 'N/A'), which could result in a 5100% load. The hard limit is set to 300%. Overusing the CPUs has negative impact on the current R process, but also on all other processes of yours and others running on the same machine. See help("parallelly.maxWorkers.localhost", package = "parallelly") for further explanations and how to override the hard limit that triggered this error. By the way, was parallel::detectCores() used, because the number of workers (255) equals detectCores() - 1? If so, please use parallelly::availableCores() instead
    ---
    Backtrace:
    ...
    
    Error: processing vignette 'FracFixR-intro.Rmd' failed with diagnostics:
    Attempting to set up 255 localhost parallel workers with only 5 CPU cores available for this R process (per 'N/A'), which could result in a 5100% load. The hard limit is set to 300%. Overusing the CPUs has negative impact on the current R process, but also on all other processes of yours and others running on the same machine. See help("parallelly.maxWorkers.localhost", package = "parallelly") for further explanations and how to override the hard limit that triggered this error. By the way, was parallel::detectCores() used, because the number of workers (255) equals detectCores() - 1? If so, please use parallelly::availableCores() instead
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
    See ‘/c4/home/henrik/futureverse/future/revdep/checks/GeDS/new/GeDS.Rcheck/00install.out’ for details.
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
* Number of recursive dependencies: 119

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
* Number of recursive dependencies: 198

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

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Complete output:
      > library(testthat)
      > library(ISAnalytics)
      > 
      > test_check("ISAnalytics")
      Loading required namespace: plotly
      Loading required namespace: rmarkdown
    ...
      Backtrace:
          ▆
       1. └─ISAnalytics:::.re_agg_and_estimate(...) at test-population-size-estimate.R:605:5
       2.   ├─groups_dfs[[i]]
       3.   └─vctrs:::`[[.vctrs_list_of`(groups_dfs, i)
      
      [ FAIL 1 | WARN 0 | SKIP 0 | PASS 832 ]
      Error:
      ! Test failures.
      Execution halted
    ```

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

*   checking for code/documentation mismatches ... WARNING
    ```
    Codoc mismatches from Rd file 'Surv.Rd':
    Surv
      Code: function(time, time2, event, type = c("right", "left",
                     "interval", "counting", "interval2"), origin = 0)
      Docs: function(time, time2, event, type = c("right", "left",
                     "interval", "counting", "interval2", "mstate"), origin
                     = 0)
      Mismatches in argument default values:
        Name: 'type' Code: c("right", "left", "interval", "counting", "interval2") Docs: c("right", "left", "interval", "counting", "interval2", "mstate")
    ```

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

# kmeRtone

<details>

* Version: 1.0
* GitHub: https://github.com/SahakyanLab/kmeRtone
* Source code: https://github.com/cran/kmeRtone
* Date/Publication: 2024-08-30 10:50:06 UTC
* Number of recursive dependencies: 69

Run `revdepcheck::revdep_details(, "kmeRtone")` for more info

</details>

## In both

*   checking whether package ‘kmeRtone’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/c4/home/henrik/futureverse/future/revdep/checks/kmeRtone/new/kmeRtone.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘kmeRtone’ ...
** this is package ‘kmeRtone’ version ‘1.0’
** package ‘kmeRtone’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘g++ (GCC) 13.3.1 20240611 (Red Hat 13.3.1-2)’
Error in loadNamespace(x) : there is no package called ‘Rhtslib’
Calls: loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
Execution halted
g++ -std=gnu++17 -I"/software/c4/cbi/software/_rocky8/R-4.5.2-gcc13/lib64/R/include" -DNDEBUG  -I'/c4/home/henrik/futureverse/future/revdep/library/kmeRtone/Rcpp/include' -I'/c4/home/henrik/futureverse/future/revdep/library/kmeRtone/stringi/include' -I/usr/local/include    -fpic  -g -O2   -c RcppExports.cpp -o RcppExports.o
...
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
Error in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]) : 
  there is no package called ‘rJava’
Calls: <Anonymous> ... loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
Execution halted
ERROR: lazy loading failed for package ‘kmeRtone’
* removing ‘/c4/home/henrik/futureverse/future/revdep/checks/kmeRtone/new/kmeRtone.Rcheck/kmeRtone’


```
### CRAN

```
* installing *source* package ‘kmeRtone’ ...
** this is package ‘kmeRtone’ version ‘1.0’
** package ‘kmeRtone’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘g++ (GCC) 13.3.1 20240611 (Red Hat 13.3.1-2)’
Error in loadNamespace(x) : there is no package called ‘Rhtslib’
Calls: loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
Execution halted
g++ -std=gnu++17 -I"/software/c4/cbi/software/_rocky8/R-4.5.2-gcc13/lib64/R/include" -DNDEBUG  -I'/c4/home/henrik/futureverse/future/revdep/library/kmeRtone/Rcpp/include' -I'/c4/home/henrik/futureverse/future/revdep/library/kmeRtone/stringi/include' -I/usr/local/include    -fpic  -g -O2   -c RcppExports.cpp -o RcppExports.o
...
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
Error in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]) : 
  there is no package called ‘rJava’
Calls: <Anonymous> ... loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
Execution halted
ERROR: lazy loading failed for package ‘kmeRtone’
* removing ‘/c4/home/henrik/futureverse/future/revdep/checks/kmeRtone/old/kmeRtone.Rcheck/kmeRtone’


```
# lavDiag

<details>

* Version: 0.1.0
* GitHub: https://github.com/reckak/lavDiag
* Source code: https://github.com/cran/lavDiag
* Date/Publication: 2026-01-17 11:50:08 UTC
* Number of recursive dependencies: 90

Run `revdepcheck::revdep_details(, "lavDiag")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘spelling.R’
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
      Error in `checkNumberOfLocalWorkers(workers)`: Attempting to set up 255 localhost parallel workers with only 5 CPU cores available for this R process (per 'N/A'), which could result in a 5100% load. The hard limit is set to 300%. Overusing the CPUs has negative impact on the current R process, but also on all other processes of yours and others running on the same machine. See help("parallelly.maxWorkers.localhost", package = "parallelly") for further explanations and how to override the hard limit that triggered this error. By the way, was parallel::detectCores() used, because the number of workers (255) equals detectCores() - 1? If so, please use parallelly::availableCores() instead
      Backtrace:
           ▆
        1. ├─lavDiag::augment(fit) at test-augment.R:13:3
        2. │ └─lavDiag::lavPredict_parallel(...)
    ...
      Error in `prepare(fit, length.out = 15)`: Neither continuous nor ordinal branch succeeded - check model/functions.
      Backtrace:
          ▆
       1. └─lavDiag::prepare(fit, length.out = 15) at test-prepare.R:12:3
       2.   └─rlang::abort("Neither continuous nor ordinal branch succeeded - check model/functions.")
      
      [ FAIL 3 | WARN 25 | SKIP 1 | PASS 28 ]
      Error:
      ! Test failures.
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
    
    > ### Name: IcaSet
    > ### Title: Class to Contain and Describe an ICA decomposition of
    > ###   High-Throughput Data.
    > ### Aliases: class:IcaSet IcaSet IcaSet-class [ [,ANY,ANY,IcaSet-method
    > ###   [,IcaSet,ANY-method [,IcaSet,ANY,ANY-method
    > ###   [,IcaSet,ANY,ANY,ANY-method [<- [<-,IcaSet,ANY,ANY,ANY,ANY-method
    > ###   [<-,IcaSet,ANY,ANY,ANY-method [<-,IcaSet,ANY,ANY-method organism
    ...
    Annotation:  
    > dat <- matrix(runif(100000), nrow=1000, ncol=100)
    > rownames(dat) <- 1:nrow(dat)
    > new("IcaSet",
    +     dat=dat, 
    +     A=as.data.frame(matrix(runif(1000), nrow=100, ncol=10)),
    +     S=as.data.frame(matrix(runif(10000), nrow=1000, ncol=10), row.names = 1:nrow(dat)))
    Error: Your query has been redirected to https://status.ensembl.org indicating this Ensembl service is currently unavailable.
    Look at ?useEnsembl for details on how to try a mirror site.
    Execution halted
    ```

*   checking re-building of vignette outputs ... ERROR
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘MineICA.Rnw’ using Sweave
    Loading required package: BiocGenerics
    Loading required package: generics
    
    Attaching package: ‘generics’
    
    The following objects are masked from ‘package:base’:
    
        as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
    ...
    Error : Your query has been redirected to https://status.ensembl.org indicating this Ensembl service is currently unavailable.
    Look at ?useEnsembl for details on how to try a mirror site.
    
    --- failed re-building ‘MineICA.Rnw’
    
    SUMMARY: processing the following file failed:
      ‘MineICA.Rnw’
    
    Error: Vignette re-building failed.
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

*   checking examples ... ERROR
    ```
    Running examples in ‘mlr3resampling-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: proj_compute
    > ### Title: Compute resampling results in a project
    > ### Aliases: proj_compute
    > 
    > ### ** Examples
    > 
    > 
    ...
      version 16.05 or later: you can use SLURM's PMIx support. This
      requires that you configure and build SLURM --with-pmix.
    
      Versions earlier than 16.05: you must use either SLURM's PMI-1 or
      PMI-2 support. SLURM builds PMI-1 by default, or you can manually
      install PMI-2. You must then build Open MPI using --with-pmi pointing
      to the SLURM PMI library location.
    
    Please configure as appropriate and try again.
    --------------------------------------------------------------------------
    ```

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Complete output:
      > data.table::setDTthreads(1L)
      > if(require(testthat))test_check("mlr3resampling")
      Loading required package: testthat
      Loading required package: mlr3resampling
      [c4-n43:526522] OPAL ERROR: Not initialized in file ext2x_client.c at line 112
      --------------------------------------------------------------------------
    ...
        install PMI-2. You must then build Open MPI using --with-pmi pointing
        to the SLURM PMI library location.
      
      Please configure as appropriate and try again.
      --------------------------------------------------------------------------
      *** An error occurred in MPI_Init
      *** on a NULL communicator
      *** MPI_ERRORS_ARE_FATAL (processes in this communicator will now abort,
      ***    and potentially your MPI job)
      [c4-n43:526522] Local abort before MPI_INIT completed completed successfully, but am not able to aggregate error messages, and not able to guarantee that all other processes were killed!
    ```

*   checking dependencies in R code ... NOTE
    ```
    [c4-n43:520752] OPAL ERROR: Not initialized in file ext2x_client.c at line 112
    --------------------------------------------------------------------------
    The application appears to have been direct launched using "srun",
    but OMPI was not built with SLURM's PMI support and therefore cannot
    execute. There are several options for building PMI support under
    SLURM, depending upon the SLURM version you are using:
    
      version 16.05 or later: you can use SLURM's PMIx support. This
      requires that you configure and build SLURM --with-pmix.
    
      Versions earlier than 16.05: you must use either SLURM's PMI-1 or
      PMI-2 support. SLURM builds PMI-1 by default, or you can manually
      install PMI-2. You must then build Open MPI using --with-pmi pointing
      to the SLURM PMI library location.
    
    Please configure as appropriate and try again.
    --------------------------------------------------------------------------
    ```

# mongolstats

<details>

* Version: 0.1.0
* GitHub: https://github.com/temuulene/mongolstats
* Source code: https://github.com/cran/mongolstats
* Date/Publication: 2026-01-18 11:00:02 UTC
* Number of recursive dependencies: 117

Run `revdepcheck::revdep_details(, "mongolstats")` for more info

</details>

## In both

*   checking re-building of vignette outputs ... ERROR
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘discovery.Rmd’ using rmarkdown
    [WARNING] Deprecated: --highlight-style. Use --syntax-highlighting instead.
    --- finished re-building ‘discovery.Rmd’
    
    --- re-building ‘environmental-surveillance.Rmd’ using rmarkdown
    
    Quitting from environmental-surveillance.Rmd:61-145 [air-quality-data]
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    <error/rlang_error>
    ...
    
    --- re-building ‘ub-health-environment.Rmd’ using rmarkdown
    [WARNING] Deprecated: --highlight-style. Use --syntax-highlighting instead.
    --- finished re-building ‘ub-health-environment.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘environmental-surveillance.Rmd’
    
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
    See ‘/c4/home/henrik/futureverse/future/revdep/checks/outliers.ts.oga/new/outliers.ts.oga.Rcheck/00install.out’ for details.
    ```

# OutSeekR

<details>

* Version: 1.1.0
* GitHub: NA
* Source code: https://github.com/cran/OutSeekR
* Date/Publication: 2026-01-16 17:00:22 UTC
* Number of recursive dependencies: 35

Run `revdepcheck::revdep_details(, "OutSeekR")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘future’ ‘truncnorm’
      All declared Imports should be used.
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
    See ‘/c4/home/henrik/futureverse/future/revdep/checks/PAMpal/new/PAMpal.Rcheck/00install.out’ for details.
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
    See ‘/c4/home/henrik/futureverse/future/revdep/checks/PAMscapes/new/PAMscapes.Rcheck/00install.out’ for details.
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
    See ‘/c4/home/henrik/futureverse/future/revdep/checks/pavo/new/pavo.Rcheck/00install.out’ for details.
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

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
      Saving _problems/test_variants-57.R
      
       trying: https://progenetix.org/services/samplematrix/?filters=pgx:icdom-88503 
      Saving _problems/test_variants-64.R
      Saving _problems/test_variants-65.R
      Saving _problems/test_variants-66.R
    ...
          ▆
       1. ├─testthat::expect_gt(nrow(result), 0) at test_variants.R:66:5
       2. │ └─testthat::quasi_label(enquo(object), label)
       3. │   └─rlang::eval_bare(expr, quo_get_env(quo))
       4. └─base::nrow(result)
      
      [ FAIL 5 | WARN 2 | SKIP 0 | PASS 35 ]
      Error:
      ! Test failures.
      Execution halted
    ```

*   checking re-building of vignette outputs ... ERROR
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘Introduction_1_load_metadata.Rmd’ using rmarkdown
    The magick package is required to crop "/c4/home/henrik/futureverse/future/revdep/checks/pgxRpi/new/pgxRpi.Rcheck/vign_test/pgxRpi/vignettes/Introduction_1_load_metadata_files/figure-html/unnamed-chunk-13-1.png" but not available.
    --- finished re-building ‘Introduction_1_load_metadata.Rmd’
    
    --- re-building ‘Introduction_2_query_variants.Rmd’ using rmarkdown
    --- finished re-building ‘Introduction_2_query_variants.Rmd’
    
    --- re-building ‘Introduction_3_access_cnv_frequency.Rmd’ using rmarkdown
    
    ...
    The magick package is required to crop "/c4/home/henrik/futureverse/future/revdep/checks/pgxRpi/new/pgxRpi.Rcheck/vign_test/pgxRpi/vignettes/Introduction_4_process_pgxseg_files/figure-html/unnamed-chunk-14-1.png" but not available.
    The magick package is required to crop "/c4/home/henrik/futureverse/future/revdep/checks/pgxRpi/new/pgxRpi.Rcheck/vign_test/pgxRpi/vignettes/Introduction_4_process_pgxseg_files/figure-html/unnamed-chunk-15-1.png" but not available.
    The magick package is required to crop "/c4/home/henrik/futureverse/future/revdep/checks/pgxRpi/new/pgxRpi.Rcheck/vign_test/pgxRpi/vignettes/Introduction_4_process_pgxseg_files/figure-html/unnamed-chunk-16-1.png" but not available.
    --- finished re-building ‘Introduction_4_process_pgxseg.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘Introduction_3_access_cnv_frequency.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

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
    See ‘/c4/home/henrik/futureverse/future/revdep/checks/Prostar/new/Prostar.Rcheck/00install.out’ for details.
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
* Number of recursive dependencies: 94

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

# Rcurvep

<details>

* Version: 1.3.2
* GitHub: https://github.com/moggces/Rcurvep
* Source code: https://github.com/cran/Rcurvep
* Date/Publication: 2025-05-31 21:10:02 UTC
* Number of recursive dependencies: 122

Run `revdepcheck::revdep_details(, "Rcurvep")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘rJava’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
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

# remiod

<details>

* Version: 1.0.2
* GitHub: https://github.com/xsswang/remiod
* Source code: https://github.com/cran/remiod
* Date/Publication: 2022-11-18 17:20:02 UTC
* Number of recursive dependencies: 147

Run `revdepcheck::revdep_details(, "remiod")` for more info

</details>

## In both

*   checking whether package ‘remiod’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: replacing previous import ‘JointAI::Surv’ by ‘survival::Surv’ when loading ‘remiod’
    See ‘/c4/home/henrik/futureverse/future/revdep/checks/remiod/new/remiod.Rcheck/00install.out’ for details.
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
* Number of recursive dependencies: 176

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

# scLANE

<details>

* Version: 1.0.0
* GitHub: https://github.com/jr-leary7/scLANE
* Source code: https://github.com/cran/scLANE
* Date/Publication: 2025-10-29
* Number of recursive dependencies: 295

Run `revdepcheck::revdep_details(, "scLANE")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
      > test_check("scLANE")
      Loading required namespace: SingleCellExperiment
      
      Attaching package: 'MASS'
      
      The following object is masked from 'package:glm2':
    ...
       5.   └─SeuratObject:::GetAssayData.Seurat(...)
       6.     └─SeuratObject::.Deprecate(...)
       7.       └─lifecycle::deprecate_stop(...)
       8.         └─lifecycle:::deprecate_stop0(msg)
       9.           └─rlang::cnd_signal(...)
      
      [ FAIL 1 | WARN 741 | SKIP 0 | PASS 0 ]
      Error:
      ! Test failures.
      Execution halted
    ```

# shinyOAuth

<details>

* Version: 0.2.0
* GitHub: https://github.com/lukakoning/shinyOAuth
* Source code: https://github.com/cran/shinyOAuth
* Date/Publication: 2026-01-13 08:10:02 UTC
* Number of recursive dependencies: 75

Run `revdepcheck::revdep_details(, "shinyOAuth")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
        3.     └─httr2:::resp_failure_cnd(req, resp, error_call = error_call)
        4.       ├─rlang::catch_cnd(...)
        5.       │ ├─rlang::eval_bare(...)
        6.       │ ├─base::tryCatch(...)
        7.       │ │ └─base (local) tryCatchList(expr, classes, parentenv, handlers)
        8.       │ │   └─base (local) tryCatchOne(expr, names, parentenv, handlers[[1L]])
    ...
        7.       │ │ └─base (local) tryCatchList(expr, classes, parentenv, handlers)
        8.       │ │   └─base (local) tryCatchOne(expr, names, parentenv, handlers[[1L]])
        9.       │ │     └─base (local) doTryCatch(return(expr), name, parentenv, handler)
       10.       │ └─base::force(expr)
       11.       └─rlang::abort(...)
      
      [ FAIL 35 | WARN 0 | SKIP 19 | PASS 1206 ]
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

# SpaDES.core

<details>

* Version: 3.0.4
* GitHub: https://github.com/PredictiveEcology/SpaDES.core
* Source code: https://github.com/cran/SpaDES.core
* Date/Publication: 2026-01-11 06:12:04 UTC
* Number of recursive dependencies: 142

Run `revdepcheck::revdep_details(, "SpaDES.core")` for more info

</details>

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘SpaDES.core-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: convertToPackage
    > ### Title: Convert standard module code into an R package
    > ### Aliases: convertToPackage
    > 
    > ### ** Examples
    > 
    > if (requireNamespace("ggplot2") && requireNamespace("pkgload") ) {
    +   tmpdir <- tempdir2()
    +   newModule("test", tmpdir, open = FALSE)
    +   convertToPackage("test", path = tmpdir)
    + }
    Loading required namespace: pkgload
    New module test created at /scratch/henrik/1016046/RtmpqVW9ux/reproducible/U3C0xYmG
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
    See ‘/c4/home/henrik/futureverse/future/revdep/checks/sparrpowR/new/sparrpowR.Rcheck/00install.out’ for details.
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
    See ‘/c4/home/henrik/futureverse/future/revdep/checks/stppSim/new/stppSim.Rcheck/00install.out’ for details.
    ```

# survstan

<details>

* Version: 0.0.7.1
* GitHub: https://github.com/fndemarqui/survstan
* Source code: https://github.com/cran/survstan
* Date/Publication: 2024-04-12 16:50:02 UTC
* Number of recursive dependencies: 112

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

# targets

<details>

* Version: 1.11.4
* GitHub: https://github.com/ropensci/targets
* Source code: https://github.com/cran/targets
* Date/Publication: 2025-09-13 05:10:02 UTC
* Number of recursive dependencies: 156

Run `revdepcheck::revdep_details(, "targets")` for more info

</details>

## In both

*   checking Rd cross-references ... NOTE
    ```
    Unknown package ‘qs’ in Rd xrefs
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
    See ‘/c4/home/henrik/futureverse/future/revdep/checks/TriDimRegression/new/TriDimRegression.Rcheck/00install.out’ for details.
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
* removing ‘/c4/home/henrik/futureverse/future/revdep/checks/TriDimRegression/new/TriDimRegression.Rcheck/TriDimRegression’


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
* removing ‘/c4/home/henrik/futureverse/future/revdep/checks/TriDimRegression/old/TriDimRegression.Rcheck/TriDimRegression’


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
    LaTeX failed to compile /c4/home/henrik/futureverse/future/revdep/checks/tsmarch/new/tsmarch.Rcheck/vign_test/tsmarch/vignettes/feasible_multivariate_garch.tex. See https://yihui.org/tinytex/r/#debugging for debugging tips. See feasible_multivariate_garch.log for more info.
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
    See ‘/c4/home/henrik/futureverse/future/revdep/checks/vmeasur/new/vmeasur.Rcheck/00install.out’ for details.
    ```

# WeightedCluster

<details>

* Version: 2.0
* GitHub: NA
* Source code: https://github.com/cran/WeightedCluster
* Date/Publication: 2025-12-10 08:40:02 UTC
* Number of recursive dependencies: 91

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
* Number of recursive dependencies: 95

Run `revdepcheck::revdep_details(, "wru")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘future’ ‘tidyr’
      All declared Imports should be used.
    ```

