#' @tags globals tricky
#' @tags listenv
#' @tags sequential multisession multicore

library(future)
not_cran <- isTRUE(as.logical(Sys.getenv("NOT_CRAN", "FALSE")))
options(future.debug = FALSE)

message("*** Tricky use cases #2 related to globals ...")

if (isTRUE(getOption("future.globals.keepWhere", TRUE))) {

for (cores in 1:availCores) {
  message(sprintf("Testing with %d cores ...", cores))
  options(mc.cores = cores)

  message("availableCores(): ", availableCores())

  message("- Local variables with the same name as globals ...")

  for (strategy in supportedStrategies(cores)) {
    message(sprintf("- plan('%s') ...", strategy))
    plan(strategy)

    message("Case A")
    ## Note that 'a' is _not_ a global variable here; instead
    ## it's part of closure 'g'
    expr <- quote({
      a <- 42L
      g <- function() {
        h <- function(a) a
        h(a)
      }
      g()
    })
    gg <- globals::findGlobals(expr, substitute = FALSE)
    message("Globals: ", paste(sQuote(gg), collapse = ", "))
    if (not_cran) stopifnot(gg == c("{", "<-"))
    
    f <- future({
      a <- 42L
      g <- function() {
        h <- function(a) a
        h(a)
      }
      g()
    }, lazy = TRUE)
    globals <- f[["globals"]]
    if (not_cran) stopifnot(length(globals) == 0)
    y <- value(f)
    stopifnot(y == 42L)


    message("Case B")
    ## Note that 'a' is a global variable here, but
    ## globals::findGlobals() fails to pick it up
    expr <- quote({
      g <- function() {
        h <- function(a) a
        h(a)
      }
      g()
    })
    gg <- globals::findGlobals(expr, substitute = FALSE, trace = TRUE)
    message("Globals: ", paste(sQuote(gg), collapse = ", "))
    if (not_cran) stopifnot(gg == c("{", "<-")) ## ideally also 'a'


    message("Case C")
    ## This one failed to pick up 'a' as a global variable with
    ## globals (<= 0.17.0).
    a <- 42L
    f <- future({
      g <- function() {
        h <- function(a) a
        h(a)
      }
      g()
    }, lazy = TRUE)
    rm(list = "a")
    globals <- f[["globals"]]
    if (not_cran) {
      stopifnot(length(globals) == 1L, names(globals) == "a")
      y <- value(f)
      print(y)
      stopifnot(y == 42L)
    }
    rm(list = "y")
    
    message("Case D")
    fcn <- function(x) {
      y
    }
    wrapper <- function(fn) {
      y <- -1
      fn(1)
    }
    res <- tryCatch({
      f <- wrapper(fcn)
      v <- value(f)
    }, error = identity)
    print(res)
    stopifnot(inherits(res, "error"))
    
    message("Case D")
    ## https://github.com/futureverse/future/issues/608#issuecomment-1116855224
    r0 <- local({
      mu <- 0
      function() mu
    })
    r1 <- local({
      mu <- 1
      function() mu
    })
    truth <- r1() - r0()
    print(truth)
    f <- future(r1() - r0())
    y <- value(f)
    print(y)
    stopifnot(identical(y, truth))

    plan(sequential)
  } ## for (strategy ...)

  message(sprintf("Testing with %d cores ... DONE", cores))
} ## for (cores ...)

} else {
  message(" - skip test, because it requires future.globals.keepWhere = TRUE")
} ## if (isTRUE(getOption("future.globals.keepWhere", TRUE)))


message("*** Tricky use cases #2 related to globals ... DONE")
