# altdoc (0.7.3)

* GitHub: <https://github.com/etiennebacher/altdoc>
* Email: <mailto:etienne.bacher@protonmail.com>
* GitHub mirror: <https://github.com/cran/altdoc>

Run `revdepcheck::revdep_details(, "altdoc")` for more info

## In both

*   checking for non-standard things in the check directory ... NOTE
     ```
     Found the following files/directories:
       ‘testpkg3936671736cfe3’
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
     localhost:pid3932007.R: Unable to initialize verbs NIC /sys/class/infiniband/mlx5_0 (unit 0:0)
     localhost:pid3932007: PSM3 can't open nic unit: 0 (err=23)
     localhost:pid3932007.R: Unable to create send CQ of size 5080 on mlx5_0: Cannot allocate memory
     localhost:pid3932007.R: Unable to initialize verbs NIC /sys/class/infiniband/mlx5_0 (unit 0:0)
     --------------------------------------------------------------------------
     No OpenFabrics connection schemes reported that they were able to be
     used on a specific port.  As such, the openib BTL (OpenFabrics
     support) will be disabled for this port.
     
       Local host:           dev3
       Local device:         mlx5_0
       Local port:           1
       CPCs attempted:       rdmacm, udcm
     --------------------------------------------------------------------------
     localhost:pid3932007: PSM3 can't open nic unit: 0 (err=23)
     localhost:pid3932007.R: Unable to create send CQ of size 5080 on mlx5_0: Cannot allocate memory
     localhost:pid3932007.R: Unable to initialize verbs NIC /sys/class/infiniband/mlx5_0 (unit 0:0)
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

# cSEM (0.7.1)

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

# delimtools (0.2.2)

* GitHub: <https://github.com/legalLab/delimtools>
* Email: <mailto:pedro.sennabittencourt@gmail.com>
* GitHub mirror: <https://github.com/cran/delimtools>

Run `revdepcheck::revdep_details(, "delimtools")` for more info

## In both

*   checking Rd cross-references ... NOTE
     ```
     Package unavailable to check Rd xrefs: ‘bGMYC’
     Unknown package ‘splits’ in Rd xrefs
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

# fmeffects (0.1.4)

* GitHub: <https://github.com/holgstr/fmeffects>
* Email: <mailto:hbj.loewe@gmail.com>
* GitHub mirror: <https://github.com/cran/fmeffects>

Run `revdepcheck::revdep_details(, "fmeffects")` for more info

## In both

*   checking re-building of vignette outputs ... ERROR
     ```
     ...
          ▆
       1. └─fmeffects::fme(...)
       2.   └─ForwardMarginalEffect$new(makePredictor(model, data), features = features, ... at fmeffects/R/FME.R:326:3
       3.     └─private$fme(...) at fmeffects/R/FME.R:106:7
       4.       └─furrr::future_map_dbl(...) at fmeffects/R/FME.R:255:9
       5.         └─furrr:::furrr_map_template(...)
       6.           └─furrr:::furrr_template(...)
       7.             └─furrr:::furrr_try_catch(...)
       8.               └─base::tryCatch(expr = expr, purrr_error_indexed = rethrow_purrr_error_indexed)
       9.                 └─base (local) tryCatchList(expr, classes, parentenv, handlers)
      10.                   └─base (local) tryCatchOne(expr, names, parentenv, handlers[[1L]])
      11.                     └─value[[3L]](cond)
      12.                       └─rlang::cnd_signal(cnd)
      13.                         └─rlang:::signal_abort(cnd)
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     
     Error: processing vignette 'fmeffects.Rmd' failed with diagnostics:
     Assertion on 'names(rhs)' failed: Names must be a permutation of set {'feature','target','name','order','stratum','group','offset','weights_learner','weights_measure'}, but has extra elements {'always_included'}.
     --- failed re-building ‘fmeffects.Rmd’
     
     SUMMARY: processing the following file failed:
       ‘fmeffects.Rmd’
     
     Error: Vignette re-building failed.
     Execution halted
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

# marcxmlr (0.2.1)

* GitHub: <https://github.com/larry77/marcxmlr>
* Email: <mailto:lorenzo.isella@gmail.com>
* GitHub mirror: <https://github.com/cran/marcxmlr>

Run `revdepcheck::revdep_details(, "marcxmlr")` for more info

## In both

*   checking whether package ‘marcxmlr’ can be installed ... ERROR
     ```
     Installation failed.
     See ‘/scratch/henrik/revdep/future/checks/marcxmlr/new/marcxmlr.Rcheck/00install.out’ for details.
     ```

## Installation

### Devel

```
* installing *source* package ‘marcxmlr’ ...
** this is package ‘marcxmlr’ version ‘0.2.1’
** package ‘marcxmlr’ successfully unpacked and MD5 sums checked
** using staged installation
Using PKG_CFLAGS=-I/usr/include/libxml2
Using PKG_LIBS=-lxml2 -lz -llzma -lm -ldl
** libs
using C compiler: ‘gcc (GCC) 13.3.1 20240611 (Red Hat 13.3.1-2)’
gcc -std=gnu2x -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG -I/usr/include/libxml2  -I/usr/local/include    -fpic  -g -O2  -c marcxml-native.c -o marcxml-native.o
marcxml-native.c:69:23: error: conflicting types for ‘attribute’; have ‘const xmlChar *(xmlNode *, const char *)’ {aka ‘const unsigned char *(struct _xmlNode *, const char *)’}
...
In file included from /usr/include/libxml2/libxml/globals.h:20,
                 from /usr/include/libxml2/libxml/xmlIO.h:117,
                 from /usr/include/libxml2/libxml/parser.h:811,
                 from marcxml-native.c:5:
