# adestr

<details>

* Version: 1.0.0
* GitHub: NA
* Source code: https://github.com/cran/adestr
* Date/Publication: 2024-07-12 13:50:09 UTC
* Number of recursive dependencies: 122

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

# AgePopDenom

<details>

* Version: 0.4.0
* GitHub: NA
* Source code: https://github.com/cran/AgePopDenom
* Date/Publication: 2025-02-25 18:10:02 UTC
* Number of recursive dependencies: 138

Run `revdepcheck::revdep_details(, "AgePopDenom")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘terra’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# AICcPermanova

<details>

* Version: 0.0.2
* GitHub: https://github.com/Sustainscapes/AICcPerm
* Source code: https://github.com/cran/AICcPermanova
* Date/Publication: 2023-04-11 13:40:06 UTC
* Number of recursive dependencies: 101

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
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
        5. │     │ └─base::withCallingHandlers(...)
        6. │     └─rlang::eval_bare(quo_get_expr(.quo), quo_get_env(.quo))
        7. └─altdoc::render_docs(path = getwd())
        8.   └─altdoc:::.import_vignettes(...)
        9.     └─base::vapply(...)
    ...
       2.   └─altdoc:::.import_vignettes(...)
       3.     └─base::vapply(...)
       4.       └─altdoc (local) FUN(X[[i]], ...)
       5.         └─altdoc:::.render_one_vignette(...)
       6.           └─altdoc:::.qmd2md(origin, tar_dir, verbose = verbose, preamble = pre)
       7.             └─base::cat(out[[2]])
      
      [ FAIL 8 | WARN 0 | SKIP 8 | PASS 55 ]
      Error: Test failures
      Execution halted
    ```

# bamm

<details>

* Version: 0.5.0
* GitHub: https://github.com/luismurao/bamm
* Source code: https://github.com/cran/bamm
* Date/Publication: 2024-07-06 20:22:11 UTC
* Number of recursive dependencies: 101

Run `revdepcheck::revdep_details(, "bamm")` for more info

</details>

## In both

*   checking whether package ‘bamm’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/scratch/henrik/revdep/future/checks/bamm/new/bamm.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘bamm’ ...
** this is package ‘bamm’ version ‘0.5.0’
** package ‘bamm’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘g++ (GCC) 13.3.1 20240611 (Red Hat 13.3.1-2)’
g++ -std=gnu++17 -I"/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/bamm/Rcpp/include' -I'/scratch/henrik/revdep/future/library/bamm/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c RcppExports.cpp -o RcppExports.o
g++ -std=gnu++17 -I"/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/bamm/Rcpp/include' -I'/scratch/henrik/revdep/future/library/bamm/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c randomize_pams.cpp -o randomize_pams.o
g++ -std=gnu++17 -shared -L/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/lib -L/usr/local/lib64 -o bamm.so RcppExports.o randomize_pams.o -L/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/lib -lR
installing to /scratch/henrik/revdep/future/checks/bamm/new/bamm.Rcheck/00LOCK-bamm/00new/bamm/libs
** R
** inst
** byte-compile and prepare package for lazy loading
Error in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]) : 
  there is no package called ‘terra’
Calls: <Anonymous> ... loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
Execution halted
ERROR: lazy loading failed for package ‘bamm’
* removing ‘/scratch/henrik/revdep/future/checks/bamm/new/bamm.Rcheck/bamm’


```
### CRAN

```
* installing *source* package ‘bamm’ ...
** this is package ‘bamm’ version ‘0.5.0’
** package ‘bamm’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘g++ (GCC) 13.3.1 20240611 (Red Hat 13.3.1-2)’
g++ -std=gnu++17 -I"/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/bamm/Rcpp/include' -I'/scratch/henrik/revdep/future/library/bamm/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c RcppExports.cpp -o RcppExports.o
g++ -std=gnu++17 -I"/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/bamm/Rcpp/include' -I'/scratch/henrik/revdep/future/library/bamm/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c randomize_pams.cpp -o randomize_pams.o
g++ -std=gnu++17 -shared -L/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/lib -L/usr/local/lib64 -o bamm.so RcppExports.o randomize_pams.o -L/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/lib -lR
installing to /scratch/henrik/revdep/future/checks/bamm/old/bamm.Rcheck/00LOCK-bamm/00new/bamm/libs
** R
** inst
** byte-compile and prepare package for lazy loading
Error in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]) : 
  there is no package called ‘terra’
Calls: <Anonymous> ... loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
Execution halted
ERROR: lazy loading failed for package ‘bamm’
* removing ‘/scratch/henrik/revdep/future/checks/bamm/old/bamm.Rcheck/bamm’


```
# baseballr

<details>

* Version: 1.6.0
* GitHub: https://github.com/BillPetti/baseballr
* Source code: https://github.com/cran/baseballr
* Date/Publication: 2024-01-16 12:50:02 UTC
* Number of recursive dependencies: 118

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

# batchtools

<details>

* Version: 0.9.17
* GitHub: https://github.com/mllg/batchtools
* Source code: https://github.com/cran/batchtools
* Date/Publication: 2023-04-20 14:20:06 UTC
* Number of recursive dependencies: 81

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
* Number of recursive dependencies: 163

Run `revdepcheck::revdep_details(, "bayesmove")` for more info

</details>

## In both

*   checking Rd files ... NOTE
    ```
    checkRd: (-1) insert_NAs.Rd:22: Lost braces; missing escapes or markup?
        22 | A data frame where new rows have been inserted to regularize the \code{date} column. This results in values provided for \code{id}, \code{date}, and {dt} while inserting NAs for all other columns. Additionally, observations with duplicate date-times are removed.
           |                                                                                                                                                      ^
    ```

# bolasso

<details>

* Version: 0.3.0
* GitHub: https://github.com/dmolitor/bolasso
* Source code: https://github.com/cran/bolasso
* Date/Publication: 2024-12-08 22:20:12 UTC
* Number of recursive dependencies: 70

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
* Number of recursive dependencies: 206

Run `revdepcheck::revdep_details(, "brms")` for more info

</details>

## In both

*   checking whether package ‘brms’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: namespace ‘colorspace’ is not available and has been replaced
    See ‘/scratch/henrik/revdep/future/checks/brms/new/brms.Rcheck/00install.out’ for details.
    ```

