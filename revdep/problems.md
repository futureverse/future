# bamm (0.6.0)

* GitHub: <https://github.com/luismurao/bamm>
* Email: <mailto:luismurao@gmail.com>
* GitHub mirror: <https://github.com/cran/bamm>

Run `revdepcheck::revdep_details(, "bamm")` for more info

## In both

*   checking dependencies in R code ... NOTE
     ```
     Namespaces in Imports field not imported from:
       ‘crosstalk’ ‘plotly’
       All declared Imports should be used.
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

# bistablehistory (1.1.3)

* GitHub: <https://github.com/alexander-pastukhov/bistablehistory>
* Email: <mailto:pastukhov.alexander@gmail.com>
* GitHub mirror: <https://github.com/cran/bistablehistory>

Run `revdepcheck::revdep_details(, "bistablehistory")` for more info

## In both

*   checking tests ...
     ```
     ...
         1. ├─testthat::expect_s3_class(fixef(fit), "data.frame") at test-fit_and_post_fit_utilities.R:44:3
         2. │ └─testthat::quasi_label(enquo(object))
         3. │   └─rlang::eval_bare(expr, quo_get_env(quo))
         4. ├─bistablehistory::fixef(fit)
         5. │ └─... %>% ...
         6. ├─dplyr::mutate(...)
         7. ├─dplyr::mutate(...)
         8. ├─dplyr::mutate(., Estimate = c(bF))
         9. ├─dplyr::ungroup(.)
        10. ├─dplyr::summarise(...)
        11. ├─dplyr:::summarise.grouped_df(...)
        12. │ └─dplyr:::summarise_cols(.data, dplyr_quosures(...), by, "summarise")
        13. │   └─base::withCallingHandlers(...)
        14. ├─dplyr:::dplyr_internal_error(...)
        15. │ └─rlang::abort(class = c(class, "dplyr:::internal_error"), dplyr_error_data = data)
        16. │   └─rlang:::signal_abort(cnd, .file)
        17. │     └─base::signalCondition(cnd)
        18. └─dplyr (local) `<fn>`(`<dpl:::__>`)
        19.   └─dplyr (local) handler(cnd)
        20.     └─rlang::abort(message, class = error_class, parent = parent, call = error_call)
       
       [ FAIL 1 | WARN 1 | SKIP 0 | PASS 97 ]
       Error:
       ! Test failures.
       Execution halted
     ```

*   checking re-building of vignette outputs ... ERROR
     ```
     ...
      6. └─dplyr:::dplyr_internal_error(...)
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     
     Error: processing vignette 'cumulative-history.Rmd' failed with diagnostics:
     ℹ In argument: `t = t`.
     ℹ In group 1: `h0 = 0`, `S = 1`, `tau = 1`.
     Caused by error:
     ! `t` must be size 1, not 100.
     ℹ To return more or less than 1 row per group, use `reframe()`.
     --- failed re-building ‘cumulative-history.Rmd’
     
     --- re-building ‘usage-examples.Rmd’ using rmarkdown
     [WARNING] Deprecated: --highlight-style. Use --syntax-highlighting instead.
     [WARNING] Citeproc: citation loo not found
     --- finished re-building ‘usage-examples.Rmd’
     
     --- re-building ‘writing-stan-code.Rmd’ using rmarkdown
     [WARNING] Deprecated: --highlight-style. Use --syntax-highlighting instead.
     --- finished re-building ‘writing-stan-code.Rmd’
     
     SUMMARY: processing the following file failed:
       ‘cumulative-history.Rmd’
     
     Error: Vignette re-building failed.
     Execution halted
     ```

# ceRNAnetsim (1.22.0)

* GitHub: <https://github.com/selcenari/ceRNAnetsim>
* Email: <mailto:selcenarii@gmail.com>

Run `revdepcheck::revdep_details(, "ceRNAnetsim")` for more info

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

# Certara.RsNLME.ModelExecutor (3.0.2)

* Email: <mailto:james.craig@certara.com>
* GitHub mirror: <https://github.com/cran/Certara.RsNLME.ModelExecutor>

Run `revdepcheck::revdep_details(, "Certara.RsNLME.ModelExecutor")` for more info

## In both

*   checking R code for possible problems ... NOTE
     ```
     .run_shiny_RsNLME : server: no visible global function definition for
       ‘addTablesToColumnMapping’
     Undefined global functions or variables:
       addTablesToColumnMapping
     ```

# chevreulShiny (1.2.0)

* GitHub: <https://github.com/cobriniklab/chevreulShiny>
* Email: <mailto:kevin.stachelek@gmail.com>

Run `revdepcheck::revdep_details(, "chevreulShiny")` for more info

## In both

*   checking DESCRIPTION meta-information ... NOTE
     ```
     License stub is invalid DCF.
     ```

# ChromSCape (1.20.0)

* GitHub: <https://github.com/vallotlab/ChromSCape>
* Email: <mailto:pacome.pr@gmail.com>

Run `revdepcheck::revdep_details(, "ChromSCape")` for more info

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
     ...
       ‘genes’
     plot_percent_active_feature_scExp: no visible binding for global
       variable ‘group’
     plot_percent_active_feature_scExp: no visible binding for global
       variable ‘percent_active’
     plot_pie_most_contributing_chr: no visible binding for global variable
       ‘absolute_value’
     plot_reduced_dim_scExp: no visible binding for global variable ‘V1’
     plot_reduced_dim_scExp: no visible binding for global variable ‘V2’
     plot_reduced_dim_scExp: no visible binding for global variable
       ‘cluster’
     plot_top_TF_scExp: no visible binding for global variable ‘TF’
     rebin_helper: no visible binding for global variable ‘new_row’
     rebin_helper: no visible binding for global variable ‘origin_value’
     rebin_matrix: no visible binding for global variable ‘group’
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

# ClustIRR (1.8.0)

* GitHub: <https://github.com/snaketron/ClustIRR>
* Email: <mailto:simokitanovski@gmail.com>

Run `revdepcheck::revdep_details(, "ClustIRR")` for more info

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

# ctsem (3.10.6)

* GitHub: <https://github.com/cdriveraus/ctsem>
* Email: <mailto:charles.driver2@uzh.ch>
* GitHub mirror: <https://github.com/cran/ctsem>

Run `revdepcheck::revdep_details(, "ctsem")` for more info

## In both

*   checking whether package ‘ctsem’ can be installed ... WARNING
     ```
     Found the following significant warnings:
       Warning: namespace ‘colorspace’ is not available and has been replaced
     See ‘/scratch/henrik/revdep/future/checks/ctsem/new/ctsem.Rcheck/00install.out’ for details.
     ```

*   checking re-building of vignette outputs ... WARNING
     ```
     ...
       ...
     --- re-building ‘hierarchicalmanual.rnw’ using knitr_notangle
     Warning in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  :
       texi2dvi script/program not available, using emulation
     Error: processing vignette 'hierarchicalmanual.rnw' failed with diagnostics:
     unable to run pdflatex on 'hierarchicalmanual.tex'
     LaTeX errors:
     ! LaTeX Error: File `apacite.sty' not found.
     
     Type X to quit or <RETURN> to proceed,
     or enter new name. (Default extension: sty)
     
     ! Emergency stop.
     <read *> 
              
     l.62 \bibliographystyle
                            {apacite}     % Set bibliography style^^M
     !  ==> Fatal error occurred, no output PDF file produced!
     --- failed re-building ‘hierarchicalmanual.rnw’
     
     SUMMARY: processing the following file failed:
       ‘hierarchicalmanual.rnw’
     
     Error: Vignette re-building failed.
     Execution halted
     ```

