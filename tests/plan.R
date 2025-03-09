source("incl/start,load-only.R")
options(future.debug=FALSE)
message("*** plan() ...")

cl <- future::makeClusterPSOCK(1L)
print(cl)

message("*** Set strategy via future::plan(future::sequential)")
oplan <- future::plan(future::sequential)
print(future::plan())
future::plan(oplan)
print(future::plan())

message("*** Set strategy via future::plan(future::cluster, workers = cl)")
oplan <- future::plan(future::cluster, workers = cl)
print(future::plan())
future::plan(oplan)
print(future::plan())

message("*** Set strategy via future::plan(future::cluster(workers = cl)")
oplan <- future::plan(future::cluster(workers = cl))
print(future::plan())
future::plan(oplan)
print(future::plan())

message("*** Set strategy via future::plan('sequential')")
oplan <- future::plan("sequential")
print(future::plan())
future::plan(oplan)
print(future::plan())

message("*** plan('default')")
oplan <- future::plan("default")
print(future::plan())
future::plan(oplan)
print(future::plan())


library("future")

message("*** plan('unknown strategy')")
res <- try(plan('unknown strategy'), silent = TRUE)
print(res)
stopifnot(inherits(res, "try-error"))


message("*** plan(sequential)")
plan(sequential)
a <- 0
f <- future({
  b <- 3
  c <- 2
  a * b * c
})
a <- 7
v <- value(f)
print(v)
stopifnot(v == 0)

message("*** plan('sequential')")
## Setting strategy by name
plan("sequential")
print(plan())


message("*** plan() and overriding defaults")
message("*** plan(sequential)")
plan(sequential)
fcn <- plan("next")
print(fcn)
x <- 0
f <- future({ x <- 1 })
print(value(f))
stopifnot(x == 0)

message("*** plan(sequential, abc = 1)")
plan(sequential, abc = 1, def = TRUE)
fcn <- plan("next")
print(fcn)
stopifnot(formals(fcn)$abc == 1)

message("*** plan(sequential(abc = 1))")
plan(cluster, workers = cl)
plan(sequential(abc = 1))
fcn <- plan("next")
print(fcn)
stopifnot(formals(fcn)$abc == 1)

message("*** plan(tweak(sequential, abc = 1))")
plan(cluster, workers = cl)
plan(tweak(sequential, abc = 1))
fcn <- plan("next")
print(fcn)
stopifnot(formals(fcn)$abc == 1)

message("*** do.call(plan, args = list(sequential, abc = 1))")
do.call(plan, args = list(sequential, abc = 1, def = TRUE))
fcn <- plan("next")
print(fcn)
stopifnot(formals(fcn)$abc == 1)

message("*** plan(cluster, ..., rscript_startup = \"<code>\")")
plan(cluster, workers = 1L, rscript_startup = "options(abc = 42L)")
f <- future(getOption("abc"))
v <- value(f)
stopifnot(identical(v, 42L))
plan(sequential)

message("*** plan(cluster, ..., rscript_startup = <expr>)")
plan(cluster, workers = 1L, rscript_startup = quote(options(abc = 42L)))
f <- future(getOption("abc"))
v <- value(f)
print(v)
stopifnot(identical(v, 42L))
plan(sequential)


message("*** plan(sequential, gc = TRUE)")
oplan <- plan(cluster, gc = TRUE)
f <- future(42L)
v <- value(f)
print(v)
stopifnot(identical(v, 42L))
plan(sequential)

message("*** plan(cluster, gc = TRUE)")
oplan <- plan(cluster, gc = TRUE)
f <- future(42L)
v <- value(f)
print(v)
stopifnot(identical(v, 42L))
plan(sequential)

message("*** plan(multisession, gc = TRUE)")
oplan <- plan(cluster, gc = TRUE)
f <- future(42L)
v <- value(f)
print(v)
stopifnot(identical(v, 42L))
plan(sequential)