# canaper

<details>

* Version: 1.0.1
* GitHub: https://github.com/ropensci/canaper
* Source code: https://github.com/cran/canaper
* Date/Publication: 2023-05-04 23:00:06 UTC
* Number of recursive dependencies: 151

Run `revdepcheck::revdep_details(, "canaper")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 50 lines of output:
        8.       └─base::withRestarts(stop(cond), retry_loadNamespace = function() NULL)
        9.         └─base (local) withOneRestart(expr, restarts[[1L]])
       10.           └─base (local) doWithOneRestart(return(expr), restart)
      ── Error ('test-get_ses.R:9:1'): (code run outside of `test_that()`) ───────────
      <purrr_error_indexed/rlang_error/error/condition>
      Error in `purrr::map(1:100, ~calc_biodiv_random(comm, phy, phy_alt, "curveball", 
    ...
        7.   └─base::loadNamespace(j <- i[[1L]], c(lib.loc, .libPaths()), versionCheck = vI[[j]])
        8.     ├─base::namespaceImport(...)
        9.     └─base::loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]])
       10.       └─base::withRestarts(stop(cond), retry_loadNamespace = function() NULL)
       11.         └─base (local) withOneRestart(expr, restarts[[1L]])
       12.           └─base (local) doWithOneRestart(return(expr), restart)
      
      [ FAIL 9 | WARN 0 | SKIP 0 | PASS 99 ]
      Error: Test failures
      Execution halted
    ```

# ceRNAnetsim

<details>

* Version: 1.20.0
* GitHub: https://github.com/selcenari/ceRNAnetsim
* Source code: https://github.com/cran/ceRNAnetsim
* Date/Publication: 2025-04-15
* Number of recursive dependencies: 97

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

# chevreulShiny

<details>

* Version: 1.0.0
* GitHub: https://github.com/cobriniklab/chevreulShiny
* Source code: https://github.com/cran/chevreulShiny
* Date/Publication: 2025-04-15
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

* Version: 1.17.0
* GitHub: https://github.com/vallotlab/ChromSCape
* Source code: https://github.com/cran/ChromSCape
* Date/Publication: 2024-10-29
* Number of recursive dependencies: 229

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
    ...
      4. │   └─tibble:::`[.tbl_df`(msigdbr::msigdbr("Homo sapiens"), , columns)
      5. │     └─tibble:::vectbl_as_col_location(...)
      6. │       ├─tibble:::subclass_col_index_errors(...)
      7. │       │ └─base::withCallingHandlers(...)
      8. │       └─vctrs::vec_as_location(j, n, names, missing = "error", call = call)
      9. └─vctrs (local) `<fn>`()
     10.   └─vctrs:::stop_subscript_oob(...)
     11.     └─vctrs:::stop_subscript(...)
     12.       └─rlang::abort(...)
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
* Number of recursive dependencies: 86

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
* Number of recursive dependencies: 109

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
* Number of recursive dependencies: 74

Run `revdepcheck::revdep_details(, "CSGo")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘extrafont’ ‘future’
      All declared Imports should be used.
    ```

# dartR.popgen

<details>

* Version: 1.0.0
* GitHub: NA
* Source code: https://github.com/cran/dartR.popgen
* Date/Publication: 2024-06-27 23:20:04 UTC
* Number of recursive dependencies: 174

Run `revdepcheck::revdep_details(, "dartR.popgen")` for more info

</details>

## In both

*   checking whether package ‘dartR.popgen’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/scratch/henrik/revdep/future/checks/dartR.popgen/new/dartR.popgen.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘dartR.popgen’ ...
** this is package ‘dartR.popgen’ version ‘1.0.0’
** package ‘dartR.popgen’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** inst
** byte-compile and prepare package for lazy loading
Error: package or namespace load failed for ‘dartR.base’ in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]):
 there is no package called ‘terra’
Execution halted
ERROR: lazy loading failed for package ‘dartR.popgen’
* removing ‘/scratch/henrik/revdep/future/checks/dartR.popgen/new/dartR.popgen.Rcheck/dartR.popgen’


```
### CRAN

```
* installing *source* package ‘dartR.popgen’ ...
** this is package ‘dartR.popgen’ version ‘1.0.0’
** package ‘dartR.popgen’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** inst
** byte-compile and prepare package for lazy loading
Error: package or namespace load failed for ‘dartR.base’ in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]):
 there is no package called ‘terra’
Execution halted
ERROR: lazy loading failed for package ‘dartR.popgen’
* removing ‘/scratch/henrik/revdep/future/checks/dartR.popgen/old/dartR.popgen.Rcheck/dartR.popgen’


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
      Found non-API calls to R: ‘CLOENV’, ‘ENCLOS’
    
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
* Number of recursive dependencies: 96

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

# EFAtools

<details>

* Version: 0.5.0
* GitHub: https://github.com/mdsteiner/EFAtools
* Source code: https://github.com/cran/EFAtools
* Date/Publication: 2025-05-23 21:12:02 UTC
* Number of recursive dependencies: 90

Run `revdepcheck::revdep_details(, "EFAtools")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘progress’
      All declared Imports should be used.
    ```

# elevatr

<details>

* Version: 0.99.0
* GitHub: https://github.com/jhollist/elevatr
* Source code: https://github.com/cran/elevatr
* Date/Publication: 2023-09-12 21:00:02 UTC
* Number of recursive dependencies: 78

Run `revdepcheck::revdep_details(, "elevatr")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘terra’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# envi

<details>

* Version: 1.0.0
* GitHub: https://github.com/lance-waller-lab/envi
* Source code: https://github.com/cran/envi
* Date/Publication: 2024-11-06 19:00:03 UTC
* Number of recursive dependencies: 151

Run `revdepcheck::revdep_details(, "envi")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘terra’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
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
* Number of recursive dependencies: 113

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
* Number of recursive dependencies: 124

Run `revdepcheck::revdep_details(, "fdacluster")` for more info

</details>

## In both

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
* Number of recursive dependencies: 67

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
* Number of recursive dependencies: 122

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

# forecastML

<details>

* Version: 0.9.0
* GitHub: https://github.com/nredell/forecastML
* Source code: https://github.com/cran/forecastML
* Date/Publication: 2020-05-07 15:10:17 UTC
* Number of recursive dependencies: 101

Run `revdepcheck::revdep_details(, "forecastML")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘dtplyr’
      All declared Imports should be used.
    ```

# GeDS

<details>

* Version: 0.3.1
* GitHub: https://github.com/emilioluissaenzguillen/GeDS
* Source code: https://github.com/cran/GeDS
* Date/Publication: 2025-04-22 07:30:06 UTC
* Number of recursive dependencies: 74

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
* Number of recursive dependencies: 209

Run `revdepcheck::revdep_details(, "geocmeans")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘terra’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# geohabnet

<details>

* Version: 2.2
* GitHub: https://github.com/GarrettLab/HabitatConnectivity
* Source code: https://github.com/cran/geohabnet
* Date/Publication: 2025-05-21 09:00:02 UTC
* Number of recursive dependencies: 139

Run `revdepcheck::revdep_details(, "geohabnet")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘terra’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
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
* Number of recursive dependencies: 67

Run `revdepcheck::revdep_details(, "googleTagManageR")` for more info

</details>

## In both

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
* Number of recursive dependencies: 94

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
* Number of recursive dependencies: 63

Run `revdepcheck::revdep_details(, "gsynth")` for more info

</details>

## In both

*   checking C++ specification ... NOTE
    ```
      Specified C++11: please drop specification unless essential
    ```

# gtfs2emis

<details>

* Version: 0.1.1
* GitHub: https://github.com/ipeaGIT/gtfs2emis
* Source code: https://github.com/cran/gtfs2emis
* Date/Publication: 2024-12-02 15:40:12 UTC
* Number of recursive dependencies: 92

Run `revdepcheck::revdep_details(, "gtfs2emis")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘terra’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# gtfs2gps

<details>

* Version: 2.1-2
* GitHub: https://github.com/ipeaGIT/gtfs2gps
* Source code: https://github.com/cran/gtfs2gps
* Date/Publication: 2024-10-08 07:00:06 UTC
* Number of recursive dependencies: 87

Run `revdepcheck::revdep_details(, "gtfs2gps")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘terra’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
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

# heterogen

<details>

* Version: 1.2.33
* GitHub: https://github.com/patauchi/heterogen
* Source code: https://github.com/cran/heterogen
* Date/Publication: 2023-08-17 07:42:33 UTC
* Number of recursive dependencies: 53

Run `revdepcheck::revdep_details(, "heterogen")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘terra’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# hwep

<details>

* Version: 2.0.2
* GitHub: https://github.com/dcgerard/hwep
* Source code: https://github.com/cran/hwep
* Date/Publication: 2023-05-16 17:40:02 UTC
* Number of recursive dependencies: 112

Run `revdepcheck::revdep_details(, "hwep")` for more info

</details>

## In both

*   checking Rd files ... NOTE
    ```
    checkRd: (-1) simgl.Rd:50: Lost braces; missing escapes or markup?
        50 | Uses the {updog} R package for simulating read counts and generating
           |          ^
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

# infercnv

<details>

* Version: 1.24.0
* GitHub: https://github.com/broadinstitute/inferCNV
* Source code: https://github.com/cran/infercnv
* Date/Publication: 2025-04-15
* Number of recursive dependencies: 201

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
* Number of recursive dependencies: 89

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

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘terra’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# ISAnalytics

<details>

* Version: 1.18.0
* GitHub: https://github.com/calabrialab/ISAnalytics
* Source code: https://github.com/cran/ISAnalytics
* Date/Publication: 2025-04-15
* Number of recursive dependencies: 176

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
* Number of recursive dependencies: 116

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

# JANE

<details>

* Version: 1.0.0
* GitHub: https://github.com/a1arakkal/JANE
* Source code: https://github.com/cran/JANE
* Date/Publication: 2025-03-22 18:00:02 UTC
* Number of recursive dependencies: 51

Run `revdepcheck::revdep_details(, "JANE")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘progress’
      All declared Imports should be used.
    ```

# JointAI

<details>

* Version: 1.0.6
* GitHub: https://github.com/nerler/JointAI
* Source code: https://github.com/cran/JointAI
* Date/Publication: 2024-04-02 18:25:00 UTC
* Number of recursive dependencies: 125

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
* Number of recursive dependencies: 50

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
* Number of recursive dependencies: 142

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
* Number of recursive dependencies: 131

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

# ldmppr

<details>

* Version: 1.0.4
* GitHub: https://github.com/lanedrew/ldmppr
* Source code: https://github.com/cran/ldmppr
* Date/Publication: 2025-02-24 21:00:02 UTC
* Number of recursive dependencies: 129

Run `revdepcheck::revdep_details(, "ldmppr")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘terra’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# ldsr

<details>

* Version: 0.0.2
* GitHub: https://github.com/ntthung/ldsr
* Source code: https://github.com/cran/ldsr
* Date/Publication: 2020-05-04 14:40:09 UTC
* Number of recursive dependencies: 74

Run `revdepcheck::revdep_details(, "ldsr")` for more info

</details>

## In both

*   checking C++ specification ... NOTE
    ```
      Specified C++11: please drop specification unless essential
    ```

# lidR

<details>

* Version: 4.2.1
* GitHub: https://github.com/r-lidar/lidR
* Source code: https://github.com/cran/lidR
* Date/Publication: 2025-06-02 10:20:02 UTC
* Number of recursive dependencies: 153

Run `revdepcheck::revdep_details(, "lidR")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘terra’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# MAI

<details>

* Version: 1.14.0
* GitHub: https://github.com/KechrisLab/MAI
* Source code: https://github.com/cran/MAI
* Date/Publication: 2025-04-15
* Number of recursive dependencies: 174

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

* Version: 1.6.3
* GitHub: https://github.com/malaria-atlas-project/malariaAtlas
* Source code: https://github.com/cran/malariaAtlas
* Date/Publication: 2024-08-26 08:20:02 UTC
* Number of recursive dependencies: 122

Run `revdepcheck::revdep_details(, "malariaAtlas")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘terra’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# mapme.biodiversity

<details>

* Version: 0.9.4
* GitHub: https://github.com/mapme-initiative/mapme.biodiversity
* Source code: https://github.com/cran/mapme.biodiversity
* Date/Publication: 2025-04-28 13:00:08 UTC
* Number of recursive dependencies: 104

Run `revdepcheck::revdep_details(, "mapme.biodiversity")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘terra’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# migraph

<details>

* Version: 1.4.5
* GitHub: https://github.com/stocnet/migraph
* Source code: https://github.com/cran/migraph
* Date/Publication: 2024-12-02 10:00:10 UTC
* Number of recursive dependencies: 96

Run `revdepcheck::revdep_details(, "migraph")` for more info

</details>

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
      Missing dependency on R >= 4.1.0 because package code uses the pipe
      |> or function shorthand \(...) syntax added in R 4.1.0.
      File(s) using such syntax:
        ‘model_tests.R’
    ```

# mikropml

<details>

* Version: 1.6.1
* GitHub: https://github.com/SchlossLab/mikropml
* Source code: https://github.com/cran/mikropml
* Date/Publication: 2023-08-21 15:10:05 UTC
* Number of recursive dependencies: 128

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
* Number of recursive dependencies: 219

Run `revdepcheck::revdep_details(, "MineICA")` for more info

</details>

## In both

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
    Error in { : task 3 failed - "Multiple cache results found.
    Please clear your cache by running biomartCacheClear()"
    
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
* Number of recursive dependencies: 151

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

# mlr3spatial

<details>

* Version: 0.5.0
* GitHub: https://github.com/mlr-org/mlr3spatial
* Source code: https://github.com/cran/mlr3spatial
* Date/Publication: 2024-03-09 13:00:02 UTC
* Number of recursive dependencies: 91

Run `revdepcheck::revdep_details(, "mlr3spatial")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘terra’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# momentuHMM

<details>

* Version: 1.5.5
* GitHub: https://github.com/bmcclintock/momentuHMM
* Source code: https://github.com/cran/momentuHMM
* Date/Publication: 2022-10-18 20:52:35 UTC
* Number of recursive dependencies: 150

Run `revdepcheck::revdep_details(, "momentuHMM")` for more info

</details>

## In both

*   checking whether package ‘momentuHMM’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/scratch/henrik/revdep/future/checks/momentuHMM/new/momentuHMM.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘momentuHMM’ ...
** this is package ‘momentuHMM’ version ‘1.5.5’
** package ‘momentuHMM’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C compiler: ‘gcc (GCC) 13.3.1 20240611 (Red Hat 13.3.1-2)’
using C++ compiler: ‘g++ (GCC) 13.3.1 20240611 (Red Hat 13.3.1-2)’
g++ -std=gnu++17 -I"/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/momentuHMM/Rcpp/include' -I'/scratch/henrik/revdep/future/library/momentuHMM/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c RcppExports.cpp -o RcppExports.o
g++ -std=gnu++17 -I"/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/momentuHMM/Rcpp/include' -I'/scratch/henrik/revdep/future/library/momentuHMM/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c XBloop.cpp -o XBloop.o
g++ -std=gnu++17 -I"/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/momentuHMM/Rcpp/include' -I'/scratch/henrik/revdep/future/library/momentuHMM/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c getDM.cpp -o getDM.o
...
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
Error in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]) : 
  there is no package called ‘terra’
Calls: <Anonymous> ... loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
Execution halted
ERROR: lazy loading failed for package ‘momentuHMM’
* removing ‘/scratch/henrik/revdep/future/checks/momentuHMM/new/momentuHMM.Rcheck/momentuHMM’


```
### CRAN

```
* installing *source* package ‘momentuHMM’ ...
** this is package ‘momentuHMM’ version ‘1.5.5’
** package ‘momentuHMM’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C compiler: ‘gcc (GCC) 13.3.1 20240611 (Red Hat 13.3.1-2)’
using C++ compiler: ‘g++ (GCC) 13.3.1 20240611 (Red Hat 13.3.1-2)’
g++ -std=gnu++17 -I"/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/momentuHMM/Rcpp/include' -I'/scratch/henrik/revdep/future/library/momentuHMM/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c RcppExports.cpp -o RcppExports.o
g++ -std=gnu++17 -I"/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/momentuHMM/Rcpp/include' -I'/scratch/henrik/revdep/future/library/momentuHMM/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c XBloop.cpp -o XBloop.o
g++ -std=gnu++17 -I"/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/momentuHMM/Rcpp/include' -I'/scratch/henrik/revdep/future/library/momentuHMM/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c getDM.cpp -o getDM.o
...
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
Error in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]) : 
  there is no package called ‘terra’
Calls: <Anonymous> ... loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
Execution halted
ERROR: lazy loading failed for package ‘momentuHMM’
* removing ‘/scratch/henrik/revdep/future/checks/momentuHMM/old/momentuHMM.Rcheck/momentuHMM’


```
# multitool

<details>

* Version: 0.1.4
* GitHub: https://github.com/ethan-young/multitool
* Source code: https://github.com/cran/multitool
* Date/Publication: 2024-02-08 17:40:02 UTC
* Number of recursive dependencies: 150

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
* Number of recursive dependencies: 136

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
* Number of recursive dependencies: 92

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

# PAMpal

<details>

* Version: 1.4.4
* GitHub: NA
* Source code: https://github.com/cran/PAMpal
* Date/Publication: 2025-03-04 00:20:02 UTC
* Number of recursive dependencies: 121

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

* Version: 0.11.3
* GitHub: NA
* Source code: https://github.com/cran/PAMscapes
* Date/Publication: 2025-04-02 20:30:05 UTC
* Number of recursive dependencies: 130

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
        zlib               anaconda/linux-64::zlib-1.2.13-h5eee18b_1 
      
      
      Preparing transaction: ...working... done
      Verifying transaction: ...working... done
      Executing transaction: ...working... done
    ...
            └─ tensorflow-base [2.10.0 eigen_py39h1969d1f_0|2.10.0 gpu_py39h6559e04_0|2.10.0 mkl_py39hb9daa73_0], which requires
               └─ python >=3.9,<3.10.0a0 , which conflicts with any installable versions previously reported.
      
      Error: one or more Python packages failed to install [error code 1]
      In addition: Warning messages:
      1: In check_forbidden_install("Python packages") :
        cannot install Python packages during R CMD check
      2: In check_forbidden_install("Conda Environments") :
        cannot install Conda Environments during R CMD check
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

# partR2

<details>

* Version: 0.9.2
* GitHub: https://github.com/mastoffel/partR2
* Source code: https://github.com/cran/partR2
* Date/Publication: 2024-03-04 13:20:02 UTC
* Number of recursive dependencies: 93

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

* Version: 1.4.3
* GitHub: https://github.com/progenetix/pgxRpi
* Source code: https://github.com/cran/pgxRpi
* Date/Publication: 2025-05-21
* Number of recursive dependencies: 157

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
* Number of recursive dependencies: 118

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

# phylospatial

<details>

* Version: 1.1.1
* GitHub: https://github.com/matthewkling/phylospatial
* Source code: https://github.com/cran/phylospatial
* Date/Publication: 2025-05-02 14:00:02 UTC
* Number of recursive dependencies: 173

Run `revdepcheck::revdep_details(, "phylospatial")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘terra’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# pliman

<details>

* Version: 3.0.0
* GitHub: https://github.com/NA/NA
* Source code: https://github.com/cran/pliman
* Date/Publication: 2024-11-06 10:30:02 UTC
* Number of recursive dependencies: 133

Run `revdepcheck::revdep_details(, "pliman")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘terra’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# powRICLPM

<details>

* Version: 0.2.1
* GitHub: https://github.com/JeroenDMulder/powRICLPM
* Source code: https://github.com/cran/powRICLPM
* Date/Publication: 2024-10-26 13:50:03 UTC
* Number of recursive dependencies: 72

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

* Version: 1.40.0
* GitHub: https://github.com/edyp-lab/Prostar
* Source code: https://github.com/cran/Prostar
* Date/Publication: 2025-04-15
* Number of recursive dependencies: 189

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
* Number of recursive dependencies: 101

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
* Number of recursive dependencies: 42

Run `revdepcheck::revdep_details(, "qape")` for more info

</details>

## In both

*   checking Rd files ... NOTE
    ```
    checkRd: (-1) srswrRe.Rd:10: Lost braces
        10 |   \item{listRanef}{{\emph{ranef(model)}} object where {\emph{model}} is an { \emph{lmer}} object.}
           |                                                                            ^
    ```

# QBMS

<details>

* Version: 1.5.0
* GitHub: https://github.com/icarda-git/QBMS
* Source code: https://github.com/cran/QBMS
* Date/Publication: 2024-09-18 12:40:02 UTC
* Number of recursive dependencies: 52

Run `revdepcheck::revdep_details(, "QBMS")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘terra’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
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

# rangeMapper

<details>

* Version: 2.0.3
* GitHub: https://github.com/mpio-be/rangeMapper
* Source code: https://github.com/cran/rangeMapper
* Date/Publication: 2022-10-03 22:20:02 UTC
* Number of recursive dependencies: 110

Run `revdepcheck::revdep_details(, "rangeMapper")` for more info

</details>

## In both

*   checking whether package ‘rangeMapper’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/scratch/henrik/revdep/future/checks/rangeMapper/new/rangeMapper.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘rangeMapper’ ...
** this is package ‘rangeMapper’ version ‘2.0.3’
** package ‘rangeMapper’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
Error in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]) : 
  there is no package called ‘terra’
Calls: <Anonymous> ... loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
Execution halted
ERROR: lazy loading failed for package ‘rangeMapper’
* removing ‘/scratch/henrik/revdep/future/checks/rangeMapper/new/rangeMapper.Rcheck/rangeMapper’


```
### CRAN

```
* installing *source* package ‘rangeMapper’ ...
** this is package ‘rangeMapper’ version ‘2.0.3’
** package ‘rangeMapper’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
Error in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]) : 
  there is no package called ‘terra’
Calls: <Anonymous> ... loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
Execution halted
ERROR: lazy loading failed for package ‘rangeMapper’
* removing ‘/scratch/henrik/revdep/future/checks/rangeMapper/old/rangeMapper.Rcheck/rangeMapper’


```
# rechaRge

<details>

* Version: 1.0.0
* GitHub: https://github.com/gwrecharge/rechaRge
* Source code: https://github.com/cran/rechaRge
* Date/Publication: 2024-05-14 08:20:02 UTC
* Number of recursive dependencies: 53

Run `revdepcheck::revdep_details(, "rechaRge")` for more info

</details>

## In both

*   checking whether package ‘rechaRge’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/scratch/henrik/revdep/future/checks/rechaRge/new/rechaRge.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘rechaRge’ ...
** this is package ‘rechaRge’ version ‘1.0.0’
** package ‘rechaRge’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** byte-compile and prepare package for lazy loading
Error in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]) : 
  there is no package called ‘terra’
