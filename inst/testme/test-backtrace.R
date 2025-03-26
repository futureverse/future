#' @tags debug listenv
#' @tags sequential multisession

library(future)

message("*** backtrace( ) - explicit future ...")

f <- future({ 42L; stop("Woops") })
v <- value(f, signal = FALSE)
print(v)
calls <- backtrace(f)
print(calls)

message("*** backtrace( ) - explicit future ... DONE")


message("*** backtrace( ) - implicit future ...")

v %<-% { 42L; stop("Woops") }
calls <- backtrace(v)
print(calls)

message("*** backtrace( ) - implicit future ... DONE")


message("*** backtrace( ) - subsetting ...")

env <- new.env()
env[["a"]] %<-% { 42L; stop("Woops") }
env[["b"]] %<-% { 42L; stop("Woops") }
calls <- backtrace(env[["b"]])
print(calls)
stopifnot(is.list(calls))

lenv <- listenv::listenv()
lenv[[1]] %<-% { 42L; stop("Woops") }
lenv[[2]] %<-% { 42L; stop("Woops") }
calls <- backtrace(lenv[[2]])
print(calls)
stopifnot(is.list(calls))

ll <- list()
ll[[1]] <- future({ 42L; stop("Woops") })
ll[[2]] <- future({ 42L; stop("Woops") })
vs <- value(ll, signal = FALSE)
calls <- backtrace(ll[[2]])
print(calls)
stopifnot(is.list(calls))

message("*** backtrace( ) - subsetting ... DONE")


message("*** backtrace( ) - exceptions ...")

message("- No condition ...")
f <- future(42L)
res <- tryCatch(backtrace(f), error = identity)
print(res)
stopifnot(inherits(res, "error"))

message("- No call stack ...")
f <- future({ 42L; stop("Woops") })
v <- value(f, signal = FALSE)

if (availableCores() >= 2L) {
  message("- Non-resolved future ...")
  plan(multisession, workers = 2L)
  message("- plan set")
  f <- future({ Sys.sleep(0.3); 42L; stop("Woops") })
  res <- tryCatch(backtrace(f), error = identity)
  print(res)
  stopifnot(inherits(res, "error"))
  
  ## If we don't resolve the future, the cluster of workers will not
  ## be able to shut down naturally. They will eventually time out,
  ## but that will happen long after 'R CMD check' terminates. Because
  ## of this, 'R CMD check --as-cran' will report on "detritus in the
  ## temp directory" when running on MS Windows.  This happens because
  ## MS Windows doesn't shut down child processes as Linux and macOS
  ## does when the main R session terminates.
  resolve(f)
}

message("*** backtrace( ) - exceptions ... DONE")
