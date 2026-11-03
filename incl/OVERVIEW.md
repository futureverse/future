## TL;DR

The Futureverse makes it easy to parallelize existing R code - often
with only a minor change of code.  It lowers the barriers so that
anyone can safely speed up their existing R code in a worry-free
manner. It is a cross-platform solution that requires no additional
setups or technical skills. Anyone can be up and running within a few
minutes.

At the core of Futureverse is this package, the **future**
package. Most users interact with the future ecosystem using
higher-level packages such as **[futurize]** for its convenience of
running map-reduce calls concurrently.  Here are some examples for
**futurize**:

```r
library(futurize)
plan(multisession)  # parallelize on the current machine

# A slow function
slow_fcn <- function(x) {
  Sys.sleep(1.0)
  x^2
}

# Example data
xs <- 1:10

# Sequential and parallel base R apply
ys <- lapply(xs, slow_fcn)
ys <- lapply(xs, slow_fcn) |> futurize()

# Sequential and parallel purrr map
library(purrr)
ys <- xs |>  map(slow_fcn)
ys <- xs |>  map(slow_fcn) |> futurize()

# Sequential and parallel foreach calls
library(foreach)
ys <- foreach(x = xs) %do% slow_fcn(x)
ys <- foreach(x = xs) %do% slow_fcn(x) |> futurize()
```


<%
## Reuse the future vignette
md <- R.rsp::rstring(file="vignettes/future-1-overview.md.rsp", postprocess=FALSE)

## Drop the header, i.e. anything before the first "H2" header
md <- unlist(strsplit(md, split="\n", fixed=TRUE))
row <- grep("^## ", md)[1]
if (!is.na(row)) md <- md[-seq_len(row-1)]

## Drop the footer, i.e. anything after the first horizontal line
row <- grep("^---", md)[1]
if (!is.na(row)) md <- md[seq_len(row-1)]

## Turn otherwise local links to CRAN for README.md
md <- gsub(": (future-.*[.]html)",
           ": https://cran.r-project.org/web/packages/future/vignettes/\\1", md)

## Output
cat(md, sep="\n")
%>

[futurize]: https://futurize.futureverse.org/