# delimtools (0.2.1)

* GitHub: <https://github.com/legalLab/delimtools>
* Email: <mailto:pedro.sennabittencourt@gmail.com>
* GitHub mirror: <https://github.com/cran/delimtools>

Run `revdepcheck::revdep_details(, "delimtools")` for more info

## In both

*   checking examples ... ERROR
     ```
     ...
       2. │ ├─dplyr::ungroup(...)
       3. │ ├─dplyr::arrange(...)
       4. │ ├─dplyr::group_by(...)
       5. │ ├─purrr::list_rbind(...)
       6. │ │ └─purrr:::check_list_of_data_frames(x)
       7. │ │   └─vctrs::obj_check_list(x, call = error_call)
       8. │ ├─rlang::set_names(...)
       9. │ └─purrr::map(...)
      10. │   └─purrr:::map_("list", .x, .f, ..., .progress = .progress)
      11. │     ├─purrr:::with_indexed_errors(...)
      12. │     │ └─base::withCallingHandlers(...)
      13. │     ├─purrr:::call_with_cleanup(...)
      14. │     └─delimtools (local) .f(.x[[i]], ...)
      15. │       ├─dplyr::summarise(...)
      16. │       ├─dplyr::mutate(...)
      17. │       └─dplyr:::mutate.data.frame(...)
      18. │         └─dplyr:::mutate_cols(.data, dplyr_quosures(...), by)
      19. │           ├─base::withCallingHandlers(...)
      20. │           └─dplyr:::mutate_col(dots[[i]], data, mask, new_columns)
      21. │             └─mask$eval_all_mutate(quo)
      22. │               └─dplyr (local) eval()
      23. ├─dplyr::if_else(...)
      24. │ └─vctrs::vec_if_else(...)
      25. └─rlang::abort(message = message, call = call)
     Execution halted
     ```

# disk.frame (0.8.3)

* GitHub: <https://github.com/DiskFrame/disk.frame>
* Email: <mailto:zhuojia.dai@gmail.com>
* GitHub mirror: <https://github.com/cran/disk.frame>

Run `revdepcheck::revdep_details(, "disk.frame")` for more info

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

# EFAtools (0.6.1)

* GitHub: <https://github.com/mdsteiner/EFAtools>
* Email: <mailto:markus.d.steiner@gmail.com>
* GitHub mirror: <https://github.com/cran/EFAtools>

Run `revdepcheck::revdep_details(, "EFAtools")` for more info

## In both

