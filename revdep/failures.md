# apsimx ()

* GitHub: <https://github.com/futureverse/future>
* Email: <mailto:henrikb@braju.com>

Run `revdepcheck::revdep_details(, "apsimx")` for more info

## Error before installation

### Devel

```
g++ -std=gnu++20 -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I'/scratch/henrik/revdep/future/library/apsimx/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c DisC2_criteria.cpp -o DisC2_criteria.o
g++ -std=gnu++20 -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I'/scratch/henrik/revdep/future/library/apsimx/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c DisL2_criteria.cpp -o DisL2_criteria.o
g++ -std=gnu++20 -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I'/scratch/henrik/revdep/future/library/apsimx/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c DisL2star_criteria.cpp -o DisL2star_criteria.o
g++ -std=gnu++20 -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I'/scratch/henrik/revdep/future/library/apsimx/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c DisM2_criteria.cpp -o DisM2_criteria.o
g++ -std=gnu++20 -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I'/scratch/henrik/revdep/future/library/apsimx/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c DisS2_criteria.cpp -o DisS2_criteria.o
g++ -std=gnu++20 -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I'/scratch/henrik/revdep/future/library/apsimx/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c DisW2_criteria.cpp -o DisW2_criteria.o
g++ -std=gnu++20 -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I'/scratch/henrik/revdep/future/library/apsimx/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c LG_Rowsort.cpp -o LG_Rowsort.o
g++ -std=gnu++20 -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I'/scratch/henrik/revdep/future/library/apsimx/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c LG_estimator.cpp -o LG_estimator.o
g++ -std=gnu++20 -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I'/scratch/henrik/revdep/future/library/apsimx/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c LG_estimatornew.cpp -o LG_estimatornew.o
g++ -std=gnu++20 -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I'/scratch/henrik/revdep/future/library/apsimx/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c RcppExports.cpp -o RcppExports.o
g++ -std=gnu++20 -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I'/scratch/henrik/revdep/future/library/apsimx/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c compar_array.cpp -o compar_array.o
g++ -std=gnu++20 -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I'/scratch/henrik/revdep/future/library/apsimx/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c maximin_cplus.cpp -o maximin_cplus.o
g++ -std=gnu++20 -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I'/scratch/henrik/revdep/future/library/apsimx/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c nested.cpp -o nested.o
g++ -std=gnu++20 -shared -L/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/lib -L/usr/local/lib64 -o sensitivity.so DisC2_criteria.o DisL2_criteria.o DisL2star_criteria.o DisM2_criteria.o DisS2_criteria.o DisW2_criteria.o LG_Rowsort.o LG_estimator.o LG_estimatornew.o RcppExports.o compar_array.o maximin_cplus.o nested.o -L/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/lib -lR
g++ -std=gnu++20 -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I/usr/local/include    -fpic  -g -O2   -c RcppExports.cpp -o RcppExports.o
gcc -std=gnu2x -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I/usr/local/include    -fpic  -g -O2  -c init.c -o init.o
g++ -std=gnu++20 -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I/usr/local/include    -fpic  -g -O2   -c vsem.cpp -o vsem.o
g++ -std=gnu++20 -shared -L/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/lib -L/usr/local/lib64 -o BayesianTools.so RcppExports.o init.o vsem.o -L/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/lib -lR


* installing *binary* package ‘base64enc’ ...
* package ‘base64enc’ successfully unpacked and SHA256 sums checked
* DONE (base64enc)
* installing *binary* package ‘bit’ ...
* package ‘bit’ successfully unpacked and SHA256 sums checked
* DONE (bit)
* installing *binary* package ‘boot’ ...
* package ‘boot’ successfully unpacked and SHA256 sums checked
* DONE (boot)
* installing *binary* package ‘class’ ...
...
** installing vignettes
** testing if installed package can be loaded from temporary location
** checking absolute paths in shared objects and dynamic libraries
** testing if installed package can be loaded from final location
** testing if installed package keeps a record of temporary installation path
* DONE (BayesianTools)

The downloaded source packages are in
	‘/scratch/hb/RtmpQmzpa0/downloaded_packages’
Error in loadNamespace(x) : there is no package called ‘callr’


```
### CRAN