Calls: <Anonymous> ... loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
Execution halted
ERROR: lazy loading failed for package ‘rechaRge’
* removing ‘/scratch/henrik/revdep/future/checks/rechaRge/new/rechaRge.Rcheck/rechaRge’


```
### CRAN

```
* installing *source* package ‘rechaRge’ ...
** this is package ‘rechaRge’ version ‘1.0.0’
** package ‘rechaRge’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** byte-compile and prepare package for lazy loading
Error in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]) : 
  there is no package called ‘terra’
Calls: <Anonymous> ... loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
Execution halted
ERROR: lazy loading failed for package ‘rechaRge’
* removing ‘/scratch/henrik/revdep/future/checks/rechaRge/old/rechaRge.Rcheck/rechaRge’


```
# regmedint

<details>

* Version: 1.0.1
* GitHub: https://github.com/kaz-yos/regmedint
* Source code: https://github.com/cran/regmedint
* Date/Publication: 2024-01-13 00:50:02 UTC
* Number of recursive dependencies: 154

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
* Number of recursive dependencies: 104

Run `revdepcheck::revdep_details(, "reproducible")` for more info

</details>

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘reproducible-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: gdalProject
    > ### Title: 3-Step postProcess sequence for SpatRasters using 'gdalwarp'
    > ### Aliases: gdalProject gdalResample gdalMask
    > 
    > ### ** Examples
    > 
    > # prepare dummy data -- 3 SpatRasters, 2 SpatVectors
    > # need 2 SpatRaster
    > rf <- system.file("ex/elev.tif", package = "terra")
    > elev1 <- terra::rast(rf)
    Error in loadNamespace(x) : there is no package called ‘terra’
    Calls: loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
    Execution halted
    ```

