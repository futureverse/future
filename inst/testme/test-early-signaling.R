#' @tags early-signal
#' @tags sequential multisession multicore
#' @tags skip_on_cran

library(future)

options(future.debug = FALSE)

message("*** Early signaling of conditions ...")

message("*** Early signaling of conditions with sequential futures ...")

plan(sequential)
f <- future({ stop("bang!") })
r <- resolved(f)
stopifnot(r)
v <- tryCatch(value(f), error = identity)
stopifnot(inherits(v, "error"))

message("- with lazy evaluation ...")
f <- future({ stop("bang!") }, lazy = TRUE)
r <- resolved(f)
print(r)
v <- tryCatch(value(f), error = identity)
stopifnot(inherits(v, "error"))

plan(sequential, earlySignal = TRUE)
f <- tryCatch(future({ stop("bang!") }), error = identity)
stopifnot(inherits(f, "error"))

message("- with lazy evaluation ...")

## Errors
f <- future({ stop("bang!") }, lazy = TRUE)
r <- tryCatch(resolved(f), error = identity)
print(r)
v <- tryCatch(value(f), error = identity)
stopifnot(inherits(v, "error"))

## Warnings
f <- future({ warning("careful!") }, lazy = TRUE)
res <- tryCatch({
  r <- resolved(f)
}, condition = function(w) w)
str(res)
stopifnot(inherits(res, "warning"))

## Messages
f <- future({ message("hey!") }, lazy = TRUE)
res <- tryCatch({
  r <- resolved(f)
}, condition = function(w) w)
stopifnot(inherits(res, "message"))

## Condition
f <- future({ signalCondition(simpleCondition("hmm")) }, lazy = TRUE)
res <- tryCatch({
  r <- resolved(f)
}, condition = function(w) w)
stopifnot(inherits(res, "condition"))

message("*** Early signaling of conditions with sequential futures ... DONE")


message("Number of available cores: ", availableCores())

message("*** Early signaling of conditions with multisession futures ...")

plan(multisession)
f <- future({ stop("bang!") })
Sys.sleep(0.2)
r <- resolved(f)
print(r)
v <- tryCatch(value(f), error = identity)
stopifnot(inherits(v, "error"))

if (availableCores() > 1L) {
  plan(multisession, earlySignal = TRUE)
  f <- future({ stop("bang!") })
  Sys.sleep(0.2)
  print(f)
  r <- tryCatch(resolved(f), error = identity)
  print(r)
  v <- tryCatch(value(f), error = identity)
  stopifnot(inherits(v, "error"))
} else {
  message("- Skipping earlySignal = TRUE with 'multisession' because availableCores() == 1")
}


message("*** Early signaling of conditions with multisession futures ... DONE")


if (supportsMulticore()) {
  message("*** Early signaling of conditions with multicore futures ...")
  
  plan(multicore)
  f <- future({ stop("bang!") })
  Sys.sleep(0.2)
  r <- resolved(f)
  print(r)
  v <- tryCatch(value(f), error = identity)
  stopifnot(inherits(v, "error"))
  
  if (availableCores() > 1L) {
    plan(multicore, earlySignal = TRUE)
    f <- future({ stop("bang!") })
    Sys.sleep(0.2)
    print(f)
    r <- tryCatch(resolved(f), error = identity)
    print(r)
    v <- tryCatch(value(f), error = identity)
    stopifnot(inherits(v, "error"))
  
    ## Errors
    f <- future({ stop("bang!") }, earlySignal = TRUE)
    Sys.sleep(0.2)
    r <- tryCatch(resolved(f), error = identity)
    print(r)
    stopifnot(inherits(r, "error") || inherits(f, "SequentialFuture"))
    v <- tryCatch(value(f), error = identity)
    stopifnot(inherits(v, "error"))
  } else {
    message("- Skipping earlySignal = TRUE with 'multicore' because availableCores() == 1")
  }
  
  ## Warnings
  f <- future({ warning("careful!") }, earlySignal = TRUE)
  Sys.sleep(0.2)
  res <- tryCatch({ r <- resolved(f) }, condition = function(w) w)
  print(res)
  
  ## Messages
  f <- future({ message("hey!") }, earlySignal = TRUE)
  Sys.sleep(0.2)
  res <- tryCatch({ r <- resolved(f) }, condition = function(w) w)
  print(res)
  
  ## Condition
  f <- future({ signalCondition(simpleCondition("hmm")) }, earlySignal = TRUE)
  Sys.sleep(0.2)
  res <- tryCatch({ r <- resolved(f) }, condition = function(w) w)
  print(res)
  
  message("*** Early signaling of conditions with multicore futures ... DONE")
}


message("*** Early signaling of conditions ... DONE")