*   checking dependencies in R code ... NOTE
     ```
     Namespace in Imports field not imported from: ‘progress’
       All declared Imports should be used.
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

# flowGraph (1.18.0)

* GitHub: <https://github.com/aya49/flowGraph>
* Email: <mailto:aya43@sfu.ca>

Run `revdepcheck::revdep_details(, "flowGraph")` for more info

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

# fmeffects (0.1.4)

* GitHub: <https://github.com/holgstr/fmeffects>
* Email: <mailto:hbj.loewe@gmail.com>
* GitHub mirror: <https://github.com/cran/fmeffects>

Run `revdepcheck::revdep_details(, "fmeffects")` for more info

## In both

*   checking re-building of vignette outputs ... ERROR
     ```
     ...
      50. │                   └─fmeffects (local) simpson(prediction.s, subintervals)
      51. │                     └─fmeffects (local) f(0/s + m)
      52. │                       └─predictor$predict(observation.t)
      53. │                         ├─data.table::as.data.table(self$model$predict_newdata(newdata))
      54. │                         └─self$model$predict_newdata(newdata)
      55. │                           └─mlr3:::.__Learner__predict_newdata(...)
      56. └─mlr3 (local) `<fn>`(base::quote(`<named list>`))
      57.   └─mlr3:::.__Task__col_roles(...)
      58.     └─checkmate::assert_names(names(rhs), "unique", permutation.of = mlr_reflections$task_col_roles[[self$task_type]])
      59.       └─checkmate::makeAssertion(x, res, .var.name, add)
      60.         └─checkmate:::mstop(...)
      61.           └─base::stop(simpleError(sprintf(msg, ...), call.))
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     
     Error: processing vignette 'fmeffects.Rmd' failed with diagnostics:
     ℹ In index: 1.
     Caused by error in `.__Task__col_roles()`:
     ! Assertion on 'names(rhs)' failed: Names must be a permutation of set {'feature','target','name','order','stratum','group','offset','weights_learner','weights_measure'}, but has extra elements {'always_included'}.
     --- failed re-building ‘fmeffects.Rmd’
     
     SUMMARY: processing the following file failed:
       ‘fmeffects.Rmd’
     
     Error: Vignette re-building failed.
     Execution halted
     ```

# FracFixR (1.0.0)

* Email: <mailto:alice.cleynen@cnrs.fr>
* GitHub mirror: <https://github.com/cran/FracFixR>

Run `revdepcheck::revdep_details(, "FracFixR")` for more info

## In both

*   checking re-building of vignette outputs ... ERROR
     ```
     ...
          ▆
       1. ├─FracFixR::FracFixR(MatrixCounts = counts, Annotation = annotation)
       2. │ └─future::plan(...)
       3. │   └─future (local) plan_set(...)
       4. │     └─future:::plan_init(stack[[1]], debug = debug)
       5. │       └─future:::makeFutureBackend(evaluator, debug = debug)
       6. │         └─base::do.call(factory, args = args, envir = envir)
       7. └─future (local) `<fn>`(workers = 255)
       8.   └─future::ClusterFutureBackend(...)
       9.     └─clusterRegistry$startCluster(...)
      10.       └─future (local) makeCluster(workers, ...)
      11.         ├─base::do.call(makeClusterPSOCK, args = args, quote = TRUE)
      12.         └─parallelly (local) `<fn>`(base::quote(255L), rscript_libs = base::quote(`<chr>`))
      13.           └─parallelly:::checkNumberOfLocalWorkers(workers)
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     
     Error: processing vignette 'FracFixR-intro.Rmd' failed with diagnostics:
     Attempting to set up 255 localhost parallel workers with only 5 CPU cores available for this R process (per 'N/A'), which could result in a 5100% load. The hard limit is set to 300%. Overusing the CPUs has negative impact on the current R process, but also on all other processes of yours and others running on the same machine. See help("parallelly.maxWorkers.localhost", package = "parallelly") for further explanations and how to override the hard limit that triggered this error. By the way, was parallel::detectCores() used, because the number of workers (255) equals detectCores() - 1? If so, please use parallelly::availableCores() instead
     --- failed re-building ‘FracFixR-intro.Rmd’
     
     SUMMARY: processing the following file failed:
       ‘FracFixR-intro.Rmd’
     
     Error: Vignette re-building failed.
     Execution halted
     ```

# GeDS (0.3.3)

* GitHub: <https://github.com/emilioluissaenzguillen/GeDS>
* Email: <mailto:Emilio.Saenz-Guillen@citystgeorges.ac.uk>
* GitHub mirror: <https://github.com/cran/GeDS>

Run `revdepcheck::revdep_details(, "GeDS")` for more info

## In both

*   checking whether package ‘GeDS’ can be installed ... WARNING
     ```
     Found the following significant warnings:
       Warning: no DISPLAY variable so Tk is not available
     See ‘/scratch/henrik/revdep/future/checks/GeDS/new/GeDS.Rcheck/00install.out’ for details.
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

# greenSD (0.1.1)

* GitHub: <https://github.com/billbillbilly/greenSD>
* Email: <mailto:xiaohaoy111@gmail.com>
* GitHub mirror: <https://github.com/cran/greenSD>

Run `revdepcheck::revdep_details(, "greenSD")` for more info

## In both