*   checking tests ...
    ```
      Running ‘test-all.R’
     ERROR
    Running the tests in ‘tests/test-all.R’ failed.
    Last 50 lines of output:
        'test-preProcessWorks.R:270:3', 'test-preProcessWorks.R:286:3',
        'test-preProcessWorks.R:302:3', 'test-preProcessWorks.R:315:3',
        'test-preProcessWorks.R:328:3', 'test-preProcessWorks.R:348:3',
        'test-preProcessWorks.R:361:3', 'test-preProcessWorks.R:374:3',
        'test-preProcessWorks.R:391:3', 'test-preProcessWorks.R:409:3',
        'test-preProcessWorks.R:438:3', 'test-preProcessWorks.R:459:3',
    ...
      ── Error ('test-cache.R:1310:5'): test cache with new approach to match.call ───
      Error in `st_make_valid.sfc(p1)`: package lwgeom required, please install it first
      Backtrace:
          ▆
       1. ├─sf::st_make_valid(p1)
       2. └─sf:::st_make_valid.sfc(p1)
      
      [ FAIL 1 | WARN 0 | SKIP 114 | PASS 185 ]
      Error: Test failures
      Execution halted
    ```

# rgee

<details>

* Version: 1.1.7
* GitHub: https://github.com/r-spatial/rgee
* Source code: https://github.com/cran/rgee
* Date/Publication: 2023-09-27 08:30:02 UTC
* Number of recursive dependencies: 133

