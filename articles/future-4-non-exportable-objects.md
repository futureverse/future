# A Future for R: Non-Exportable Objects

Certain types of objects are tied to a given R session. Such objects
cannot be saved to file by one R process and then later be reloaded in
another R process and expected to work correctly. If attempted, we will
often get an informative error but not always. For the same reason,
these types of objects cannot be exported to other R processes(\*) for
parallel processing regardless of which parallelization framework we
use. We refer to these types of objects as “non-exportable objects”.

(\*) The exception *might be* when *forked* processes are used,
i.e. `plan(multicore)`. However, such attempts to work around the
underlying problem, which is non-exportable objects, should be avoided
and considered non-stable. Moreover, such code will fail to parallelize
when using other future backends.

## A first example - file connections

An example of a non-exportable object is a connection, e.g. a file
connection. For instance, if you create a file connection,

\
`con`` ``<-`` `[`file`](https://rdrr.io/r/base/connections.html)`(``"output.log"``, open ``=`` ``"wb"``)`\
[`cat`](https://rdrr.io/r/base/cat.html)`(``"hello "``, file ``=`` ``con``)`\
[`flush`](https://rdrr.io/r/base/connections.html)`(``con``)`\
[`readLines`](https://rdrr.io/r/base/readLines.html)`(``"output.log"``, warn ``=`` ``FALSE``)`\
`## [1] "hello "`

it will not work when used in another R process. If we try, the result
is “unknown”, e.g.

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`future`](https://future.futureverse.org)`)`\
[`plan`](https://future.futureverse.org/reference/plan.md)`(``multisession``)`\
`f`` ``<-`` `[`future`](https://future.futureverse.org/reference/future.md)`(``{`` `[`cat`](https://rdrr.io/r/base/cat.html)`(``"world!"``, file ``=`` ``con``)``; `[`flush`](https://rdrr.io/r/base/connections.html)`(``con``)`` ``}``)`\
[`value`](https://future.futureverse.org/reference/value.md)`(``f``)`\
`## NULL`\
[`close`](https://rdrr.io/r/base/connections.html)`(``con``)`\
[`readLines`](https://rdrr.io/r/base/readLines.html)`(``"output.log"``, warn ``=`` ``FALSE``)`\
`## [1] "hello "`

In other words, the output `"world!"` written by the R worker is
completely lost.

The culprit here is that the connection uses a so called *external
pointer*:

\
[`str`](https://rdrr.io/r/utils/str.html)`(``con``)`\
`## Classes 'file', 'connection'  atomic [1:1] 3`\
`##   ..- attr(*, "conn_id")=<externalptr>`

which is bound to the main R process and makes no sense to the worker.
Ideally, the R process of the worker would detect this and produce an
informative error message, but as seen here, that does not always occur.

## Protect against non-exportable objects

To help avoid exporting non-exportable objects by mistake, which
typically happens because a global variable is non-exportable, the
future framework provides a mechanism for automatically detecting such
objects. To enable it, do:

\
[`options`](https://rdrr.io/r/base/options.html)`(``future.globals.onReference ``=`` ``"error"``)`\
`f`` ``<-`` `[`future`](https://future.futureverse.org/reference/future.md)`(``{`` `[`cat`](https://rdrr.io/r/base/cat.html)`(``"world!"``, file ``=`` ``con``)``; `[`flush`](https://rdrr.io/r/base/connections.html)`(``con``)`` ``}``)`\
`## Error: Detected a non-exportable reference ('externalptr') in one of the globals`\
`## ('con' of class 'file') used in the future expression`

*Comment*: The `future.globals.onReference` option is set to `"ignore"`
by default due to the extra overhead `"error"` introduces, which can be
significant for very large nested objects. Furthermore, some subclasses
of external pointers can be exported without causing problems.

## Packages with non-exportable objects

The below table and sections provide a few examples of non-exportable R
objects that you may run into when trying to parallelize your code, or
simply from trying to reload objects saved in a previous R session. *If
you identify other cases, please consider
[reporting](https://github.com/futureverse/future/issues/) them so they
can be documented here and possibly even be fixed.*

| Package | Examples of non-exportable types or classes |
|:---|:---|
| **arrow** | Table (`externalptr`) |
| **base** | connection (`externalptr`) |
| **bigmemory** | big.matrix (`externalptr`) |
| **cpp11** | E.g. functions created by `cpp_source()` |
| **DBI** | DBIConnection (`externalptr`) |
| **inline** | CFunc (`externalptr` of class DLLHandle) |
| **keras** | keras.engine.sequential.Sequential (`externalptr`), keras.engine.base_layer.Layer (`externalptr`) |
| **magick** | magick-image (`externalptr`) |
| **ncdf4** | ncdf4 (custom reference; *non-detectable*) |
| **parallel** | cluster and cluster nodes (`connection`) |
| **polars** | RPolarsDataFrame (`externalptr`) |
| **raster** | RasterLayer (`externalptr`; *not all*) |
| **Rcpp** | NativeSymbol (`externalptr`) |
| **reticulate** | python.builtin.function (`externalptr`), python.builtin.module (`externalptr`) |
| **rJava** | jclassName (`externalptr`) |
| **ShortRead** | FastqFile, FastqStreamer, FastqStreamerList (`connection`) |
| **sparklyr** | tbl_spark (`externalptr`) |
| **terra** | SpatRaster, SpatVector (`externalptr`) |
| **udpipe** | udpipe_model (`externalptr`) |
| **xgboost** | xgb.DMatrix (`externalptr`) |
| **XML** | XMLInternalDocument, XMLInternalElementNode (`externalptr`) |
| **xml2** | xml_document (`externalptr`) |

These are illustrated in sections ‘Packages that rely on external
pointers’ and ‘Packages with other types of non-external objects’ below.

Importantly, there are objects with external pointers that can indeed be
exported. Here are some examples,

| Package        | Examples of exportable types or classes |
|:---------------|:----------------------------------------|
| **data.table** | data.table (`externalptr`)              |
| **rstan**      | stanmodel (`externalptr`)               |

These are discussed in sections ‘False positives - packages with
exportable external pointers’ at the very end of this vignette.

### Packages with connections

#### Package: parallel

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`future`](https://future.futureverse.org)`)`\
[`plan`](https://future.futureverse.org/reference/plan.md)`(``multisession``, workers ``=`` ``2``)`\
\
`cl`` ``<-`` ``parallel``::`[`makeCluster`](https://rdrr.io/r/parallel/makeCluster.html)`(``2L``)`\
`y`` ``<-`` ``parSapply``(``cl``, X ``=`` ``2``:``3``, FUN ``=`` ``sqrt``)`\
`y`\
`## [1] 1.414214 1.732051`\
\
`y`` `[`%<-%`](https://future.futureverse.org/reference/futureAssign.md)` ``parSapply``(``cl``, X ``=`` ``2``:``3``, FUN ``=`` ``sqrt``)`\
`y`\
`## Error in summary.connection(connection) : invalid connection`

If we turn on `options(future.globals.onReference = "error")`, we will
catch this already when we create the future:

\
`y`` `[`%<-%`](https://future.futureverse.org/reference/futureAssign.md)` ``parSapply``(``cl``, X ``=`` ``2``:``3``, FUN ``=`` ``sqrt``)`\
`## Error: Detected a non-exportable reference ('externalptr') in one of the globals`\
`## ('cl' of class 'SOCKcluster') used in the future expression`

### Packages that rely on external pointers

If an object carries an *external pointer*, it is likely that it can
only be used in the R session where it was created. If it is exported to
and used in a parallel process, it will likely cause an error there. As
shown above, and in below examples, setting option
`future.globals.onReference` to `"error"` will make **future** to scan
for external pointers before launching the future on a parallel worker,
and throw an error if one is detected.

However, there are objects with external pointers that can be exported,
e.g. `data.table` objects of the
**[data.table](https://cran.r-project.org/package=data.table)** package
are one such example. In other words, the existence of a *external
pointer* is just a suggestion for an object being non-exportable - it is
not a sufficient condition.

Below are some examples of packages that produce non-exportable objects
with external pointers.

#### Package: arrow

The **[arrow](https://cran.r-project.org/package=arrow)** package
provides efficient in-memory storage of arrays and tables. However,
these objects cannot be transferred as-is to a parallel worker.

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`arrow`](https://github.com/apache/arrow/)`)`\
\
[`library`](https://rdrr.io/r/base/library.html)`(`[`future`](https://future.futureverse.org)`)`\
[`plan`](https://future.futureverse.org/reference/plan.md)`(``multisession``)`\
\
`data`` ``<-`` `[`as_arrow_table`](https://arrow.apache.org/docs/r/reference/as_arrow_table.html)`(``iris``)`\
`f`` ``<-`` `[`future`](https://future.futureverse.org/reference/future.md)`(`[`dim`](https://rdrr.io/r/base/dim.html)`(``data``)``)`\
`v`` ``<-`` `[`value`](https://future.futureverse.org/reference/value.md)`(``f``)`\
`#> Error: Invalid <Table>, external pointer to null`

This error takes place on the parallel worker. We could set
`options(future.globals.onReference = "error")` to have **future**
detect the problem before it sends the object over to the parallel
worker.

That said, the **arrow** package provides low-level functions
[`write_to_raw()`](https://arrow.apache.org/docs/r/reference/write_to_raw.html)
and
[`read_ipc_stream()`](https://arrow.apache.org/docs/r/reference/read_ipc_stream.html)
that can be used to marshal and unmarshal **arrow** objects. For
example,

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`arrow`](https://github.com/apache/arrow/)`)`\
\
[`library`](https://rdrr.io/r/base/library.html)`(`[`future`](https://future.futureverse.org)`)`\
[`plan`](https://future.futureverse.org/reference/plan.md)`(``multisession``)`\
\
`data`` ``<-`` `[`as_arrow_table`](https://arrow.apache.org/docs/r/reference/as_arrow_table.html)`(``iris``)`\
`.data`` ``<-`` `[`write_to_raw`](https://arrow.apache.org/docs/r/reference/write_to_raw.html)`(``data``)``      ``## marshal`\
`f`` ``<-`` `[`future`](https://future.futureverse.org/reference/future.md)`(``{`\
`  ``data`` ``<-`` `[`read_ipc_stream`](https://arrow.apache.org/docs/r/reference/read_ipc_stream.html)`(``.data``)`` ``## unmarshal`\
`  `[`dim`](https://rdrr.io/r/base/dim.html)`(``data``)`\
`}``)`\
`v`` ``<-`` `[`value`](https://future.futureverse.org/reference/value.md)`(``f``)`\
[`print`](https://rdrr.io/r/base/print.html)`(``v``)`\
`#> [1] 150   5`

#### Package: bigmemory

The **[bigmemory](https://cran.r-project.org/package=bigmemory)**
package provides mechanisms for working with very large matrices that
can be updated in-place, which helps save memory. For example,

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`bigmemory`](https://github.com/kaneplusplus/bigmemory)`)`\
\
`g`` ``<-`` ``function``(``x``)`` ``{`\
`  ``x``[``1``,``1``]`` ``<-`` ``42L`\
`  ``x`\
`}`\
\
`x`` ``<-`` `[`big.matrix`](https://rdrr.io/pkg/bigmemory/man/big.matrix.html)`(``nrow ``=`` ``3``, ncol ``=`` ``2``, type ``=`` ``"integer"``)`\
[`print`](https://rdrr.io/r/base/print.html)`(``x``[``1``,``1``]``)`\
`#> [1] NA`\
\
`void`` ``<-`` ``g``(``x``)`\
[`print`](https://rdrr.io/r/base/print.html)`(``x``[``1``,``1``]``)`\
`#> [1] 42`

Note how `x` was updated in-place. This is achieved by `big.matrix`
objects hold an external pointer to where the matrix data is stored;

\
[`str`](https://rdrr.io/r/utils/str.html)`(``x``)`\
`#> Formal class 'big.matrix' [package "bigmemory"] with 1 slot`\
`#>   ..@ address:<externalptr> `

If we would try to use `x` in a parallel worker, then the parallel
worker crashes due to a bug in **bigmemory**, e.g.

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`bigmemory`](https://github.com/kaneplusplus/bigmemory)`)`\
\
[`library`](https://rdrr.io/r/base/library.html)`(`[`future`](https://future.futureverse.org)`)`\
[`plan`](https://future.futureverse.org/reference/plan.md)`(``multisession``, workers ``=`` ``2``)`\
\
`x`` ``<-`` `[`big.matrix`](https://rdrr.io/pkg/bigmemory/man/big.matrix.html)`(``nrow ``=`` ``3``, ncol ``=`` ``2``, type ``=`` ``"integer"``)`\
`f`` ``<-`` `[`future`](https://future.futureverse.org/reference/future.md)`(`[`dim`](https://rdrr.io/r/base/dim.html)`(``x``)``, packages ``=`` ``"bigmemory"``)`\
[`value`](https://future.futureverse.org/reference/value.md)`(``f``)`\
`#> Error in unserialize(node$con) : `\
`#>   MultisessionFuture (<none>) failed to receive message results from`\
`#> cluster RichSOCKnode #1 (PID 1746676 on localhost 'localhost'). The`\
`#> reason reported was 'error reading from connection'. Post-mortem`\
`#> diagnostic: No process exists with this PID, i.e. the localhost worker`\
`#> is no longer alive. Detected a non-exportable reference`\
`#> ('externalptr') in one of the globals ('x' of class 'big.matrix') used`\
`#> in the future expression. The total size of the 1 globals exported is`\
`#> 696 bytes. There is one global: 'x' (696 bytes of class 'S4')`

We can protect against this by setting:

\
[`options`](https://rdrr.io/r/base/options.html)`(``future.globals.onReference ``=`` ``"error"``)`

which gives:

\
`f`` ``<-`` `[`future`](https://future.futureverse.org/reference/future.md)`(`[`dim`](https://rdrr.io/r/base/dim.html)`(``x``)``, packages ``=`` ``"bigmemory"``)`\
`#> Error: Detected a non-exportable reference ('externalptr') in one`\
`#> of the globals ('x' of class 'big.matrix') used in the future`\
`#> expression`

#### Package: cpp11

Another example is
**[cpp11](https://cran.r-project.org/package=cpp11)**, which allows us
to easily create R functions that are implemented in C++, e.g.

\
`cpp11``::`[`cpp_source`](https://cpp11.r-lib.org/reference/cpp_source.html)`(``code ``=`` ``'`\
`#include "cpp11/doubles.hpp"`\
`using namespace cpp11;`\
\
`[[cpp11::register]]`\
`int my_length(doubles x) {`\
`    return x.size();`\
`}`\
`'``)`

so that:

    x <- rnorm(10)
    my_length(x)
    ## [1] 10

However, this function cannot be exported to another R process:

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`future`](https://future.futureverse.org)`)`\
[`plan`](https://future.futureverse.org/reference/plan.md)`(``multisession``)`\
`x`` ``<-`` `[`rnorm`](https://rdrr.io/r/stats/Normal.html)`(``10``)`\
`n`` `[`%<-%`](https://future.futureverse.org/reference/futureAssign.md)` ``my_length``(``x``)`\
`n`\
`#> Error in .Call("_code_1748ff617940b9_my_length", x, PACKAGE = "code_1748ff617940b9") :`\
`#>   "_code_1748ff617940b9_my_length" not available for .Call() for package "code_1748ff617940b9"`

#### Package: DBI

**[DBI](https://cran.r-project.org/package=DBI)** provides a unified
database interface for communication between R and various database
engines. Analogously to regular connections in R, DBIConnection objects
cannot safely be exported to another R process, e.g.

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`future`](https://future.futureverse.org)`)`\
[`options`](https://rdrr.io/r/base/options.html)`(``future.globals.onReference ``=`` ``"error"``)`\
[`plan`](https://future.futureverse.org/reference/plan.md)`(``multisession``)`\
[`library`](https://rdrr.io/r/base/library.html)`(`[`DBI`](https://dbi.r-dbi.org)`)`\
`con`` ``<-`` `[`dbConnect`](https://dbi.r-dbi.org/reference/dbConnect.html)`(``RSQLite``::`[`SQLite`](https://rsqlite.r-dbi.org/reference/SQLite.html)`(``)``, ``":memory:"``)`\
`dummy`` `[`%<-%`](https://future.futureverse.org/reference/futureAssign.md)` `[`print`](https://rdrr.io/r/base/print.html)`(``con``)`\
`## Error: Detected a non-exportable reference ('externalptr') in one of the globals`\
`## ('con' of class 'SQLiteConnection') used in the future expression`

#### Package: inline

Another example is
**[inline](https://cran.r-project.org/package=inline)**, which allows us
to easily create R functions that are implemented in C and C++, e.g.

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`inline`](https://github.com/eddelbuettel/inline)`)`\
`code`` ``<-`` ``"`\
`  int i;`\
`  for (i = 0; i < *n; i++) x[0] = x[0] + (i+1);`\
`"`\
`sum_1_to_n`` ``<-`` `[`cfunction`](https://rdrr.io/pkg/inline/man/cfunction.html)`(`[`signature`](https://rdrr.io/r/methods/GenericFunctions.html)`(``n``=``"integer"``, x``=``"numeric"``)``, ``code``, language ``=`` ``"C"``, convention ``=`` ``".C"``)`\
`y`` ``<-`` ``sum_1_to_n``(``10``, ``0``)``$``x`\
[`print`](https://rdrr.io/r/base/print.html)`(``y``)`\
`## 55`

However, if we would attempt to call `sum_1_to_n()` in a future, we get
an error:

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`future`](https://future.futureverse.org)`)`\
[`plan`](https://future.futureverse.org/reference/plan.md)`(``cluster``, workers ``=`` ``1L``)`\
`f`` ``<-`` `[`future`](https://future.futureverse.org/reference/future.md)`(``sum_1_to_n``(``10``, ``0``)``)`\
`v`` ``<-`` `[`value`](https://future.futureverse.org/reference/value.md)`(``f``)`\
`## Error in .Primitive(".C")(<pointer: (nil)>, n = as.integer(n), x = as.double(x)) :`\
`##   NULL value passed as symbol address`

This is because:

\
[`options`](https://rdrr.io/r/base/options.html)`(``future.globals.onReference ``=`` ``"error"``)`\
`f`` ``<-`` `[`future`](https://future.futureverse.org/reference/future.md)`(``sum_1_to_n``(``10``, ``0``)``)`\
`## Error: Detected a non-exportable reference ('externalptr' of class`\
`## 'DLLHandle') in one of the globals ('sum_1_to_n' of class 'CFunc')`\
`## used in the future expression`

#### Package: keras

The **[keras](https://cran.r-project.org/package=DBI)** package provides
an R interface to [Keras](https://keras.io/), which “is a high-level
neural networks API developed with a focus on enabling fast
experimentation”. The R implementation accesses the Keras Python API via
**[reticulate](https://cran.r-project.org/package=reticulate)**.
However, Keras model instances in R make use of R connections and
external pointers, which prevents them from being exported to external R
processes. For example, if we attempt to use a Keras model in a
multisession worker, the worker will produce a run-time error:

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`keras`](https://tensorflow.rstudio.com/)`)`\
\
[`library`](https://rdrr.io/r/base/library.html)`(`[`future`](https://future.futureverse.org)`)`\
[`plan`](https://future.futureverse.org/reference/plan.md)`(``multisession``)`\
\
`## Adopted from the 'keras' vignettes`\
`inputs`` ``<-`` `[`layer_input`](https://rdrr.io/pkg/keras/man/layer_input.html)`(``shape ``=`` `[`shape`](https://rdrr.io/pkg/tensorflow/man/shape.html)`(``32``)``)`\
`outputs`` ``<-`` `[`layer_dense`](https://rdrr.io/pkg/keras/man/layer_dense.html)`(``inputs``, units ``=`` ``1L``)`\
`model`` ``<-`` `[`keras_model`](https://rdrr.io/pkg/keras/man/keras_model.html)`(``inputs``, ``outputs``)`\
`model`` ``<-`` `[`compile`](https://generics.r-lib.org/reference/compile.html)`(``model``, optimizer ``=`` ``"adam"``, loss ``=`` ``"mean_squared_error"``)`\
\
`test_input`` ``<-`` `[`array`](https://rdrr.io/r/base/array.html)`(`[`runif`](https://rdrr.io/r/stats/Uniform.html)`(``128`` ``*`` ``32``)``, dim ``=`` `[`c`](https://rdrr.io/r/base/c.html)`(``128``, ``32``)``)`\
`test_target`` ``<-`` `[`array`](https://rdrr.io/r/base/array.html)`(`[`runif`](https://rdrr.io/r/stats/Uniform.html)`(``128``)``, dim ``=`` `[`c`](https://rdrr.io/r/base/c.html)`(``128``, ``1``)``)`\
[`fit`](https://generics.r-lib.org/reference/fit.html)`(``model``, ``test_input``, ``test_target``)`\
\
`f`` ``<-`` `[`future`](https://future.futureverse.org/reference/future.md)`(``{`\
`  ``stats``::`[`predict`](https://rdrr.io/r/stats/predict.html)`(``model``, ``test_input``)`\
`}``, seed ``=`` ``TRUE``)`\
`pred`` ``<-`` `[`value`](https://future.futureverse.org/reference/value.md)`(``f``)`\
`## Error in do.call(object$predict, args) :`\
`##   'what' must be a function or character string`

This error message is not very helpful. But, if we turn on
`options(future.globals.onReference = "error")`, we get more clues;

``` r
Error: Detected a non-exportable reference ('externalptr') in one of the
globals ('model' of class 'keras.engine.functional.Functional') used in
the future expression
```

Functions
[`serialize_model()`](https://rdrr.io/pkg/keras/man/serialize_model.html)
and
[`unserialize_model()`](https://rdrr.io/pkg/keras/man/serialize_model.html)
of the **keras** package can be used as workaround to marshal and
unmarshal non-exportable **keras** objects, e.g.

\
`.model`` ``<-`` `[`serialize_model`](https://rdrr.io/pkg/keras/man/serialize_model.html)`(``model``)``      ``## marshal`\
`f`` ``<-`` `[`future`](https://future.futureverse.org/reference/future.md)`(``{`\
`  ``model`` ``<-`` `[`unserialize_model`](https://rdrr.io/pkg/keras/man/serialize_model.html)`(``.model``)``  ``## unmarshal`\
`  ``stats``::`[`predict`](https://rdrr.io/r/stats/predict.html)`(``model``, ``test_input``)`\
`}``, seed ``=`` ``TRUE``)`\
[`rm`](https://rdrr.io/r/base/rm.html)`(``.model``)`` ``## not needed anymore`\
\
`pred`` ``<-`` `[`value`](https://future.futureverse.org/reference/value.md)`(``f``)`\
[`str`](https://rdrr.io/r/utils/str.html)`(``pred``)`\
`## num [1:128, 1] 0.6937 -0.048 0.2996 -0.0818 1.0673 ...`

#### Package: magick

The **[magick](https://cran.r-project.org/package=magick)** package
provides an R-level API for [ImageMagick](https://imagemagick.org/) to
work with images. When working with this API, the images are represented
internally as external pointers of class ‘magick_image’ that cannot be
exported to another R process, e.g.

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`future`](https://future.futureverse.org)`)`\
[`plan`](https://future.futureverse.org/reference/plan.md)`(``multisession``)`\
[`library`](https://rdrr.io/r/base/library.html)`(`[`magick`](https://docs.ropensci.org/magick/)`)`\
`frink`` ``<-`` ``magick``::`[`image_read`](https://docs.ropensci.org/magick/reference/editing.html)`(``"https://jeroen.github.io/images/frink.png"``)`\
`f`` ``<-`` `[`future`](https://future.futureverse.org/reference/future.md)`(`[`image_fill`](https://docs.ropensci.org/magick/reference/painting.html)`(``frink``, ``"orange"``, ``"+100+200"``, ``20``)``)`\
`v`` ``<-`` `[`value`](https://future.futureverse.org/reference/value.md)`(``f``)`\
`## Error: Image pointer is dead. You cannot save or cache image objects`\
`## between R sessions.`

If we set:

\
[`options`](https://rdrr.io/r/base/options.html)`(``future.globals.onReference ``=`` ``"error"``)`

we’ll see that this is caught even before attempting to run this in
parallel;

``` r
> f <- future(image_fill(frink, "orange", "+100+200", 20))
## Error: Detected a non-exportable reference ('externalptr' of class
## 'magick-image') in one of the globals ('frink' of class 'magick-image')
## used in the future expression
```

#### Package: polars

The **[polars](https://rpolars.github.io/)** package provides objects
for performant processing on tabular data. However, these objects are
tied to the R process that created them. If we attempt to use them in a
parallel worker, we end up crashing the parallel worker:

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`future`](https://future.futureverse.org)`)`\
[`plan`](https://future.futureverse.org/reference/plan.md)`(``multisession``)`\
\
[`library`](https://rdrr.io/r/base/library.html)`(``polars``)`\
`data`` ``<-`` ``as_polars_df``(`[`data.frame`](https://rdrr.io/r/base/data.frame.html)`(``x ``=`` ``1``:``3``)``)`\
`f`` ``<-`` `[`future`](https://future.futureverse.org/reference/future.md)`(`[`dim`](https://rdrr.io/r/base/dim.html)`(``data``)``, packages ``=`` ``"polars"``)`\
`v`` ``<-`` `[`value`](https://future.futureverse.org/reference/value.md)`(``f``)`\
`#> Error: Execution halted with the following contexts`\
`` #>    0: In R: in `$.RPolarsDataFrame` ``\
`#>    0: During function call [workRSOCK()]`\
`` #>    1: This Polars object is not valid. Execute `rm(<object>)` to remove ``\
`#>       the object or restart the R session.`

This is because the external pointer in the `RPolarsDataFrame` object is
erased when transferred to another process, which **polars** (\>=
0.15.0) detects and gives an informative error message about.

#### Package: raster

The **[raster](https://cran.r-project.org/package=raster)** package
provides methods for working with spatial data, which are held in
‘RasterLayer’ objects. Not all but some of these objects use an external
pointer. For example,

``` r
library(future)
plan(multisession)
options(future.globals.onReference = "error")

library(raster)
r <- raster(system.file("external/test.grd", package = "raster"))
tf <- tempfile(fileext = ".grd")
s <- writeStart(r, filename = tf,  overwrite = TRUE)

f <- future({
  print(dim(r))
  print(dim(s))
})
Error: Detected a non-exportable reference ('externalptr') in one of the
globals ('s' of class 'RasterLayer') used in the future expression
```

Note that it is only the RasterLayer object `s` that carries an external
pointer. If we dig deeper, we find that this is because
`attr(s@file, "con")` is file connection opened for writing. This is why
`s` cannot be passed on to an external worker. In contrast, RasterLayer
object `r` does not have this problem and would be fine to pass on to a
worker.

#### Package: Rcpp

Similarly to **cpp11**,
**[Rcpp](https://cran.r-project.org/package=Rcpp)** can be used to
create R functions that are implemented in C++, e.g.

\
`Rcpp``::`[`sourceCpp`](https://rdrr.io/pkg/Rcpp/man/sourceCpp.html)`(``code ``=`` ``'`\
`#include <Rcpp.h>`\
`using namespace Rcpp;`\
\
`// [[Rcpp::export]]`\
`int my_length(NumericVector x) {`\
`    return x.size();`\
`}`\
`'``)`

so that:

    x <- 1:10
    my_length(x)
    ## [1] 10

However, since this function uses an external pointer internally, we
cannot pass it to another R process:

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`future`](https://future.futureverse.org)`)`\
[`plan`](https://future.futureverse.org/reference/plan.md)`(``multisession``)`\
`x`` ``<-`` `[`rnorm`](https://rdrr.io/r/stats/Normal.html)`(``10``)`\
`n`` `[`%<-%`](https://future.futureverse.org/reference/futureAssign.md)` ``my_length``(``x``)`\
`n`\
`## Error in .Call(<pointer: (nil)>, x) : NULL value passed as symbol address`

We can detect and protect against this using:

\
[`options`](https://rdrr.io/r/base/options.html)`(``future.globals.onReference ``=`` ``"error"``)`\
`n`` `[`%<-%`](https://future.futureverse.org/reference/futureAssign.md)` ``my_length``(``x``)`\
`## Error: Detected a non-exportable reference ('externalptr' of class`\
`## 'NativeSymbol') in one of the globals ('my_length' of class 'function')`\
`## used in the future expression`

#### Package: reticulate

The **[reticulate](https://cran.r-project.org/package=reticulate)**
package provides methods for creating and calling Python code from
within R. If one attempts to use Python-binding objects from this
package, we get errors like:

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`future`](https://future.futureverse.org)`)`\
[`plan`](https://future.futureverse.org/reference/plan.md)`(``multisession``)`\
[`library`](https://rdrr.io/r/base/library.html)`(`[`reticulate`](https://rstudio.github.io/reticulate/)`)`\
`os`` ``<-`` `[`import`](https://rstudio.github.io/reticulate/reference/import.html)`(``"os"``)`\
`pwd`` `[`%<-%`](https://future.futureverse.org/reference/futureAssign.md)` ``os``$``getcwd``(``)`\
`pwd`\
`## Error in eval(quote(os$getcwd()), new.env()) :`\
`##   attempt to apply non-function`

and by telling the **future** package to validate globals further, we
get:

\
[`options`](https://rdrr.io/r/base/options.html)`(``future.globals.onReference ``=`` ``"error"``)`\
`pwd`` `[`%<-%`](https://future.futureverse.org/reference/futureAssign.md)` ``os``$``getcwd``(``)`\
`## Error: Detected a non-exportable reference ('externalptr') in one of the`\
`## globals ('os' of class 'python.builtin.module') used in the future expression`

Another reticulate example is when we try to use a Python function that
we create ourselves as in:

\
[`cat`](https://rdrr.io/r/base/cat.html)`(``"def twice(x):\n    return 2*x\n"``, file ``=`` ``"twice.py"``)`\
[`source_python`](https://rstudio.github.io/reticulate/reference/source_python.html)`(``"twice.py"``)`\
`twice``(``1.2``)`\
`## [1] 2.4`\
`y`` `[`%<-%`](https://future.futureverse.org/reference/futureAssign.md)` ``twice``(``1.2``)`\
`y`\
`## Error in unserialize(node$con) :`\
`##   Failed to retrieve the value of MultisessionFuture from cluster node #1`\
`##   (on 'localhost').  The reason reported was 'error reading from connection'`

which, again, is because:

\
[`options`](https://rdrr.io/r/base/options.html)`(``future.globals.onReference ``=`` ``"error"``)`\
`y`` `[`%<-%`](https://future.futureverse.org/reference/futureAssign.md)` ``twice``(``1.2``)`\
`## Error: Detected a non-exportable reference ('externalptr') in one of the globals`\
`## ('twice' of class 'python.builtin.function') used in the future expression`

#### Package: rJava

Here is an example that shows how
**[rJava](https://cran.r-project.org/package=rJava)** objects cannot be
exported to external R processes.

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`future`](https://future.futureverse.org)`)`\
[`plan`](https://future.futureverse.org/reference/plan.md)`(``multisession``)`\
[`library`](https://rdrr.io/r/base/library.html)`(`[`rJava`](https://www.rforge.net/rJava/)`)`\
[`.jinit`](https://rdrr.io/pkg/rJava/man/jinit.html)`(``)`` ``## Initialize Java VM on master`\
\
`Double`` ``<-`` `[`J`](https://rdrr.io/pkg/rJava/man/J.html)`(``"java.lang.Double"``)`\
`d0`` ``<-`` `[`new`](https://rdrr.io/r/methods/new.html)`(``Double``, ``"3.14"``)`\
`d0`\
`## [1] "Java-Object{3.14}"`\
\
`f`` ``<-`` `[`future`](https://future.futureverse.org/reference/future.md)`(``{`\
`  `[`.jinit`](https://rdrr.io/pkg/rJava/man/jinit.html)`(``)`` ``## Initialize Java VM on worker`\
`  `[`new`](https://rdrr.io/r/methods/new.html)`(``Double``, ``"3.14"``)`\
`}``)`\
`d1`` ``<-`` `[`value`](https://future.futureverse.org/reference/value.md)`(``f``)`\
`d1`\
`## [1] "Java-Object<null>"`

Although no error is produced, we see that the value `d1` is a Java NULL
Object. As before, we can catch this by using:

\
[`options`](https://rdrr.io/r/base/options.html)`(``future.globals.onReference ``=`` ``"error"``)`\
`f`` ``<-`` `[`future`](https://future.futureverse.org/reference/future.md)`(``{`\
`  `[`.jinit`](https://rdrr.io/pkg/rJava/man/jinit.html)`(``)`` ``## Initialize Java VM on worker`\
`  `[`new`](https://rdrr.io/r/methods/new.html)`(``Double``, ``"3.14"``)`\
`}``)`\
`## Error: Detected a non-exportable reference ('externalptr') in one of the`\
`## globals ('Double' of class 'jclassName') used in the future expression`

#### Package: ShortRead

The **[ShortRead](https://bioconductor.org/packages/ShortRead/)**
package from Bioconductor implements efficient methods for sampling,
iterating, and reading FASTQ files. Some of the helper objects used
cannot be saved to file or exported to a parallel worker, because they
comprise of connections and other non-exportable objects.

Here is an example that illustrates how an attempt to use a
‘FastqStreamer’ object created in the main R session fails when used in
a parallel worker:

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`future`](https://future.futureverse.org)`)`\
[`plan`](https://future.futureverse.org/reference/plan.md)`(``multisession``)`\
\
`# Adopted from example("FastqStreamer", package = "ShortRead")`\
[`library`](https://rdrr.io/r/base/library.html)`(``ShortRead``)`\
`sp`` ``<-`` ``SolexaPath``(`[`system.file`](https://rdrr.io/r/base/system.file.html)`(``"extdata"``, package ``=`` ``"ShortRead"``)``)`\
`fl`` ``<-`` `[`file.path`](https://rdrr.io/r/base/file.path.html)`(``analysisPath``(``sp``)``, ``"s_1_sequence.txt"``)`\
`fs`` ``<-`` ``FastqStreamer``(``fl``, ``50``)`\
\
`reads`` `[`%<-%`](https://future.futureverse.org/reference/futureAssign.md)` ``yield``(``fs``)`\
`reads`\
`## Error in status(update = TRUE) : invalid FastqStreamer`

To catch this earlier, and to get a more informative error message, we
do as before;

\
[`options`](https://rdrr.io/r/base/options.html)`(``future.globals.onReference ``=`` ``"error"``)`\
\
`reads`` `[`%<-%`](https://future.futureverse.org/reference/futureAssign.md)` ``yield``(``fs``)`\
`## Error: Detected a non-exportable reference ('externalptr') in one of the`\
`## globals ('fs' of class 'FastqStreamer') used in the future expression`

#### Package: sparklyr

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`future`](https://future.futureverse.org)`)`\
[`plan`](https://future.futureverse.org/reference/plan.md)`(``multisession``)`\
[`library`](https://rdrr.io/r/base/library.html)`(`[`sparklyr`](https://spark.posit.co/)`)`\
`sc`` ``<-`` `[`spark_connect`](https://rdrr.io/pkg/sparklyr/man/spark-connections.html)`(``master ``=`` ``"local"``)`\
\
`file`` ``<-`` `[`system.file`](https://rdrr.io/r/base/system.file.html)`(``"misc"``, ``"exDIF.csv"``, package ``=`` ``"utils"``)`\
`data`` ``<-`` `[`spark_read_csv`](https://rdrr.io/pkg/sparklyr/man/spark_read_csv.html)`(``sc``, ``"exDIF"``, ``file``)`\
`d`` `[`%<-%`](https://future.futureverse.org/reference/futureAssign.md)` `[`dim`](https://rdrr.io/r/base/dim.html)`(``data``)`\
`d`\
`## Error in unserialize(node$con) :`\
`##   Failed to retrieve the value of MultisessionFuture (<none>) from cluster`\
`## SOCKnode #1 (PID 29864 on localhost 'localhost'). The reason reported was`\
`## 'unknown input format'. Post-mortem diagnostic: A process with this PID`\
`## exists, which suggests that the localhost worker is still alive.`

To catch this as soon as possible,

\
[`options`](https://rdrr.io/r/base/options.html)`(``future.globals.onReference ``=`` ``"error"``)`\
`d`` `[`%<-%`](https://future.futureverse.org/reference/futureAssign.md)` `[`dim`](https://rdrr.io/r/base/dim.html)`(``data``)`\
`## Error: Detected a non-exportable reference ('externalptr') in one of`\
`## the globals ('data' of class 'tbl_spark') used in the future expression`

#### Package: terra

``` r
library(future)
plan(multisession)
library(terra)

file <- system.file("ex/lux.shp", package = "terra")
v <- vect(file)
dv %<-% dim(v)
dv
Error in x@ptr$nrow() : external pointer is not valid

file <- system.file("ex/elev.tif", package = "terra")
r <- rast(file)
dr %<-% dim(r)
dr
## Error in .External(list(name = "CppMethod__invoke_notvoid", address = <pointer: (nil)>,  :
##  NULL value passed as symbol address
```

To catch this as soon as possible,

\
[`options`](https://rdrr.io/r/base/options.html)`(``future.globals.onReference ``=`` ``"error"``)`\
\
`dv`` `[`%<-%`](https://future.futureverse.org/reference/futureAssign.md)` `[`dim`](https://rdrr.io/r/base/dim.html)`(``v``)`\
`## Error: Detected a non-exportable reference ('externalptr' of class`\
`## 'RegisteredNativeSymbol') in one of the globals ('v' of class`\
`## 'SpatVector') used in the future expression`\
\
`dr`` `[`%<-%`](https://future.futureverse.org/reference/futureAssign.md)` `[`dim`](https://rdrr.io/r/base/dim.html)`(``data``)`\
`## Error: Detected a non-exportable reference ('externalptr' of class`\
`## 'RegisteredNativeSymbol') in one of the globals ('r' of class`\
`## 'SpatRaster') used in the future expression`

Functions `wrap()` and `unwrap()` of the **terra** package can be used
as workaround to marshal and unmarshal non-exportable **terra** objects,
e.g.

``` r
library(future)
plan(multisession)
library(terra)

file <- system.file("ex/lux.shp", package = "terra")
v <- vect(file)
.v <- wrap(v)      ## marshal
dv %<-% {
  v <- unwrap(.v)  ## unmarshal
  dim(v)
}
rm(.v) ## not needed anymore
dv
[1] 12  6
```

and

``` r
file <- system.file("ex/elev.tif", package = "terra")
r <- rast(file)
.r <- wrap(r)      ## marshal
dr %<-% {
  r <- unwrap(.r)  ## unmarshal
  dim(r)
}
rm(.r) ## not needed anymore
dr
[1] 90 95  1
```

For more details, see
[`help("wrap", package = "terra")`](https://rspatial.github.io/terra/reference/wrap.html).

#### Package: udpipe

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`future`](https://future.futureverse.org)`)`\
[`plan`](https://future.futureverse.org/reference/plan.md)`(``multisession``)`\
[`library`](https://rdrr.io/r/base/library.html)`(`[`udpipe`](https://bnosac.github.io/udpipe/en/index.html)`)`\
`udmodel`` ``<-`` `[`udpipe_download_model`](https://rdrr.io/pkg/udpipe/man/udpipe_download_model.html)`(``language ``=`` ``"dutch"``)`\
`udmodel`` ``<-`` `[`udpipe_load_model`](https://rdrr.io/pkg/udpipe/man/udpipe_load_model.html)`(``file ``=`` ``udmodel``$``file_model``)`\
`x`` `[`%<-%`](https://future.futureverse.org/reference/futureAssign.md)` `[`udpipe_annotate`](https://rdrr.io/pkg/udpipe/man/udpipe_annotate.html)`(``udmodel``, x ``=`` ``"Ik ging op reis en ik nam mee."``)`\
`x`\
`## Error in udp_tokenise_tag_parse(object$model, x, doc_id, tokenizer, tagger,  :`\
`##   external pointer is not valid`

To catch this as soon as possible,

\
[`options`](https://rdrr.io/r/base/options.html)`(``future.globals.onReference ``=`` ``"error"``)`\
`x`` `[`%<-%`](https://future.futureverse.org/reference/futureAssign.md)` `[`udpipe_annotate`](https://rdrr.io/pkg/udpipe/man/udpipe_annotate.html)`(``udmodel``, x ``=`` ``"Ik ging op reis en ik nam mee."``)`\
`## Error: Detected a non-exportable reference ('externalptr') in one of the`\
`## globals ('udmodel' of class 'udpipe_model') used in the future expression`

Now, it is indeed possible to parallelize
**[udpipe](https://cran.r-project.org/package=udpipe)** calls. For
details on how to do this, see the ‘UDPipe Natural Language Processing -
Parallel’ vignette that comes with the **udpipe** package.

#### Package: xgboost

The **[xgboost](https://cran.r-project.org/package=xgboost)** package
provides fast gradient-boosting methods. Some of its data structures use
external pointers. For example,

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`future`](https://future.futureverse.org)`)`\
[`plan`](https://future.futureverse.org/reference/plan.md)`(``multisession``)`\
\
[`library`](https://rdrr.io/r/base/library.html)`(`[`xgboost`](https://github.com/dmlc/xgboost)`)`\
[`data`](https://rdrr.io/r/utils/data.html)`(``agaricus.train``, package ``=`` ``"xgboost"``)`\
`train`` ``<-`` `[`xgb.DMatrix`](https://rdrr.io/pkg/xgboost/man/xgb.DMatrix.html)`(``agaricus.train``$``data``, label ``=`` ``agaricus.train``$``label``)`\
[`class`](https://rdrr.io/r/base/class.html)`(``train``)`\
`## [1] "xgb.DMatrix"`\
\
`d`` ``<-`` `[`dim`](https://rdrr.io/r/base/dim.html)`(``train``)`\
`d`\
`## [1] 6513  126`

works just fine, but if we attempt to pass the ‘xgb.DMatrix’ object
`train` to an external worker, we silently get an incorrect value:

\
`f`` ``<-`` `[`future`](https://future.futureverse.org/reference/future.md)`(`[`dim`](https://rdrr.io/r/base/dim.html)`(``train``)``)`\
`d`` ``<-`` `[`value`](https://future.futureverse.org/reference/value.md)`(``f``)`\
`d`\
`## NULL`

This is unfortunate, but we can at least detect this by:

\
[`options`](https://rdrr.io/r/base/options.html)`(``future.globals.onReference ``=`` ``"error"``)`\
`f`` ``<-`` `[`future`](https://future.futureverse.org/reference/future.md)`(`[`dim`](https://rdrr.io/r/base/dim.html)`(``dtrain``)``)`\
`## Error: Detected a non-exportable reference ('externalptr' of class 'xgb.DMatrix')`\
`## in one of the globals ('dtrain' of class 'xgb.DMatrix') used in the future expression`

This is because `train` itself is an external pointer,
i.e. `mode(train) == "externalptr"`.

#### Package: XML

Another example is XML objects of the
**[XML](https://cran.r-project.org/package=XML)** package, which may
produce evaluation error, or even cause R to abort if used in another R
process, e.g.

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`future`](https://future.futureverse.org)`)`\
[`plan`](https://future.futureverse.org/reference/plan.md)`(``multisession``)`\
[`library`](https://rdrr.io/r/base/library.html)`(``XML``)`\
`doc`` ``<-`` `[`xmlParse`](https://rdrr.io/pkg/XML/man/xmlTreeParse.html)`(`[`system.file`](https://rdrr.io/r/base/system.file.html)`(``"exampleData"``, ``"tagnames.xml"``, package ``=`` ``"XML"``)``)`\
`a`` ``<-`` `[`getNodeSet`](https://rdrr.io/pkg/XML/man/getNodeSet.html)`(``doc``, ``"/doc//a[@status]"``)``[[``1``]``]`\
`f`` ``<-`` `[`future`](https://future.futureverse.org/reference/future.md)`(`[`xmlGetAttr`](https://rdrr.io/pkg/XML/man/xmlGetAttr.html)`(``a``, ``"status"``)``)`\
[`value`](https://future.futureverse.org/reference/value.md)`(``f``)`\
`## Error in unserialize(node$con) :`\
`##   MultisessionFuture (<none>) failed to receive results from cluster`\
`## RichSOCKnode #1 (PID 31541 on localhost 'localhost'). The reason`\
`## reported was 'error reading from connection'. Post-mortem diagnostic:`\
`## No process exists with this PID, i.e. the localhost worker is no`\
`## longer alive. Detected a non-exportable reference ('externalptr' of`\
`## class 'XMLInternalElementNode') in one of the globals ('a' of class`\
`## 'XMLInternalElementNode') used in the future expression. The total`\
`## size of the 1 globals exported is 520 bytes. There is one global: 'a'`\
`## (520 bytes of class 'externalptr')`

This is an example, where we end up exporting an
`XMLInternalElementNode` object to another R process, where it is no
longer valid. When we try to use it there by calling
[`xmlGetAttr()`](https://rdrr.io/pkg/XML/man/xmlGetAttr.html) on it,
**XML** causes R to crash and abort. To illustrate what’s going on the
parallel workers, if we save the object to file using
`saveRDS(a, "a.rds")`, and try to use it in *another* R session, the
following happens:

``` r
$ R --quiet --vanilla
> a <- readRDS("a.rds")
> XML::xmlGetAttr(a, "status")

 *** caught segfault ***
address 0x40, cause 'memory not mapped'

Traceback:
 1: xmlAttrs.XMLInternalNode(node, addNamespace)
 2: xmlAttrs(node, addNamespace)
 3: XML::xmlGetAttr(a, "status")

Possible actions:
1: abort (with core dump, if enabled)
2: normal R exit
3: exit R without saving workspace
4: exit R saving workspace
Selection:
```

This is a very harsh way of telling us that we cannot export all types
of objects produced by **XML**. Ideally, **XML** would detect this and
give an informative error message and not crash R like this.

A workaround is to marshal the problematic objects before exporting them
to a parallel R process, and unmarshal them before working with them
there. For example,

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`future`](https://future.futureverse.org)`)`\
[`plan`](https://future.futureverse.org/reference/plan.md)`(``multisession``)`\
[`library`](https://rdrr.io/r/base/library.html)`(``XML``)`\
`doc`` ``<-`` `[`xmlParse`](https://rdrr.io/pkg/XML/man/xmlTreeParse.html)`(`[`system.file`](https://rdrr.io/r/base/system.file.html)`(``"exampleData"``, ``"tagnames.xml"``, package ``=`` ``"XML"``)``)`\
`a`` ``<-`` `[`getNodeSet`](https://rdrr.io/pkg/XML/man/getNodeSet.html)`(``doc``, ``"/doc//a[@status]"``)``[[``1``]``]`\
\
`## Marshall the non-exportable XMLInternalElementNode object`\
`.a`` ``<-`` `[`xmlSerializeHook`](https://rdrr.io/pkg/XML/man/xmlSerializeHook.html)`(``a``)``      ``## marshal`\
\
`f`` ``<-`` `[`future`](https://future.futureverse.org/reference/future.md)`(``{`\
`  ``a`` ``<-`` `[`xmlDeserializeHook`](https://rdrr.io/pkg/XML/man/xmlSerializeHook.html)`(``.a``)``  ``## unmarshal`\
`  `[`xmlGetAttr`](https://rdrr.io/pkg/XML/man/xmlGetAttr.html)`(``a``, ``"status"``)`\
`}``)`\
[`value`](https://future.futureverse.org/reference/value.md)`(``f``)`\
`## [1] "xyz"`

An alternative, more generic workaround, is to always create the `doc`
element, an `XMLInternalDocument` object, on the parallel workers, i.e.

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`future`](https://future.futureverse.org)`)`\
[`plan`](https://future.futureverse.org/reference/plan.md)`(``multisession``)`\
[`library`](https://rdrr.io/r/base/library.html)`(``XML``)`\
\
`f`` ``<-`` `[`future`](https://future.futureverse.org/reference/future.md)`(``{`\
`  ``doc`` ``<-`` `[`xmlParse`](https://rdrr.io/pkg/XML/man/xmlTreeParse.html)`(`[`system.file`](https://rdrr.io/r/base/system.file.html)`(``"exampleData"``, ``"tagnames.xml"``, package ``=`` ``"XML"``)``)`\
`  ``a`` ``<-`` `[`getNodeSet`](https://rdrr.io/pkg/XML/man/getNodeSet.html)`(``doc``, ``"/doc//a[@status]"``)``[[``1``]``]`\
`  `[`xmlGetAttr`](https://rdrr.io/pkg/XML/man/xmlGetAttr.html)`(``a``, ``"status"``)`\
`}``)`\
[`value`](https://future.futureverse.org/reference/value.md)`(``f``)`\
`## [1] "xyz"`

#### Package: xml2

Yet another example is XML objects of the
**[xml2](https://cran.r-project.org/package=xml2)** package, which may
produce evaluation errors (or just invalid results depending on how they
are used), e.g.

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`future`](https://future.futureverse.org)`)`\
[`plan`](https://future.futureverse.org/reference/plan.md)`(``multisession``)`\
[`library`](https://rdrr.io/r/base/library.html)`(`[`xml2`](https://xml2.r-lib.org)`)`\
`doc`` ``<-`` `[`read_xml`](http://xml2.r-lib.org/reference/read_xml.md)`(``"<body></body>"``)`\
`f`` ``<-`` `[`future`](https://future.futureverse.org/reference/future.md)`(`[`xml_children`](http://xml2.r-lib.org/reference/xml_children.md)`(``doc``)``)`\
[`value`](https://future.futureverse.org/reference/value.md)`(``f``)`\
`## Error: external pointer is not valid`

The future framework can help detect this *before* sending off the
future to the worker;

\
[`options`](https://rdrr.io/r/base/options.html)`(``future.globals.onReference ``=`` ``"error"``)`\
`f`` ``<-`` `[`future`](https://future.futureverse.org/reference/future.md)`(`[`xml_children`](http://xml2.r-lib.org/reference/xml_children.md)`(``xml``)``)`\
`## Error: Detected a non-exportable reference ('externalptr') in one of the`\
`## globals ('xml' of class 'xml_document') used in the future expression`

One workaround when dealing with non-exportable objects is to look for
ways to encode the object such that it can be exported, and then decoded
on the receiving end. With **xml2**, we can use
[`xml2::xml_serialize()`](http://xml2.r-lib.org/reference/xml_serialize.md)
and
[`xml2::xml_unserialize()`](http://xml2.r-lib.org/reference/xml_serialize.md)
to do this. Here is how we can rewrite the above example such that we
can pass **xml2** object back and forth between the main R session and R
workers:

\
`## Encode the 'xml_document' object 'doc' as a 'raw' object`\
`.doc`` ``<-`` `[`xml_serialize`](http://xml2.r-lib.org/reference/xml_serialize.md)`(``doc``, connection ``=`` ``NULL``)``  ``## marshal`\
\
`f`` ``<-`` `[`future`](https://future.futureverse.org/reference/future.md)`(``{`\
`  ``## In the future, reconstruct the 'xml_document' object`\
`  ``## from the 'raw' object`\
`  ``doc`` ``<-`` `[`xml_unserialize`](http://xml2.r-lib.org/reference/xml_serialize.md)`(``.doc``)``                 ``## unmarshal`\
\
`  ``## Continue as usual`\
`  ``children`` ``<-`` `[`xml_children`](http://xml2.r-lib.org/reference/xml_children.md)`(``doc``)`\
\
`  ``## Send back a 'raw' representation of the 'xml_nodeset'`\
`  ``## object 'children'`\
`  `[`xml_serialize`](http://xml2.r-lib.org/reference/xml_serialize.md)`(``children``, connection ``=`` ``NULL``)`\
`}``)`\
\
`## Reconstruct the 'xml_nodeset' object in the main R session`\
`children`` ``<-`` `[`xml_unserialize`](http://xml2.r-lib.org/reference/xml_serialize.md)`(`[`value`](https://future.futureverse.org/reference/value.md)`(``f``)``)`

### Packages with other types of non-external objects

#### Package: ncdf4

Package **[ncdf4](https://cran.r-project.org/package=ncdf4)** provides
an R API to work with data that live in netCDF files. For example, we
can create a simple netCDF file that holds a variable ‘x’:

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`ncdf4`](https://cirrus.ucsd.edu/~pierce/ncdf/)`)`\
`x`` ``<-`` `[`ncvar_def`](https://rdrr.io/pkg/ncdf4/man/ncvar_def.html)`(``"x"``, units ``=`` ``"count"``, dim ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``)``)`\
`file`` ``<-`` `[`nc_create`](https://rdrr.io/pkg/ncdf4/man/nc_create.html)`(``"example.nc"``, ``x``)`\
[`ncvar_put`](https://rdrr.io/pkg/ncdf4/man/ancvar_put.html)`(``file``, ``x``, ``42``)`\
[`nc_close`](https://rdrr.io/pkg/ncdf4/man/nc_close.html)`(``file``)`

We can now use this netCDF file next time we start R, e.g.

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`ncdf4`](https://cirrus.ucsd.edu/~pierce/ncdf/)`)`\
`file`` ``<-`` `[`nc_open`](https://rdrr.io/pkg/ncdf4/man/nc_open.html)`(``"example.nc"``)`\
`y`` ``<-`` `[`ncvar_get`](https://rdrr.io/pkg/ncdf4/man/ncvar_get.html)`(``file``)`\
`y`\
`## [1] 42`

However, it would fail if we attempt to use `file`, which is an object
of class ‘ncdf4’, in a parallel worker, we will get an error:

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`future`](https://future.futureverse.org)`)`\
[`plan`](https://future.futureverse.org/reference/plan.md)`(``multisession``)`\
[`library`](https://rdrr.io/r/base/library.html)`(`[`ncdf4`](https://cirrus.ucsd.edu/~pierce/ncdf/)`)`\
`file`` ``<-`` `[`nc_open`](https://rdrr.io/pkg/ncdf4/man/nc_open.html)`(``"example.nc"``)`\
`f`` ``<-`` `[`future`](https://future.futureverse.org/reference/future.md)`(`[`ncvar_get`](https://rdrr.io/pkg/ncdf4/man/ncvar_get.html)`(``file``)``)`\
`y`` ``<-`` `[`value`](https://future.futureverse.org/reference/value.md)`(``f``)`\
`## Error in R_nc4_inq_varndims: NetCDF: Not a valid ID`\
`## Error in ncvar_ndims(ncid, varid) : error returned from C call`

This is because ncdf4 objects make use of internal references that are
unique to the R session where they were created. However, these are
*not* formal *external pointer*:s, meaning the future framework cannot
detect them. That is, using
`options(future.globals.onReference = "error")` is of no help here.

A workaround is to open the netCDF in each worker, e.g.

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`future`](https://future.futureverse.org)`)`\
[`plan`](https://future.futureverse.org/reference/plan.md)`(``multisession``)`\
[`library`](https://rdrr.io/r/base/library.html)`(`[`ncdf4`](https://cirrus.ucsd.edu/~pierce/ncdf/)`)`\
`f`` ``<-`` `[`future`](https://future.futureverse.org/reference/future.md)`(``{`\
`  ``file`` ``<-`` `[`nc_open`](https://rdrr.io/pkg/ncdf4/man/nc_open.html)`(``"example.nc"``)`\
`  ``value`` ``<-`` `[`ncvar_get`](https://rdrr.io/pkg/ncdf4/man/ncvar_get.html)`(``file``)`\
`  `[`nc_close`](https://rdrr.io/pkg/ncdf4/man/nc_close.html)`(``file``)`\
`  ``value`\
`}``)`\
`y`` ``<-`` `[`value`](https://future.futureverse.org/reference/value.md)`(``f``)`\
`y`\
`## [1] 42`

### False positives - packages with exportable external pointers

#### Package data.table

The **[data.table](https://cran.r-project.org/package=data.table)**
package creates objects comprising external pointers. Contrary to the
above non-exportable examples, such objects can be saved to file and
used in another R session, or exported to a parallel worker. This is
because **data.table** is capable of restoring these objects to a valid
state. Consider the following example:

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`data.table`](https://r-datatable.com)`)`\
`DT`` ``<-`` `[`data.table`](https://rdrr.io/pkg/data.table/man/data.table.html)`(``a ``=`` ``1``:``3``, b ``=`` ``letters``[``1``:``3``]``)`\
\
`## Extract second row`\
`row`` ``<-`` ``DT``[``2``]`\
[`print`](https://rdrr.io/r/base/print.html)`(``row``)`\
`#>    a b`\
`#> 1: 2 b`

If we would try the last step with a future with strict checking for
references enabled, we would get an error:

``` r
library(future)
plan(multisession)
options(future.globals.onReference = "error")

row %<-% DT[2]
Error: Detected a non-exportable reference ('externalptr') in one of
the globals ('DT' of class 'data.table') used in the future expression
```

This is a false positive. If we relax the checks, it does indeed work:

\
[`options`](https://rdrr.io/r/base/options.html)`(``future.globals.onReference ``=`` ``NULL``)`\
\
`row`` ``<-`` ``DT``[``2``]`\
[`print`](https://rdrr.io/r/base/print.html)`(``row``)`\
`#>    a b`\
`#> 1: 2 b`

#### Package rstan

The **[rstan](https://cran.r-project.org/package=rstan)** package
creates objects comprising external pointers. Contrary to above
non-exportable examples, such objects can be saved to file and used in
another R session, or exported to a parallel worker. This is because
**rstan** is capable of restoring these objects to a valid state.
Consider the following example from
`example("rstan", package = "rstan")`:

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`rstan`](https://mc-stan.org/rstan/)`)`\
\
`code`` ``<-`` ``"`\
`data {`\
`  int<lower=0> N;`\
`  real y[N];`\
`}`\
\
`parameters {`\
`  real mu;`\
`}`\
\
`model {`\
`  target += normal_lpdf(mu | 0, 10);`\
`  target += normal_lpdf(y  | mu, 1);`\
`}`\
`"`\
\
`y`` ``<-`` `[`rnorm`](https://rdrr.io/r/stats/Normal.html)`(``20``)`\
`data`` ``<-`` `[`list`](https://rdrr.io/r/base/list.html)`(``N ``=`` ``20``, y ``=`` ``y``)`\
`fit`` ``<-`` `[`stan`](https://mc-stan.org/rstan/reference/stan.html)`(``model_code ``=`` ``code``, model_name ``=`` ``"example"``,`\
`            data ``=`` ``data``, iter ``=`` ``2012L``, chains ``=`` ``3L``,`\
`            sample_file ``=`` `[`file.path`](https://rdrr.io/r/base/file.path.html)`(`[`tempdir`](https://rdrr.io/r/base/tempfile.html)`(``)``, ``"norm.csv"``)``)`\
\
`e`` ``<-`` `[`extract`](https://mc-stan.org/rstan/reference/stanfit-method-extract.html)`(``fit``, permuted ``=`` ``FALSE``)`

If we would try the last step with a future with strict checking for
references enabled, we would get an error:

``` r
library(future)
plan(multisession)
options(future.globals.onReference = "error")

e %<-% extract(fit, permuted = FALSE)
Error: Detected a non-exportable reference ('externalptr' of class 'DLLHandle')
in one of the globals ('fit' of class 'stanfit') used in the future expression
```

However, this is a false positive. The `fit` object, which is of class
‘stanfit’, can indeed be exported to be used in an external R process,
e.g.

\
[`options`](https://rdrr.io/r/base/options.html)`(``future.globals.onReference ``=`` ``NULL``)`\
\
`e`` `[`%<-%`](https://future.futureverse.org/reference/futureAssign.md)` `[`extract`](https://mc-stan.org/rstan/reference/stanfit-method-extract.html)`(``fit``, permuted ``=`` ``FALSE``)`\
[`str`](https://rdrr.io/r/utils/str.html)`(``e``)`\
`#>  num [1:1006, 1:3, 1:2] -0.3028 -0.4017 -0.3379 -0.2358 0.0443 ...`\
`#>  - attr(*, "dimnames")=List of 3`\
`#>   ..$ iterations: NULL`\
`#>   ..$ chains    : chr [1:3] "chain:1" "chain:2" "chain:3"`\
`#>   ..$ parameters: chr [1:2] "mu" "lp__"`
