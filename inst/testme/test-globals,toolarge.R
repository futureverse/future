#' @tags globals too-large
#' @tags multisession

library(future)

message("*** Globals - too large ...")

a <- integer(length = 1000)
ooptsT <- options(future.globals.maxSize = object.size(a) - 100L)
limit <- getOption("future.globals.maxSize")
cat(sprintf("Max total size of globals: %g bytes\n", limit))

plan(multisession, workers = 2L)
print(plan("backend"))

exprs <- list(
  A = substitute({ a                 }, env = list()),
  B = substitute({ a * b             }, env = list()),
  C = substitute({ a * b * c         }, env = list()),
  D = substitute({ a * b * c * d     }, env = list()),
  E = substitute({ a * b * c * d * e }, env = list())
)

a <- integer(length = 1000)
b <- integer(length =  900)
c <- integer(length =  800)
d <- integer(length =  700)
e <- integer(length =    1)

for (name in names(exprs)) {
  message(sprintf("Expression %s:", name))
  expr <- exprs[[name]]
  print(expr)
  res <- tryCatch({
    f <- future(expr, substitute = FALSE)
  }, error = function(ex) ex)
  print(res)
  stopifnot(inherits(res, "error"))
  msg <- conditionMessage(res)
  stopifnot(grepl("exceeds the maximum allowed size", msg))
}

message("*** Globals - too large ... DONE")