```
g++ -std=gnu++20 -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I'/scratch/henrik/revdep/future/library/apsimx/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c DisC2_criteria.cpp -o DisC2_criteria.o
g++ -std=gnu++20 -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I'/scratch/henrik/revdep/future/library/apsimx/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c DisL2_criteria.cpp -o DisL2_criteria.o
g++ -std=gnu++20 -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I'/scratch/henrik/revdep/future/library/apsimx/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c DisL2star_criteria.cpp -o DisL2star_criteria.o
g++ -std=gnu++20 -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I'/scratch/henrik/revdep/future/library/apsimx/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c DisM2_criteria.cpp -o DisM2_criteria.o
g++ -std=gnu++20 -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I'/scratch/henrik/revdep/future/library/apsimx/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c DisS2_criteria.cpp -o DisS2_criteria.o
g++ -std=gnu++20 -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I'/scratch/henrik/revdep/future/library/apsimx/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c DisW2_criteria.cpp -o DisW2_criteria.o
g++ -std=gnu++20 -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I'/scratch/henrik/revdep/future/library/apsimx/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c LG_Rowsort.cpp -o LG_Rowsort.o
g++ -std=gnu++20 -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I'/scratch/henrik/revdep/future/library/apsimx/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c LG_estimator.cpp -o LG_estimator.o
g++ -std=gnu++20 -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I'/scratch/henrik/revdep/future/library/apsimx/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c LG_estimatornew.cpp -o LG_estimatornew.o
g++ -std=gnu++20 -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I'/scratch/henrik/revdep/future/library/apsimx/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c RcppExports.cpp -o RcppExports.o
g++ -std=gnu++20 -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I'/scratch/henrik/revdep/future/library/apsimx/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c compar_array.cpp -o compar_array.o
g++ -std=gnu++20 -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I'/scratch/henrik/revdep/future/library/apsimx/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c maximin_cplus.cpp -o maximin_cplus.o
g++ -std=gnu++20 -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I'/scratch/henrik/revdep/future/library/apsimx/RcppArmadillo/include' -I/usr/local/include    -fpic  -g -O2   -c nested.cpp -o nested.o
g++ -std=gnu++20 -shared -L/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/lib -L/usr/local/lib64 -o sensitivity.so DisC2_criteria.o DisL2_criteria.o DisL2star_criteria.o DisM2_criteria.o DisS2_criteria.o DisW2_criteria.o LG_Rowsort.o LG_estimator.o LG_estimatornew.o RcppExports.o compar_array.o maximin_cplus.o nested.o -L/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/lib -lR
g++ -std=gnu++20 -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I/usr/local/include    -fpic  -g -O2   -c RcppExports.cpp -o RcppExports.o
gcc -std=gnu2x -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I/usr/local/include    -fpic  -g -O2  -c init.c -o init.o
g++ -std=gnu++20 -I"/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG  -I'/scratch/henrik/revdep/future/library/apsimx/Rcpp/include' -I/usr/local/include    -fpic  -g -O2   -c vsem.cpp -o vsem.o
g++ -std=gnu++20 -shared -L/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/lib -L/usr/local/lib64 -o BayesianTools.so RcppExports.o init.o vsem.o -L/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/lib -lR


* installing *binary* package ‘base64enc’ ...
* package ‘base64enc’ successfully unpacked and SHA256 sums checked
* DONE (base64enc)
* installing *binary* package ‘bit’ ...
* package ‘bit’ successfully unpacked and SHA256 sums checked
* DONE (bit)
* installing *binary* package ‘boot’ ...
* package ‘boot’ successfully unpacked and SHA256 sums checked
* DONE (boot)
* installing *binary* package ‘class’ ...
...
** installing vignettes
** testing if installed package can be loaded from temporary location
** checking absolute paths in shared objects and dynamic libraries
** testing if installed package can be loaded from final location
** testing if installed package keeps a record of temporary installation path
* DONE (BayesianTools)

The downloaded source packages are in
	‘/scratch/hb/RtmpQmzpa0/downloaded_packages’
Error in loadNamespace(x) : there is no package called ‘callr’


```
# iccTraj ()

* GitHub: <https://github.com/futureverse/future>
* Email: <mailto:henrikb@braju.com>

Run `revdepcheck::revdep_details(, "iccTraj")` for more info

## Error before installation

### Devel