Run `revdepcheck::revdep_details(, "rgee")` for more info

</details>

## In both

*   checking whether package ‘rgee’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/scratch/henrik/revdep/future/checks/rgee/new/rgee.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘rgee’ ...
** this is package ‘rgee’ version ‘1.1.7’
** package ‘rgee’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** inst
** byte-compile and prepare package for lazy loading
Error in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]) : 
  there is no package called ‘terra’
Error: unable to load R code in package ‘rgee’
Execution halted
ERROR: lazy loading failed for package ‘rgee’
* removing ‘/scratch/henrik/revdep/future/checks/rgee/new/rgee.Rcheck/rgee’


```
### CRAN

```
* installing *source* package ‘rgee’ ...
** this is package ‘rgee’ version ‘1.1.7’
** package ‘rgee’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** inst
** byte-compile and prepare package for lazy loading
Error in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]) : 
  there is no package called ‘terra’
Error: unable to load R code in package ‘rgee’
Execution halted
ERROR: lazy loading failed for package ‘rgee’
* removing ‘/scratch/henrik/revdep/future/checks/rgee/old/rgee.Rcheck/rgee’


```
# rsi

<details>

* Version: 0.3.2
* GitHub: https://github.com/Permian-Global-Research/rsi
* Source code: https://github.com/cran/rsi
* Date/Publication: 2025-01-22 03:20:02 UTC
* Number of recursive dependencies: 76

Run `revdepcheck::revdep_details(, "rsi")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘terra’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# SCArray.sat