*   checking examples ... ERROR
     ```
     ...
     1008                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           Boca del R\x92o, La Antigua, Manlio Fabio Altamirano, Medell\x92n, Veracruz
     1009                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Matamoros, Cameron
     1010                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       Amozoc, Atlixco, Coronango, Cuautinch\x87n, Cuautlancingo, Juan C. Bonilla, Nealtican, Ocoyucan, Puebla, San Andr\x8es Cholula, San Gregorio Atzompa, San Jer\x97nimo Tecuanipan, San Miguel Xoxtla, San Pedro Cholula, Santa Isabel Cholula, Tianguismanalco, Tlaltenango, Nat\x92vitas, Tepetitla de Lardiz\x87bal, Zacatelco
     1011                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        R\x92o Bravo, Reynosa, Hidalgo
     1012                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              Pachuca de Soto, San Agust\x92n Tlaxiaca
     1013                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                Alvaro Obreg\x97n, Azcapotzalco, Benito Ju\x87rez, Coyoac\x87n, Cuajimalpa de Morelos, Cuauht\x8emoc, Gustavo A. Madero, Iztacalco, Iztapalapa, Magdalena Contreras, Miguel Hidalgo, Tl\x87huac, Tlalpan, Venustiano Carranza, Xochimilco, Acolman, Atenco, Atizap\x87n de Zaragoza, Chalco, Chicoloapan, Chimalhuac\x87n, Coacalco de Berrioz\x87bal, Coyotepec, Cuautitl\x87n Izcalli, Cuautitl\x87n, Ecatepec de Morelos, Huehuetoca, Huixquilucan, Isidro Fabela, Ixtapaluca, Jaltenco, Jilotzingo, La Paz, Melchor Ocampo, Naucalpan de Ju\x87rez, Nextlalpan, Nezahualc\x97yotl, Nicol\x87s Romero, Tec\x87mac, Teoloyuc\x87n, Teotihuac\x87n, Tepotzotl\x87n, Texcoco, Timilpan, Tlalnepantla, Tultepec, Tultitl\x87n, Zumpango
     1014                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Cuernavaca, Huitzilac, Jiutepec, Miacatl\x87n, Temixco, Xochitepec
     1015                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                Almoloya de Ju\x87rez, Lerma, Otzolotepec, Temoaya, Toluca, Xonacatl\x87n, Zinacatepec
     1016                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         Apodaca, Carmen, Garc\x92a, General Escobedo, Guadalupe, Ju\x87rez, Monterrey, Pesquer\x92a, San Nicol\x87s de los Garza, San Pedro Garza Garc\x92a, Santa Catarina, Santiago
     1017                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              Corregidora, El Marqu\x8es, Quer\x8etaro
     1018                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       Arteaga, Ramos Arizpe, Saltillo
     1019                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    Mexquitic de Carmona, San Luis Potos\x92, Soledad de Graciano S\x87nchez, Villa de Reyes, Zaragoza
     1020                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               Le\x97n
     1021                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     Aguascalientes, Jes\x9cs Mar\x92a
     1022                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            El Salto, Guadalajara, Ixtlahuac\x87n del R\x92o, Tlajomulco de Z\x9c\x96iga, Tlaquepaque, Tonal\x87, Zapopan, Zapotlanejo
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

# infercnv (1.26.0)

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

# InPAS (2.18.1)

* Email: <mailto:jou@morgridge.org>

Run `revdepcheck::revdep_details(, "InPAS")` for more info

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

# lavDiag (0.1.0)

* GitHub: <https://github.com/reckak/lavDiag>
* Email: <mailto:reckak@mail.muni.cz>
* GitHub mirror: <https://github.com/cran/lavDiag>

Run `revdepcheck::revdep_details(, "lavDiag")` for more info

## In both

*   checking tests ...
     ```
     ...
         6. │     └─furrr:::furrr_template(...)
         7. │       ├─future::nbrOfWorkers()
         8. │       └─future:::nbrOfWorkers.NULL()
         9. │         └─future::plan("backend")
        10. │           └─future:::plan_init(strategy, debug = debug)
        11. │             └─future:::makeFutureBackend(evaluator, debug = debug)
        12. │               └─base::do.call(factory, args = args, envir = envir)
        13. └─future (local) `<fn>`(workers = 255L)
        14.   └─future::ClusterFutureBackend(...)
        15.     └─clusterRegistry$startCluster(...)
        16.       └─future (local) makeCluster(workers, ...)
        17.         ├─base::do.call(makeClusterPSOCK, args = args, quote = TRUE)
        18.         └─parallelly (local) `<fn>`(base::quote(255L), rscript_libs = base::quote(`<chr>`))
        19.           └─parallelly:::checkNumberOfLocalWorkers(workers)
       ── Error ('test-prepare.R:12:3'): prepare merges branches for mixed model ──────
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

# ldsr (0.0.2)

* GitHub: <https://github.com/ntthung/ldsr>
* Email: <mailto:ntthung@gmail.com>
* GitHub mirror: <https://github.com/cran/ldsr>

Run `revdepcheck::revdep_details(, "ldsr")` for more info

## In both

*   checking C++ specification ... NOTE
     ```
       Specified C++11: please drop specification unless essential
     ```

# MAI (1.16.0)

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

# mapme.biodiversity (0.9.5)

* GitHub: <https://github.com/mapme-initiative/mapme.biodiversity>
* Email: <mailto:sven.bergtold@gmail.com>
* GitHub mirror: <https://github.com/cran/mapme.biodiversity>

Run `revdepcheck::revdep_details(, "mapme.biodiversity")` for more info

## In both

