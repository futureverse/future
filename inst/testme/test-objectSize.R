#' @tags globals objectSize

library(future)

objectSize <- future:::objectSize

message("objectSize() ...")

env <- new.env()
env$a <- 3.14
env$b <- 1:100

env2 <- new.env()
env2$env <- env

## Namespaces will be skipped
env3 <- getNamespace("utils")

fcn <- function(...) TRUE

objs <- list(
  NULL,
  TRUE,
  1L,
  3.14,
  "hello",
  1:100,
  1:100 + 0.1,
  letters,
  list(a = 3.14, b = 1:100),
  list(a = 3.14, b = 1:100, c = list(a = 3.14, b = 1:100)),
  env,
  env2,
  env3,
  fcn,
  as.FutureGlobals(list(a = 3.14, b = 1:100)),
  list(x = as.FutureGlobals(list(a = 3.14, b = 1:100))),
  alist(a=)
)

for (kk in seq_along(objs)) {
  obj <- objs[[kk]]
  message(sprintf("objectSize(<%s>) ...", mode(obj)))
  str(obj)
  
  size0 <- object.size(obj)
  str(size0)
  
  size <- objectSize(obj)
  str(size)
  
  message(sprintf("objectSize(<%s>) ... DONE", mode(obj)))
}

message("*** objectSize() - globals with non-trustful length() ...")

length.CantTrustLength <- function(x) length(unclass(x)) + 1L

.length <- future:::.length

x <- structure(as.list(1:3), class = c("CantTrustLength", "list"))
str(list(n = length(x), n_true = .length(x)))
stopifnot(length(x) > .length(x))
size <- objectSize(x)
print(size)

message("*** objectSize() - globals with non-trustful length() ... DONE")

message("objectSize() ... DONE")

