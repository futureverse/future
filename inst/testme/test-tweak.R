#' @tags plan tweak
#' @tags sequential cluster

message("*** Tweaking future strategies ...")

message("*** y <- tweak(future::sequential) ...")
sequential2 <- future::tweak(future::sequential)
print(args(sequential2))
stopifnot(identical(sequential2, future::sequential))
stopifnot(!inherits(sequential2, "tweaked"))


message("*** y <- tweak(future::sequential, abc = FALSE) ...")
sequential2 <- future::tweak(future::sequential, abc = FALSE)
print(args(sequential2))
stopifnot(!identical(sequential2, future::sequential))
stopifnot(inherits(sequential2, "tweaked"))
stopifnot(identical(formals(sequential2)$abc, FALSE))


message("*** y <- tweak('sequential', abc = FALSE) ...")
sequential2 <- future::tweak("sequential", abc = FALSE)
print(args(sequential2))
stopifnot(!identical(sequential2, future::sequential))
stopifnot(inherits(sequential2, "tweaked"))
stopifnot(identical(formals(sequential2)$abc, FALSE))


library(future)

message("*** y <- tweak(sequential, abc = FALSE) ...")
sequential2 <- future::tweak(sequential, abc = FALSE)
print(args(sequential2))
stopifnot(!identical(sequential2, future::sequential))
stopifnot(inherits(sequential2, "tweaked"))
stopifnot(identical(formals(sequential2)$abc, FALSE))

message("*** y <- tweak('sequential', abc = FALSE) ...")
sequential2 <- future::tweak('sequential', abc = FALSE)
print(args(sequential2))
stopifnot(!identical(sequential2, future::sequential))
stopifnot(inherits(sequential2, "tweaked"))
stopifnot(identical(formals(sequential2)$abc, FALSE))


message("*** y <- tweak('sequential', abc = FALSE, abc = 1, def = TRUE) ...")
res <- tryCatch({
  sequential2 <- future::tweak('sequential', abc = FALSE, abc = 1, def = TRUE)
}, warning = function(w) {
  w
})
stopifnot(inherits(res, "warning"))
sequential2 <- future::tweak('sequential', abc = FALSE, abc = 1, def = TRUE)
print(args(sequential2))
stopifnot(!identical(sequential2, future::sequential))
stopifnot(inherits(sequential2, "tweaked"))
stopifnot(identical(formals(sequential2)$abc, FALSE))



message("*** y <- tweak(cluster, rscript_startup = quote(...)) ...")
cl <- 42L
cluster2 <- tweak(cluster, workers = cl, rscript_startup = quote(options(abc = 42L)))
print(args(cluster2))
stopifnot(!identical(cluster2, future::cluster))
stopifnot(inherits(cluster2, "tweaked"))
formals2 <- formals(cluster2)
stopifnot(identical(formals2$workers, cl))
stopifnot("rscript_startup" %in% names(formals2))
rscript_startup <- formals2$rscript_startup
stopifnot(!is.null(rscript_startup),
          is.language(rscript_startup), is.call(rscript_startup))
value <- eval(rscript_startup)
stopifnot(is.language(value), is.call(value))


message("*** plan() - tweak without introducting package dependencies ...")

## Requires a auxillary package that is available and not already loaded
if (!covr_testing && requireNamespace("grid")) {
  local({
    cl <- makeClusterPSOCK(1L)
    on.exit(parallel:::stopCluster(cl))
    ns0 <- unlist(parallel::clusterEvalQ(cl, loadedNamespaces()))

    ## When using futures, the 'future' package is loaded on the worker
    ns0 <- c(ns0, c("tools", "parallelly",
                    "codetools", "digest", "globals", "listenv", "future"))
    if (!is.element("grid", ns0)) {
      ## Assert that a global copy from a package does not trigger
      ## that package from being loaded on the worker
      dummy <- grid::depth
      oplan <- future::plan(future::cluster, workers = cl)
      on.exit(future::plan(oplan), add = TRUE)
      ns <- unlist(parallel::clusterEvalQ(cl, loadedNamespaces()))
      diff <- setdiff(ns, ns0)
      if ("covr" %in% diff) diff <- setdiff(diff, c("lazyeval", "rex", "covr"))
      if (length(diff) > 0) {
        print(loadedNamespaces())
        stop("plan() with a tweak() causes new packages to be loaded: ", sQuote(paste(diff, collapse = ", ")))
      }
    }
  })
}

message("*** plan() - tweak without introducting package dependencies ... DONE")


message("*** y %<-% { expr } %tweak% tweaks ...")

plan(sequential)

a <- 0
x %<-% { a <- 1; a }
print(x)
stopifnot(a == 0, x == 1)


plan(sequential, abc = FALSE)

a <- 0
x %<-% { a <- 1; a }
print(x)
stopifnot(a == 0, x == 1)

x %<-% { a <- 2; a } %tweak% list(abc = TRUE)
print(x)
stopifnot(a == 0, x == 2)


# Preserve nested futures
plan(list(A = sequential, B = tweak(sequential, abc = FALSE)))
a <- 0

x %<-% {
  stopifnot(identical(names(plan("list")), "B"))
  a <- 1
  a
}
print(x)
stopifnot(a == 0, x == 1)


message("*** y %<-% { expr } %tweak% tweaks ... DONE")


message("*** tweak() - abc = TRUE ...")

res <- tryCatch(tweak(multisession, gc = TRUE), condition = identity)
stopifnot(inherits(res, "tweaked"))

## Argument 'gc' is unknown
res <- tryCatch(tweak(sequential, abc = TRUE), condition = identity)
stopifnot(inherits(res, "warning"))

res <- tryCatch(tweak(multicore, abc = TRUE), condition = identity)
stopifnot(inherits(res, "warning"))

message("*** tweak() - abc = TRUE ... DONE")


message("*** tweak() - odds and ends ...")

## BUG: getGlobalsAndPackages(Formula::Formula(~ x)) would produce
## "the condition has length > 1" warnings.
## https://github.com/futureverse/future/issues/395
length.Formula <- function(x) c(1L, 1L)
expr <- structure(y ~ x, class = "Formula")
stopifnot(length(length(expr)) == 2L)
gp <- future::getGlobalsAndPackages(expr)
stopifnot(
  !inherits(gp, "error"),
  is.list(gp),
  all(c("expr", "globals", "packages") %in% names(gp))
)

message("*** tweak() - odds and ends ... DONE")


message("*** tweak() - exceptions ...")

res <- try(tweak("<unknown-future-strategy>"), silent = TRUE)
stopifnot(inherits(res, "try-error"))

res <- try(tweak(base::eval), silent = TRUE)
stopifnot(inherits(res, "try-error"))

res <- try(tweak(sequential, "unnamed-argument"), silent = TRUE)
stopifnot(inherits(res, "try-error"))

## Arguments that must not be tweaked
res <- try(tweak(sequential, lazy = TRUE), silent = TRUE)
stopifnot(inherits(res, "try-error"))

res <- try(tweak(sequential, asynchronous = FALSE), silent = TRUE)
stopifnot(inherits(res, "try-error"))

res <- try(tweak(sequential, seed = 42L), silent = TRUE)
stopifnot(inherits(res, "try-error"))

message("*** tweak() - exceptions ... DONE")


message("*** Tweaking future strategies ... DONE")

