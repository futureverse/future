# batchtools ()

* GitHub: <https://github.com/futureverse/future>
* Email: <mailto:henrikb@braju.com>

Run `revdepcheck::revdep_details(, "batchtools")` for more info

## Error before installation

### Devel

```
checking for gcc... gcc -std=gnu2x
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables... 
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether the compiler supports GNU C... yes
checking whether gcc -std=gnu2x accepts -g... yes
checking for gcc -std=gnu2x option to enable C11 features... none needed
checking for pkg-config... /usr/bin/pkg-config
...
  call: dyn.load(file, DLLpath = DLLpath, ...)
  error: unable to load shared object '/scratch/henrik/revdep/future/library/batchtools/00LOCK-Rmpi/00new/Rmpi/libs/Rmpi.so':
  /scratch/henrik/revdep/future/library/batchtools/00LOCK-Rmpi/00new/Rmpi/libs/Rmpi.so: undefined symbol: MPI_Info_get_string
Error: loading failed
Execution halted
gcc -std=gnu2x -I"/wynton/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG   -I/usr/local/include    -fpic  -g -O2  -c getMaxColRowIndex.c -o getMaxColRowIndex.o
gcc -std=gnu2x -I"/wynton/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG   -I/usr/local/include    -fpic  -g -O2  -c getMaxIndex.c -o getMaxIndex.o
gcc -std=gnu2x -I"/wynton/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG   -I/usr/local/include    -fpic  -g -O2  -c init.c -o init.o
gcc -std=gnu2x -I"/wynton/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG   -I/usr/local/include    -fpic  -g -O2  -c itostr.c -o itostr.o
gcc -std=gnu2x -shared -L/wynton/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/lib -L/usr/local/lib64 -o BBmisc.so getMaxColRowIndex.o getMaxIndex.o init.o itostr.o -L/wynton/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/lib -lR


trying URL 'https://cloud.r-project.org/src/contrib/BBmisc_1.13.2.tar.gz'
Content type 'application/x-gzip' length 88646 bytes (86 KB)
==================================================
downloaded 86 KB

* installing *binary* package ‘backports’ ...
* package ‘backports’ successfully unpacked and SHA256 sums checked
* DONE (backports)
* installing *binary* package ‘base64enc’ ...
* package ‘base64enc’ successfully unpacked and SHA256 sums checked
...

The downloaded source packages are in
	‘/scratch/hb/RtmpBxW6DO/downloaded_packages’
Error in (function (libdir, packages, quiet, repos)  : 
  all(packages %in% rownames(installed.packages(libdir[1]))) is not TRUE
In addition: Warning messages:
1: In utils::install.packages(pkgs = pkgs, lib = lib, repos = myrepos,  :
  installation of package ‘Rmpi’ had non-zero exit status
2: In utils::install.packages(pkgs = pkgs, lib = lib, repos = myrepos,  :
  installation of package ‘Rmpi’ had non-zero exit status


```
### CRAN

```
checking for gcc... gcc -std=gnu2x
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables... 
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether the compiler supports GNU C... yes
checking whether gcc -std=gnu2x accepts -g... yes
checking for gcc -std=gnu2x option to enable C11 features... none needed
checking for pkg-config... /usr/bin/pkg-config
...
  call: dyn.load(file, DLLpath = DLLpath, ...)
  error: unable to load shared object '/scratch/henrik/revdep/future/library/batchtools/00LOCK-Rmpi/00new/Rmpi/libs/Rmpi.so':
  /scratch/henrik/revdep/future/library/batchtools/00LOCK-Rmpi/00new/Rmpi/libs/Rmpi.so: undefined symbol: MPI_Info_get_string
Error: loading failed
Execution halted
gcc -std=gnu2x -I"/wynton/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG   -I/usr/local/include    -fpic  -g -O2  -c getMaxColRowIndex.c -o getMaxColRowIndex.o
gcc -std=gnu2x -I"/wynton/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG   -I/usr/local/include    -fpic  -g -O2  -c getMaxIndex.c -o getMaxIndex.o
gcc -std=gnu2x -I"/wynton/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG   -I/usr/local/include    -fpic  -g -O2  -c init.c -o init.o
gcc -std=gnu2x -I"/wynton/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/include" -DNDEBUG   -I/usr/local/include    -fpic  -g -O2  -c itostr.c -o itostr.o
gcc -std=gnu2x -shared -L/wynton/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/lib -L/usr/local/lib64 -o BBmisc.so getMaxColRowIndex.o getMaxIndex.o init.o itostr.o -L/wynton/home/cbi/shared/software/CBI/_rocky8/R-4.6.1-gcc13/lib64/R/lib -lR


trying URL 'https://cloud.r-project.org/src/contrib/BBmisc_1.13.2.tar.gz'
Content type 'application/x-gzip' length 88646 bytes (86 KB)
==================================================
downloaded 86 KB

* installing *binary* package ‘backports’ ...
* package ‘backports’ successfully unpacked and SHA256 sums checked
* DONE (backports)
* installing *binary* package ‘base64enc’ ...
* package ‘base64enc’ successfully unpacked and SHA256 sums checked
...

The downloaded source packages are in
	‘/scratch/hb/RtmpBxW6DO/downloaded_packages’
Error in (function (libdir, packages, quiet, repos)  : 
  all(packages %in% rownames(installed.packages(libdir[1]))) is not TRUE
In addition: Warning messages:
1: In utils::install.packages(pkgs = pkgs, lib = lib, repos = myrepos,  :
  installation of package ‘Rmpi’ had non-zero exit status
2: In utils::install.packages(pkgs = pkgs, lib = lib, repos = myrepos,  :
  installation of package ‘Rmpi’ had non-zero exit status


```
