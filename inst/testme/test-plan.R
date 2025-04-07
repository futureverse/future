#' @tags plan %plan%
#' @tags listenv
#' @tags sequential cluster 

library(future)

options(future.debug=FALSE)
message("*** plan() ...")

cl <- parallelly::makeClusterPSOCK(1L)
print(cl)

pid <- Sys.getpid()
message("R session PID: ", pid)

message("*** Set strategy via plan(sequential)")
oplan <- plan(sequential)
print(plan())
plan(oplan)
print(plan())
worker_pid <- value(future(Sys.getpid()))
message("Worker PID: ", worker_pid)
stopifnot(worker_pid == pid)

message("*** Set strategy via plan(cluster, workers = cl)")
oplan <- plan(cluster, workers = cl)
print(plan())
worker_pid_1 <- value(future(Sys.getpid()))
message("Worker PID: ", worker_pid_1)
stopifnot(worker_pid_1 != pid)
plan(oplan)
print(plan())

message("*** Set strategy via plan(cluster(workers = cl)")
oplan <- plan(future::cluster(workers = cl))
print(plan())
worker_pid_2 <- value(future(Sys.getpid()))
message("Worker PID: ", worker_pid_2)
stopifnot(
  worker_pid_2 != pid,
  worker_pid_2 == worker_pid_1  ## assert identical plan as before
)

plan(oplan)
print(plan())

message("*** Set strategy via plan('sequential')")
oplan <- plan("sequential")
print(plan())
worker_pid <- value(future(Sys.getpid()))
message("Worker PID: ", worker_pid)
stopifnot(worker_pid == pid)
 
plan(oplan)
print(plan())

message("*** plan('default')")
oplan <- plan("default")
print(plan())
plan(oplan)
print(plan())


message("*** Stability of plan(cluster, workers = n)")

oplan <- plan(cluster, workers = I(1))
print(plan())
worker_pid_1 <- value(future(Sys.getpid()))
message("Worker PID: ", worker_pid_1)
stopifnot(worker_pid_1 != pid)

oplan <- plan(cluster, workers = I(1))
print(plan())
worker_pid_2 <- value(future(Sys.getpid()))
message("Worker PID: ", worker_pid_2)
stopifnot(
  worker_pid_2 != pid,
  worker_pid_2 == worker_pid_1
)

plan(oplan)
print(plan())


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
print(v)
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

message("*** plan(cluster, gc = TRUE)")
oplan <- plan(cluster, gc = TRUE)
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

message("*** plan(cluster, earlySignal = TRUE)")
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


message("*** with(plan(sequential), ...)")
plan(cluster, workers = cl)
pid <- Sys.getpid()
with(plan(sequential), {
  f <- future({ Sys.getpid() })
  v <- value(f)
})
stopifnot(
  v == pid,
  inherits(plan("next"), "cluster")
)

message("*** with(plan(sequential), local = TRUE)")
plan(cluster, workers = cl)
pid <- Sys.getpid()
v <- local({
  with(plan(sequential), local = TRUE)
  f <- future({ Sys.getpid() })
  v <- value(f)
})
stopifnot(
  v == pid,
  inherits(plan("next"), "cluster")
)


message("*** %plan% 'sequential'")
plan(cluster, workers = cl)
pid <- Sys.getpid()
x %<-% { Sys.getpid() } %plan% "sequential"
stopifnot(
  v == pid,
  inherits(plan("next"), "cluster")
)


message("*** %plan% sequential")
plan(cluster, workers = cl)

## %plan% can operate on any expression, so it
## works just as an with(plan(...), { ... })
fun <- { plan("next") } %plan% sequential

pid <- Sys.getpid()
x %<-% { Sys.getpid() } %plan% sequential
stopifnot(
  v == pid,
  inherits(plan("next"), "cluster")
)


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

plan(list("sequential", "sequential"))
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
plan(sequential)

message("*** plan() ... DONE")
