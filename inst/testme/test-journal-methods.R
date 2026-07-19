#' @tags journal sequential

library(future)

journal <- future:::journal

oopts <- options(future.journal = TRUE)
plan(sequential)

mkfuture <- function(x) {
  f <- future(x)
  value(f)
  f
}

f1 <- mkfuture(1L)
f2 <- mkfuture(2L)

message("*** journal() - Future ...")

j <- journal(f1)
print(class(j))
stopifnot(inherits(j, "FutureJournal"), is.data.frame(j), nrow(j) > 0L)
stopifnot(all(c("event", "start") %in% names(j)))

message("*** journal() - Future ... DONE")


message("*** journal() - FutureJournal ...")

## Without a baseline the journal is returned as-is
stopifnot(identical(journal(j), j))

## 'baseline = TRUE' uses the first observed timestamp
j2 <- journal(j, baseline = TRUE)
print(class(j2))
stopifnot(inherits(j2, "FutureJournal"), "at" %in% names(j2))
stopifnot(min(j2[["at"]], na.rm = TRUE) == 0)

## A numeric baseline is used as-is
j3 <- journal(j, baseline = 0)
stopifnot(inherits(j3, "FutureJournal"), "at" %in% names(j3))

message("*** journal() - FutureJournal ... DONE")


message("*** journal() - list ...")

## Journals of several futures are stacked
jl <- journal(list(f1, f2))
print(class(jl))
stopifnot(inherits(jl, "FutureJournal"), is.data.frame(jl))
stopifnot(nrow(jl) == nrow(journal(f1)) + nrow(journal(f2)))

## The relative times are measured from the earliest event of all futures
stopifnot("at" %in% names(jl))
stopifnot(min(jl[["at"]], na.rm = TRUE) == 0)

## An explicit baseline is passed through
jl2 <- journal(list(f1, f2), baseline = 0)
stopifnot(inherits(jl2, "FutureJournal"), nrow(jl2) == nrow(jl))

message("*** journal() - list ... DONE")


message("*** summary() - FutureJournal ...")

s <- summary(j)
print(class(s))
stopifnot(inherits(s, "FutureJournalSummary"), is.data.frame(s))

## 'workers' scales the summary
s2 <- summary(j, workers = 2)
stopifnot(inherits(s2, "FutureJournalSummary"))

## 'workers' must be a single, finite value >= 1
for (workers in list(c(1, 2), NA_real_, 0, "two")) {
  res <- tryCatch(summary(j, workers = workers), error = identity)
  print(res)
  stopifnot(inherits(res, "error"))
}

## The summary can be printed
print(s)

message("*** summary() - FutureJournal ... DONE")

options(oopts)
plan(sequential)