*   checking tests ...
     ```
     ...
         'test-get_carbon.R:2:3', 'test-get_carbon.R:29:3', 'test-get_chelsa.R:2:3',
         'test-get_esalandcover.R:2:3', 'test-get_fritz_et_al.R:2:3',
         'test-get_gfw_emissions.R:2:3', 'test-get_gfw_lossyear.R:2:3',
         'test-get_gfw_treecover.R:7:3', 'test-get_gmw.R:2:3', 'test-get_gsw.R:2:3',
         'test-get_hfp.R:10:3', 'test-get_mcd64A1.R:2:3', 'test-get_nasa_grace.R:2:3',
         'test-get_nasa_srtm.R:2:3', 'test-get_nelson_et_al.R:2:3',
         'test-get_resources.R:2:3', 'test-get_soilgrids.R:2:3',
         'test-get_teow.R:2:3', 'test-get_ucdp_ged.R:3:3', 'test-get_worldpop.R:2:3',
         'test-ipbes.R:2:3', 'test-ipbes.R:11:3'
       
       ══ Failed tests ════════════════════════════════════════════════════════════════
       ── Failure ('test-chunking.R:7:3'): .crosses_dateline and .split_dateline works ──
       Expected `x2 <- .split_dateline(x)` to run silently.
       Actual noise: warnings.
       ── Failure ('test-chunking.R:8:3'): .crosses_dateline and .split_dateline works ──
       Expected `nrow(x2)` to equal 2.
       Differences:
         `actual`: 1.0
       `expected`: 2.0
       
       
       [ FAIL 2 | WARN 0 | SKIP 43 | PASS 543 ]
       Error:
       ! Test failures.
       Execution halted
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

# mistyR (1.18.0)

* GitHub: <https://github.com/saezlab/mistyR>
* Email: <mailto:jovan.tanevski@uni-heidelberg.de>

Run `revdepcheck::revdep_details(, "mistyR")` for more info

## In both

*   checking R code for possible problems ... NOTE
     ```
     ...
       ‘total’
     plot_view_contributions: no visible binding for global variable
       ‘measure’
     plot_view_contributions: no visible binding for global variable
       ‘target’
     plot_view_contributions: no visible binding for global variable
       ‘fraction’
     plot_view_contributions: no visible binding for global variable ‘view’
     run_misty : <anonymous>: no visible binding for global variable ‘p’
     run_misty : <anonymous>: no visible binding for global variable
       ‘intra.RMSE’
     run_misty : <anonymous>: no visible binding for global variable
       ‘multi.RMSE’
     run_misty : <anonymous>: no visible binding for global variable
       ‘intra.R2’
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

# mlr3resampling (2025.11.19)

* GitHub: <https://github.com/tdhock/mlr3resampling>
* Email: <mailto:toby.hocking@r-project.org>
* GitHub mirror: <https://github.com/cran/mlr3resampling>

Run `revdepcheck::revdep_details(, "mlr3resampling")` for more info

## In both

*   checking examples ... ERROR
     ```
     ...
             <fctr>        <char>  <int>     <int> <int>          <int>     <int>
     1:       Alice           all     52         1     1             52         1
     2:         Bob           all     52         1     1             52         2
        Train_subsets
               <fctr>
     1:           all
     2:           all
     > mlr3resampling::proj_compute(1, pkg.proj.dir)
     [c4-n43:2139761] OPAL ERROR: Not initialized in file ext2x_client.c at line 112
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

*   checking tests ...
     ```
     ...
       > if(require(testthat))test_check("mlr3resampling")
       Loading required package: testthat
       Loading required package: mlr3resampling
       [c4-n43:2142660] OPAL ERROR: Not initialized in file ext2x_client.c at line 112
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
       *** An error occurred in MPI_Init
       *** on a NULL communicator
       *** MPI_ERRORS_ARE_FATAL (processes in this communicator will now abort,
       ***    and potentially your MPI job)
       [c4-n43:2142660] Local abort before MPI_INIT completed completed successfully, but am not able to aggregate error messages, and not able to guarantee that all other processes were killed!
     ```

*   checking dependencies in R code ... NOTE
     ```
     [c4-n43:2127791] OPAL ERROR: Not initialized in file ext2x_client.c at line 112
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

# nfl4th (1.0.4)

* GitHub: <https://github.com/nflverse/nfl4th>
* Email: <mailto:bbaldwin206@gmail.com>
* GitHub mirror: <https://github.com/cran/nfl4th>

Run `revdepcheck::revdep_details(, "nfl4th")` for more info

## In both

*   checking R code for possible problems ... NOTE
     ```
     get_4th_plays: no visible binding for global variable ‘id’
     Undefined global functions or variables:
       id
     ```

# nixtlar (0.6.2)

* GitHub: <https://github.com/Nixtla/nixtlar>
* Email: <mailto:mariana@nixtla.io>
* GitHub mirror: <https://github.com/cran/nixtlar>

Run `revdepcheck::revdep_details(, "nixtlar")` for more info

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

# oncomsm (0.1.4)

* GitHub: <https://github.com/Boehringer-Ingelheim/oncomsm>
* Email: <mailto:kevin.kunzmann@boehringer-ingelheim.com>
* GitHub mirror: <https://github.com/cran/oncomsm>

Run `revdepcheck::revdep_details(, "oncomsm")` for more info

## In both

