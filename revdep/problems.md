# adestr

<details>

* Version: 1.0.0
* GitHub: NA
* Source code: https://github.com/cran/adestr
* Date/Publication: 2024-07-12 13:50:09 UTC
* Number of recursive dependencies: 121

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
* Number of recursive dependencies: 100

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

# aifeducation

<details>

* Version: 1.0.2
* GitHub: https://github.com/cran/aifeducation
* Source code: https://github.com/cran/aifeducation
* Date/Publication: 2025-02-05 13:00:02 UTC
* Number of recursive dependencies: 140

Run `revdepcheck::revdep_details(, "aifeducation")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
       $ base_exec_prefix    : chr "/c4/home/henrik/.cache/R/reticulate/uv/python/cpython-3.11.12-linux-x86_64-gnu"
       $ virtualenv          : chr "/c4/home/henrik/.cache/R/reticulate/uv/cache/archive-v0/xwIZawJ8xbb6dwCvr6IR2"
       $ virtualenv_activate : chr "/c4/home/henrik/.cache/R/reticulate/uv/cache/archive-v0/xwIZawJ8xbb6dwCvr6IR2/bin/activate_this.py"
       $ executable          : chr "/c4/home/henrik/.cache/R/reticulate/uv/cache/archive-v0/xwIZawJ8xbb6dwCvr6IR2/bin/python3"
       $ base_executable     : chr "/c4/home/henrik/.cache/R/reticulate/uv/python/cpython-3.11.12-linux-x86_64-gnu/bin/python3.11"
       $ version_string      : chr "3.11.12 (main, May 17 2025, 13:48:36) [Clang 20.1.4 ]"
    ...
      Backtrace:
          ▆
       1. ├─transformers$logging at test-08_TEClassifierRegular.R:42:1
       2. ├─reticulate:::`$.python.builtin.module`(transformers, logging) at test-08_TEClassifierRegular.R:42:1
       3. │ └─reticulate::py_get_attr(x, name, TRUE)
       4. └─reticulate (local) `<fn>`(`<python.builtin.module>`)
      
      [ FAIL 1 | WARN 0 | SKIP 11 | PASS 23 ]
      Error: Test failures
      Execution halted
    ```

# ale

<details>

* Version: 0.5.0
* GitHub: https://github.com/tripartio/ale
* Source code: https://github.com/cran/ale
* Date/Publication: 2025-04-09 20:50:02 UTC
* Number of recursive dependencies: 130

