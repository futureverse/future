#' @tags skip_on_cran
library(future)
if (getRversion() >= "4.4.0") {
prune <- function() {
  options(future.disposable = structure(list(prune = TRUE), dispose = FALSE))
}
unprune <- function() options(future.disposable = NULL)

plan(multisession, workers = 2L)

message("Worker functions are pruned when requested")
## parLapply(cl, X, fun) sends lapply() to the nodes, with fun as an argument.
## This worker looks up an unused variable in a way that static code analysis
## cannot detect, so it fails if, and only if, it is pruned
make_fun <- function() {
  unused <- 42
  function(i) get("unused") + i
}
fun <- make_fun()
cl <- makeClusterFuture()

unprune()
y <- parallel::parLapply(cl, 1:2, fun)
stopifnot(identical(y, list(43, 44)))

prune()
res <- tryCatch(parallel::parLapply(cl, 1:2, fun), error = identity)
unprune()
stopifnot(inherits(res, "error"), grepl("dropped", conditionMessage(res)))

message("prune = \"closure\" is the same as prune = TRUE")
options(future.disposable = structure(list(prune = "closure"), dispose = FALSE))
res <- tryCatch(parallel::parLapply(cl, 1:2, fun), error = identity)
unprune()
stopifnot(inherits(res, "error"), grepl("dropped", conditionMessage(res)))

message("Functions that the worker calls, and that live in the same frame, work")
make_fun_sibling <- function() {
  unused <- numeric(10)
  scale <- 2
  sibling <- function(n) n * scale
  function(i) sibling(i) + 1
}
fun <- make_fun_sibling()
prune()
y <- parallel::parLapply(cl, 1:4, fun)
y_sapply <- parallel::parSapply(cl, 1:4, fun)
y_apply <- parallel::clusterApply(cl, 1:4, fun)
y_map <- parallel::clusterMap(cl, function(a, b) a + b, 1:3, 4:6)
unprune()
y_truth <- lapply(1:4, fun)
stopifnot(identical(y, y_truth), identical(y_sapply, sapply(1:4, fun)),
          identical(y_apply, y_truth), identical(y_map, as.list(c(5L, 7L, 9L))))

message("A cached pruned function is not reused if its closure environment has changed")
## The function is the same object, but the variable it uses is updated
## between two calls on the same cluster
make_stateful <- function() {
  state <- 1
  list(set = function(v) state <<- v, fun = function(i) i * state)
}
stateful <- make_stateful()
cl <- makeClusterFuture()
prune()
y1 <- unlist(parallel::parLapply(cl, 1:3, stateful$fun))
stateful$set(10)
y2 <- unlist(parallel::parLapply(cl, 1:3, stateful$fun))
unprune()
stopifnot(identical(y1, c(1, 2, 3)), identical(y2, c(10, 20, 30)))

## A variable that is added to the frame is also detected, so that the
## function is pruned again
make_grow <- function() {
  offset <- 1
  fun <- function(i) i + offset
  list(fun = fun, grow = function() assign("another", 2, envir = environment(fun)))
}
grow <- make_grow()
n <- 0L
trace("pruneClosureEnvironment", tracer = quote(assign("n", get("n", globalenv()) + 1L, envir = globalenv())), print = FALSE, where = asNamespace("future"))
cl <- makeClusterFuture()
prune()
z1 <- unlist(parallel::parLapply(cl, 1:2, grow$fun))
n1 <- n
grow$grow()
z2 <- unlist(parallel::parLapply(cl, 1:2, grow$fun))
n2 <- n
unprune()
untrace("pruneClosureEnvironment", where = asNamespace("future"))
stopifnot(identical(z1, c(2, 3)), identical(z2, c(2, 3)))
## The function was pruned again after the frame changed
stopifnot(n2 > n1)

message("The cache is used when nothing has changed")
n <- 0L
trace("pruneClosureEnvironment", tracer = quote(assign("n", get("n", globalenv()) + 1L, envir = globalenv())), print = FALSE, where = asNamespace("future"))
unchanged <- make_fun_sibling()
cl <- makeClusterFuture()
prune()
invisible(parallel::parLapply(cl, 1:4, unchanged))
invisible(parallel::parLapply(cl, 1:4, unchanged))
unprune()
untrace("pruneClosureEnvironment", where = asNamespace("future"))
## One for the worker function and one for the function that is called
stopifnot(n == 2L)

message("Not pruned for sequential processing")
plan(sequential)
cl <- makeClusterFuture()
fun <- make_fun()
prune()
y <- parallel::parLapply(cl, 1:2, fun)
unprune()
stopifnot(identical(y, list(43, 44)))
}
