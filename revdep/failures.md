# carts ()

* GitHub: <https://github.com/futureverse/future>
* Email: <mailto:henrikb@braju.com>

Run `revdepcheck::revdep_details(, "carts")` for more info

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
* installing *binary* package ‘cli’ ...
...
* installing *binary* package ‘broom’ ...
* package ‘broom’ successfully unpacked and SHA256 sums checked
* DONE (broom)
* installing *binary* package ‘geepack’ ...
* package ‘geepack’ successfully unpacked and SHA256 sums checked
* DONE (geepack)

The downloaded source packages are in
	‘/scratch/hb/RtmpqIOW4k/downloaded_packages’
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
* installing *binary* package ‘cli’ ...
...
* installing *binary* package ‘broom’ ...
* package ‘broom’ successfully unpacked and SHA256 sums checked
* DONE (broom)
* installing *binary* package ‘geepack’ ...
* package ‘geepack’ successfully unpacked and SHA256 sums checked
* DONE (geepack)

The downloaded source packages are in
	‘/scratch/hb/RtmpqIOW4k/downloaded_packages’
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
	‘/scratch/hb/RtmpWAjQQ3/downloaded_packages’
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
	‘/scratch/hb/RtmpWAjQQ3/downloaded_packages’
Error in loadNamespace(x) : there is no package called ‘callr’


```
# marcxmlr (0.4.0)

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
** this is package ‘marcxmlr’ version ‘0.4.0’
** package ‘marcxmlr’ successfully unpacked and MD5 sums checked
** using staged installation
Using PKG_CFLAGS=-I/usr/include/libxml2
Using PKG_LIBS=-lxml2 -lz -llzma -lm -ldl
** libs
using C compiler: ‘gcc (GCC) 13.3.1 20240611 (Red Hat 13.3.1-2)’
gcc -std=gnu2x -I"/path/to/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG -I/usr/include/libxml2  -I/usr/local/include    -fpic  -g -O2  -c marcxml-native.c -o marcxml-native.o
marcxml-native.c:72:23: error: conflicting types for ‘attribute’; have ‘const xmlChar *(xmlNode *, const char *)’ {aka ‘const unsigned char *(struct _xmlNode *, const char *)’}
...
In file included from /usr/include/libxml2/libxml/globals.h:20,
                 from /usr/include/libxml2/libxml/xmlIO.h:117,
                 from /usr/include/libxml2/libxml/parser.h:811,
                 from marcxml-native.c:5:
/usr/include/libxml2/libxml/SAX.h:104:17: note: previous declaration of ‘attribute’ with type ‘void(void *, const xmlChar *, const xmlChar *)’ {aka ‘void(void *, const unsigned char *, const unsigned char *)’}
  104 |                 attribute                       (void *ctx,
      |                 ^~~~~~~~~
make: *** [/path/to/_rocky8/R-4.6.1-gcc13/lib64/R/etc/Makeconf:190: marcxml-native.o] Error 1
ERROR: compilation failed for package ‘marcxmlr’
* removing ‘/scratch/henrik/revdep/future/checks/marcxmlr/new/marcxmlr.Rcheck/marcxmlr’


```
### CRAN

```
* installing *source* package ‘marcxmlr’ ...
** this is package ‘marcxmlr’ version ‘0.4.0’
** package ‘marcxmlr’ successfully unpacked and MD5 sums checked
** using staged installation
Using PKG_CFLAGS=-I/usr/include/libxml2
Using PKG_LIBS=-lxml2 -lz -llzma -lm -ldl
** libs
using C compiler: ‘gcc (GCC) 13.3.1 20240611 (Red Hat 13.3.1-2)’
gcc -std=gnu2x -I"/path/to/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG -I/usr/include/libxml2  -I/usr/local/include    -fpic  -g -O2  -c marcxml-native.c -o marcxml-native.o
marcxml-native.c:72:23: error: conflicting types for ‘attribute’; have ‘const xmlChar *(xmlNode *, const char *)’ {aka ‘const unsigned char *(struct _xmlNode *, const char *)’}
...
In file included from /usr/include/libxml2/libxml/globals.h:20,
                 from /usr/include/libxml2/libxml/xmlIO.h:117,
                 from /usr/include/libxml2/libxml/parser.h:811,
                 from marcxml-native.c:5:
/usr/include/libxml2/libxml/SAX.h:104:17: note: previous declaration of ‘attribute’ with type ‘void(void *, const xmlChar *, const xmlChar *)’ {aka ‘void(void *, const unsigned char *, const unsigned char *)’}
  104 |                 attribute                       (void *ctx,
      |                 ^~~~~~~~~
make: *** [/path/to/_rocky8/R-4.6.1-gcc13/lib64/R/etc/Makeconf:190: marcxml-native.o] Error 1
ERROR: compilation failed for package ‘marcxmlr’
* removing ‘/scratch/henrik/revdep/future/checks/marcxmlr/old/marcxmlr.Rcheck/marcxmlr’


```
# VIM ()

* GitHub: <https://github.com/futureverse/future>
* Email: <mailto:henrikb@braju.com>

Run `revdepcheck::revdep_details(, "VIM")` for more info

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
* installing *binary* package ‘bdsmatrix’ ...
...
* installing *binary* package ‘pbkrtest’ ...
* package ‘pbkrtest’ successfully unpacked and SHA256 sums checked
* DONE (pbkrtest)
* installing *binary* package ‘car’ ...
* package ‘car’ successfully unpacked and SHA256 sums checked
* DONE (car)

The downloaded source packages are in
	‘/scratch/hb/Rtmpon8dhS/downloaded_packages’
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
* installing *binary* package ‘bdsmatrix’ ...
...
* installing *binary* package ‘pbkrtest’ ...
* package ‘pbkrtest’ successfully unpacked and SHA256 sums checked
* DONE (pbkrtest)
* installing *binary* package ‘car’ ...
* package ‘car’ successfully unpacked and SHA256 sums checked
* DONE (car)

The downloaded source packages are in
	‘/scratch/hb/Rtmpon8dhS/downloaded_packages’
Error in loadNamespace(x) : there is no package called ‘callr’


```
