#' @tags demo fibonacci
#' @tags sequential

library(future)
plan(sequential)
options(future.debug = FALSE)

message("*** Fibonacci demo of the 'future' package ...")
# Temporarily protect against non-default R_FUTURE_PLAN
oopts <- options(future.plan = NULL)
demo("fibonacci", package = "future", ask = FALSE)
options(oopts)
message("*** Fibonacci demo of the 'future' package ... DONE")