*   checking re-building of vignette outputs ... ERROR
     ```
     ...
      4. ├─dplyr::filter(., to != "stable")
      5. ├─dplyr::summarize(...)
      6. ├─dplyr:::summarise.grouped_df(., dt = t - lag(t), from = lag(state), to = state, .groups = "drop")
      7. │ └─dplyr:::summarise_cols(.data, dplyr_quosures(...), by, "summarise")
      8. │   └─base::withCallingHandlers(...)
      9. └─dplyr:::dplyr_internal_error(...)
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     
     Error: processing vignette 'oncomsm.Rmd' failed with diagnostics:
     ℹ In argument: `dt = t - lag(t)`.
     ℹ In group 1: `iter = 1`, `group_id = "A"`, `subject_id = "ID00827488"`.
     Caused by error:
     ! `dt` must be size 1, not 3.
     ℹ To return more or less than 1 row per group, use `reframe()`.
     --- failed re-building ‘oncomsm.Rmd’
     
     --- re-building ‘prior-choice.Rmd’ using rmarkdown
     [WARNING] Deprecated: --highlight-style. Use --syntax-highlighting instead.
     --- finished re-building ‘prior-choice.Rmd’
     
     SUMMARY: processing the following file failed:
       ‘oncomsm.Rmd’
     
     Error: Vignette re-building failed.
     Execution halted
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

# Prostar (1.42.0)

* GitHub: <https://github.com/edyp-lab/Prostar>
* Email: <mailto:samuel.wieczorek@cea.fr>

Run `revdepcheck::revdep_details(, "Prostar")` for more info

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

# QDNAseq (1.46.0)

* GitHub: <https://github.com/ccagc/QDNAseq>
* Email: <mailto:d.sie@vumc.nl>

Run `revdepcheck::revdep_details(, "QDNAseq")` for more info

## In both

*   checking re-building of vignette outputs ... WARNING
     ```
     ...
     Total time:0minutes
     
     Warning in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  :
       texi2dvi script/program not available, using emulation
     Error: processing vignette 'QDNAseq.Rnw' failed with diagnostics:
     unable to run pdflatex on 'QDNAseq.tex'
     LaTeX errors:
     ! LaTeX Error: File `nowidow.sty' not found.
     
     Type X to quit or <RETURN> to proceed,
     or enter new name. (Default extension: sty)
     
     ! Emergency stop.
     <read *> 
              
     l.197 \RequirePackage
                          {parnotes}^^M
     !  ==> Fatal error occurred, no output PDF file produced!
     --- failed re-building ‘QDNAseq.Rnw’
     
     SUMMARY: processing the following file failed:
       ‘QDNAseq.Rnw’
     
     Error: Vignette re-building failed.
     Execution halted
     ```

# receptiviti (0.2.1)

* GitHub: <https://github.com/Receptiviti/receptiviti-r>
* Email: <mailto:kenglish@receptiviti.com>
* GitHub mirror: <https://github.com/cran/receptiviti>

Run `revdepcheck::revdep_details(, "receptiviti")` for more info

## In both

*   checking tests ...
     ```
     ...
       
       ══ Skipped tests (4) ═══════════════════════════════════════════════════════════
       • no API key (4): 'test-receptiviti.R:78:1',
         'test-receptiviti_frameworks.R:1:1', 'test-receptiviti_norming.R:12:1',
         'test-receptiviti_status.R:13:1'
       
       ══ Failed tests ════════════════════════════════════════════════════════════════
       ── Error ('test-receptiviti.R:9:3'): invalid inputs are caught ─────────────────
       Error: Invalid header received from client.
       
       Backtrace:
           ▆
        1. ├─testthat::expect_error(...) at test-receptiviti.R:9:3
        2. │ └─testthat:::expect_condition_matching_(...)
        3. │   └─testthat:::quasi_capture(...)
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

# regmedint (1.0.1)

* GitHub: <https://github.com/kaz-yos/regmedint>
* Email: <mailto:yi.li10@mail.mcgill.ca>
* GitHub mirror: <https://github.com/cran/regmedint>

Run `revdepcheck::revdep_details(, "regmedint")` for more info

## In both

*   checking tests ...
     ```
     ...
       ── Error ('test-05_calc_myreg.R:194:9'): calc_myreg / calls calc_myreg_mreg_logistic_yreg_linear when mreg logistic / yreg linear ──
       <lifecycle_error_deprecated/defunctError/rlang_error/error/condition>
       Error: `with_mock()` was deprecated in testthat 3.2.0 and is now defunct.
       ℹ Please use `with_mocked_bindings()` instead.
       Backtrace:
           ▆
        1. └─testthat::with_mock(...) at test-05_calc_myreg.R:194:9
        2.   └─lifecycle::deprecate_stop("3.2.0", "with_mock()", "with_mocked_bindings()")
        3.     └─lifecycle:::deprecate_stop0(msg)
        4.       └─rlang::cnd_signal(...)
       ── Error ('test-05_calc_myreg.R:235:9'): calc_myreg / calls calc_myreg_mreg_logistic_yreg_logistic when mreg logistic / yreg logistic ──
       <lifecycle_error_deprecated/defunctError/rlang_error/error/condition>
       Error: `with_mock()` was deprecated in testthat 3.2.0 and is now defunct.
       ℹ Please use `with_mocked_bindings()` instead.
       Backtrace:
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

# shinyOAuth (0.3.0)

* GitHub: <https://github.com/lukakoning/shinyOAuth>
* Email: <mailto:koningluka@gmail.com>
* GitHub mirror: <https://github.com/cran/shinyOAuth>