Run `revdepcheck::revdep_details(, "ale")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
      ── Failure ('test-ALEpDist.R:117:5'): ALEpDist works with binary outcome ───────
      Snapshot of code has changed:
      old[17:32] vs new[17:32]
          # A tibble: 10 x 6
                 aled  aler_min aler_max naled naler_min naler_max
                <dbl>     <dbl>    <dbl> <dbl>     <dbl>     <dbl>
    ...
          
          
          attr(,"params")$y_col
      
      * Run `testthat::snapshot_accept('ALEpDist')` to accept the change.
      * Run `testthat::snapshot_review('ALEpDist')` to interactively review the change.
      
      [ FAIL 22 | WARN 13 | SKIP 0 | PASS 95 ]
      Error: Test failures
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

# altdoc

<details>

* Version: 0.5.0
* GitHub: https://github.com/etiennebacher/altdoc
* Source code: https://github.com/cran/altdoc
* Date/Publication: 2025-01-23 16:40:07 UTC
* Number of recursive dependencies: 80

Run `revdepcheck::revdep_details(, "altdoc")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘spelling.R’
      Comparing ‘spelling.Rout’ to ‘spelling.Rout.save’ ... OK
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
        5. │     │ └─base::withCallingHandlers(...)
        6. │     └─rlang::eval_bare(quo_get_expr(.quo), quo_get_env(.quo))
        7. └─altdoc::render_docs(path = getwd())
        8.   └─altdoc:::.import_vignettes(...)
    ...
       2.   └─altdoc:::.import_vignettes(...)
       3.     └─base::vapply(...)
       4.       └─altdoc (local) FUN(X[[i]], ...)
       5.         └─altdoc:::.render_one_vignette(...)
       6.           └─altdoc:::.qmd2md(origin, tar_dir, verbose = verbose, preamble = pre)
       7.             └─base::cat(out[[2]])
      
      [ FAIL 14 | WARN 1 | SKIP 3 | PASS 55 ]
      Error: Test failures
      Execution halted
    ```

# bamm

<details>

* Version: 0.5.0
* GitHub: https://github.com/luismurao/bamm
* Source code: https://github.com/cran/bamm
* Date/Publication: 2024-07-06 20:22:11 UTC
* Number of recursive dependencies: 100

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
* Number of recursive dependencies: 117

Run `revdepcheck::revdep_details(, "baseballr")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
      Error in `mlb_homerun_derby_bracket(game_pk = 511101)`: object 'bracket' not found
      Backtrace:
          ▆
       1. └─baseballr::mlb_homerun_derby_bracket(game_pk = 511101) at test-mlb_homerun_derby_bracket.R:26:3
      ── Failure ('test-mlb_pitch_codes.R:20:3'): MLB Pitch Codes ────────────────────
      colnames(x) not equal to `cols`.
    ...
       1. └─baseballr::statcast_search(start_date = "2022-11-04", end_date = "2022-11-06") at test-statcast_search.R:31:3
       2.   ├─base::`names<-`(...)
       3.   └─data.table:::`names<-.data.table`(...)
       4.     └─data.table::setnames(x, value)
       5.       └─data.table:::stopf(...)
       6.         └─data.table:::raise_condition(...)
      
      [ FAIL 24 | WARN 1 | SKIP 0 | PASS 164 ]
      Error: Test failures
      Execution halted
    ```

*   checking DESCRIPTION meta-information ... NOTE
    ```
      Missing dependency on R >= 4.1.0 because package code uses the pipe
      |> or function shorthand \(...) syntax added in R 4.1.0.
      File(s) using such syntax:
        ‘chadwick_installation.R’
    ```

# batchtools

<details>

* Version: 0.9.17
* GitHub: https://github.com/mllg/batchtools
* Source code: https://github.com/cran/batchtools
* Date/Publication: 2023-04-20 14:20:06 UTC
* Number of recursive dependencies: 80

Run `revdepcheck::revdep_details(, "batchtools")` for more info

</details>

## In both

*   checking Rd files ... NOTE
    ```
    checkRd: (-1) JobCollection.Rd:41: Lost braces
        41 |  \item{namespaces}{code{character} with required packages to load via \code{\link[base]{requireNamespace}}.}
           |                        ^
    checkRd: (-1) addAlgorithm.Rd:31: Lost braces
        31 | Algorithms are functions which get the code{data} part as well as the problem instance (the return value of the
           |                                            ^
    ```

# bayesmove

<details>

* Version: 0.2.1
* GitHub: https://github.com/joshcullen/bayesmove
* Source code: https://github.com/cran/bayesmove
* Date/Publication: 2021-10-22 08:50:09 UTC
* Number of recursive dependencies: 161

Run `revdepcheck::revdep_details(, "bayesmove")` for more info

</details>

## In both

*   checking Rd files ... NOTE
    ```
    checkRd: (-1) insert_NAs.Rd:22: Lost braces; missing escapes or markup?
        22 | A data frame where new rows have been inserted to regularize the \code{date} column. This results in values provided for \code{id}, \code{date}, and {dt} while inserting NAs for all other columns. Additionally, observations with duplicate date-times are removed.
           |                                                                                                                                                      ^
    ```

# bcmaps

<details>

* Version: 2.2.1
* GitHub: https://github.com/bcgov/bcmaps
* Source code: https://github.com/cran/bcmaps
* Date/Publication: 2024-12-21 00:00:08 UTC
* Number of recursive dependencies: 122

Run `revdepcheck::revdep_details(, "bcmaps")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Complete output:
      > library(testthat)
      > library(bcmaps)
      Loading required package: sf
      Linking to GEOS 3.7.2, GDAL 3.0.4, PROJ 6.3.2; sf_use_s2() is TRUE
      Support for Spatial objects (`sp`) was removed in {bcmaps} v2.0.0. Please use `sf` objects with {bcmaps}.
      > 
    ...
        7.   ├─bcdata::bcdc_get_data(...)
        8.   └─bcdata:::bcdc_get_data.character(...)
        9.     ├─bcdata::bcdc_get_data(x, resource, verbose = verbose, ...)
       10.     └─bcdata:::bcdc_get_data.bcdc_record(...)
       11.       └─bcdata:::read_from_url(...)
       12.         └─r$raise_for_status()
      
      [ FAIL 1 | WARN 0 | SKIP 0 | PASS 237 ]
      Error: Test failures
      Execution halted
    ```

# bolasso

<details>

* Version: 0.3.0
* GitHub: https://github.com/dmolitor/bolasso
* Source code: https://github.com/cran/bolasso
* Date/Publication: 2024-12-08 22:20:12 UTC
* Number of recursive dependencies: 69

Run `revdepcheck::revdep_details(, "bolasso")` for more info

</details>

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
      Missing dependency on R >= 4.1.0 because package code uses the pipe
      |> or function shorthand \(...) syntax added in R 4.1.0.
      File(s) using such syntax:
        ‘plot.R’ ‘utils.R’
    ```

# brms

<details>

* Version: 2.22.0
* GitHub: https://github.com/paul-buerkner/brms
* Source code: https://github.com/cran/brms
* Date/Publication: 2024-09-23 13:00:29 UTC
* Number of recursive dependencies: 205

Run `revdepcheck::revdep_details(, "brms")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Complete output:
      > library(testthat)
      > library(brms)
      Loading required package: Rcpp
      Loading 'brms' package (version 2.22.0). Useful instructions
      can be found by typing help('brms'). A more detailed introduction
      to the package is available through vignette('brms_overview').
    ...
          ▆
       1. ├─base (local) SW(pp_check(fit1, type = "loo_pit", cores = 1)) at tests.brmsfit-methods.R:673:3
       2. │ └─base::withCallingHandlers(...)
       3. ├─bayesplot::pp_check(fit1, type = "loo_pit", cores = 1)
       4. └─brms:::pp_check.brmsfit(fit1, type = "loo_pit", cores = 1)
       5.   └─brms:::stop2(...)
      
      [ FAIL 1 | WARN 0 | SKIP 8 | PASS 3026 ]
      Error: Test failures
      Execution halted
    ```

*   R CMD check timed out
    

*   checking whether package ‘brms’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: namespace ‘colorspace’ is not available and has been replaced
    See ‘/scratch/henrik/revdep/future/checks/brms/new/brms.Rcheck/00install.out’ for details.
    ```

# bslib

<details>

* Version: 0.9.0
* GitHub: https://github.com/rstudio/bslib
* Source code: https://github.com/cran/bslib
* Date/Publication: 2025-01-30 23:20:02 UTC
* Number of recursive dependencies: 75

Run `revdepcheck::revdep_details(, "bslib")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Complete output:
      > library(testthat)
      > library(bslib)
      
      Attaching package: 'bslib'
      
      The following object is masked from 'package:utils':
    ...
      Backtrace:
          ▆
       1. ├─withr::with_tempdir(...) at test-page.R:92:3
       2. │ └─withr::with_dir(tmp, code)
       3. │   └─base::force(code)
       4. └─testthat::expect_snapshot_file("modern-page.html") at test-page.R:100:5
      
      [ FAIL 2 | WARN 0 | SKIP 0 | PASS 683 ]
      Error: Test failures
      Execution halted
    ```

# caretSDM

<details>

* Version: 1.1.0.1
* GitHub: https://github.com/luizesser/caretSDM
* Source code: https://github.com/cran/caretSDM
* Date/Publication: 2025-07-10 13:30:02 UTC
* Number of recursive dependencies: 183

Run `revdepcheck::revdep_details(, "caretSDM")` for more info

</details>

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘caretSDM-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: add_scenarios
    > ### Title: Add scenarios to 'sdm_area'
    > ### Aliases: add_scenarios set_scenarios_names scenarios_names
    > ###   get_scenarios_data select_scenarios
    > 
    > ### ** Examples
    > 
    ...
    Backtrace:
        ▆
     1. ├─caretSDM::select_predictors(...)
     2. │ └─dplyr::select(x, ...)
     3. ├─caretSDM::add_scenarios(sa, scen[1:2])
     4. └─caretSDM:::add_scenarios.stars(sa, scen[1:2])
     5.   └─caretSDM::set_variables_names(scen, sa)
     6.     └─cli::cli_abort(...)
     7.       └─rlang::abort(...)
    Execution halted
    ```

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
        8. │       │ └─base::withCallingHandlers(...)
        9. │       └─tidyselect:::vars_select_eval(...)
       10. │         └─tidyselect:::walk_data_tree(expr, data_mask, context_mask)
       11. │           └─tidyselect:::eval_c(expr, data_mask, context_mask)
       12. │             └─tidyselect:::reduce_sels(node, data_mask, context_mask, init = init)
       13. │               └─tidyselect:::walk_data_tree(new, data_mask, context_mask)
    ...
       20. │                             └─tidyselect:::chr_as_locations(x, vars, call = call, arg = arg)
       21. │                               └─vctrs::vec_as_location(...)
       22. └─vctrs (local) `<fn>`()
       23.   └─vctrs:::stop_subscript_oob(...)
       24.     └─vctrs:::stop_subscript(...)
       25.       └─rlang::abort(...)
      
      [ FAIL 21 | WARN 133 | SKIP 0 | PASS 437 ]
      Error: Test failures
      Execution halted
    ```

# ceRNAnetsim

<details>

* Version: 1.20.0
* GitHub: https://github.com/selcenari/ceRNAnetsim
* Source code: https://github.com/cran/ceRNAnetsim
* Date/Publication: 2025-04-15
* Number of recursive dependencies: 95

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

# cft

<details>

* Version: 1.0.0
* GitHub: https://github.com/earthlab/cft-CRAN
* Source code: https://github.com/cran/cft
* Date/Publication: 2022-10-03 07:12:18 UTC
* Number of recursive dependencies: 89

Run `revdepcheck::revdep_details(, "cft")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
      Attaching package: 'magrittr'
      
      The following objects are masked from 'package:testthat':
      
          equals, is_less_than, not
      
    ...
      Error in `RNetCDF::open.nc(x)`: NetCDF: Malformed or inaccessible DAP DDS
      Backtrace:
          ▆
       1. └─cft::available_data() at test_single_point_firehose.R:19:3
       2.   ├─tidync::tidync(web_link)
       3.   └─tidync:::tidync.character(web_link)
      
      [ FAIL 2 | WARN 0 | SKIP 0 | PASS 0 ]
      Error: Test failures
      Execution halted
    ```

*   checking re-building of vignette outputs ... ERROR
    ```
    Error(s) in re-building vignettes:
      ...
    --- re-building ‘available-data.Rmd’ using rmarkdown
    Error: processing vignette 'available-data.Rmd' failed with diagnostics:
    there is no package called ‘rmarkdown’
    --- failed re-building ‘available-data.Rmd’
    
    --- re-building ‘firehose.Rmd’ using rmarkdown
    Error: processing vignette 'firehose.Rmd' failed with diagnostics:
    there is no package called ‘rmarkdown’
    --- failed re-building ‘firehose.Rmd’
    
    SUMMARY: processing the following files failed:
      ‘available-data.Rmd’ ‘firehose.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# chevreulShiny

<details>

* Version: 1.0.0
* GitHub: https://github.com/cobriniklab/chevreulShiny
* Source code: https://github.com/cran/chevreulShiny
* Date/Publication: 2025-04-15
* Number of recursive dependencies: 266

Run `revdepcheck::revdep_details(, "chevreulShiny")` for more info

</details>

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
    License stub is invalid DCF.
    ```

# ChromSCape

<details>

* Version: 1.17.0
* GitHub: https://github.com/vallotlab/ChromSCape
* Source code: https://github.com/cran/ChromSCape
* Date/Publication: 2024-10-29
* Number of recursive dependencies: 228

Run `revdepcheck::revdep_details(, "ChromSCape")` for more info

</details>

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘ChromSCape-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: get_pathway_mat_scExp
    > ### Title: Get pathway matrix
    > ### Aliases: get_pathway_mat_scExp
    > 
    > ### ** Examples
    > 
    > data(scExp)
    > mat = get_pathway_mat_scExp(scExp, pathways = "KEGG_T_CELL_RECEPTOR_SIGNALING_PATHWAY")
    ChromSCape::gene_set_enrichment_analysis_scExp - Loading hg38 MSigDB gene sets.
    Error: nchar(db_species) not equal to 2
    Execution halted
    ```

*   checking dependencies in R code ... WARNING
    ```
    'library' or 'require' call not declared from: ‘dplyr’
    'library' or 'require' call to ‘dplyr’ in package code.
      Please use :: or requireNamespace() instead.
      See section 'Suggested packages' in the 'Writing R Extensions' manual.
    ```

*   checking for code/documentation mismatches ... WARNING
    ```
    Codoc mismatches from Rd file 'generate_analysis.Rd':
    generate_analysis
      Code: function(input_data_folder, analysis_name = "Analysis_1",
                     output_directory = "./", input_data_type = c("scBED",
                     "DenseMatrix", "SparseMatrix", "scBAM")[1],
                     feature_count_on = c("bins", "genebody", "peaks")[1],
                     feature_count_parameter = 50000, rebin_sparse_matrix =
                     FALSE, ref_genome = c("hg38", "mm10")[1], run =
                     c("filter", "CNA", "cluster", "consensus", "coverage",
                     "DA", "GSA", "report")[c(1, 3, 5, 6, 7, 8)],
    ...
      Mismatches in argument names:
        Position: 5 Code: feature_count_on Docs: rebin_sparse_matrix
        Position: 6 Code: feature_count_parameter Docs: feature_count_on
        Position: 7 Code: rebin_sparse_matrix Docs: feature_count_parameter
      Mismatches in argument default values:
        Name: 'run'
        Code: c("filter", "CNA", "cluster", "consensus", "coverage", "DA", 
              "GSA", "report")[c(1, 3, 5, 6, 7, 8)]
        Docs: c("filter", "CNA", "cluster", "consensus", "peak_call", "coverage", 
              "DA", "GSA", "report")[c(1, 3, 6, 7, 8, 9)]
    ```

*   checking Rd \usage sections ... WARNING
    ```
    Undocumented arguments in Rd file 'rebin_matrix.Rd'
      ‘rebin_function’
    
    Functions with \usage entries need to have the appropriate \alias
    entries, and all their arguments documented.
    The \usage entries must correspond to syntactically valid R code.
    See chapter ‘Writing R documentation files’ in the ‘Writing R
    Extensions’ manual.
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

*   checking Rd files ... NOTE
    ```
    prepare_Rd: raw_counts_to_sparse_matrix.Rd:6-8: Dropping empty section \source
    ```

# civis

<details>

* Version: 3.1.2
* GitHub: https://github.com/civisanalytics/civis-r
* Source code: https://github.com/cran/civis
* Date/Publication: 2023-03-31 08:00:03 UTC
* Number of recursive dependencies: 85

Run `revdepcheck::revdep_details(, "civis")` for more info

</details>

## In both

*   checking Rd files ... NOTE
    ```
    checkRd: (-1) enhancements_get_civis_data_match.Rd:60: Lost braces; missing escapes or markup?
        60 | \item{inputFieldMapping}{list, The field (i.e., column) mapping for the input table. See https://api.civisanalytics.com/enhancements/field-mapping for a list of valid field types and descriptions. Each field type should be mapped to a string specifying a column name in the input table. For field types that support multiple values (e.g., the "phone" field), a list of column names can be provided (e.g., {"phone": ["home_phone", "mobile_phone"], ...}).}
           |                                                                                                                                                                                                                                                                                                                                                                                                                      ^
    checkRd: (-1) enhancements_patch_civis_data_match.Rd:53: Lost braces; missing escapes or markup?
        53 | \item{input_field_mapping}{list optional. The field (i.e., column) mapping for the input table. See https://api.civisanalytics.com/enhancements/field-mapping for a list of valid field types and descriptions. Each field type should be mapped to a string specifying a column name in the input table. For field types that support multiple values (e.g., the "phone" field), a list of column names can be provided (e.g., {"phone": ["home_phone", "mobile_phone"], ...}).}
           |                                                                                                                                                                                                                                                                                                                                                                                                                                 ^
    checkRd: (-1) enhancements_patch_civis_data_match.Rd:125: Lost braces; missing escapes or markup?
       125 | \item{inputFieldMapping}{list, The field (i.e., column) mapping for the input table. See https://api.civisanalytics.com/enhancements/field-mapping for a list of valid field types and descriptions. Each field type should be mapped to a string specifying a column name in the input table. For field types that support multiple values (e.g., the "phone" field), a list of column names can be provided (e.g., {"phone": ["home_phone", "mobile_phone"], ...}).}
           |                                                                                                                                                                                                                                                                                                                                                                                                                      ^
    checkRd: (-1) enhancements_post_civis_data_match.Rd:24: Lost braces; missing escapes or markup?
    ...
           |                                                                                                                                                                                         ^
    checkRd: (-1) templates_patch_scripts.Rd:42: Lost braces; missing escapes or markup?
        42 | \item allowedValues array, The possible values this parameter can take, effectively making this an enumerable parameter. Allowed values is an array of hashes of the following format: `{label: 'Import', 'value': 'import'}`
           |                                                                                                                                                                                         ^
    checkRd: (-1) templates_post_scripts.Rd:45: Lost braces; missing escapes or markup?
        45 | \item allowedValues array, The possible values this parameter can take, effectively making this an enumerable parameter. Allowed values is an array of hashes of the following format: `{label: 'Import', 'value': 'import'}`
           |                                                                                                                                                                                         ^
    checkRd: (-1) templates_put_scripts.Rd:42: Lost braces; missing escapes or markup?
        42 | \item allowedValues array, The possible values this parameter can take, effectively making this an enumerable parameter. Allowed values is an array of hashes of the following format: `{label: 'Import', 'value': 'import'}`
           |                                                                                                                                                                                         ^
    ```

# ClustIRR

<details>

* Version: 1.6.0
* GitHub: https://github.com/snaketron/ClustIRR
* Source code: https://github.com/cran/ClustIRR
* Date/Publication: 2025-04-15
* Number of recursive dependencies: 108

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
    get_ag_summary: no visible binding for global variable ‘community’
    get_beta_scatterplot : get_scatters: no visible binding for global
      variable ‘mean_x’
    get_beta_scatterplot : get_scatters: no visible binding for global
      variable ‘mean_y’
    get_beta_scatterplot : get_scatters: no visible binding for global
      variable ‘specificity’
    get_beta_scatterplot : get_scatters: no visible binding for global
      variable ‘size_x’
    get_beta_scatterplot : get_scatters: no visible binding for global
    ...
      ‘specificity’
    get_beta_violins : get_violins: no visible binding for global variable
      ‘size’
    get_beta_violins: no visible binding for global variable ‘community’
    get_honeycombs: no visible binding for global variable ‘x_adj’
    get_honeycombs: no visible binding for global variable ‘y_adj’
    get_honeycombs: no visible binding for global variable ‘..count..’
    Undefined global functions or variables:
      ..count.. community mean_x mean_y size size_x size_y specificity
      x_adj y_adj
    ```

*   checking Rd files ... NOTE
    ```
    prepare_Rd: decode_communities.Rd:21-23: Dropping empty section \details
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

# collinear

<details>

* Version: 2.0.0
* GitHub: https://github.com/blasbenito/collinear
* Source code: https://github.com/cran/collinear
* Date/Publication: 2024-11-08 13:50:02 UTC
* Number of recursive dependencies: 47

Run `revdepcheck::revdep_details(, "collinear")` for more info

</details>

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
      Missing dependency on R >= 4.1.0 because package code uses the pipe
      |> or function shorthand \(...) syntax added in R 4.1.0.
      File(s) using such syntax:
        ‘collinear.R’ ‘cor_cramer_v.R’ ‘cor_df.R’ ‘cor_select.R’ ‘f_auc.Rd’
        ‘f_r2.Rd’ ‘f_r2_counts.Rd’ ‘f_v.Rd’ ‘f_v_rf_categorical.Rd’
        ‘identify.R’ ‘model_formula.R’ ‘preference_order.R’
        ‘preference_order_methods.R’ ‘target_encoding_methods.R’ ‘validate.R’
        ‘vif_df.R’ ‘vif_select.R’
    ```

# cSEM

<details>

* Version: 0.6.1
* GitHub: https://github.com/FloSchuberth/cSEM
* Source code: https://github.com/cran/cSEM
* Date/Publication: 2025-05-16 09:40:14 UTC
* Number of recursive dependencies: 143

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
* Number of recursive dependencies: 73

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
* Number of recursive dependencies: 164

Run `revdepcheck::revdep_details(, "ctsem")` for more info

</details>

## In both

*   R CMD check timed out
    

*   checking whether package ‘ctsem’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: namespace ‘colorspace’ is not available and has been replaced
    See ‘/scratch/henrik/revdep/future/checks/ctsem/new/ctsem.Rcheck/00install.out’ for details.
    ```

# dataquieR

<details>

* Version: 2.5.1
* GitHub: NA
* Source code: https://github.com/cran/dataquieR
* Date/Publication: 2025-03-05 18:10:02 UTC
* Number of recursive dependencies: 196

Run `revdepcheck::revdep_details(, "dataquieR")` for more info

</details>

## In both

*   R CMD check timed out
    

# DeclareDesign

<details>

* Version: 1.0.10
* GitHub: https://github.com/DeclareDesign/DeclareDesign
* Source code: https://github.com/cran/DeclareDesign
* Date/Publication: 2024-04-21 20:52:45 UTC
* Number of recursive dependencies: 141

Run `revdepcheck::revdep_details(, "DeclareDesign")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
      ══ Skipped tests (1) ═══════════════════════════════════════════════════════════
      • Skipped bootstrap SE test for speed (1): 'test-bootstrap-diagnosands.R:43:3'
      
      ══ Warnings ════════════════════════════════════════════════════════════════════
      ── Warning ('test-conduct-custom.R:36:3'): test error messages in run_design ───
      Caught simpleError. Canceling all iterations ...
    ...
      
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Failure ('test-reshape-diagnosis.R:133:3'): groups with factors ─────────────
      `expect_equal(...)` did not produce any warnings.
      ── Failure ('test-reshape-diagnosis.R:141:3'): groups with factors ─────────────
      `expect_equal(...)` did not produce any warnings.
      
      [ FAIL 2 | WARN 2 | SKIP 1 | PASS 566 ]
      Error: Test failures
      Execution halted
    ```

# dipsaus

<details>

* Version: 0.3.1
* GitHub: https://github.com/dipterix/dipsaus
* Source code: https://github.com/cran/dipsaus
* Date/Publication: 2025-04-03 16:50:02 UTC
* Number of recursive dependencies: 62

Run `revdepcheck::revdep_details(, "dipsaus")` for more info

</details>

## In both

*   checking compiled code ... NOTE
    ```
    File ‘dipsaus/libs/dipsaus.so’:
      Found non-API call to R: ‘ENCLOS’
    
    Compiled code should not call non-API entry points in R.
    
    See ‘Writing portable packages’ in the ‘Writing R Extensions’ manual,
    and section ‘Moving into C API compliance’ for issues with the use of
    non-API entry points.
    ```

# disk.frame

<details>

* Version: 0.8.3
* GitHub: https://github.com/DiskFrame/disk.frame
* Source code: https://github.com/cran/disk.frame
* Date/Publication: 2023-08-24 16:20:10 UTC
* Number of recursive dependencies: 95

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
* Number of recursive dependencies: 133

Run `revdepcheck::revdep_details(, "dispositionEffect")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
      ── Failure ('test-realized_duration.R:113:2'): realized_duration works (realized_only = TRUE) ──
      realized_duration(...) not equal to c(...).
      1/4 mismatches
      [2] 34 - 28 == 6
      ── Failure ('test-realized_duration.R:116:2'): realized_duration works (realized_only = TRUE) ──
      realized_duration(...) not equal to c(...).
    ...
      1/4 mismatches
      [2] 34 - 28 == 6
      ── Failure ('test-realized_duration.R:161:2'): realized_duration works (realized_only = TRUE) ──
      realized_duration(...) not equal to c(...).
      1/4 mismatches
      [1] 34 - 28 == 6
      
      [ FAIL 36 | WARN 0 | SKIP 0 | PASS 331 ]
      Error: Test failures
      Execution halted
    ```

# easyalluvial

<details>

* Version: 0.3.2
* GitHub: https://github.com/erblast/easyalluvial
* Source code: https://github.com/cran/easyalluvial
* Date/Publication: 2023-12-07 13:40:06 UTC
* Number of recursive dependencies: 148

Run `revdepcheck::revdep_details(, "easyalluvial")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
       1. └─easyalluvial:::expect_doppelganger(...) at test_plot_marginal_histograms.R:48:3
       2.   └─vdiffr::expect_doppelganger(title, fig, path = path, ...)
       3.     ├─base::withCallingHandlers(...)
       4.     └─testthat::expect_snapshot_file(...)
      ── Failure ('test_plot_marginal_histograms.R:52:3'): plot_hist_as_margins ──────
      Snapshot of `testcase` to 'plot_marginal_histograms/plot-hist-long-num-is-fill.svg' has changed
    ...
      Backtrace:
          ▆
       1. └─easyalluvial:::expect_doppelganger("mod_num_pred_train", p) at test_plot_marginal_histograms.R:117:3
       2.   └─vdiffr::expect_doppelganger(title, fig, path = path, ...)
       3.     ├─base::withCallingHandlers(...)
       4.     └─testthat::expect_snapshot_file(...)
      
      [ FAIL 37 | WARN 4 | SKIP 2 | PASS 91 ]
      Error: Test failures
      Execution halted
    ```

# EFAtools

<details>

* Version: 0.6.0
* GitHub: https://github.com/mdsteiner/EFAtools
* Source code: https://github.com/cran/EFAtools
* Date/Publication: 2025-06-19 08:30:02 UTC
* Number of recursive dependencies: 89

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

* Version: 1.0.0
* GitHub: https://github.com/lance-waller-lab/envi
* Source code: https://github.com/cran/envi
* Date/Publication: 2024-11-06 19:00:03 UTC
* Number of recursive dependencies: 150

Run `revdepcheck::revdep_details(, "envi")` for more info

</details>

## In both

*   checking whether package ‘envi’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: no DISPLAY variable so Tk is not available
    See ‘/scratch/henrik/revdep/future/checks/envi/new/envi.Rcheck/00install.out’ for details.
    ```

# EpiNow2

<details>

* Version: 1.7.1
* GitHub: https://github.com/epiforecasts/EpiNow2
* Source code: https://github.com/cran/EpiNow2
* Date/Publication: 2025-02-19 23:40:09 UTC
* Number of recursive dependencies: 128

Run `revdepcheck::revdep_details(, "EpiNow2")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘spelling.R’
      Comparing ‘spelling.Rout’ to ‘spelling.Rout.save’ ...9,65c9
    < Potential spelling errors:
    <   WORD              FOUND IN
    < Charniga          discrete_pmf.Rd:53
    <                   discretise.Rd:57
    < Matérn           gp_opts.Rd:63,68
    <                   NEWS.md:75,81
    <                   gaussian_process_implementation_details.Rmd:44,59,65,97
    < Ornstein          gp_opts.Rd:60
    ...
        5. ├─base::suppressWarnings(sims <- forecast_infections(out, backend = "cmdstanr"))
        6. │ └─base::withCallingHandlers(...)
        7. └─EpiNow2::forecast_infections(out, backend = "cmdstanr")
        8.   └─EpiNow2::stan_opts(...)
        9.     └─cli::cli_abort(...)
       10.       └─rlang::abort(...)
      
      [ FAIL 7 | WARN 0 | SKIP 0 | PASS 552 ]
      Error: Test failures
      Execution halted
    ```

*   checking re-building of vignette outputs ... ERROR
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘EpiNow2.Rmd’ using rmarkdown
    Could not fetch https://raw.githubusercontent.com/citation-style-language/styles/master/apa-numeric-superscript-brackets.csl
    HttpExceptionRequest Request {
      host                 = "raw.githubusercontent.com"
      port                 = 443
      secure               = True
      requestHeaders       = []
      path                 = "/citation-style-language/styles/master/apa-numeric-superscript-brackets.csl"
      queryString          = ""
    ...
    --- re-building ‘gaussian_process_implementation_details.Rmd’ using rmarkdown
    --- finished re-building ‘gaussian_process_implementation_details.Rmd’
    
    SUMMARY: processing the following files failed:
      ‘EpiNow2.Rmd’ ‘epinow.Rmd’ ‘estimate_infections.Rmd’
      ‘estimate_infections_options.Rmd’ ‘estimate_infections_workflow.Rmd’
      ‘estimate_secondary.Rmd’ ‘estimate_truncation.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# EQRN

<details>

* Version: 0.1.1
* GitHub: https://github.com/opasche/EQRN
* Source code: https://github.com/cran/EQRN
* Date/Publication: 2025-03-17 20:40:02 UTC
* Number of recursive dependencies: 39

Run `revdepcheck::revdep_details(, "EQRN")` for more info

</details>

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘EQRN-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: default_device
    > ### Title: Default torch device
    > ### Aliases: default_device
    > 
    > ### ** Examples
    > 
    > device <- default_device()
    Error in cpp_cuda_is_available() : 
      Lantern is not loaded. Please use `install_torch()` to install additional dependencies.
    Calls: default_device -> <Anonymous> -> cpp_cuda_is_available
    Execution halted
    ```

*   checking whether package ‘EQRN’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: ℹ torch failed to start, restart your R session to try again.
    See ‘/scratch/henrik/revdep/future/checks/EQRN/new/EQRN.Rcheck/00install.out’ for details.
    ```

# fastRhockey

<details>

* Version: 0.4.0
* GitHub: https://github.com/sportsdataverse/fastRhockey
* Source code: https://github.com/cran/fastRhockey
* Date/Publication: 2022-10-25 20:55:15 UTC
* Number of recursive dependencies: 112

Run `revdepcheck::revdep_details(, "fastRhockey")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
      <curl_error_recv_error/curl_error/error/condition>
      Error in `curl::curl_fetch_memory(url, handle = handle)`: Failure when receiving data from the peer [statsapi.web.nhl.com]:
      CONNECT tunnel failed, response 404
      Backtrace:
          ▆
       1. └─fastRhockey::nhl_teams_roster(team_id = 14) at test-nhl_teams_roster.R:3:3
    ...
      ── Failure ('test-phf_team_box.R:39:3'): phf_team_box ──────────────────────────
      `x` is not an S3 object
      ── Failure ('test-phf_team_box.R:40:3'): phf_team_box ──────────────────────────
      `y` is not an S3 object
      ── Failure ('test-phf_team_box.R:41:3'): phf_team_box ──────────────────────────
      `z` is not an S3 object
      
      [ FAIL 25 | WARN 1 | SKIP 0 | PASS 4 ]
      Error: Test failures
      Execution halted
    ```

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
* Number of recursive dependencies: 124

Run `revdepcheck::revdep_details(, "fdacluster")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
      Backtrace:
           ▆
        1. ├─fdacluster::fdakmeans(...) at test-fdakmeans.R:774:3
        2. │ └─fdacluster::fdadist(...)
        3. │   └─fdacluster (local) .pairwise_distances(index_table)
        4. │     └─fdacluster:::future_map2_dbl(...)
    ...
       16.   └─future::ClusterFutureBackend(...)
       17.     └─clusterRegistry$startCluster(...)
       18.       └─future (local) makeCluster(workers, ...)
       19.         ├─base::do.call(makeClusterPSOCK, args = args, quote = TRUE)
       20.         └─parallelly (local) `<fn>`(base::quote(47L), rscript_libs = base::quote(`<chr>`))
       21.           └─parallelly:::checkNumberOfLocalWorkers(workers)
      
      [ FAIL 17 | WARN 0 | SKIP 0 | PASS 88 ]
      Error: Test failures
      Execution halted
    ```

*   checking DESCRIPTION meta-information ... NOTE
    ```
      Missing dependency on R >= 4.2.0 because package code uses the pipe
      placeholder syntax added in R 4.2.0.
      File(s) using such syntax:
        ‘caps-plot.R’ ‘utils.R’
    ```

# fect

<details>

* Version: 1.0.0
* GitHub: NA
* Source code: https://github.com/cran/fect
* Date/Publication: 2022-10-14 09:52:32 UTC
* Number of recursive dependencies: 66

Run `revdepcheck::revdep_details(, "fect")` for more info

</details>

## In both

*   checking C++ specification ... NOTE
    ```
      Specified C++11: please drop specification unless essential
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘panelView’
      All declared Imports should be used.
    ```

# ferrn

<details>

* Version: 0.1.0
* GitHub: https://github.com/huizezhang-sherry/ferrn
* Source code: https://github.com/cran/ferrn
* Date/Publication: 2024-06-23 22:30:07 UTC
* Number of recursive dependencies: 145

Run `revdepcheck::revdep_details(, "ferrn")` for more info

</details>

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
      Missing dependency on R >= 4.1.0 because package code uses the pipe
      |> or function shorthand \(...) syntax added in R 4.1.0.
      File(s) using such syntax:
        ‘calc-squintability.R’ ‘get.R’ ‘pipe-sine-boa.Rd’ ‘plot-projection.R’
        ‘projection.Rd’
    ```

# finbif

<details>

* Version: 0.9.10
* GitHub: https://github.com/luomus/finbif
* Source code: https://github.com/cran/finbif
* Date/Publication: 2025-04-15 10:10:02 UTC
* Number of recursive dependencies: 68

Run `revdepcheck::revdep_details(, "finbif")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
      ── Error ('test-finbif_taxa.R:23:7'): searching for taxa works ─────────────────
      Error: Access token for FinBIF has not been set. Use finbif_get_token() to 
      have an access token sent to your email address. Then set it as the 
      environment variable FINBIF_ACCESS_TOKEN with 
      Sys.setenv(FINBIF_ACCESS_TOKEN = "<access_token_sent_to_your_email>")
      Backtrace:
    ...
       6.       └─finbif:::records(fb_records_obj)
       7.         └─finbif:::request(fb_records_obj)
       8.           └─finbif:::api_get(fb_records_obj)
       9.             └─finbif:::get_token()
      
      [ FAIL 15 | WARN 0 | SKIP 0 | PASS 8 ]
      Error: Test failures
      In addition: Warning message:
      call dbDisconnect() when finished working with a connection 
      Execution halted
    ```

# FLAMES

<details>

* Version: 2.2.0
* GitHub: https://github.com/mritchielab/FLAMES
* Source code: https://github.com/cran/FLAMES
* Date/Publication: 2025-04-15
* Number of recursive dependencies: 260

Run `revdepcheck::revdep_details(, "FLAMES")` for more info

</details>

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘FLAMES-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: create_sce_from_dir
    > ### Title: Create 'SingleCellExperiment' object from 'FLAMES' output folder
    > ### Aliases: create_sce_from_dir
    > 
    > ### ** Examples
    > 
    > outdir <- tempfile()
    ...
        return _find_and_load(name, import_)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      File "/scratch/henrik/revdep/future/checks/FLAMES/new/FLAMES.Rcheck/FLAMES/python/count_gene.py", line 8, in <module>
        import pandas as pd
      File "/scratch/henrik/revdep/future/library/FLAMES/reticulate/python/rpytools/loader.py", line 122, in _find_and_load_hook
        return _run_hook(name, _hook)
               ^^^^^^^^^^^^^^^^^^^^^^
      File "/scratch/henrik/revdep/future/library/FLA
    Calls: <Anonymous> ... tryCatch -> tryCatchList -> tryCatchOne -> <Anonymous>
    Execution halted
    ```

*   checking whether package ‘FLAMES’ can be installed ... NOTE
    ```
    Found the following notes/warnings:
      Non-staged installation was used
    See ‘/scratch/henrik/revdep/future/checks/FLAMES/new/FLAMES.Rcheck/00install.out’ for details.
    ```

*   checking R code for possible problems ... NOTE
    ```
    addRowRanges: no visible global function definition for ‘head’
    chisq_test_by_gene: no visible global function definition for
      ‘chisq.test’
    create_spe: no visible binding for global variable ‘barcode’
    create_spe: no visible binding for global variable ‘in_tissue’
    filter_coverage: no visible global function definition for
      ‘starts_with’
    filter_coverage: no visible binding for global variable ‘filter_res’
    find_barcode: no visible binding for global variable ‘Sample’
    find_barcode: no visible binding for global variable ‘Outfile’
    ...
      multi-matching reads mutation_index n_reads na.omit name nucleotide
      output p.value pct pos read1_with_adapter read_counts ref
      scale_alpha_continuous scale_colour_gradient single match reads
      starts_with test total total reads total_counts tr_length transcript
      undemultiplexted reads value which_label x y
    Consider adding
      importFrom("base", "match", "single")
      importFrom("stats", "chisq.test", "na.omit")
      importFrom("utils", "head")
    to your NAMESPACE file.
    ```

# flowGraph

<details>

* Version: 1.16.0
* GitHub: https://github.com/aya49/flowGraph
* Source code: https://github.com/cran/flowGraph
* Date/Publication: 2025-04-15
* Number of recursive dependencies: 89

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

# forecastML

<details>

* Version: 0.9.0
* GitHub: https://github.com/nredell/forecastML
* Source code: https://github.com/cran/forecastML
* Date/Publication: 2020-05-07 15:10:17 UTC
* Number of recursive dependencies: 100

Run `revdepcheck::revdep_details(, "forecastML")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘dtplyr’
      All declared Imports should be used.
    ```

# furrr

<details>

* Version: 0.3.1
* GitHub: https://github.com/DavisVaughan/furrr
* Source code: https://github.com/cran/furrr
* Date/Publication: 2022-08-15 19:40:02 UTC
* Number of recursive dependencies: 67

Run `revdepcheck::revdep_details(, "furrr")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
       39. │                 │   │ └─base (local) doTryCatch(return(expr), name, parentenv, handler)
       40. │                 │   └─base (local) tryCatchList(expr, names[-nh], parentenv, handlers[-nh])
       41. │                 │     └─base (local) tryCatchOne(expr, names, parentenv, handlers[[1L]])
       42. │                 │       └─base (local) doTryCatch(return(expr), name, parentenv, handler)
       43. │                 ├─base::tryCatch(...)
       44. │                 │ └─base (local) tryCatchList(expr, classes, parentenv, handlers)
    ...
      [ FAIL 1 | WARN 175 | SKIP 0 | PASS 855 ]
      Error: Test failures
      In addition: Warning messages:
      1: In .Internal(gc(verbose, reset, full)) :
        closing unused connection 4 (<-localhost:37577)
      2: In .Internal(gc(verbose, reset, full)) :
        closing unused connection 4 (<-localhost:36069)
      3: In .Internal(gc(verbose, reset, full)) :
        closing unused connection 4 (<-localhost:32474)
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

# geocmeans

<details>

* Version: 0.3.4
* GitHub: https://github.com/JeremyGelb/geocmeans
* Source code: https://github.com/cran/geocmeans
* Date/Publication: 2023-09-12 03:10:02 UTC
* Number of recursive dependencies: 207

Run `revdepcheck::revdep_details(, "geocmeans")` for more info

</details>

## In both

*   checking re-building of vignette outputs ... ERROR
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘introduction.Rmd’ using rmarkdown
    
    Quitting from introduction.Rmd:487-489 [unnamed-chunk-38]
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    <error/rlang_error>
    Error in `st_transform.bbox()`:
    ! method not available for GDAL: 3.0.4
    ---
    Backtrace:
    ...
    
    Error: processing vignette 'introduction.Rmd' failed with diagnostics:
    method not available for GDAL: 3.0.4
    --- failed re-building ‘introduction.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘introduction.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
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

# googlePubsubR

<details>

* Version: 0.0.4
* GitHub: https://github.com/andodet/googlePubsubR
* Source code: https://github.com/cran/googlePubsubR
* Date/Publication: 2023-03-03 01:00:02 UTC
* Number of recursive dependencies: 62

Run `revdepcheck::revdep_details(, "googlePubsubR")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
       3. │   └─testthat:::quasi_capture(...)
       4. │     ├─testthat (local) .capture(...)
       5. │     │ └─base::withCallingHandlers(...)
       6. │     └─rlang::eval_bare(quo_get_expr(.quo), quo_get_env(.quo))
       7. └─googlePubsubR::topics_delete(topic = topic_name)
       8.   └─googleAuthR (local) f()
    ...
       3. │   └─testthat:::quasi_capture(...)
       4. │     ├─testthat (local) .capture(...)
       5. │     │ └─base::withCallingHandlers(...)
       6. │     └─rlang::eval_bare(quo_get_expr(.quo), quo_get_env(.quo))
       7. └─googlePubsubR::snapshots_delete(snapshot = snap_name)
       8.   └─googleAuthR (local) f()
      
      [ FAIL 27 | WARN 0 | SKIP 0 | PASS 7 ]
      Error: Test failures
      Execution halted
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

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Complete output:
      > library("testthat")
      > library("googleTagManageR")
      > test_check("googleTagManageR")
      [ FAIL 3 | WARN 0 | SKIP 0 | PASS 0 ]
      
      ══ Failed tests ════════════════════════════════════════════════════════════════
    ...
      Backtrace:
          ▆
       1. └─googleTagManageR::gtm_accounts_get(account_id) at test_accounts.R:15:3
       2.   └─googleTagManageR:::gtm_get(path_args = path_args)
       3.     └─googleAuthR::gar_api_page(get, page_f = get_attr_nextLink)
       4.       └─googleAuthR (local) f()
      
      [ FAIL 3 | WARN 0 | SKIP 0 | PASS 0 ]
      Error: Test failures
      Execution halted
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘assertthat’ ‘future’ ‘httr’
      All declared Imports should be used.
    ```

# greed

<details>

* Version: 0.6.1
* GitHub: https://github.com/comeetie/greed
* Source code: https://github.com/cran/greed
* Date/Publication: 2022-10-03 22:00:05 UTC
* Number of recursive dependencies: 93

Run `revdepcheck::revdep_details(, "greed")` for more info

</details>

## In both

*   checking C++ specification ... NOTE
    ```
      Specified C++11: please drop specification unless essential
    ```

# gsynth

<details>

* Version: 1.2.1
* GitHub: NA
* Source code: https://github.com/cran/gsynth
* Date/Publication: 2021-08-06 07:50:05 UTC
* Number of recursive dependencies: 62

Run `revdepcheck::revdep_details(, "gsynth")` for more info

</details>

## In both

*   checking C++ specification ... NOTE
    ```
      Specified C++11: please drop specification unless essential
    ```

# gtfs2gps

<details>

* Version: 2.1-2
* GitHub: https://github.com/ipeaGIT/gtfs2gps
* Source code: https://github.com/cran/gtfs2gps
* Date/Publication: 2024-10-08 07:00:06 UTC
* Number of recursive dependencies: 86

Run `revdepcheck::revdep_details(, "gtfs2gps")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Complete output:
      > library(testthat)
      > library(gtfs2gps)
      gtfs2gps version 2.1-2 is now loaded
      NOTE: All filter functions from gtfs2gps were removed
      Please replace them by similar functions from gtfstools
      > 
    ...
       4.     └─terra (local) .local(x, ...)
       5.       ├─terra::makeValid(x)
       6.       └─terra::makeValid(x)
       7.         └─terra (local) .local(x, ...)
       8.           └─terra:::messages(x)
       9.             └─terra:::error(f, x@pntr$getError())
      
      [ FAIL 1 | WARN 0 | SKIP 0 | PASS 119 ]
      Error: Test failures
      Execution halted
    ```

*   checking DESCRIPTION meta-information ... NOTE
    ```
      Missing dependency on R >= 4.1.0 because package code uses the pipe
      |> or function shorthand \(...) syntax added in R 4.1.0.
      File(s) using such syntax:
        ‘adjust_speed.R’ ‘adjust_speed.Rd’ ‘gps_as_sflinestring.Rd’
        ‘gps_as_sfpoints.Rd’ ‘gtfs2gps.Rd’ ‘write_gtfs.Rd’
    ```

# hero

<details>

* Version: 0.6
* GitHub: NA
* Source code: https://github.com/cran/hero
* Date/Publication: 2023-07-15 21:10:09 UTC
* Number of recursive dependencies: 157

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

# hoopR

<details>

* Version: 2.1.0
* GitHub: https://github.com/sportsdataverse/hoopR
* Source code: https://github.com/cran/hoopR
* Date/Publication: 2023-11-25 23:40:20 UTC
* Number of recursive dependencies: 112

Run `revdepcheck::revdep_details(, "hoopR")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
      x[24]: "TOV"
      y[24]: "Team_ID"
      ── Failure ('test-nba_playercareerstats.R:264:3'): NBA Player Career Stats ─────
      sort(colnames(x[[6]])) not equal to sort(cols_x6).
      2/24 mismatches
      x[23]: "TEAM_ID"
    ...
      ── Failure ('test-nba_videodetails.R:42:3'): NBA Video Details ─────────────────
      sort(colnames(x[[1]])) not equal to sort(cols_x1).
      Lengths differ: 0 is not 14
      ── Failure ('test-nba_videodetails.R:44:3'): NBA Video Details ─────────────────
      sort(colnames(x[[2]])) not equal to sort(cols_x2).
      Lengths differ: 0 is not 15
      
      [ FAIL 38 | WARN 0 | SKIP 38 | PASS 841 ]
      Error: Test failures
      Execution halted
    ```

# hydroloom

<details>

* Version: 1.1.0
* GitHub: https://github.com/DOI-USGS/hydroloom
* Source code: https://github.com/cran/hydroloom
* Date/Publication: 2024-08-26 06:20:02 UTC
* Number of recursive dependencies: 146

Run `revdepcheck::revdep_details(, "hydroloom")` for more info

</details>

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
      Missing dependency on R >= 4.1.0 because package code uses the pipe
      |> or function shorthand \(...) syntax added in R 4.1.0.
      File(s) using such syntax:
        ‘add_divergence.R’ ‘add_levelpaths.R’ ‘add_pfafstetter.R’
        ‘add_streamorder-level.R’ ‘add_toids.R’ ‘disambiguate.R’
        ‘format_index_ids.Rd’ ‘get_hydro_location.R’
        ‘index_points_to_lines.R’ ‘make_attribute_topology.R’
        ‘make_index_ids.R’ ‘make_node_topology.R’
        ‘navigate_connected_paths.R’ ‘navigation_network.R’ ‘sort_network.R’
        ‘to_flownetwork.R’ ‘utils.R’
    ```

# imagefluency

<details>

* Version: 0.2.5
* GitHub: https://github.com/stm/imagefluency
* Source code: https://github.com/cran/imagefluency
* Date/Publication: 2024-02-22 14:50:02 UTC
* Number of recursive dependencies: 93

Run `revdepcheck::revdep_details(, "imagefluency")` for more info

</details>

## Newly broken

*   checking re-building of vignette outputs ... ERROR
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘getting-started.Rmd’ using rmarkdown
    Could not fetch https://www.zotero.org/styles/springer-socpsych-brackets
    HttpExceptionRequest Request {
      host                 = "www.zotero.org"
      port                 = 443
      secure               = True
      requestHeaders       = []
      path                 = "/styles/springer-socpsych-brackets"
      queryString          = ""
    ...
     (ConnectionFailure Network.Socket.getAddrInfo (called with preferred socket type/protocol: AddrInfo {addrFlags = [AI_ADDRCONFIG], addrFamily = AF_UNSPEC, addrSocketType = Stream, addrProtocol = 0, addrAddress = 0.0.0.0:0, addrCanonName = Nothing}, host name: "c4-yum1", service name: "3128"): does not exist (Name does not resolve))
    Error: processing vignette 'getting-started.Rmd' failed with diagnostics:
    pandoc document conversion failed with error 61
    --- failed re-building ‘getting-started.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘getting-started.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# infercnv

<details>

* Version: 1.24.0
* GitHub: https://github.com/broadinstitute/inferCNV
* Source code: https://github.com/cran/infercnv
* Date/Publication: 2025-04-15
* Number of recursive dependencies: 200

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

* Version: 2.16.0
* GitHub: NA
* Source code: https://github.com/cran/InPAS
* Date/Publication: 2025-04-15
* Number of recursive dependencies: 163

Run `revdepcheck::revdep_details(, "InPAS")` for more info

</details>

## In both

*   checking Rd cross-references ... WARNING
    ```
    Missing link(s) in Rd file 'get_ssRleCov.Rd':
      ‘[BSgenome:BSgenomeForge]{BSgenome::forgeBSgenomeDataPkg()}’
    
    Missing link(s) in Rd file 'set_globals.Rd':
      ‘[BSgenome:BSgenomeForge]{BSgenome::forgeBSgenomeDataPkg()}’
    
    See section 'Cross-references' in the 'Writing R Extensions' manual.
    ```

*   checking dependencies in R code ... NOTE
    ```
    There are ::: calls to the package's namespace in its code. A package
      almost never needs to use ::: for its own objects:
      ‘adjust_distalCPs’ ‘adjust_proximalCPs’ ‘adjust_proximalCPsByNBC’
      ‘adjust_proximalCPsByPWM’ ‘calculate_mse’ ‘find_valleyBySpline’
      ‘get_PAscore’ ‘get_PAscore2’ ‘remove_convergentUTR3s’
      ‘search_distalCPs’ ‘search_proximalCPs’
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
* Number of recursive dependencies: 88

Run `revdepcheck::revdep_details(, "interflex")` for more info

</details>

## In both

*   checking C++ specification ... NOTE
    ```
      Specified C++11: please drop specification unless essential
    ```

# InterpolateR

<details>

* Version: 1.3-4
* GitHub: https://github.com/Jonnathan-Landi/InterpolateR
* Source code: https://github.com/cran/InterpolateR
* Date/Publication: 2025-05-02 18:50:06 UTC
* Number of recursive dependencies: 67

Run `revdepcheck::revdep_details(, "InterpolateR")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
          ▆
       1. └─InterpolateR::RFplus(...) at test-RFplus.R:89:3
       2.   ├─stats::setNames(...)
       3.   └─base::lapply(...)
       4.     └─InterpolateR (local) FUN(X[[i]], ...)
       5.       ├─terra::distance(DEM, Points_VectTrain[i, ], rasterize = FALSE)
    ...
       10.     └─InterpolateR (local) FUN(X[[i]], ...)
       11.       ├─terra::distance(DEM, Points_VectTrain[i, ], rasterize = FALSE)
       12.       └─terra::distance(DEM, Points_VectTrain[i, ], rasterize = FALSE)
       13.         └─terra (local) .local(x, y, ...)
       14.           └─terra:::messages(x, "distance")
       15.             └─terra:::error(f, x@pntr$getError())
      
      [ FAIL 14 | WARN 20 | SKIP 0 | PASS 50 ]
      Error: Test failures
      Execution halted
    ```

# ISAnalytics

<details>

* Version: 1.18.0
* GitHub: https://github.com/calabrialab/ISAnalytics
* Source code: https://github.com/cran/ISAnalytics
* Date/Publication: 2025-04-15
* Number of recursive dependencies: 175

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
* Number of recursive dependencies: 115

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

# jlmerclusterperm

<details>

* Version: 1.1.4
* GitHub: https://github.com/yjunechoe/jlmerclusterperm
* Source code: https://github.com/cran/jlmerclusterperm
* Date/Publication: 2024-06-30 14:20:08 UTC
* Number of recursive dependencies: 110

Run `revdepcheck::revdep_details(, "jlmerclusterperm")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
      ── Error ('test-julia_rng.R:3:1'): (code run outside of `test_that()`) ─────────
      Error in `jlmerclusterperm_setup(cache_dir = tempdir(), restart = FALSE, 
          verbose = FALSE)`: No Julia installation detected.
      Backtrace:
          ▆
       1. └─jlmerclusterperm::jlmerclusterperm_setup(cache_dir = tempdir(), restart = FALSE, verbose = FALSE) at test-julia_rng.R:3:1
    ...
          verbose = FALSE)`: No Julia installation detected.
      Backtrace:
          ▆
       1. └─jlmerclusterperm::jlmerclusterperm_setup(cache_dir = tempdir(), restart = FALSE, verbose = FALSE) at test-timewise_statistics.R:3:1
       2.   └─cli::cli_abort("No Julia installation detected.")
       3.     └─rlang::abort(...)
      
      [ FAIL 7 | WARN 0 | SKIP 3 | PASS 5 ]
      Error: Test failures
      Execution halted
    ```

# JointAI

<details>

* Version: 1.0.6
* GitHub: https://github.com/nerler/JointAI
* Source code: https://github.com/cran/JointAI
* Date/Publication: 2024-04-02 18:25:00 UTC
* Number of recursive dependencies: 124

Run `revdepcheck::revdep_details(, "JointAI")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
        4. └─JointAI::mlogitmm_imp(...)
        5.   ├─base::do.call(model_imp, arglist)
        6.   └─JointAI (local) `<fn>`(...)
        7.     └─JointAI:::divide_matrices(...)
        8.       └─base::mapply(...)
        9.         └─JointAI (local) `<fn>`(...)
    ...
      ── Failure ('test-clm.R:247:3'): wrong models give errors ──────────────────────
      clm_imp(O2 ~ I(O1^2) + C1 + C2, data = wideDF, warn = FALSE) inherits from 'JointAI' not 'JointAI_errored'.
      ── Failure ('test-clmm.R:307:5'): wrong models give errors ─────────────────────
      clmm_imp(o2 ~ I(O1^2) + C1 + C2 + (1 | id), warn = FALSE, data = longDF) inherits from 'JointAI' not 'JointAI_errored'.
      ── Failure ('test-mlogitmm.R:236:3'): wrong models give errors ─────────────────
      mlogitmm_imp(...) inherits from 'JointAI' not 'JointAI_errored'.
      
      [ FAIL 3 | WARN 44 | SKIP 4 | PASS 2166 ]
      Error: Test failures
      Execution halted
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

# latentcor

<details>

* Version: 2.0.1
* GitHub: NA
* Source code: https://github.com/cran/latentcor
* Date/Publication: 2022-09-05 20:50:02 UTC
* Number of recursive dependencies: 141

Run `revdepcheck::revdep_details(, "latentcor")` for more info

</details>

## In both

*   checking Rd files ... NOTE
    ```
    checkRd: (-1) evaluation.Rd:38: Lost braces in \itemize; \value handles \item{}{} directly
    checkRd: (-1) evaluation.Rd:39: Lost braces in \itemize; \value handles \item{}{} directly
    checkRd: (-1) evaluation.Rd:40: Lost braces in \itemize; \value handles \item{}{} directly
    checkRd: (-1) evaluation.Rd:41: Lost braces in \itemize; \value handles \item{}{} directly
    checkRd: (-1) evaluation.Rd:42: Lost braces in \itemize; \value handles \item{}{} directly
    checkRd: (-1) evaluation.Rd:43: Lost braces in \itemize; \value handles \item{}{} directly
    checkRd: (-1) evaluation.Rd:44: Lost braces in \itemize; \value handles \item{}{} directly
    checkRd: (-1) evaluation.Rd:45: Lost braces in \itemize; \value handles \item{}{} directly
    checkRd: (-1) evaluation.Rd:46: Lost braces in \itemize; \value handles \item{}{} directly
    checkRd: (-1) evaluation.Rd:47: Lost braces in \itemize; \value handles \item{}{} directly
    ...
    checkRd: (-1) gen_data.Rd:35: Lost braces in \itemize; \value handles \item{}{} directly
    checkRd: (-1) gen_data.Rd:36-37: Lost braces in \itemize; \value handles \item{}{} directly
    checkRd: (-1) get_types.Rd:17: Lost braces in \itemize; \value handles \item{}{} directly
    checkRd: (-1) interpolation.Rd:23: Lost braces in \itemize; \value handles \item{}{} directly
    checkRd: (-1) interpolation.Rd:24: Lost braces in \itemize; \value handles \item{}{} directly
    checkRd: (-1) latentcor.Rd:38: Lost braces in \itemize; \value handles \item{}{} directly
    checkRd: (-1) latentcor.Rd:39: Lost braces in \itemize; \value handles \item{}{} directly
    checkRd: (-1) latentcor.Rd:40: Lost braces in \itemize; \value handles \item{}{} directly
    checkRd: (-1) latentcor.Rd:41: Lost braces in \itemize; \value handles \item{}{} directly
    checkRd: (-1) latentcor.Rd:42: Lost braces in \itemize; \value handles \item{}{} directly
    ```

# lava

<details>

* Version: 1.8.1
* GitHub: https://github.com/kkholst/lava
* Source code: https://github.com/cran/lava
* Date/Publication: 2025-01-12 11:40:02 UTC
* Number of recursive dependencies: 130

Run `revdepcheck::revdep_details(, "lava")` for more info

</details>

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
      Missing dependency on R >= 4.1.0 because package code uses the pipe
      |> or function shorthand \(...) syntax added in R 4.1.0.
      File(s) using such syntax:
        ‘contr.Rd’
    ```

# ldsr

<details>

* Version: 0.0.2
* GitHub: https://github.com/ntthung/ldsr
* Source code: https://github.com/cran/ldsr
* Date/Publication: 2020-05-04 14:40:09 UTC
* Number of recursive dependencies: 73

Run `revdepcheck::revdep_details(, "ldsr")` for more info

</details>

## In both

*   checking C++ specification ... NOTE
    ```
      Specified C++11: please drop specification unless essential
    ```

# LLMR

<details>

* Version: 0.5.0
* GitHub: https://github.com/asanaei/LLMR
* Source code: https://github.com/cran/LLMR
* Date/Publication: 2025-07-17 00:10:02 UTC
* Number of recursive dependencies: 89

Run `revdepcheck::revdep_details(, "LLMR")` for more info

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
        9.           │ ├─base::tryCatch(...)
       10.           │ │ └─base (local) tryCatchList(expr, classes, parentenv, handlers)
       11.           │ │   └─base (local) tryCatchOne(expr, names, parentenv, handlers[[1L]])
       12.           │ │     └─base (local) doTryCatch(return(expr), name, parentenv, handler)
       13.           │ └─base::force(expr)
       14.           └─rlang::abort(...)
      
      [ FAIL 1 | WARN 0 | SKIP 1 | PASS 0 ]
      Error: Test failures
      Execution halted
    ```

# MAI

<details>

* Version: 1.14.0
* GitHub: https://github.com/KechrisLab/MAI
* Source code: https://github.com/cran/MAI
* Date/Publication: 2025-04-15
* Number of recursive dependencies: 173

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
* Number of recursive dependencies: 121

Run `revdepcheck::revdep_details(, "malariaAtlas")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
       3. │   ├─testthat (local) .capture(...)
       4. │   │ └─base::withCallingHandlers(...)
       5. │   └─rlang::eval_bare(quo_get_expr(.quo), quo_get_env(.quo))
       6. └─malariaAtlas::extractRaster(...)
       7.   └─base::lapply(...)
       8.     └─malariaAtlas (local) FUN(X[[i]], ...)
    ...
       2.   └─base::sapply(...)
       3.     └─base::lapply(X = X, FUN = FUN, ...)
       4.       └─malariaAtlas (local) FUN(X[[i]], ...)
       5.         └─malariaAtlas:::download_rst(...)
       6.           └─wcs_client$getCoverage(...)
       7.             └─cov$getCoverage(...)
      
      [ FAIL 21 | WARN 13 | SKIP 1 | PASS 268 ]
      Error: Test failures
      Execution halted
    ```

# mapme.biodiversity

<details>

* Version: 0.9.4
* GitHub: https://github.com/mapme-initiative/mapme.biodiversity
* Source code: https://github.com/cran/mapme.biodiversity
* Date/Publication: 2025-04-28 13:00:08 UTC
* Number of recursive dependencies: 103

Run `revdepcheck::revdep_details(, "mapme.biodiversity")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
                           (right here) ------^
      Backtrace:
           ▆
        1. ├─mapme.biodiversity::make_footprints(tifs, what = "raster") at test-get_resources.R:72:3
        2. │ └─purrr::map2(srcs, oo, function(src, opt) .raster_footprint(src, opt))
        3. │   └─purrr:::map2_("list", .x, .y, .f, ..., .progress = .progress)
    ...
       13. │                 └─jsonlite:::parseJSON(txt, bigint_as_char)
       14. │                   └─jsonlite:::parse_string(txt, bigint_as_char)
       15. └─base::.handleSimpleError(...)
       16.   └─purrr (local) h(simpleError(msg, call))
       17.     └─cli::cli_abort(...)
       18.       └─rlang::abort(...)
      
      [ FAIL 7 | WARN 2 | SKIP 7 | PASS 684 ]
      Error: Test failures
      Execution halted
    ```

# merTools

<details>

* Version: 0.6.2
* GitHub: https://github.com/jknowles/merTools
* Source code: https://github.com/cran/merTools
* Date/Publication: 2024-02-08 07:20:07 UTC
* Number of recursive dependencies: 142

Run `revdepcheck::revdep_details(, "merTools")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat-a_m.R’
      Running ‘testthat-m_z.R’
     ERROR
    Running the tests in ‘tests/testthat-m_z.R’ failed.
    Complete output:
      > library(testthat)
      > library(merTools)
      Loading required package: arm
      Loading required package: MASS
      Loading required package: Matrix
    ...
      -   7   0.008824320 1.433124 -1.449002
      +   7   0.008823944 1.433126 -1.449003
      and 3 more ...
      
      * Run `testthat::snapshot_accept('predict2')` to accept the change.
      * Run `testthat::snapshot_review('predict2')` to interactively review the change.
      
      [ FAIL 2 | WARN 0 | SKIP 0 | PASS 487 ]
      Error: Test failures
      Execution halted
    ```

# MIC

<details>

* Version: 1.1.0
* GitHub: https://github.com/agerada/MIC
* Source code: https://github.com/cran/MIC
* Date/Publication: 2025-06-05 04:20:06 UTC
* Number of recursive dependencies: 144

Run `revdepcheck::revdep_details(, "MIC")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
          ▆
       1. └─MIC::download_patric_db(tmp_path_db) at test-patric.R:34:3
       2.   └─utils::download.file(ftp_path, save_path, mode = "wb")
      ── Warning ('test-patric.R:42:3'): check can download genomes ──────────────────
      cannot open URL 'ftp://ftp.bvbrc.org/RELEASE_NOTES/PATRIC_genomes_AMR.txt': FTP status was '400 Unknown Error'
      Backtrace:
    ...
       2. │ └─MIC::load_patric_db(database)
       3. │   └─readr::read_delim(x, delim = "\t", col_types = readr::cols(.default = "c"))
       4. │     └─vroom::vroom(...)
       5. │       └─vroom:::vroom_(...)
       6. ├─base (local) `<fn>`(`<url>`, "rb")
       7. └─base::open.connection(`<url>`, "rb")
      
      [ FAIL 3 | WARN 3 | SKIP 0 | PASS 218 ]
      Error: Test failures
      Execution halted
    ```

# mikropml

<details>

* Version: 1.6.1
* GitHub: https://github.com/SchlossLab/mikropml
* Source code: https://github.com/cran/mikropml
* Date/Publication: 2023-08-21 15:10:05 UTC
* Number of recursive dependencies: 127

Run `revdepcheck::revdep_details(, "mikropml")` for more info

</details>

## In both

*   checking Rd files ... NOTE
    ```
    checkRd: (-1) create_grouped_data_partition.Rd:60: Lost braces; missing escapes or markup?
        60 | Zena Lapp, {zenalapp@umich.edu}
           |            ^
    checkRd: (-1) create_grouped_data_partition.Rd:62: Lost braces; missing escapes or markup?
        62 | Kelly Sovacool, {sovacool@umich.edu}
           |                 ^
    checkRd: (-1) create_grouped_k_multifolds.Rd:30: Lost braces; missing escapes or markup?
        30 | Zena Lapp, {zenalapp@umich.edu}
           |            ^
    checkRd: (-1) get_partition_indices.Rd:58: Lost braces; missing escapes or markup?
        58 | Kelly Sovacool, {sovacool@umich.edu}
           |                 ^
    checkRd: (-1) set_hparams_glmnet.Rd:16: Lost braces; missing escapes or markup?
        16 | Zena Lapp, {zenalapp@umich.edu}
           |            ^
    ```

# MineICA

<details>

* Version: 1.48.0
* GitHub: NA
* Source code: https://github.com/cran/MineICA
* Date/Publication: 2025-04-15
* Number of recursive dependencies: 218

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
    > ###   Slist,IcaSet-method SlistByGene,IcaSet-method Alist,IcaSet-method
    > ### Keywords: classes
    > 
    > ### ** Examples
    > 
    > # create an instance of IcaSet
    > new("IcaSet")
    Error: Your query has been redirected to http://status.ensembl.org indicating this Ensembl service is currently unavailable.
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
    Error : Your query has been redirected to http://status.ensembl.org indicating this Ensembl service is currently unavailable.
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

* Version: 1.16.0
* GitHub: https://github.com/saezlab/mistyR
* Source code: https://github.com/cran/mistyR
* Date/Publication: 2025-04-15
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

# mlr3tuning

<details>

* Version: 1.4.0
* GitHub: https://github.com/mlr-org/mlr3tuning
* Source code: https://github.com/cran/mlr3tuning
* Date/Publication: 2025-06-04 11:10:02 UTC
* Number of recursive dependencies: 100

Run `revdepcheck::revdep_details(, "mlr3tuning")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
       3.     └─redux::redis_connection(config)
       4.       └─redux:::redis_connect(config)
       5.         └─redux:::redis_connect_tcp(config$host, config$port, config$timeout)
      ── Error ('test_mlr_callbacks.R:480:3'): async freeze archive callback works ───
      Error in `redis_connect_tcp(config$host, config$port, config$timeout)`: Failed to create context: Connection refused
      Backtrace:
    ...
          ▆
       1. └─global flush_redis() at test_ti_async.R:44:3
       2.   └─redux::hiredis(config)
       3.     └─redux::redis_connection(config)
       4.       └─redux:::redis_connect(config)
       5.         └─redux:::redis_connect_tcp(config$host, config$port, config$timeout)
      
      [ FAIL 63 | WARN 5 | SKIP 0 | PASS 4664 ]
      Error: Test failures
      Execution halted
    ```

# multilevelmediation

<details>

* Version: 0.4.1
* GitHub: https://github.com/falkcarl/multilevelmediation
* Source code: https://github.com/cran/multilevelmediation
* Date/Publication: 2025-01-10 12:10:02 UTC
* Number of recursive dependencies: 102

Run `revdepcheck::revdep_details(, "multilevelmediation")` for more info

</details>

## In both

*   R CMD check timed out
    

# multitool

<details>

* Version: 0.1.4
* GitHub: https://github.com/ethan-young/multitool
* Source code: https://github.com/cran/multitool
* Date/Publication: 2024-02-08 17:40:02 UTC
* Number of recursive dependencies: 149

Run `revdepcheck::revdep_details(, "multitool")` for more info

</details>

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
      Missing dependency on R >= 4.2.0 because package code uses the pipe
      placeholder syntax added in R 4.2.0.
      File(s) using such syntax:
        ‘grid-pipeline.R’ ‘inspect-decisions.R’ ‘multiverse-tables.R’
        ‘show-pipelines.R’ ‘utils.R’ ‘visualize-pipeline.R’
    ```

# multiverse

<details>

* Version: 0.6.2
* GitHub: https://github.com/MUCollective/multiverse
* Source code: https://github.com/cran/multiverse
* Date/Publication: 2024-10-07 23:20:03 UTC
* Number of recursive dependencies: 135

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
* Number of recursive dependencies: 91

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

# oncomsm

<details>

* Version: 0.1.4
* GitHub: https://github.com/Boehringer-Ingelheim/oncomsm
* Source code: https://github.com/cran/oncomsm
* Date/Publication: 2023-04-17 07:00:02 UTC
* Number of recursive dependencies: 122

Run `revdepcheck::revdep_details(, "oncomsm")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
       1. └─vdiffr::expect_doppelganger("plot.srp_model_1", plt) at test-plots.R:20:3
       2.   ├─base::withCallingHandlers(...)
       3.   └─testthat::expect_snapshot_file(...)
      ── Failure ('test-plots.R:31:3'): default plotting works as intended ───────────
      Snapshot of `testcase` to 'plots/plot-srp-model-2.svg' has changed
      * Locate check directory
    ...
       3.   └─testthat::expect_snapshot_file(...)
      ── Failure ('test-simulate_decision.R:54:3'): decision rules can be simulated ──
      mean(tbl_decisions$go) < 0.5 is not TRUE
      
      `actual`:   FALSE
      `expected`: TRUE 
      
      [ FAIL 6 | WARN 0 | SKIP 0 | PASS 61 ]
      Error: Test failures
      Execution halted
    ```

# onemapsgapi

<details>

* Version: 2.0.0
* GitHub: NA
* Source code: https://github.com/cran/onemapsgapi
* Date/Publication: 2025-05-30 09:20:02 UTC
* Number of recursive dependencies: 65

Run `revdepcheck::revdep_details(, "onemapsgapi")` for more info

</details>

## In both

*   checking re-building of vignette outputs ... ERROR
    ```
    Error(s) in re-building vignettes:
      ...
    --- re-building ‘onemapsgapi_vignette.Rmd’ using rmarkdown
    
    Quitting from onemapsgapi_vignette.Rmd:49-51 [unnamed-chunk-5]
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    <error/rlang_error>
    Error in `get_token()`:
    ! The request returned an error message: Your email field is empty. Status Code: 400
    ---
    ...
    
    Error: processing vignette 'onemapsgapi_vignette.Rmd' failed with diagnostics:
    The request returned an error message: Your email field is empty. Status Code: 400
    --- failed re-building ‘onemapsgapi_vignette.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘onemapsgapi_vignette.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
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

* Version: 0.14.0
* GitHub: NA
* Source code: https://github.com/cran/PAMscapes
* Date/Publication: 2025-06-11 05:20:02 UTC
* Number of recursive dependencies: 129

Run `revdepcheck::revdep_details(, "PAMscapes")` for more info

</details>

## In both

*   checking whether package ‘PAMscapes’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: no DISPLAY variable so Tk is not available
    See ‘/scratch/henrik/revdep/future/checks/PAMscapes/new/PAMscapes.Rcheck/00install.out’ for details.
    ```

# paramsim

<details>

* Version: 0.1.0
* GitHub: NA
* Source code: https://github.com/cran/paramsim
* Date/Publication: 2023-01-23 07:50:06 UTC
* Number of recursive dependencies: 71

Run `revdepcheck::revdep_details(, "paramsim")` for more info

</details>

## In both

*   checking re-building of vignette outputs ... ERROR
    ```
    Error(s) in re-building vignettes:
      ...
    --- re-building ‘paramsim.Rmd’ using rmarkdown
    Error: processing vignette 'paramsim.Rmd' failed with diagnostics:
    there is no package called ‘rmarkdown’
    --- failed re-building ‘paramsim.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘paramsim.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# pareg

<details>

* Version: 1.6.0
* GitHub: https://github.com/cbg-ethz/pareg
* Source code: https://github.com/cran/pareg
* Date/Publication: 2023-10-24
* Number of recursive dependencies: 319

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
       │     └─ python >=3.10,<3.11.0a0 , which conflicts with any installable versions previously reported;
       ├─ tensorflow 2.10.0 would require
       │  └─ tensorflow-base [2.10.0 eigen_py38h1969d1f_0|2.10.0 gpu_py38h6559e04_0|2.10.0 mkl_py38hb9daa73_0], which requires
       │     └─ python >=3.8,<3.9.0a0 , which conflicts with any installable versions previously reported;
       └─ tensorflow 2.10.0 would require
          └─ tensorflow-base [2.10.0 eigen_py39h1969d1f_0|2.10.0 gpu_py39h6559e04_0|2.10.0 mkl_py39hb9daa73_0], which requires
             └─ python >=3.9,<3.10.0a0 , which conflicts with any installable versions previously reported.
    
    Error: one or more Python packages failed to install [error code 1]
    Execution halted
    ```

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
        xorg-libx11        anaconda/linux-64::xorg-libx11-1.8.12-h9b100fa_1 
        xorg-libxau        anaconda/linux-64::xorg-libxau-1.0.12-h9b100fa_0 
        xorg-libxdmcp      anaconda/linux-64::xorg-libxdmcp-1.1.5-h9b100fa_0 
        xorg-xorgproto     anaconda/linux-64::xorg-xorgproto-2024.1-h5eee18b_1 
        xz                 anaconda/linux-64::xz-5.6.4-h5eee18b_1 
        zlib               anaconda/linux-64::zlib-1.2.13-h5eee18b_1 
    ...
         │     └─ python >=3.10,<3.11.0a0 , which conflicts with any installable versions previously reported;
         ├─ tensorflow 2.10.0 would require
         │  └─ tensorflow-base [2.10.0 eigen_py38h1969d1f_0|2.10.0 gpu_py38h6559e04_0|2.10.0 mkl_py38hb9daa73_0], which requires
         │     └─ python >=3.8,<3.9.0a0 , which conflicts with any installable versions previously reported;
         └─ tensorflow 2.10.0 would require
            └─ tensorflow-base [2.10.0 eigen_py39h1969d1f_0|2.10.0 gpu_py39h6559e04_0|2.10.0 mkl_py39hb9daa73_0], which requires
               └─ python >=3.9,<3.10.0a0 , which conflicts with any installable versions previously reported.
      
      Error: one or more Python packages failed to install [error code 1]
      Execution halted
    ```

*   checking re-building of vignette outputs ... ERROR
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘pareg.Rmd’ using rmarkdown
    The magick package is required to crop "/scratch/henrik/revdep/future/checks/pareg/new/pareg.Rcheck/vign_test/pareg/vignettes/pareg_files/figure-html/unnamed-chunk-4-1.png" but not available.
    The magick package is required to crop "/scratch/henrik/revdep/future/checks/pareg/new/pareg.Rcheck/vign_test/pareg/vignettes/pareg_files/figure-html/unnamed-chunk-5-1.png" but not available.
    Channels:
     - anaconda
    Platform: linux-64
    Collecting package metadata (repodata.json): ...working... done
    Solving environment: ...working... done
    
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

# parseRPDR

<details>

* Version: 1.1.2
* GitHub: https://github.com/martonkolossvary/parseRPDR
* Source code: https://github.com/cran/parseRPDR
* Date/Publication: 2025-01-19 18:10:02 UTC
* Number of recursive dependencies: 85

Run `revdepcheck::revdep_details(, "parseRPDR")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘covr.R’
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
        2. │ └─base::withCallingHandlers(...)
        3. └─parseRPDR::load_prc(d_fname, nThread = 2)
        4.   └─base::lapply(...)
        5.     └─parseRPDR (local) FUN(X[[i]], ...)
        6.       ├─base::suppressMessages(...)
    ...
       3. ├─parseRPDR::load_notes(...)
       4. │ └─readr::read_lines(...)
       5. │   └─vroom::vroom_lines(...)
       6. │     └─vroom:::vroom_(...)
       7. └─vroom (local) `<fn>`(NA_character_)
       8.   └─vroom:::split_path_ext(basename_utf8(path))
      
      [ FAIL 33 | WARN 3 | SKIP 0 | PASS 66 ]
      Error: Test failures
      Execution halted
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

# pGRN

<details>

* Version: 0.3.5
* GitHub: NA
* Source code: https://github.com/cran/pGRN
* Date/Publication: 2023-01-17 17:20:02 UTC
* Number of recursive dependencies: 89

Run `revdepcheck::revdep_details(, "pGRN")` for more info

</details>

## In both

*   checking re-building of vignette outputs ... ERROR
    ```
    Error(s) in re-building vignettes:
      ...
    --- re-building ‘pGRN.Rmd’ using knitr
    Error: processing vignette 'pGRN.Rmd' failed with diagnostics:
    there is no package called ‘markdown’
    --- failed re-building ‘pGRN.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘pGRN.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# pgxRpi

<details>

* Version: 1.4.3
* GitHub: https://github.com/progenetix/pgxRpi
* Source code: https://github.com/cran/pgxRpi
* Date/Publication: 2025-05-21
* Number of recursive dependencies: 156

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

# POMADE

<details>

* Version: 0.2.0
* GitHub: https://github.com/MikkelVembye/POMADE
* Source code: https://github.com/cran/POMADE
* Date/Publication: 2024-02-13 20:41:20 UTC
* Number of recursive dependencies: 73

Run `revdepcheck::revdep_details(, "POMADE")` for more info

</details>

## In both

*   R CMD check timed out
    

# powRICLPM

<details>

* Version: 0.2.1
* GitHub: https://github.com/JeroenDMulder/powRICLPM
* Source code: https://github.com/cran/powRICLPM
* Date/Publication: 2024-10-26 13:50:03 UTC
* Number of recursive dependencies: 71

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

# projpred

<details>

* Version: 2.9.0
* GitHub: https://github.com/stan-dev/projpred
* Source code: https://github.com/cran/projpred
* Date/Publication: 2025-07-08 22:00:02 UTC
* Number of recursive dependencies: 160

Run `revdepcheck::revdep_details(, "projpred")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
      Setting 'K' to the number of folds (2)
      Fitting model 1 out of 2
      Fitting model 2 out of 2
      Setting 'K' to the number of folds (2)
      Fitting model 1 out of 2
      Fitting model 2 out of 2
    ...
       28. │                                               ├─utils::capture.output(tryCatch(expr, error = throw_err), type = "message")
       29. │                                               │ └─base::withVisible(...elt(i))
       30. │                                               └─base::tryCatch(expr, error = throw_err)
       31. │                                                 └─base (local) tryCatchList(expr, classes, parentenv, handlers)
       32. │                                                   └─base (local) tryCatchOne(expr, names, parentenv, handlers[[1L]])
       33. │                                                     └─value[[3L]](cond)
       34. │                                                       └─base::stop(e)
       35. └─testthat (local) `<fn>`(`<std::rn_>`)
       36.   └─rlang::abort(...)
      Execution halted
    ```

# Prostar

<details>

* Version: 1.40.0
* GitHub: https://github.com/edyp-lab/Prostar
* Source code: https://github.com/cran/Prostar
* Date/Publication: 2025-04-15
* Number of recursive dependencies: 188

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
* Number of recursive dependencies: 100

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

* Version: 1.44.0
* GitHub: https://github.com/ccagc/QDNAseq
* Source code: https://github.com/cran/QDNAseq
* Date/Publication: 2025-04-15
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

# R4GoodPersonalFinances

<details>

* Version: 1.0.0
* GitHub: https://github.com/R4GoodAcademy/R4GoodPersonalFinances
* Source code: https://github.com/cran/R4GoodPersonalFinances
* Date/Publication: 2025-06-04 11:00:09 UTC
* Number of recursive dependencies: 107

Run `revdepcheck::revdep_details(, "R4GoodPersonalFinances")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘spelling.R’
      Comparing ‘spelling.Rout’ to ‘spelling.Rout.save’ ... OK
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
        9.         ├─base::tryCatch(fun(libname, pkgname), error = identity)
       10.         │ └─base (local) tryCatchList(expr, classes, parentenv, handlers)
       11.         │   └─base (local) tryCatchOne(expr, names, parentenv, handlers[[1L]])
       12.         │     └─base (local) doTryCatch(return(expr), name, parentenv, handler)
    ...
      -    5       0.02          450343. -1395305.                   -79051.
      +    5       0.02          450343. -1395305.                -79051.         -7051.
      and 308 more ...
      
      * Run `testthat::snapshot_accept('simulate_single_scenario')` to accept the change.
      * Run `testthat::snapshot_review('simulate_single_scenario')` to interactively review the change.
      
      [ FAIL 1 | WARN 2 | SKIP 1 | PASS 335 ]
      Error: Test failures
      Execution halted
    ```

# rBiasCorrection

<details>

* Version: 0.3.5
* GitHub: https://github.com/kapsner/rBiasCorrection
* Source code: https://github.com/cran/rBiasCorrection
* Date/Publication: 2025-04-05 13:50:02 UTC
* Number of recursive dependencies: 120

Run `revdepcheck::revdep_details(, "rBiasCorrection")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
       13.           ├─future::value(fs)
       14.           └─future:::value.list(fs)
       15.             └─future (local) signalConditionsASAP(...)
       16.               └─future:::signalConditions(...)
      ── Warning ('test-plotting.R:128:5'): createbarerrorplots ──────────────────────
      lmdif: info = -1. Number of iterations has reached `maxiter' == 50.
    ...
      and 3 more ...
      
      * Run `testthat::snapshot_accept('algorithm_minmax_FALSE')` to accept the change.
      * Run `testthat::snapshot_review('algorithm_minmax_FALSE')` to interactively review the change.
      
      [ FAIL 1 | WARN 122 | SKIP 1 | PASS 102 ]
      Error: Test failures
      Execution halted
      Error in deferred_run(env) : could not find function "deferred_run"
      Calls: <Anonymous>
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
      [ FAIL 1 | WARN 0 | SKIP 4 | PASS 5 ]
      
    ...
       3. │   └─testthat:::quasi_capture(...)
       4. │     ├─testthat (local) .capture(...)
       5. │     │ └─base::withCallingHandlers(...)
       6. │     └─rlang::eval_bare(quo_get_expr(.quo), quo_get_env(.quo))
       7. └─receptiviti::receptiviti(...)
       8.   └─receptiviti:::manage_request(...)
      
      [ FAIL 1 | WARN 0 | SKIP 4 | PASS 5 ]
      Error: Test failures
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

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘Deriv’
      All declared Imports should be used.
    ```

# reproducible

<details>

* Version: 2.1.2
* GitHub: https://github.com/PredictiveEcology/reproducible
* Source code: https://github.com/cran/reproducible
* Date/Publication: 2024-12-12 06:30:02 UTC
* Number of recursive dependencies: 103

Run `revdepcheck::revdep_details(, "reproducible")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘test-all.R’
     ERROR
    Running the tests in ‘tests/test-all.R’ failed.
    Last 50 lines of output:
      <cmdError/error/condition>
      Error in `system("apt -qq list p7zip-rar", intern = TRUE, ignore.stderr = TRUE)`: error in running command
      Backtrace:
          ▆
       1. └─reproducible:::.archiveExtractBinary() at test-prepInputsInNestedArchives.R:146:5
       2.   └─base::system("apt -qq list p7zip-rar", intern = TRUE, ignore.stderr = TRUE)
    ...
       1. ├─sf::st_union(...) at test-symlinks.R:47:5
       2. ├─sf::st_transform(...)
       3. └─reproducible::prepInputs(...)
       4.   └─reproducible::preProcess(...)
       5.     └─reproducible::downloadFile(...)
       6.       └─reproducible:::dlErrorHandling(...)
      
      [ FAIL 9 | WARN 0 | SKIP 34 | PASS 625 ]
      Error: Test failures
      Execution halted
    ```

# rgee

<details>

* Version: 1.1.7
* GitHub: https://github.com/r-spatial/rgee
* Source code: https://github.com/cran/rgee
* Date/Publication: 2023-09-27 08:30:02 UTC
* Number of recursive dependencies: 132

Run `revdepcheck::revdep_details(, "rgee")` for more info

</details>

## In both

*   checking Rd files ... NOTE
    ```
    checkRd: (-1) ee_Authenticate.Rd:40: Lost braces in \itemize; meant \describe ?
    checkRd: (-1) ee_Authenticate.Rd:41: Lost braces in \itemize; meant \describe ?
    checkRd: (-1) ee_Authenticate.Rd:42: Lost braces in \itemize; meant \describe ?
    checkRd: (-1) ee_Authenticate.Rd:43: Lost braces in \itemize; meant \describe ?
    checkRd: (-1) ee_Authenticate.Rd:44: Lost braces in \itemize; meant \describe ?
    checkRd: (-1) ee_Initialize.Rd:49: Lost braces in \itemize; meant \describe ?
    checkRd: (-1) ee_Initialize.Rd:50: Lost braces in \itemize; meant \describe ?
    checkRd: (-1) ee_Initialize.Rd:51: Lost braces in \itemize; meant \describe ?
    checkRd: (-1) ee_Initialize.Rd:52: Lost braces in \itemize; meant \describe ?
    checkRd: (-1) ee_Initialize.Rd:53: Lost braces in \itemize; meant \describe ?
    ...
    checkRd: (-1) ee_imagecollection_to_local.Rd:105: Lost braces in \itemize; meant \describe ?
    checkRd: (-1) ee_imagecollection_to_local.Rd:106: Lost braces in \itemize; meant \describe ?
    checkRd: (-1) ee_imagecollection_to_local.Rd:107: Lost braces in \itemize; meant \describe ?
    checkRd: (-1) ee_imagecollection_to_local.Rd:108: Lost braces in \itemize; meant \describe ?
    checkRd: (-1) ee_install.Rd:35-37: Lost braces in \itemize; meant \describe ?
    checkRd: (-1) ee_install.Rd:38-39: Lost braces in \itemize; meant \describe ?
    checkRd: (-1) ee_install.Rd:40: Lost braces in \itemize; meant \describe ?
    checkRd: (-1) ee_install.Rd:41-44: Lost braces in \itemize; meant \describe ?
    checkRd: (-1) ee_install.Rd:45: Lost braces in \itemize; meant \describe ?
    checkRd: (-1) ee_install.Rd:46: Lost braces in \itemize; meant \describe ?
    ```

# robust2sls

<details>

* Version: 0.2.3
* GitHub: https://github.com/jkurle/robust2sls
* Source code: https://github.com/cran/robust2sls
* Date/Publication: 2025-05-20 22:30:02 UTC
* Number of recursive dependencies: 123

Run `revdepcheck::revdep_details(, "robust2sls")` for more info

</details>

## In both

*   R CMD check timed out
    

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

*   R CMD check timed out
    

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

* Version: 1.8.0
* GitHub: https://github.com/AbbVie-ComputationalGenomics/SCArray
* Source code: https://github.com/cran/SCArray.sat
* Date/Publication: 2025-04-15
* Number of recursive dependencies: 179

Run `revdepcheck::revdep_details(, "SCArray.sat")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Unexported objects imported by ':::' calls:
      ‘Seurat:::DEmethods_counts’ ‘Seurat:::DEmethods_nocorrect’
      ‘Seurat:::FastExpMean’ ‘Seurat:::FastLogVMR’ ‘Seurat:::NBResiduals’
      ‘Seurat:::UpdateKey’ ‘Seurat:::ValidateDataForMerge’
      See the note in ?`:::` about the use of this operator.
    ```

# scStability

<details>

* Version: 1.0.3
* GitHub: NA
* Source code: https://github.com/cran/scStability
* Date/Publication: 2025-06-23 15:50:02 UTC
* Number of recursive dependencies: 229

Run `revdepcheck::revdep_details(, "scStability")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘spelling.R’
      Comparing ‘spelling.Rout’ to ‘spelling.Rout.save’ ... OK
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
       11.         ├─base::do.call(makeClusterPSOCK, args = args, quote = TRUE)
       12.         └─parallelly (local) `<fn>`(base::quote(8L), rscript_libs = base::quote(`<chr>`))
       13.           └─parallelly:::checkNumberOfLocalWorkers(workers)
      ── Error ('test-createEmb.R:3:3'): All embeddings are generated correctly ──────
    ...
       14.   └─future::ClusterFutureBackend(...)
       15.     └─clusterRegistry$startCluster(...)
       16.       └─future (local) makeCluster(workers, ...)
       17.         ├─base::do.call(makeClusterPSOCK, args = args, quote = TRUE)
       18.         └─parallelly (local) `<fn>`(base::quote(8L), rscript_libs = base::quote(`<chr>`))
       19.           └─parallelly:::checkNumberOfLocalWorkers(workers)
      
      [ FAIL 4 | WARN 1 | SKIP 0 | PASS 0 ]
      Error: Test failures
      Execution halted
    ```

*   checking re-building of vignette outputs ... ERROR
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘Introduction-to-scStability.Rmd’ using rmarkdown
    Performing log-normalization
    0%   10   20   30   40   50   60   70   80   90   100%
    [----|----|----|----|----|----|----|----|----|----|
    **************************************************|
    Calculating gene variances
    0%   10   20   30   40   50   60   70   80   90   100%
    [----|----|----|----|----|----|----|----|----|----|
    **************************************************|
    ...
    
    Error: processing vignette 'Introduction-to-scStability.Rmd' failed with diagnostics:
    Attempting to set up 8 localhost parallel workers with only 2 CPU cores available for this R process (per 'fallback'), which could result in a 400% load. The hard limit is set to 300%. Overusing the CPUs has negative impact on the current R process, but also on all other processes of yours and others running on the same machine. See help("parallelly.maxWorkers.localhost", package = "parallelly") for further explanations and how to override the hard limit that triggered this error
    --- failed re-building ‘Introduction-to-scStability.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘Introduction-to-scStability.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# sdmTMB

<details>

* Version: 0.7.2
* GitHub: https://github.com/pbs-assess/sdmTMB
* Source code: https://github.com/cran/sdmTMB
* Date/Publication: 2025-06-19 21:20:02 UTC
* Number of recursive dependencies: 150

Run `revdepcheck::revdep_details(, "sdmTMB")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Complete output:
      > options(Matrix.warnDeprecatedCoerce = 2)
      > 
      > library(testthat)
      > library(sdmTMB)
      > 
      > test_check("sdmTMB")
    ...
      
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Failure ('test-nonstationary.R:277:3'): Test that non-stationary model works without spatial field and random effects in epsilon ──
      as.numeric(par) not equal to -14.
      1/1 mismatches
      [1] -14.3 - -14 == -0.285
      
      [ FAIL 1 | WARN 0 | SKIP 3 | PASS 1122 ]
      Error: Test failures
      Execution halted
    ```

# sigminer

<details>

* Version: 2.3.1
* GitHub: https://github.com/ShixiangWang/sigminer
* Source code: https://github.com/cran/sigminer
* Date/Publication: 2024-05-11 08:50:02 UTC
* Number of recursive dependencies: 211

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

* Version: 2.10.0
* GitHub: https://github.com/TojalLab/signeR
* Source code: https://github.com/cran/signeR
* Date/Publication: 2025-04-15
* Number of recursive dependencies: 235

Run `revdepcheck::revdep_details(, "signeR")` for more info

</details>

## In both

*   checking C++ specification ... NOTE
    ```
      Specified C++11: please drop specification unless essential
    ```

*   checking R code for possible problems ... NOTE
    ```
    covariate: no visible binding for global variable ‘.’
    explorepage: no visible binding for global variable ‘.’
    genCountMatrixFromMAF: no visible binding for global variable
      ‘Variant_Type’
    genCountMatrixFromMAF: no visible binding for global variable
      ‘Reference_Allele’
    genCountMatrixFromMAF: no visible binding for global variable
      ‘Tumor_Seq_Allele2’
    genCountMatrixFromMAF: no visible binding for global variable
      ‘Tumor_Seq_Allele1’
    ...
    ExposureCorrelation,SignExp-numeric: no visible binding for global
      variable ‘exposure’
    ExposureCorrelation,matrix-numeric: no visible binding for global
      variable ‘Feature’
    ExposureCorrelation,matrix-numeric: no visible binding for global
      variable ‘exposure’
    Undefined global functions or variables:
      . Col Feature Frequency Reference_Allele Row Samples Signatures
      Tumor_Seq_Allele1 Tumor_Seq_Allele2 Variant_Type alt<- exposure fc
      project sig sig_test
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

# SimDesign

<details>

* Version: 2.20.0
* GitHub: https://github.com/philchalmers/SimDesign
* Source code: https://github.com/cran/SimDesign
* Date/Publication: 2025-07-16 19:30:14 UTC
* Number of recursive dependencies: 136

Run `revdepcheck::revdep_details(, "SimDesign")` for more info

</details>

## Newly broken

*   checking re-building of vignette outputs ... ERROR
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘Catch_errors.Rmd’ using rmarkdown
    --- finished re-building ‘Catch_errors.Rmd’
    
    --- re-building ‘Fixed_obj_fun.Rmd’ using rmarkdown
    
    Quitting from Fixed_obj_fun.Rmd:64-69 [unnamed-chunk-5]
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    <error/rlang_error>
    Error in `serverSocket()`:
    ...
    --- finished re-building ‘Saving-results.Rmd’
    
    --- re-building ‘SimDesign-intro.Rmd’ using rmarkdown
    --- finished re-building ‘SimDesign-intro.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘Fixed_obj_fun.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# simhelpers

<details>

* Version: 0.3.1
* GitHub: https://github.com/meghapsimatrix/simhelpers
* Source code: https://github.com/cran/simhelpers
* Date/Publication: 2025-01-10 21:50:02 UTC
* Number of recursive dependencies: 98

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
* Number of recursive dependencies: 160

Run `revdepcheck::revdep_details(, "SmCCNet")` for more info

</details>

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘SmCCNet_Vignette_AutoSmCCNet.Rmd’ using rmarkdown
    ! LaTeX Error: File `ucharcat.sty' not found.
    
    ! Emergency stop.
    <read *> 
    
    Error: processing vignette 'SmCCNet_Vignette_AutoSmCCNet.Rmd' failed with diagnostics:
    LaTeX failed to compile /scratch/henrik/revdep/future/checks/SmCCNet/new/SmCCNet.Rcheck/vign_test/SmCCNet/vignettes/SmCCNet_Vignette_AutoSmCCNet.tex. See https://yihui.org/tinytex/r/#debugging for debugging tips. See SmCCNet_Vignette_AutoSmCCNet.log for more info.
    --- failed re-building ‘SmCCNet_Vignette_AutoSmCCNet.Rmd’
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
* Number of recursive dependencies: 128

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

* Version: 0.2.8
* GitHub: https://github.com/machiela-lab/sparrpowR
* Source code: https://github.com/cran/sparrpowR
* Date/Publication: 2024-01-23 15:20:02 UTC
* Number of recursive dependencies: 127

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
* Number of recursive dependencies: 123

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

# sphunif

<details>

* Version: 1.4.0
* GitHub: https://github.com/egarpor/sphunif
* Source code: https://github.com/cran/sphunif
* Date/Publication: 2024-05-24 21:50:01 UTC
* Number of recursive dependencies: 71

Run `revdepcheck::revdep_details(, "sphunif")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Complete output:
      > library(testthat)
      > library(sphunif)
      Loading required package: Rcpp
      > 
      > test_check("sphunif")
      data is an array with more than one slice, only the first one is employed.
    ...
      Series truncated from 10000 to 10000 terms (difference <= 0 with the HBE tail probability; last weight = 0.000e+00).
      [ FAIL 1 | WARN 0 | SKIP 0 | PASS 2398 ]
      
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Failure ('test_int_sph_MC.R:104:3'): Parallelization is faster ──────────────
      `t1` is not strictly more than `t2`. Difference: -1.16
      
      [ FAIL 1 | WARN 0 | SKIP 0 | PASS 2398 ]
      Error: Test failures
      Execution halted
    ```

# squat

<details>

* Version: 0.4.0
* GitHub: https://github.com/LMJL-Alea/squat
* Source code: https://github.com/cran/squat
* Date/Publication: 2025-05-20 08:30:02 UTC
* Number of recursive dependencies: 137

Run `revdepcheck::revdep_details(, "squat")` for more info

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
      > # * https://r-pkgs.org/tests.html
    ...
      * Run `testthat::snapshot_review('qts-prcomp/')` to review changes
      Backtrace:
          ▆
       1. └─vdiffr::expect_doppelganger(...) at test-qts-prcomp.R:25:3
       2.   ├─base::withCallingHandlers(...)
       3.   └─testthat::expect_snapshot_file(...)
      
      [ FAIL 1 | WARN 0 | SKIP 0 | PASS 79 ]
      Error: Test failures
      Execution halted
    ```

# sRACIPE

<details>

* Version: 2.0.1
* GitHub: https://github.com/lusystemsbio/sRACIPE
* Source code: https://github.com/cran/sRACIPE
* Date/Publication: 2025-05-11
* Number of recursive dependencies: 105

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

# stacks

<details>

* Version: 1.1.1
* GitHub: https://github.com/tidymodels/stacks
* Source code: https://github.com/cran/stacks
* Date/Publication: 2025-05-27 20:00:02 UTC
* Number of recursive dependencies: 136

Run `revdepcheck::revdep_details(, "stacks")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
      ── Error ('test-blend_predictions.R:8:5'): (code run outside of `test_that()`) ──
      Error in `readChar(con, 5L, useBytes = TRUE)`: cannot open the connection
      Backtrace:
          ▆
       1. └─base::load(test_path("helper_data.Rda")) at test-blend_predictions.R:8:5
       2.   └─base::readChar(con, 5L, useBytes = TRUE)
    ...
      ── Error ('test-utils.R:8:5'): (code run outside of `test_that()`) ─────────────
      Error in `readChar(con, 5L, useBytes = TRUE)`: cannot open the connection
      Backtrace:
          ▆
       1. └─base::load(test_path("helper_data.Rda")) at test-utils.R:8:5
       2.   └─base::readChar(con, 5L, useBytes = TRUE)
      
      [ FAIL 9 | WARN 9 | SKIP 0 | PASS 6 ]
      Error: Test failures
      Execution halted
    ```

# stars

<details>

* Version: 0.6-8
* GitHub: https://github.com/r-spatial/stars
* Source code: https://github.com/cran/stars
* Date/Publication: 2025-02-01 18:50:02 UTC
* Number of recursive dependencies: 161

Run `revdepcheck::revdep_details(, "stars")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘aggregate.R’
      Comparing ‘aggregate.Rout’ to ‘aggregate.Rout.save’ ... OK
      Running ‘align.R’
      Comparing ‘align.Rout’ to ‘align.Rout.save’ ... OK
      Running ‘area.R’
      Comparing ‘area.Rout’ to ‘area.Rout.save’ ... OK
      Running ‘crop.R’
      Comparing ‘crop.Rout’ to ‘crop.Rout.save’ ... OK
      Running ‘curvilinear.R’
      Comparing ‘curvilinear.Rout’ to ‘curvilinear.Rout.save’ ... OK
    ...
      > 
      > s = st_set_dimensions(s, st_dimensions(s), xy = NULL) 
      > sfc = st_sfc(st_point(0:1), st_point(3:2))
      > s = st_set_dimensions(s, 1, sfc) |> st_set_crs(4326)
      > tm = as.POSIXct("2023-03-04 12:35") + c(0, 3600)
      > s = st_set_dimensions(s, 2, tm)
      > f = tempfile(fileext = ".nc")
      > write_mdim(s, f, as_float = FALSE)
      Error: requires GDAL >= 3.1.0 and 64-bit
      Execution halted
    ```

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
* Number of recursive dependencies: 128

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
* Number of recursive dependencies: 113

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

* Version: 3.16.0
* GitHub: NA
* Source code: https://github.com/cran/synergyfinder
* Date/Publication: 2025-04-15
* Number of recursive dependencies: 196

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

* Version: 0.5
* GitHub: https://github.com/kkholst/targeted
* Source code: https://github.com/cran/targeted
* Date/Publication: 2024-02-22 10:00:21 UTC
* Number of recursive dependencies: 90

Run `revdepcheck::revdep_details(, "targeted")` for more info

</details>

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
      Missing dependency on R >= 4.1.0 because package code uses the pipe
      |> or function shorthand \(...) syntax added in R 4.1.0.
      File(s) using such syntax:
        ‘alean.Rd’ ‘nondom.Rd’
    ```

# text

<details>

* Version: 1.6
* GitHub: https://github.com/OscarKjell/text
* Source code: https://github.com/cran/text
* Date/Publication: 2025-07-22 14:31:56 UTC
* Number of recursive dependencies: 195

Run `revdepcheck::revdep_details(, "text")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
       3.     └─reticulate::py_run_file(file, local = FALSE, convert = convert)
       4.       └─reticulate:::py_run_file_impl(file, local, convert)
      ── Error ('test_5_Tasks.R:266:3'): textTranslate test ──────────────────────────
      <python.builtin.ModuleNotFoundError/python.builtin.ImportError/python.builtin.Exception/python.builtin.BaseException/python.builtin.object/error/condition>
      Error in `py_run_file_impl(file, local, convert)`: ModuleNotFoundError: No module named 'transformers'
      Run `reticulate::py_last_error()` for details.
    ...
       3.     └─reticulate::py_run_file(file, local = FALSE, convert = convert)
       4.       └─reticulate:::py_run_file_impl(file, local, convert)
      
      [ FAIL 46 | WARN 528 | SKIP 3 | PASS 205 ]
      Deleting unused snapshots:
      • 2_9_textTrainExamples/examples-error-plot.svg
      • 2_9_textTrainExamples/examples-histogram-plot.svg
      • 2_9_textTrainExamples/examples-scatter-plot.svg
      Error: Test failures
      Execution halted
    ```

# tglkmeans

<details>

* Version: 0.5.5
* GitHub: https://github.com/tanaylab/tglkmeans
* Source code: https://github.com/cran/tglkmeans
* Date/Publication: 2024-05-15 08:40:02 UTC
* Number of recursive dependencies: 86

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

* Version: 0.0-7
* GitHub: NA
* Source code: https://github.com/cran/tramvs
* Date/Publication: 2025-01-31 10:10:02 UTC
* Number of recursive dependencies: 102

Run `revdepcheck::revdep_details(, "tramvs")` for more info

</details>

## In both

*   checking re-building of vignette outputs ... WARNING
    ```
    Error(s) in re-building vignettes:
      ...
    --- re-building ‘tramvs.Rnw’ using knitr
    Error: processing vignette 'tramvs.Rnw' failed with diagnostics:
    Running 'texi2dvi' on 'tramvs.tex' failed.
    LaTeX errors:
    ! LaTeX Error: File `wrapfig.sty' not found.
    
    Type X to quit or <RETURN> to proceed,
    or enter new name. (Default extension: sty)
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

# TreeSearch

<details>

* Version: 1.6.1
* GitHub: https://github.com/ms609/TreeSearch
* Source code: https://github.com/cran/TreeSearch
* Date/Publication: 2025-06-10 12:40:10 UTC
* Number of recursive dependencies: 123

Run `revdepcheck::revdep_details(, "TreeSearch")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘spelling.R’
      Comparing ‘spelling.Rout’ to ‘spelling.Rout.save’ ... OK
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Complete output:
      > library("testthat")
      > library("TreeSearch")
      > 
      > test_check("TreeSearch")
    ...
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Failure ('test-CustomSearch.R:32:3'): Tree can be found ─────────────────────
      all.equal(...) is not TRUE
      
      `actual`:   FALSE
      `expected`: TRUE 
      
      [ FAIL 1 | WARN 0 | SKIP 0 | PASS 7379 ]
      Error: Test failures
      Execution halted
    ```

# TriDimRegression

<details>

* Version: 1.0.2
* GitHub: https://github.com/alexander-pastukhov/tridim-regression
* Source code: https://github.com/cran/TriDimRegression
* Date/Publication: 2023-09-13 14:10:03 UTC
* Number of recursive dependencies: 95

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
** this is package ‘TriDimRegression’ version ‘1.0.2’
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
** this is package ‘TriDimRegression’ version ‘1.0.2’
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
      ...
    --- re-building ‘estimation_demo.Rmd’ using rmarkdown
    --- finished re-building ‘estimation_demo.Rmd’
    
    --- re-building ‘location_scale_distributions.Rmd’ using rmarkdown
    ! Undefined control sequence.
    l.56 \NewDocumentCommand
                            \citeproctext{}{} 
    
    ...
    --- finished re-building ‘profile_demo.Rmd’
    
    --- re-building ‘spd_demo.Rmd’ using rmarkdown
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
* Number of recursive dependencies: 94

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
* Number of recursive dependencies: 147

Run `revdepcheck::revdep_details(, "tsmarch")` for more info

</details>

## In both

*   checking re-building of vignette outputs ... ERROR
    ```
    Error(s) in re-building vignettes:
      ...
    --- re-building ‘feasible_multivariate_garch.Rmd’ using rmarkdown
    ! Undefined control sequence.
    l.97 \NewDocumentCommand
                            \citeproctext{}{} 
    
    Error: processing vignette 'feasible_multivariate_garch.Rmd' failed with diagnostics:
    LaTeX failed to compile /scratch/henrik/revdep/future/checks/tsmarch/new/tsmarch.Rcheck/vign_test/tsmarch/vignettes/feasible_multivariate_garch.tex. See https://yihui.org/tinytex/r/#debugging for debugging tips. See feasible_multivariate_garch.log for more info.
    --- failed re-building ‘feasible_multivariate_garch.Rmd’
    
    --- re-building ‘tsmarch_demo.Rmd’ using rmarkdown
    --- finished re-building ‘tsmarch_demo.Rmd’
    
    SUMMARY: processing the following file failed:
      ‘feasible_multivariate_garch.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# tune

<details>

* Version: 1.3.0
* GitHub: https://github.com/tidymodels/tune
* Source code: https://github.com/cran/tune
* Date/Publication: 2025-02-21 17:50:03 UTC
* Number of recursive dependencies: 133

Run `revdepcheck::revdep_details(, "tune")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘spelling.R’
      Comparing ‘spelling.Rout’ to ‘spelling.Rout.save’ ... OK
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
      old vs new
        Code
          int_res_1 <- int_pctl(lm_res, times = 500)
        Condition
    ...
      -   Warning:
      +   Warning in `rsample::int_pctl()`:
          Recommend at least 1000 non-missing bootstrap resamples for term `mae`.
      
      * Run `testthat::snapshot_accept('int_pctl')` to accept the change.
      * Run `testthat::snapshot_review('int_pctl')` to interactively review the change.
      
      [ FAIL 4 | WARN 4 | SKIP 15 | PASS 2246 ]
      Error: Test failures
      Execution halted
    ```

# txshift

<details>

* Version: 0.3.8
* GitHub: https://github.com/nhejazi/txshift
* Source code: https://github.com/cran/txshift
* Date/Publication: 2022-02-09 22:30:02 UTC
* Number of recursive dependencies: 110

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
* Number of recursive dependencies: 107

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
    --- finished re-building ‘BigDataSA.Rmd’
    
    --- re-building ‘ClusterExternalValidSA.Rmd’ using rmarkdown
    --- finished re-building ‘ClusterExternalValidSA.Rmd’
    
    --- re-building ‘ClusterValidSA.Rmd’ using rmarkdown
    --- finished re-building ‘ClusterValidSA.Rmd’
    
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

# whitewater

<details>

* Version: 0.1.3
* GitHub: https://github.com/joshualerickson/whitewater
* Source code: https://github.com/cran/whitewater
* Date/Publication: 2023-04-01 18:00:02 UTC
* Number of recursive dependencies: 126

Run `revdepcheck::revdep_details(, "whitewater")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
       26. │             └─rlang::eval_tidy(xs[[j]], mask)
       27. ├─readNWISsite(site_no) %>% select(dec_long_va) %>% ...
       28. ├─dplyr::select(., dec_long_va)
       29. └─dataRetrieval::readNWISsite(site_no)
       30.   └─base::.Deprecated(...)
      ── Warning ('test-usgs.R:314:3'): usgs peaks ───────────────────────────────────
    ...
      Error in `class(data) <- "data.frame"`: attempt to set an attribute on NULL
      Backtrace:
          ▆
       1. ├─whitewater:::ww_reportUSGSdv(yaak_dv, days = 11) at test-usgs.R:28:1
       2. │ └─... %>% dt_to_tibble()
       3. └─whitewater:::dt_to_tibble(.)
      
      [ FAIL 1 | WARN 59 | SKIP 0 | PASS 41 ]
      Error: Test failures
      Execution halted
    ```

# wingen

<details>

* Version: 2.1.2
* GitHub: https://github.com/AnushaPB/wingen
* Source code: https://github.com/cran/wingen
* Date/Publication: 2024-05-16 23:00:02 UTC
* Number of recursive dependencies: 174

Run `revdepcheck::revdep_details(, "wingen")` for more info

</details>

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
      Missing dependency on R >= 4.1.0 because package code uses the pipe
      |> or function shorthand \(...) syntax added in R 4.1.0.
      File(s) using such syntax:
        ‘general_gd.R’ ‘plot_gd.R’ ‘window_gd.R’
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
* Number of recursive dependencies: 107

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
gcc -std=gnu2x -I"/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/include" -DNDEBUG -Dlibcaf_core_shared_EXPORTS -I../src -I../src -I'/scratch/henrik/revdep/future/library/XNAString/Rcpp/include' -I/usr/local/include    -fpic  -g -O2  -c ViennaRNA/utils/cpu.c -o ViennaRNA/utils/cpu.o
gcc -std=gnu2x -I"/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/include" -DNDEBUG -Dlibcaf_core_shared_EXPORTS -I../src -I../src -I'/scratch/henrik/revdep/future/library/XNAString/Rcpp/include' -I/usr/local/include    -fpic  -g -O2  -c ViennaRNA/utils/msa_utils.c -o ViennaRNA/utils/msa_utils.o
gcc -std=gnu2x -I"/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/include" -DNDEBUG -Dlibcaf_core_shared_EXPORTS -I../src -I../src -I'/scratch/henrik/revdep/future/library/XNAString/Rcpp/include' -I/usr/local/include    -fpic  -g -O2  -c ViennaRNA/utils/structure_tree.c -o ViennaRNA/utils/structure_tree.o
gcc -std=gnu2x -I"/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/include" -DNDEBUG -Dlibcaf_core_shared_EXPORTS -I../src -I../src -I'/scratch/henrik/revdep/future/library/XNAString/Rcpp/include' -I/usr/local/include    -fpic  -g -O2  -c ViennaRNA/utils/higher_order_functions.c -o ViennaRNA/utils/higher_order_functions.o
...
      |      ^~~~~~~~
ViennaRNA/datastructures/lists.c:284:1: error: conflicting types for ‘lst_mergesort’; have ‘void(LIST *, int (*)(void *, void *))’
  284 | lst_mergesort (LIST * l, int (*cmp_func) (void *, void *))
      | ^~~~~~~~~~~~~
../src/ViennaRNA/datastructures/lists.h:63:6: note: previous declaration of ‘lst_mergesort’ with type ‘void(LIST *, int (*)(void))’
   63 | void lst_mergesort (LIST * l, int (*cmp_func) ());
      |      ^~~~~~~~~~~~~
make: *** [/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/etc/Makeconf:202: ViennaRNA/datastructures/lists.o] Error 1
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
gcc -std=gnu2x -I"/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/include" -DNDEBUG -Dlibcaf_core_shared_EXPORTS -I../src -I../src -I'/scratch/henrik/revdep/future/library/XNAString/Rcpp/include' -I/usr/local/include    -fpic  -g -O2  -c ViennaRNA/utils/cpu.c -o ViennaRNA/utils/cpu.o
gcc -std=gnu2x -I"/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/include" -DNDEBUG -Dlibcaf_core_shared_EXPORTS -I../src -I../src -I'/scratch/henrik/revdep/future/library/XNAString/Rcpp/include' -I/usr/local/include    -fpic  -g -O2  -c ViennaRNA/utils/msa_utils.c -o ViennaRNA/utils/msa_utils.o
gcc -std=gnu2x -I"/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/include" -DNDEBUG -Dlibcaf_core_shared_EXPORTS -I../src -I../src -I'/scratch/henrik/revdep/future/library/XNAString/Rcpp/include' -I/usr/local/include    -fpic  -g -O2  -c ViennaRNA/utils/structure_tree.c -o ViennaRNA/utils/structure_tree.o
gcc -std=gnu2x -I"/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/include" -DNDEBUG -Dlibcaf_core_shared_EXPORTS -I../src -I../src -I'/scratch/henrik/revdep/future/library/XNAString/Rcpp/include' -I/usr/local/include    -fpic  -g -O2  -c ViennaRNA/utils/higher_order_functions.c -o ViennaRNA/utils/higher_order_functions.o
...
      |      ^~~~~~~~
ViennaRNA/datastructures/lists.c:284:1: error: conflicting types for ‘lst_mergesort’; have ‘void(LIST *, int (*)(void *, void *))’
  284 | lst_mergesort (LIST * l, int (*cmp_func) (void *, void *))
      | ^~~~~~~~~~~~~
../src/ViennaRNA/datastructures/lists.h:63:6: note: previous declaration of ‘lst_mergesort’ with type ‘void(LIST *, int (*)(void))’
   63 | void lst_mergesort (LIST * l, int (*cmp_func) ());
      |      ^~~~~~~~~~~~~
make: *** [/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/etc/Makeconf:202: ViennaRNA/datastructures/lists.o] Error 1
ERROR: compilation failed for package ‘XNAString’
* removing ‘/scratch/henrik/revdep/future/checks/XNAString/old/XNAString.Rcheck/XNAString’


```