```



* installing *binary* package ‘abind’ ...
* package ‘abind’ successfully unpacked and SHA256 sums checked
* DONE (abind)
* installing *binary* package ‘cli’ ...
* package ‘cli’ successfully unpacked and SHA256 sums checked
* DONE (cli)
* installing *binary* package ‘codetools’ ...
* package ‘codetools’ successfully unpacked and SHA256 sums checked
* DONE (codetools)
* installing *binary* package ‘digest’ ...
...
** testing if installed package can be loaded from final location
** testing if installed package keeps a record of temporary installation path
* DONE (trajectories)
* installing *binary* package ‘dplyr’ ...
* package ‘dplyr’ successfully unpacked and SHA256 sums checked
* DONE (dplyr)

The downloaded source packages are in
	‘/scratch/hb/RtmpR5Ig1F/downloaded_packages’
Error in loadNamespace(x) : there is no package called ‘callr’


```
### CRAN

```



* installing *binary* package ‘abind’ ...
* package ‘abind’ successfully unpacked and SHA256 sums checked
* DONE (abind)
* installing *binary* package ‘cli’ ...
* package ‘cli’ successfully unpacked and SHA256 sums checked
* DONE (cli)
* installing *binary* package ‘codetools’ ...
* package ‘codetools’ successfully unpacked and SHA256 sums checked
* DONE (codetools)
* installing *binary* package ‘digest’ ...
...
** testing if installed package can be loaded from final location
** testing if installed package keeps a record of temporary installation path
* DONE (trajectories)
* installing *binary* package ‘dplyr’ ...
* package ‘dplyr’ successfully unpacked and SHA256 sums checked
* DONE (dplyr)

The downloaded source packages are in
	‘/scratch/hb/RtmpR5Ig1F/downloaded_packages’
Error in loadNamespace(x) : there is no package called ‘callr’


```
# InPAS ()

* GitHub: <https://github.com/futureverse/future>
* Email: <mailto:henrikb@braju.com>

Run `revdepcheck::revdep_details(, "InPAS")` for more info

## Error before installation

### Devel

```



* installing *binary* package ‘abind’ ...
* package ‘abind’ successfully unpacked and SHA256 sums checked
* DONE (abind)
* installing *binary* package ‘backports’ ...
* package ‘backports’ successfully unpacked and SHA256 sums checked
* DONE (backports)
* installing *binary* package ‘base64enc’ ...
* package ‘base64enc’ successfully unpacked and SHA256 sums checked
* DONE (base64enc)
* installing *binary* package ‘BH’ ...
...
* installing *binary* package ‘EnsDb.Hsapiens.v86’ ...
* package ‘EnsDb.Hsapiens.v86’ successfully unpacked and SHA256 sums checked
* DONE (EnsDb.Hsapiens.v86)
* installing *binary* package ‘EnsDb.Mmusculus.v79’ ...
* package ‘EnsDb.Mmusculus.v79’ successfully unpacked and SHA256 sums checked
* DONE (EnsDb.Mmusculus.v79)

The downloaded source packages are in
	‘/scratch/hb/RtmpLwHluN/downloaded_packages’
Error in loadNamespace(x) : there is no package called ‘callr’


```
### CRAN

```



* installing *binary* package ‘abind’ ...
* package ‘abind’ successfully unpacked and SHA256 sums checked
* DONE (abind)
* installing *binary* package ‘backports’ ...
* package ‘backports’ successfully unpacked and SHA256 sums checked
* DONE (backports)
* installing *binary* package ‘base64enc’ ...
* package ‘base64enc’ successfully unpacked and SHA256 sums checked
* DONE (base64enc)
* installing *binary* package ‘BH’ ...
...
* installing *binary* package ‘EnsDb.Hsapiens.v86’ ...
* package ‘EnsDb.Hsapiens.v86’ successfully unpacked and SHA256 sums checked
* DONE (EnsDb.Hsapiens.v86)
* installing *binary* package ‘EnsDb.Mmusculus.v79’ ...
* package ‘EnsDb.Mmusculus.v79’ successfully unpacked and SHA256 sums checked
* DONE (EnsDb.Mmusculus.v79)

The downloaded source packages are in
	‘/scratch/hb/RtmpLwHluN/downloaded_packages’
Error in loadNamespace(x) : there is no package called ‘callr’


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
