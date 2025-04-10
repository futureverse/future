#' @tags startup parseCmdArgs

library(future)
options(future.debug = FALSE)

maxCores <- min(2L, availableCores(methods = "system"))

plan("default")
 
message("*** parseCmdArgs() ...")

args <- parseCmdArgs()
str(args)

options(future.plan = NULL, future.cmdargs = c("-p", 1L))
args <- parseCmdArgs()
str(args)
stopifnot(args$p == 1L)

options(future.plan = NULL, future.cmdargs = c(sprintf("--parallel=%d", maxCores)))
args <- parseCmdArgs()
str(args)
stopifnot(args$p == maxCores)

options(future.plan = NULL, future.cmdargs = c("-p", 1L, sprintf("--parallel=%d", maxCores)))
args <- parseCmdArgs()
str(args)
stopifnot(args$p == maxCores)

options(future.plan = NULL, future.cmdargs = c("-p", 0L))
args <- parseCmdArgs()
stopifnot(is.null(args$p))
res <- tryCatch(parseCmdArgs(), warning = function(w) w)
stopifnot(inherits(res, "warning"))

options(future.plan = NULL, future.cmdargs = c("-p", .Machine$integer.max))
args <- parseCmdArgs()
stopifnot(is.null(args$p))
res <- tryCatch(parseCmdArgs(), warning = function(w) w)
stopifnot(inherits(res, "warning"))

options(future.plan = NULL, future.cmdargs = NULL)

message("*** parseCmdArgs() ... DONE")