/usr/include/libxml2/libxml/SAX.h:104:17: note: previous declaration of ‘attribute’ with type ‘void(void *, const xmlChar *, const xmlChar *)’ {aka ‘void(void *, const unsigned char *, const unsigned char *)’}
  104 |                 attribute                       (void *ctx,
      |                 ^~~~~~~~~
make: *** [/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/etc/Makeconf:190: marcxml-native.o] Error 1
ERROR: compilation failed for package ‘marcxmlr’
* removing ‘/scratch/henrik/revdep/future/checks/marcxmlr/new/marcxmlr.Rcheck/marcxmlr’


```
### CRAN

```
* installing *source* package ‘marcxmlr’ ...
** this is package ‘marcxmlr’ version ‘0.2.1’
** package ‘marcxmlr’ successfully unpacked and MD5 sums checked
** using staged installation
Using PKG_CFLAGS=-I/usr/include/libxml2
Using PKG_LIBS=-lxml2 -lz -llzma -lm -ldl
** libs
using C compiler: ‘gcc (GCC) 13.3.1 20240611 (Red Hat 13.3.1-2)’
gcc -std=gnu2x -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG -I/usr/include/libxml2  -I/usr/local/include    -fpic  -g -O2  -c marcxml-native.c -o marcxml-native.o
marcxml-native.c:69:23: error: conflicting types for ‘attribute’; have ‘const xmlChar *(xmlNode *, const char *)’ {aka ‘const unsigned char *(struct _xmlNode *, const char *)’}
...
In file included from /usr/include/libxml2/libxml/globals.h:20,
                 from /usr/include/libxml2/libxml/xmlIO.h:117,
                 from /usr/include/libxml2/libxml/parser.h:811,
                 from marcxml-native.c:5:
/usr/include/libxml2/libxml/SAX.h:104:17: note: previous declaration of ‘attribute’ with type ‘void(void *, const xmlChar *, const xmlChar *)’ {aka ‘void(void *, const unsigned char *, const unsigned char *)’}
  104 |                 attribute                       (void *ctx,
      |                 ^~~~~~~~~
make: *** [/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/etc/Makeconf:190: marcxml-native.o] Error 1
ERROR: compilation failed for package ‘marcxmlr’
* removing ‘/scratch/henrik/revdep/future/checks/marcxmlr/old/marcxmlr.Rcheck/marcxmlr’


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

# mlr3resampling (2026.5.19)

* GitHub: <https://github.com/tdhock/mlr3resampling>
* Email: <mailto:toby.hocking@r-project.org>
* GitHub mirror: <https://github.com/cran/mlr3resampling>

Run `revdepcheck::revdep_details(, "mlr3resampling")` for more info

## In both

*   checking dependencies in R code ... NOTE
     ```
     ...
     localhost:pid2076597.R: Unable to initialize verbs NIC /sys/class/infiniband/mlx5_0 (unit 0:0)
     localhost:pid2076597: PSM3 can't open nic unit: 0 (err=23)
     localhost:pid2076597.R: Unable to create send CQ of size 5080 on mlx5_0: Cannot allocate memory
     localhost:pid2076597.R: Unable to initialize verbs NIC /sys/class/infiniband/mlx5_0 (unit 0:0)
     --------------------------------------------------------------------------
     No OpenFabrics connection schemes reported that they were able to be
     used on a specific port.  As such, the openib BTL (OpenFabrics
     support) will be disabled for this port.
     
       Local host:           dev3
       Local device:         mlx5_0
       Local port:           1
       CPCs attempted:       rdmacm, udcm
     --------------------------------------------------------------------------
     localhost:pid2076597: PSM3 can't open nic unit: 0 (err=23)
     localhost:pid2076597.R: Unable to create send CQ of size 5080 on mlx5_0: Cannot allocate memory
     localhost:pid2076597.R: Unable to initialize verbs NIC /sys/class/infiniband/mlx5_0 (unit 0:0)
     --------------------------------------------------------------------------
     Open MPI failed an OFI Libfabric library call (fi_endpoint).  This is highly
     unusual; your job may behave unpredictably (and/or abort) after this.
     
       Local host: dev3
       Location: mtl_ofi_component.c:513
       Error: Invalid argument (22)
     --------------------------------------------------------------------------
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

# Seqtometry (1.0.1)

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

*   checking dependencies in R code ... NOTE
     ```
     Namespaces in Imports field not imported from:
       ‘DelayedMatrixStats’ ‘sparseMatrixStats’
       All declared Imports should be used.
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

# SpaDES.core (3.2.1)

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
     New module test created at /scratch/hb/RtmpXvpHiy/working_dir/Rtmp9nIPZ6/reproducible/U3C0xYmG
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

# STARRS (1.0)

* Email: <mailto:daphne.giorgi@sorbonne-universite.fr>
* GitHub mirror: <https://github.com/cran/STARRS>

Run `revdepcheck::revdep_details(, "STARRS")` for more info

## In both

*   checking re-building of vignette outputs ... ERROR
     ```
     ...
     Error: processing vignette 'STARRS-clustering.Rmd' failed with diagnostics:
     Attempting to set up 48 localhost parallel workers with only 5 CPU cores available for this R process (per 'N/A'), which could result in a 960% load. The hard limit is set to 300%. Overusing the CPUs has negative impact on the current R process, but also on all other processes of yours and others running on the same machine. See help("parallelly.maxWorkers.localhost", package = "parallelly") for further explanations and how to override the hard limit that triggered this error. By the way, was parallel::detectCores() used, because the number of workers (48) equals detectCores()? If so, please use parallelly::availableCores() instead
     --- failed re-building ‘STARRS-clustering.Rmd’
     
     --- re-building ‘STARRS-intro.Rmd’ using rmarkdown
     [WARNING] Deprecated: --mathjax. Use --math-method=mathjax[:URL] instead.
     --- finished re-building ‘STARRS-intro.Rmd’
     
     --- re-building ‘STARRS-median-mcm.Rmd’ using rmarkdown
     [WARNING] Deprecated: --mathjax. Use --math-method=mathjax[:URL] instead.
     --- finished re-building ‘STARRS-median-mcm.Rmd’
     
     --- re-building ‘STARRS-regression.Rmd’ using rmarkdown
     [WARNING] Deprecated: --mathjax. Use --math-method=mathjax[:URL] instead.
     --- finished re-building ‘STARRS-regression.Rmd’
     
     --- re-building ‘STARRS-robust-variance.Rmd’ using rmarkdown
     [WARNING] Deprecated: --mathjax. Use --math-method=mathjax[:URL] instead.
     --- finished re-building ‘STARRS-robust-variance.Rmd’
     
     SUMMARY: processing the following file failed:
       ‘STARRS-clustering.Rmd’
     
     Error: Vignette re-building failed.
     Execution halted
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

# UniCensorEM (0.1.0)

* Email: <mailto:shikhar1093tyagi@gmail.com>
* GitHub mirror: <https://github.com/cran/UniCensorEM>

Run `revdepcheck::revdep_details(, "UniCensorEM")` for more info

## In both

*   checking dependencies in R code ... NOTE
     ```
     Namespaces in Imports field not imported from:
       ‘grDevices’ ‘methods’ ‘utils’
       All declared Imports should be used.
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

