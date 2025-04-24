#' @tags globals tricky
#' @tags listenv
#' @tags sequential multisession multicore

library(future)
not_cran <- isTRUE(as.logical(Sys.getenv("NOT_CRAN", "FALSE")))

message("*** Tricky use cases #2 related to globals ...")

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


    ## This one fails to pick up 'a' as a global variable
    ## Notes: This has always been the case, also before future 1.40.0.
    ## To solve this, we need to write a smarter globals::findGlobals().
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
    if (not_cran) stopifnot(length(globals) == 0) ## ideally 'a' here
    y <- tryCatch(value(f), error = identity)
    print(y)
    stopifnot(inherits(y, "error")) ## object 'a' not found
    
    plan(sequential)
  } ## for (strategy ...)

  message(sprintf("Testing with %d cores ... DONE", cores))
} ## for (cores ...)

message("*** Tricky use cases #2 related to globals ... DONE")

