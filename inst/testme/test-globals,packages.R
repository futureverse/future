#' @tags globals packages load attach
#' @tags sequential multisession multicore

library(future)
options(future.debug = FALSE)

message("*** Automatically attaching packages, if attached in parent ...")

for (strategy in supportedStrategies()) {
  message(sprintf("- Strategy: %s ...", strategy))
  
  plan(strategy)

  for (attach in c(FALSE, TRUE)) {
    message(sprintf("- Attach 'listenv': %s", attach))
    if (attach) {
      library(listenv)
    } else {
      if ("package:listenv" %in% search()) {
        detach(package:listenv)
      }
    }
    message("Attached packages: ", paste(search(), collapse = ", "))
    
    f <- future({
      env <- listenv::listenv()
      env[[1]] <- 42L
      ## 'get_variable()' is a global variable that should
      ## only work if 'listenv' is attached, which it will
      ## only be if it is attached in the parent R session
      name <- get_variable(env, 1L)
      42L
    })
    
    v <- tryCatch(value(f), error = identity)
    print(v)
    if (attach) {
      stopifnot(v == 42L)
    } else {
      stopifnot(inherits(v, "error"))
    }
  } ## for (attach in ...)
  
  message(sprintf("- Strategy: %s ... DONE", strategy))
}

message("*** Automatically attaching packages, if attached in parent ... done")
