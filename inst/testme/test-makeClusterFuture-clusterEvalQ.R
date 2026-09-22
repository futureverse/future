if (getRversion() >= "4.4.0") {
  library(future)
  library(parallel)

  parse_attach_packages <- future:::parse_attach_packages

  message("parse_attach_packages() - supported expressions:")
  exports <- list(pkg = "tools", n = 42)
  exprs <- list(
    quote(library(tools)),
    quote(library("tools")),
    quote(base::library(tools)),
    quote(require(tools)),
    quote(library(tools, quietly = TRUE, warn.conflicts = FALSE)),
    quote(library(pkg, character.only = TRUE)),
    quote(library("tools", character.only = TRUE)),
    quote(suppressPackageStartupMessages(library(tools))),
    quote(invisible(require(tools))),
    quote({ library(tools); library(pkg, character.only = TRUE) })
  )
  for (expr in exprs) {
    print(expr)
    pkgs <- parse_attach_packages(expr, envir = exports)
    stopifnot(identical(pkgs, "tools"))
  }

  expr <- quote({ library(tools); suppressMessages(require("grid")) })
  pkgs <- parse_attach_packages(expr, envir = exports)
  stopifnot(identical(pkgs, c("tools", "grid")))


  message("parse_attach_packages() - non-supported expressions:")
  exprs <- list(
    quote(42),
    quote(a <- 3.14),
    quote({}),
    quote(library()),
    quote(library(tools, lib.loc = "foo")),
    quote(library(help = tools)),
    quote(library(pkg, character.only = TRUE, foo = 1)),
    quote(library(unknown, character.only = TRUE)),
    quote(library(n, character.only = TRUE)),
    quote(library(c("tools", "grid"), character.only = TRUE)),
    quote(library(paste0("to", "ols"), character.only = TRUE)),
    quote(library(tools, character.only = flag)),
    quote(requireNamespace("tools")),
    quote(foo::library(tools)),
    quote({ library(tools); a <- 3.14 })
  )
  for (expr in exprs) {
    print(expr)
    pkgs <- parse_attach_packages(expr, envir = exports)
    stopifnot(is.null(pkgs))
  }


  message("clusterEvalQ() attaching packages:")
  stopifnot(!"package:tools" %in% search())
  oopts <- options(future.ClusterFuture.clusterEvalQ = "error")
  plan(multisession, workers = 2)
  cl <- makeClusterFuture()

  FUN <- function(x) {
    c(attached = "package:tools" %in% search(), ext = file_ext(x))
  }

  y <- parLapply(cl, c("a.txt", "b.R"), function(x) "package:tools" %in% search())
  stopifnot(!any(unlist(y)))

  pkg <- "tools"
  clusterExport(cl, "pkg", envir = environment())
  clusterEvalQ(cl, library(pkg, character.only = TRUE))
  clusterEvalQ(cl, { library(tools); suppressPackageStartupMessages(library(grid)) })
  print(cl)
  cluster_env <- attr(cl, "cluster_env")
  stopifnot(identical(cluster_env[["packages"]], c("tools", "grid")))
  stopifnot(length(cluster_env[["clusterEvalQs"]]) == 0L)

  y <- parLapply(cl, c("a.txt", "b.R"), FUN)
  str(y)
  stopifnot(identical(y, list(
    c(attached = "TRUE", ext = "txt"),
    c(attached = "TRUE", ext = "R")
  )))

  ## Other expressions are still not supported
  res <- tryCatch(clusterEvalQ(cl, { library(tools); a <- 3.14 }), error = identity)
  stopifnot(inherits(res, "FutureError"))

  plan(sequential)
  options(oopts)
  stopifnot(!"package:tools" %in% search())
}