message("*** plan(sequential, earlySignal = TRUE)")
oplan <- plan(cluster, earlySignal = TRUE)
f <- future(42L)
v <- value(f)
print(v)
stopifnot(identical(v, 42L))
plan(sequential)

message("*** plan(cluster, earlySignal = TRUE)")
oplan <- plan(cluster, earlySignal = TRUE)
f <- future(42L)
v <- value(f)
print(v)
stopifnot(identical(v, 42L))
plan(sequential)

message("*** plan(multisession, earlySignal = TRUE)")
oplan <- plan(cluster, earlySignal = TRUE)
f <- future(42L)
v <- value(f)
print(v)
stopifnot(identical(v, 42L))
plan(sequential)



message("*** old <- plan(new)")
truth <- plan("list")
old <- plan(cluster, workers = cl)
stopifnot(identical(unclass(old), unclass(truth)))

stack <- plan("list") ## stack == cluster(workers = cl)
prev <- plan(old)     ## prev == sequential(abc = 1)
stopifnot(identical(stack, prev))

stack <- plan("list") ## curr == old
stopifnot(identical(stack, old))
stopifnot(identical(stack, truth))

message("*** %plan% 'sequential'")
plan(cluster, workers = cl)
x %<-% { a <- 1 } %plan% "sequential"
stopifnot(inherits(plan("next"), "cluster"))

message("*** %plan% sequential")
plan(cluster, workers = cl)

## %plan% can operate on any expression, so it
## works just as an withPlan({ ... }, plan = ...)
fun <- { plan("next") } %plan% sequential

## Non-FutureBackend:s should be called directly
if (is.null(attr(fun, "backend"))) {
  f <- fun(1)
  stopifnot(inherits(f, "SequentialFuture"), !f$lazy, inherits(f, "SequentialFuture"))
}

x %<-% { a <- 1 } %plan% sequential
stopifnot(inherits(plan("next"), "cluster"))


message("*** Nested futures with different plans")

c %<-% {
  message("Resolving 'c'")
  a %<-% {
    message("Resolving 'a'")
    2
  } %plan% sequential
  b %<-% {
    message("Resolving 'b'")
    -9 * a
  }
  message("Local variable 'x'")
  x <- b / 3
  abs(x)
} %lazy% TRUE
d <- 42
print(d)
print(c)
stopifnot(c == 6)

message("*** plan() by functions and character names ... ")

plan(sequential)
a %<-% 42
stopifnot(a == 42)

plan("sequential")
a %<-% 42
stopifnot(a == 42)

plan(list(sequential))
a %<-% 42
stopifnot(a == 42)

plan(list("sequential"))
a %<-% 42
stopifnot(a == 42)

plan(list(sequential, sequential))
a %<-% { b %<-% 42; b }
stopifnot(a == 42)

plan(list("sequential", sequential))
a %<-% { b %<-% 42; b }
stopifnot(a == 42)

plan(list(sequential, "sequential"))
a %<-% { b %<-% 42; b }
stopifnot(a == 42)

plan(list("sequential", "sequential"))
a %<-% { b %<-% 42; b }
stopifnot(a == 42)

plan(list("future::sequential", "sequential"))
a %<-% { b %<-% 42; b }
stopifnot(a == 42)

message("*** plan() by functions and character names ... DONE")


message("*** plan() w/ commands ...")

plan(list(sequential, sequential))
res <- plan("list")
print(res)
stopifnot(length(res) == 2)

plan("pop")
res <- plan("list")
print(res)
stopifnot(length(res) == 1)

plan("reset")
print(plan())

message("*** plan() w/ commands ... DONE")


message("*** plan() - odds'n'ends ...")

plan(sequential, split = FALSE)
f <- future(42L)
v <- value(f)
stopifnot(v == 42L)
stopifnot(
  inherits(f$envir, "environment"),
  identical(f$envir, globalenv())
)

message("*** plan() - odds'n'ends ... DONE")


parallel::stopCluster(cl)

message("*** plan() ... DONE")

source("incl/end.R")
