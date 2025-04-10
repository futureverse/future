#' @tags resolve
#' @tags list listenv environment
#' @tags sequential multisession multicore

library(future)
library(listenv)
options(future.debug = FALSE)

sleep <- function(n) Sys.sleep(0.01*n)

strategies <- supportedStrategies()

message("*** resolve() ...")

message("*** resolve() for default ...")

x <- 1
y <- resolve(x)
stopifnot(identical(y, x))

message("*** resolve() for default ... DONE")


for (strategy in strategies) {
  message(sprintf("- plan('%s') ...", strategy))
  plan(strategy)

  if (strategy == "multisession" && availableCores() >= 2) {
    message("*** resolve() for Future objects ...")
    
    for (result in c(FALSE, TRUE)) {
      for (recursive in list(FALSE, TRUE, -1, 0, 1, 2, Inf)) {
        message(sprintf("- result = %s, recursive = %s ...", result, recursive))
      
        f <- future({
          sleep(2)
          list(a = 1, b = 42L)
        })
        res <- resolve(f, result = result, recursive = recursive)
        stopifnot(identical(res, f))
    
        f <- future({
          sleep(2)
          list(a = 1, b = 42L)
        }, lazy = TRUE)
        res <- resolve(f, result = result, recursive = recursive)
        stopifnot(identical(res, f))
    
        message("- w/ exception ...")
        f <- future(list(a = 1, b = 42L, c = stop("Nah!")))
        res <- resolve(f, result = result, recursive = recursive)
        stopifnot(identical(res, f))
    
        f <- future(list(a = 1, b = 42L, c = stop("Nah!")), lazy = TRUE)
        res <- resolve(f, result = result, recursive = recursive)
        stopifnot(identical(res, f))
    
        message(sprintf("- result = %s, recursive = %s ... DONE", result, recursive))
      } ## for (resolve ...)
    } ## for (result ...)
    
    message("*** resolve() for Future objects ... DONE")
  } ## if (strategy == "multisession" && availableCores() >= 2)
  
  message("*** resolve() for lists ...")

  x <- list()
  y <- resolve(x)
  stopifnot(identical(y, x))

  x <- list()
  x$a <- 1
  x$b <- 2
  y <- resolve(x)
  stopifnot(identical(y, x))

  x <- list()
  x$a <- future(1)
  x$b <- future(2)
  x[[3]] <- 3
  y <- resolve(x)
  stopifnot(identical(y, x))
  stopifnot(resolved(x$a))
  stopifnot(resolved(x[["b"]]))

  x <- list()
  x$a <- future(1, lazy = TRUE)
  x$b <- future(2)
  x[[3]] <- 3
  y <- resolve(x)
  stopifnot(identical(y, x))
  stopifnot(resolved(x$a))
  stopifnot(resolved(x[["b"]]))

  x <- list()
  x$a <- future(1, lazy = TRUE)
  x$b <- future(2, lazy = TRUE)
  x[[3]] <- 3
  y <- resolve(x)
  stopifnot(identical(y, x))
  stopifnot(resolved(x$a))
  stopifnot(resolved(x[["b"]]))

  x <- list()
  x$a <- future(1)
  x$b <- future({sleep(2); 2})
  x[[4]] <- 4
  dim(x) <- c(2, 2)
  y <- resolve(x, idxs = 1)
  stopifnot(identical(y, x))
  stopifnot(resolved(x[[1]]))
  y <- resolve(x, idxs = 2)
  stopifnot(identical(y, x))
  stopifnot(resolved(x[[2]]))
  y <- resolve(x, idxs = 3)
  stopifnot(identical(y, x))
  y <- resolve(x, idxs = seq_along(x))
  stopifnot(identical(y, x))
  y <- resolve(x, idxs = names(x))
  stopifnot(identical(y, x))

  y <- resolve(x, idxs = matrix(c(1, 2), ncol = 2L), result = TRUE)
  stopifnot(identical(y, x))

  x <- list()
  for (kk in 1:3) x[[kk]] <- future({ sleep(1); kk })
  y <- resolve(x)
  stopifnot(identical(y, x))

  x <- list()
  for (kk in 1:3) x[[kk]] <- future({ sleep(1); kk }, lazy = TRUE)
  y <- resolve(x)
  stopifnot(identical(y, x))

  ## Exceptions
  x <- list()
  x$a <- 1
  x$b <- 2

  res <- tryCatch(y <- resolve(x, idxs = 0L), error = identity)
  stopifnot(inherits(res, "error"))

  res <- tryCatch(y <- resolve(x, idxs = "unknown"), error = identity)
  stopifnot(inherits(res, "error"))

  x <- list(1, 2)
  res <- tryCatch(x <- resolve(x, idxs = "a"), error = identity)
  stopifnot(inherits(res, "error"))

  message("*** resolve() for lists ... DONE")


  message("*** resolve() for environments ...")

  x <- new.env()
  y <- resolve(x)
  stopifnot(identical(y, x))

  x <- new.env()
  x$a <- 1
  x$b <- 2
  y <- resolve(x)
  stopifnot(identical(y, x))
  stopifnot(length(futureOf(envir = x, drop = TRUE)) == 0L)

  x <- new.env()
  x$a <- future(1)
  x$b <- future(2)
  x$c <- 3
  stopifnot(length(futureOf(envir = x, drop = TRUE)) == 2L)
  y <- resolve(x)
  stopifnot(identical(y, x))
  stopifnot(resolved(x$a))
  stopifnot(resolved(x$b))
  stopifnot(length(futureOf(envir = x, drop = TRUE)) == 2L)

  x <- new.env()
  x$a %<-% { 1 }
  x$b %<-% { 2 }
  x$c <- 3
  stopifnot(length(futureOf(envir = x, drop = TRUE)) == 2L)
  y <- resolve(x)  ## FIXME: Should not do value()!
  stopifnot(identical(y, x))
  stopifnot(length(futureOf(envir = x, drop = TRUE)) == 2L)

  x <- new.env()
  x$a <- future({ 1 })
  x$b %<-% { 2 }
  x$c <- 3
  stopifnot(length(futureOf(envir = x, drop = TRUE)) == 2L)
  y <- resolve(x, idxs = "a")
  stopifnot(identical(y, x))
  stopifnot(resolved(x$a))
  stopifnot(length(futureOf(envir = x, drop = TRUE)) == 2L)
  y <- resolve(x, idxs = "b")
  stopifnot(identical(y, x))
  stopifnot(length(futureOf(envir = x, drop = TRUE)) == 2L)
  y <- resolve(x, idxs = "c")
  stopifnot(identical(y, x))
  stopifnot(length(futureOf(envir = x, drop = TRUE)) == 2L)
  y <- resolve(x, idxs = names(x), result = TRUE)
  stopifnot(identical(y, x))
  stopifnot(length(futureOf(envir = x, drop = TRUE)) == 2L)
  y <- resolve(x, recursive = TRUE, result = TRUE)
  stopifnot(identical(y, x))

  ## Exceptions
  res <- tryCatch(y <- resolve(x, idxs = "unknown"), error = identity)
  stopifnot(inherits(res, "error"))

  message("*** resolve() for environments ... DONE")


  message("*** resolve() for list environments ...")

  x <- listenv()
  y <- resolve(x)
  stopifnot(identical(y, x))

  x <- listenv()
  x$a <- 1
  x$b <- 2
  stopifnot(length(futureOf(envir = x, drop = TRUE)) == 0L)
  y <- resolve(x)
  stopifnot(identical(y, x))

  x <- listenv()
  x$a <- future(1)
  x$b <- future(2)
  x$c <- 3
  names <- names(x)
  dim(x) <- c(1, 3)
  names(x) <- names
  stopifnot(length(futureOf(envir = x, drop = TRUE)) == 2L)
  y <- resolve(x)
  stopifnot(identical(y, x))
  stopifnot(length(futureOf(envir = x, drop = TRUE)) == 2L)

  x <- listenv()
  x$a %<-% { 1 }
  x$b %<-% { 2 }
  x$c <- 3
  stopifnot(length(futureOf(envir = x, drop = TRUE)) == 2L)
  y <- resolve(x)  ## FIXME: Should not do value()!
  stopifnot(identical(y, x))
  #stopifnot(is.na(futureOf(x$a, mustExist = FALSE)))
  #stopifnot(is.na(futureOf(x$b, mustExist = FALSE)))
  stopifnot(length(futureOf(envir = x, drop = TRUE)) == 2L)

  x <- listenv()
  x$a <- future({ 1 })
  x$b %<-% { sleep(2); 2 }
  x$c %<-% { 3 }
  x$d <- 4
  names <- names(x)
  dim(x) <- c(2, 2)
  names(x) <- names
  stopifnot(length(futureOf(envir = x, drop = TRUE)) == 3L)
  y <- resolve(x, idxs = "a")
  stopifnot(identical(y, x))
  stopifnot(identical(futureOf(x$a, mustExist = FALSE), x$a))
  stopifnot(resolved(x$a))
  y <- resolve(x, idxs = "b")
  stopifnot(identical(y, x))
  stopifnot(length(futureOf(envir = x, drop = TRUE)) == 3L)

  idxs <- matrix(c(1, 2), ncol = 2L)
  y <- resolve(x, idxs = idxs)
  stopifnot(identical(y, x))
  #stopifnot(is.na(futureOf(x$c, mustExist = FALSE)))
  stopifnot(length(futureOf(envir = x, drop = TRUE)) == 3L)

  y <- resolve(x, idxs = 4L)
  stopifnot(identical(y, x))
  #stopifnot(is.na(futureOf(x[[4L]], mustExist = FALSE)))
  stopifnot(length(futureOf(envir = x, drop = TRUE)) == 3L)

  y <- resolve(x, idxs = names(x), result = TRUE)
  stopifnot(identical(y, x))
  stopifnot(length(futureOf(envir = x, drop = TRUE)) == 3L)

  y <- resolve(x, recursive = TRUE, result = TRUE)
  stopifnot(identical(y, x))

  ## Exceptions
  res <- tryCatch(y <- resolve(x, idxs = 0L), error = identity)
  stopifnot(inherits(res, "error"))

  res <- tryCatch(y <- resolve(x, idxs = "unknown"), error = identity)
  stopifnot(inherits(res, "error"))

  message("*** resolve() for list environments ... DONE")

  message(sprintf("- plan('%s') ...", strategy))
} ## for (strategy ...)


message("*** resolve() - globals with non-trustful length() ...")

length.CantTrustLength <- function(x) length(unclass(x)) + 1L

.length <- future:::.length

x <- structure(as.list(1:3), class = c("CantTrustLength", "list"))
str(list(n = length(x), n_true = .length(x)))
stopifnot(length(x) > .length(x))
x <- resolve(x)

message("*** resolve() - globals with non-trustful length() ... DONE")


message("*** resolved() - default ...")

res <- resolved(42L)
stopifnot(isTRUE(res))

message("*** resolved() - default ... DONE")


message("*** resolve() ... DONE")