<details>

* Version: 1.8.0
* GitHub: https://github.com/AbbVie-ComputationalGenomics/SCArray
* Source code: https://github.com/cran/SCArray.sat
* Date/Publication: 2025-04-15
* Number of recursive dependencies: 180

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

# sigminer

<details>

* Version: 2.3.1
* GitHub: https://github.com/ShixiangWang/sigminer
* Source code: https://github.com/cran/sigminer
* Date/Publication: 2024-05-11 08:50:02 UTC
* Number of recursive dependencies: 212

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
* Number of recursive dependencies: 236

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

# simtrial

<details>

* Version: 0.4.2
* GitHub: https://github.com/Merck/simtrial
* Source code: https://github.com/cran/simtrial
* Date/Publication: 2024-11-18 15:10:02 UTC
* Number of recursive dependencies: 113

Run `revdepcheck::revdep_details(, "simtrial")` for more info

</details>

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘gsDesign2’
      All declared Imports should be used.
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
* Number of recursive dependencies: 129

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

* Version: 2.1.0
* GitHub: https://github.com/PredictiveEcology/SpaDES.core
* Source code: https://github.com/cran/SpaDES.core
* Date/Publication: 2024-06-02 11:02:47 UTC
* Number of recursive dependencies: 133

Run `revdepcheck::revdep_details(, "SpaDES.core")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘terra’
    
    Package suggested but not available for checking: ‘NLMR’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# spaMM

<details>

* Version: 4.5.0
* GitHub: NA
* Source code: https://github.com/cran/spaMM
* Date/Publication: 2024-06-09 22:20:02 UTC
* Number of recursive dependencies: 88

Run `revdepcheck::revdep_details(, "spaMM")` for more info

</details>

## In both

*   checking compiled code ... NOTE
    ```
    File ‘spaMM/libs/spaMM.so’:
      Found non-API call to R: ‘PRVALUE’
    
    Compiled code should not call non-API entry points in R.
    
    See ‘Writing portable packages’ in the ‘Writing R Extensions’ manual,
    and section ‘Moving into C API compliance’ for issues with the use of
    non-API entry points.
    ```

# sparrpowR

<details>

* Version: 0.2.8
* GitHub: https://github.com/machiela-lab/sparrpowR
* Source code: https://github.com/cran/sparrpowR
* Date/Publication: 2024-01-23 15:20:02 UTC
* Number of recursive dependencies: 128

Run `revdepcheck::revdep_details(, "sparrpowR")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘terra’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# SPARSEMODr