Run `revdepcheck::revdep_details(, "shinyOAuth")` for more info

## In both

*   checking tests ...
     ```
     ...
         8.       │ │   └─base (local) tryCatchOne(expr, names, parentenv, handlers[[1L]])
         9.       │ │     └─base (local) doTryCatch(return(expr), name, parentenv, handler)
        10.       │ └─base::force(expr)
        11.       └─rlang::abort(...)
       ── Error ('test-client-bearer-req.R:186:3'): client_bearer_req follows redirects when follow_redirect = TRUE ──
       <httr2_http_503/httr2_http/httr2_error/rlang_error/rlang_error/error/condition>
       Error in `httr2::req_perform(req)`: HTTP 503 Service Unavailable.
       Backtrace:
            ▆
         1. └─httr2::req_perform(req) at test-client-bearer-req.R:186:3
         2.   └─httr2:::handle_resp(req, resp, error_call = error_call)
         3.     └─httr2:::resp_failure_cnd(req, resp, error_call = error_call)
         4.       ├─rlang::catch_cnd(...)
         5.       │ ├─rlang::eval_bare(...)
         6.       │ ├─base::tryCatch(...)
         7.       │ │ └─base (local) tryCatchList(expr, classes, parentenv, handlers)
         8.       │ │   └─base (local) tryCatchOne(expr, names, parentenv, handlers[[1L]])
         9.       │ │     └─base (local) doTryCatch(return(expr), name, parentenv, handler)
        10.       │ └─base::force(expr)
        11.       └─rlang::abort(...)
       
       [ FAIL 13 | WARN 0 | SKIP 47 | PASS 1180 ]
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

# signeR (2.12.0)

* GitHub: <https://github.com/TojalLab/signeR>
* Email: <mailto:renan.valieris@accamargo.org.br>

Run `revdepcheck::revdep_details(, "signeR")` for more info

## In both

*   checking C++ specification ... NOTE
     ```
       Specified C++14: please drop specification unless essential
     ```

*   checking R code for possible problems ... NOTE
     ```
     ...
       ‘Samples’
     ExposureClassify,ANY-character: no visible binding for global variable
       ‘Col’
     ExposureClassify,ANY-character: no visible binding for global variable
       ‘Frequency’
     ExposureClassify,ANY-character: no visible binding for global variable
       ‘Row’
     ExposureClassifyCV,ANY-character: no visible binding for global
       variable ‘Col’
     ExposureClassifyCV,ANY-character: no visible binding for global
       variable ‘Frequency’
     ExposureClassifyCV,ANY-character: no visible binding for global
       variable ‘Row’
     ExposureCorrelation,SignExp-numeric: no visible binding for global
       variable ‘Feature’
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

# SpaDES.core (3.0.4)

* GitHub: <https://github.com/PredictiveEcology/SpaDES.core>
* Email: <mailto:eliot.mcintire@canada.ca>
* GitHub mirror: <https://github.com/cran/SpaDES.core>

Run `revdepcheck::revdep_details(, "SpaDES.core")` for more info

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
     New module test created at /scratch/henrik/1031713/RtmpYA6RUH/reproducible/U3C0xYmG
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

# spdesign (0.0.5)

* GitHub: <https://github.com/edsandorf/spdesign>
* Email: <mailto:erlend.dancke.sandorf@nmbu.no>
* GitHub mirror: <https://github.com/cran/spdesign>

Run `revdepcheck::revdep_details(, "spdesign")` for more info

## In both

