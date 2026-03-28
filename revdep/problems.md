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

# mlr3resampling (2026.2.24)

* GitHub: <https://github.com/tdhock/mlr3resampling>
* Email: <mailto:toby.hocking@r-project.org>
* GitHub mirror: <https://github.com/cran/mlr3resampling>

Run `revdepcheck::revdep_details(, "mlr3resampling")` for more info

## In both

*   checking dependencies in R code ... NOTE
     ```
     [c4-n43:3099480] OPAL ERROR: Not initialized in file ext2x_client.c at line 112
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

# pizzarr (0.1.1)

* GitHub: <https://github.com/zarr-developers/pizzarr>
* Email: <mailto:dblodgett@usgs.gov>
* GitHub mirror: <https://github.com/cran/pizzarr>

Run `revdepcheck::revdep_details(, "pizzarr")` for more info

## In both

*   checking tests ...
     ```
     ...
        3.     └─pizzarr (local) initialize(...)
        4.       └─private$load_metadata()
        5.         └─private$load_metadata_nosync()
        6.           └─pizzarr:::get_codec(meta$compressor)
        7.             ├─base::do.call(BloscCodec$new, config)
        8.             └─R6 (local) `<fn>`(blocksize = 0L, clevel = 5L, cname = "lz4", shuffle = 1L)
        9.               └─pizzarr (local) initialize(...)
       
       [ FAIL 1 | WARN 0 | SKIP 58 | PASS 1103 ]
       Error:
       ! Test failures.
       Warning messages:
       1: `setup()` was deprecated in the 3rd edition.
       ℹ Please use test fixtures instead see vignette('test-fixtures') for details 
       2: `teardown()` was deprecated in the 3rd edition.
       ℹ Please use test fixtures instead see vignette('test-fixtures') for details 
       3: In .Internal(gc(verbose, reset, full)) :
         closing unused connection 9 (<-localhost:11114)
       4: In .Internal(gc(verbose, reset, full)) :
         closing unused connection 8 (<-localhost:11114)
       5: In .Internal(gc(verbose, reset, full)) :
         closing unused connection 7 (<-localhost:11114)
       6: In .Internal(gc(verbose, reset, full)) :
         closing unused connection 6 (<-localhost:11114)
       Execution halted
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

# SCArray.sat (1.10.1)

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
     Undefined global functions or variables:
       CreateAssay5Object
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

# steps (1.3.0)

* GitHub: <https://github.com/steps-dev/steps>
* Email: <mailto:casey.visintin@unimelb.edu.au>
* GitHub mirror: <https://github.com/cran/steps>

Run `revdepcheck::revdep_details(, "steps")` for more info

## In both

*   checking whether package ‘steps’ can be installed ... WARNING
     ```
     Found the following significant warnings:
       Warning: src/Makevars: Unknown C++ standard ‘C++11’ was ignored
     See ‘/scratch/henrik/revdep/future/checks/steps/new/steps.Rcheck/00install.out’ for details.
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

# tramvs (0.0-9)

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