<details>

* Version: 1.2.0
* GitHub: https://github.com/NAU-CCL/SPARSEMODr
* Source code: https://github.com/cran/SPARSEMODr
* Date/Publication: 2022-07-19 20:50:02 UTC
* Number of recursive dependencies: 124

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
* Number of recursive dependencies: 60

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
* Number of recursive dependencies: 73

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

# spNetwork

<details>

* Version: 0.4.4.6
* GitHub: https://github.com/JeremyGelb/spNetwork
* Source code: https://github.com/cran/spNetwork
* Date/Publication: 2025-03-29 16:00:02 UTC
* Number of recursive dependencies: 155

Run `revdepcheck::revdep_details(, "spNetwork")` for more info

</details>

## In both

*   checking re-building of vignette outputs ... ERROR
    ```
    Error(s) in re-building vignettes:
    --- re-building ‘KNetworkFunctions.Rmd’ using rmarkdown
    
    Quitting from KNetworkFunctions.Rmd:63-77 [unnamed-chunk-2]
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    <error/rlang_error>
    Error:
    ! package or namespace load failed for 'tmap' in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]):
     there is no package called 'terra'
    ---
    ...
    Error: processing vignette 'TNKDE.Rmd' failed with diagnostics:
    package or namespace load failed for 'tmap' in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]):
     there is no package called 'terra'
    --- failed re-building ‘TNKDE.Rmd’
    
    SUMMARY: processing the following files failed:
      ‘KNetworkFunctions.Rmd’ ‘NKDE.Rmd’ ‘NetworkBuilding.Rmd’ ‘TNKDE.Rmd’
    
    Error: Vignette re-building failed.
    Execution halted
    ```

# sRACIPE

<details>

* Version: 2.0.1
* GitHub: https://github.com/lusystemsbio/sRACIPE
* Source code: https://github.com/cran/sRACIPE
* Date/Publication: 2025-05-11
* Number of recursive dependencies: 106

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
* Number of recursive dependencies: 163

Run `revdepcheck::revdep_details(, "stars")` for more info

</details>

## In both

