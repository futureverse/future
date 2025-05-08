## TL;DR

The Futureverse makes it easy to parallelize existing R code - often
with only a minor change of code.  It lowers the barriers so that
anyone can safely speed up their existing R code in a worry-free
manner. It is a cross-platform solution that requires no additional
setups or technical skills. Anyone can be up and running within a few
minutes.

```r
library(future)
plan(multisession)

## Evaluate an R expression sequentially
y <- slow_fcn(X[1])

## Evaluate it in parallel in the background
f <- future(slow_fcn(X[1]))
y <- value(f)

## future.apply: futurized version of base R apply
library(future.apply)
y <-        lapply(X, slow_fcn)
y <- future_lapply(X, slow_fcn)

## furrr: futurized version of purrr
library(furrr)
y <- X |>        map(slow_fcn)
y <- X |> future_map(slow_fcn)

## foreach: futurized version (modern)
library(foreach)
y <- foreach(x = X) %do%       slow_fcn(x)
y <- foreach(x = X) %dofuture% slow_fcn(x)

## foreach: futurized version (traditional)
library(foreach)
doFuture::registerDoFuture()
y <- foreach(x = X) %do%    slow_fcn(x)
y <- foreach(x = X) %dopar% slow_fcn(x)
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