*   checking DESCRIPTION meta-information ... NOTE
     ```
       Missing dependency on R >= 4.1.0 because package code uses the pipe
       |> or function shorthand \(...) syntax added in R 4.1.0.
       File(s) using such syntax:
         ‘federov.R’
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

# sRACIPE (2.2.0)

* GitHub: <https://github.com/lusystemsbio/sRACIPE>
* Email: <mailto:m.lu@northeastern.edu>

Run `revdepcheck::revdep_details(, "sRACIPE")` for more info

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

# synergyfinder (3.18.0)

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
       ‘response_origin_mean’
     ReshapeData: no visible binding for global variable
       ‘response_origin_CI95’
     ZIP : <anonymous>: no visible global function definition for ‘predict’
     ZIP : <anonymous>: no visible binding for global variable ‘data’
     ZIP : <anonymous>: no visible binding for global variable ‘pred’
     ZIP : <anonymous>: no visible global function definition for ‘:=’
     ZIP: no visible binding for global variable ‘.’
     ZIP: no visible binding for global variable ‘ZIP_fit’
     ZIP: no visible binding for global variable ‘ZIP_ref’
     ZIP: no visible binding for global variable ‘ZIP_synergy’
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

# targets (1.11.4)

* GitHub: <https://github.com/ropensci/targets>
* Email: <mailto:will.landau.oss@gmail.com>
* GitHub mirror: <https://github.com/cran/targets>

Run `revdepcheck::revdep_details(, "targets")` for more info

## In both

*   checking Rd cross-references ... NOTE
     ```
     Unknown package ‘qs’ in Rd xrefs
     ```

# tramvs (0.0-8)

* Email: <mailto:lucasheinrich.kook@gmail.com>
* GitHub mirror: <https://github.com/cran/tramvs>

Run `revdepcheck::revdep_details(, "tramvs")` for more info

## In both

*   checking re-building of vignette outputs ... WARNING
     ```
     ...
       ...
     --- re-building ‘tramvs.Rnw’ using knitr
     Warning in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  :
       texi2dvi script/program not available, using emulation
     Error: processing vignette 'tramvs.Rnw' failed with diagnostics:
     unable to run pdflatex on 'tramvs.tex'
     LaTeX errors:
     ! LaTeX Error: File `wrapfig.sty' not found.
     
     Type X to quit or <RETURN> to proceed,
     or enter new name. (Default extension: sty)
     
     ! Emergency stop.
     <read *> 
              
     l.68 \usepackage
                     {float}^^M
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
# tsdistributions (1.0.3)

* GitHub: <https://github.com/tsmodels/tsdistributions>
* Email: <mailto:alexios@4dscape.com>
* GitHub mirror: <https://github.com/cran/tsdistributions>

Run `revdepcheck::revdep_details(, "tsdistributions")` for more info

## In both

*   checking re-building of vignette outputs ... ERROR
     ```
     ...
     --- finished re-building ‘estimation_demo.Rmd’
     
     --- re-building ‘location_scale_distributions.Rmd’ using rmarkdown
     [WARNING] Deprecated: --highlight-style. Use --syntax-highlighting instead.
     ! Undefined control sequence.
     l.56 \NewDocumentCommand
                             \citeproctext{}{} 
     
     Error: processing vignette 'location_scale_distributions.Rmd' failed with diagnostics:
     LaTeX failed to compile /scratch/henrik/revdep/future/checks/tsdistributions/new/tsdistributions.Rcheck/vign_test/tsdistributions/vignettes/location_scale_distributions.tex. See https://yihui.org/tinytex/r/#debugging for debugging tips. See location_scale_distributions.log for more info.
     --- failed re-building ‘location_scale_distributions.Rmd’
     
     --- re-building ‘profile_demo.Rmd’ using rmarkdown
     [WARNING] Deprecated: --highlight-style. Use --syntax-highlighting instead.
     --- finished re-building ‘profile_demo.Rmd’
     
     --- re-building ‘spd_demo.Rmd’ using rmarkdown
     [WARNING] Deprecated: --highlight-style. Use --syntax-highlighting instead.
     --- finished re-building ‘spd_demo.Rmd’
     
     SUMMARY: processing the following file failed:
       ‘location_scale_distributions.Rmd’
     
     Error: Vignette re-building failed.
     Execution halted
     ```

# tsgarch (1.0.3)

* GitHub: <https://github.com/tsmodels/tsgarch>
* Email: <mailto:alexios@4dscape.com>
* GitHub mirror: <https://github.com/cran/tsgarch>

Run `revdepcheck::revdep_details(, "tsgarch")` for more info

## In both

*   checking DESCRIPTION meta-information ... NOTE
     ```
       Missing dependency on R >= 4.1.0 because package code uses the pipe
       |> or function shorthand \(...) syntax added in R 4.1.0.
       File(s) using such syntax:
         ‘benchmark.R’ ‘print.R’
     ```

# tsmarch (1.0.0)

* GitHub: <https://github.com/tsmodels/tsmarch>
* Email: <mailto:alexios@4dscape.com>
* GitHub mirror: <https://github.com/cran/tsmarch>

Run `revdepcheck::revdep_details(, "tsmarch")` for more info

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
     --- failed re-building ‘feasible_multivariate_garch.Rmd’
     
     --- re-building ‘tsmarch_demo.Rmd’ using rmarkdown
     [WARNING] Deprecated: --highlight-style. Use --syntax-highlighting instead.
     --- finished re-building ‘tsmarch_demo.Rmd’
     
     SUMMARY: processing the following file failed:
       ‘feasible_multivariate_garch.Rmd’
     
     Error: Vignette re-building failed.
     Execution halted
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
     
     --- re-building ‘WeightedClusterPreview.Rnw’ using knitr
     Warning in texi2dvi(file = file, pdf = TRUE, clean = clean, quiet = quiet,  :
       texi2dvi script/program not available, using emulation
     Error: processing vignette 'WeightedClusterPreview.Rnw' failed with diagnostics:
     unable to run pdflatex on 'WeightedClusterPreview.tex'
     LaTeX errors:
     ! LaTeX Error: File `textpos.sty' not found.
     
     Type X to quit or <RETURN> to proceed,
     or enter new name. (Default extension: sty)
     
     ! Emergency stop.
     <read *> 
              
     l.85 \usepackage
                     {tikz}^^M
     !  ==> Fatal error occurred, no output PDF file produced!
     --- failed re-building ‘WeightedClusterPreview.Rnw’
     
     SUMMARY: processing the following files failed:
       ‘WeightedClusterFR.Rnw’ ‘WeightedClusterPreview.Rnw’
     
     Error: Vignette re-building failed.
     Execution halted
     ```

# wru (3.0.3)

* GitHub: <https://github.com/kosukeimai/wru>
* Email: <mailto:brandon@bertelsen.ca>
* GitHub mirror: <https://github.com/cran/wru>

Run `revdepcheck::revdep_details(, "wru")` for more info

## In both

*   checking dependencies in R code ... NOTE
     ```
     Namespaces in Imports field not imported from:
       ‘future’ ‘tidyr’
       All declared Imports should be used.
     ```

