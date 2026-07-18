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


message("*** objectSize() - method = 'objectSize' ...")

## The default method ('serializedSize') returns early, which means the
## recursive scanning of lists and environments is only exercised when
## option 'future.globals.objectSize.method' is set to 'objectSize'
oopts <- options(future.globals.objectSize.method = "objectSize")

for (kk in seq_along(objs)) {
  obj <- objs[[kk]]
  size <- objectSize(obj)
  stopifnot(length(size) == 1L, is.numeric(size), !is.na(size), size >= 0)
}

## Namespaces are skipped
stopifnot(objectSize(getNamespace("utils")) == 0)

## Nothing to do, when depth is exhausted
stopifnot(objectSize(1:100, depth = 0L) == 0)

## depth = 1 does not recurse into the object
stopifnot(objectSize(1:100, depth = 1L) > 0)
stopifnot(objectSize(list(a = 1:100), depth = 1L) == 0)

## Recursing into a list and an environment increases the estimate
stopifnot(objectSize(list(a = 1:100), depth = 3L) > 0)
stopifnot(objectSize(env, depth = 3L) > 0)

## Environments are only scanned once, also when self-referencing
env_cyclic <- new.env()
env_cyclic[["a"]] <- 1:100
env_cyclic[["self"]] <- env_cyclic
env_cyclic[["again"]] <- env_cyclic
size <- objectSize(env_cyclic, depth = 5L)
stopifnot(is.numeric(size), !is.na(size), size > 0)

## An empty environment has nothing to scan
stopifnot(objectSize(new.env(), depth = 3L) == 0)

## Variables prefixed with '.future_' are skipped
env_future <- new.env()
env_future[[".future_a"]] <- 1:100
env_future[["a"]] <- 1:100
size <- objectSize(env_future, depth = 3L)
stopifnot(is.numeric(size), !is.na(size))

## A FutureGlobals object with a known total size is not rescanned
globals <- as.FutureGlobals(list(a = 3.14, b = 1:100))
attr(globals, "total_size") <- 42
stopifnot(objectSize(list(globals), depth = 3L) == 42)

## The enclosure of a function is only scanned when requested
local({
  oopts2 <- options(future.globals.objectSize.enclosure = FALSE)
  on.exit(options(oopts2))
  stopifnot(objectSize(fcn) > 0)
})
local({
  oopts2 <- options(future.globals.objectSize.enclosure = TRUE)
  on.exit(options(oopts2))
  stopifnot(objectSize(fcn) > 0)
})

options(oopts)

message("*** objectSize() - method = 'objectSize' ... DONE")


message("*** objectSize() - unknown method ...")

local({
  oopts2 <- options(future.globals.objectSize.method = "<unknown>")
  on.exit(options(oopts2))
  res <- tryCatch(objectSize(1:100), error = identity)
  print(res)
  stopifnot(inherits(res, "error"))
})

message("*** objectSize() - unknown method ... DONE")

message("objectSize() ... DONE")