*   checking tests ...
    ```
      Running ‘aggregate.R’
      Comparing ‘aggregate.Rout’ to ‘aggregate.Rout.save’ ...92,93c92,108
    < Error: package or namespace load failed for 'raster' in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]):
    <  there is no package called 'terra'
    ---
    > stars object with 2 dimensions and 1 attribute
    > attribute(s):
    >     Min. 1st Qu. Median  Mean 3rd Qu. Max.
    > A1    28  194.25  360.5 360.5  526.75  693
    > dimension(s):
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

# steps

<details>

* Version: 1.3.0
* GitHub: https://github.com/steps-dev/steps
* Source code: https://github.com/cran/steps
* Date/Publication: 2022-10-04 23:30:02 UTC
* Number of recursive dependencies: 71

Run `revdepcheck::revdep_details(, "steps")` for more info

</details>

## In both

*   checking whether package ‘steps’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/scratch/henrik/revdep/future/checks/steps/new/steps.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘steps’ ...
** this is package ‘steps’ version ‘1.3.0’
** package ‘steps’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘g++ (GCC) 13.3.1 20240611 (Red Hat 13.3.1-2)’
g++ -std=gnu++17 -I"/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/steps/Rcpp/include' -I/usr/local/include    -fpic  -g -O2   -c RcppExports.cpp -o RcppExports.o
g++ -std=gnu++17 -I"/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/steps/Rcpp/include' -I/usr/local/include    -fpic  -g -O2   -c rcpp_dispersal_funs_v4.cpp -o rcpp_dispersal_funs_v4.o
g++ -std=gnu++17 -I"/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/steps/Rcpp/include' -I/usr/local/include    -fpic  -g -O2   -c rcpp_utils_funs.cpp -o rcpp_utils_funs.o
g++ -std=gnu++17 -shared -L/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/lib -L/usr/local/lib64 -o steps.so RcppExports.o rcpp_dispersal_funs_v4.o rcpp_utils_funs.o -L/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/lib -lR
...
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
Error in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]) : 
  there is no package called ‘terra’
Calls: <Anonymous> ... loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
Execution halted
ERROR: lazy loading failed for package ‘steps’
* removing ‘/scratch/henrik/revdep/future/checks/steps/new/steps.Rcheck/steps’


```
### CRAN

```
* installing *source* package ‘steps’ ...
** this is package ‘steps’ version ‘1.3.0’
** package ‘steps’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘g++ (GCC) 13.3.1 20240611 (Red Hat 13.3.1-2)’
g++ -std=gnu++17 -I"/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/steps/Rcpp/include' -I/usr/local/include    -fpic  -g -O2   -c RcppExports.cpp -o RcppExports.o
g++ -std=gnu++17 -I"/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/steps/Rcpp/include' -I/usr/local/include    -fpic  -g -O2   -c rcpp_dispersal_funs_v4.cpp -o rcpp_dispersal_funs_v4.o
g++ -std=gnu++17 -I"/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/steps/Rcpp/include' -I/usr/local/include    -fpic  -g -O2   -c rcpp_utils_funs.cpp -o rcpp_utils_funs.o
g++ -std=gnu++17 -shared -L/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/lib -L/usr/local/lib64 -o steps.so RcppExports.o rcpp_dispersal_funs_v4.o rcpp_utils_funs.o -L/software/c4/cbi/software/_rocky8/R-4.5.0-gcc13/lib64/R/lib -lR
...
** data
*** moving datasets to lazyload DB
** inst
** byte-compile and prepare package for lazy loading
Error in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]) : 
  there is no package called ‘terra’
Calls: <Anonymous> ... loadNamespace -> withRestarts -> withOneRestart -> doWithOneRestart
Execution halted
ERROR: lazy loading failed for package ‘steps’
* removing ‘/scratch/henrik/revdep/future/checks/steps/old/steps.Rcheck/steps’


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

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘terra’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# supercells

<details>

* Version: 1.0.0
* GitHub: https://github.com/Nowosad/supercells
* Source code: https://github.com/cran/supercells
* Date/Publication: 2024-02-11 14:20:02 UTC
* Number of recursive dependencies: 73

Run `revdepcheck::revdep_details(, "supercells")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘terra’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# survstan

<details>

* Version: 0.0.7.1
* GitHub: https://github.com/fndemarqui/survstan
* Source code: https://github.com/cran/survstan
* Date/Publication: 2024-04-12 16:50:02 UTC
* Number of recursive dependencies: 114

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
* Number of recursive dependencies: 197

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

# tenm

<details>

* Version: 0.5.1
* GitHub: https://github.com/luismurao/tenm
* Source code: https://github.com/cran/tenm
* Date/Publication: 2024-07-23 00:30:01 UTC
* Number of recursive dependencies: 78

Run `revdepcheck::revdep_details(, "tenm")` for more info

</details>

## In both

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘terra’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
    ```

# tglkmeans

<details>

* Version: 0.5.5
* GitHub: https://github.com/tanaylab/tglkmeans
* Source code: https://github.com/cran/tglkmeans
* Date/Publication: 2024-05-15 08:40:02 UTC
* Number of recursive dependencies: 87

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
* Number of recursive dependencies: 103

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

* Version: 1.0.2
* GitHub: https://github.com/alexander-pastukhov/tridim-regression
* Source code: https://github.com/cran/TriDimRegression
* Date/Publication: 2023-09-13 14:10:03 UTC
* Number of recursive dependencies: 96

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
* Number of recursive dependencies: 148

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

# txshift

<details>

* Version: 0.3.8
* GitHub: https://github.com/nhejazi/txshift
* Source code: https://github.com/cran/txshift
* Date/Publication: 2022-02-09 22:30:02 UTC
* Number of recursive dependencies: 109

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
* Number of recursive dependencies: 108

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

*   checking package dependencies ... ERROR
    ```
    Package required but not available: ‘terra’
    
    See section ‘The DESCRIPTION file’ in the ‘Writing R Extensions’
    manual.
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
