#' @tags future
#' @tags sequential

library(future)
plan(multisession, workers = 2L)
options(future.debug = FALSE)

prologue <- identity

message("*** future() with prologue expression ...")

message("*** future(..., prologue = ...) ...")

stdout <- utils::capture.output({
  f <- future({
    c(a, b)
  }, prologue = {
    cat("prologue evaluation\n")
    a <- 3.14
    b <- 42
  })
})

stopifnot(
  identical(stdout, "prologue evaluation")
)

v <- value(f)
stopifnot(identical(v, c(3.14, 42)))

f <- reset(f)
v <- value(f)
stopifnot(identical(v, c(3.14, 42)))

message("*** future(..., prologue = ...) ... DONE")


message("*** future(...) w/ prologue({ ... }) ...")

stdout <- utils::capture.output({
  f <- future({
    prologue({
      cat("prologue evaluation\n")
      a <- 3.14
      b <- 42
    })
    c(a, b)
  })
})
stopifnot(
  identical(stdout, "prologue evaluation")
)

v <- value(f)
stopifnot(identical(v, c(3.14, 42)))

message("*** future(...) w/ prologue({ ... }) ... DONE")


message("*** future(..., prologue = FALSE) w/ prologue({ ... }) ...")

prologue <- eval

stdout <- utils::capture.output({
  f <- future({
    prologue({
      cat("prologue evaluation\n")
      a <- 3.14
      b <- 42
    })
    c(a, b)
  }, prologue = FALSE)
})
stopifnot(
  identical(stdout, character(0L))
)

stdout <- utils::capture.output({
  v <- value(f)
})
stopifnot(
  identical(stdout, "prologue evaluation")
)
stopifnot(identical(v, c(3.14, 42)))

message("*** future(..., prologue = FALSE) w/ prologue({ ... }) ... DONE")



message("*** future() - exceptions ...")

f <- tryCatch({
  future({
    c(a, b)
  }, prologue = {
    cat("prologue evaluation\n")
    a <- 3.14
    b <- 42
    stop("prologue error")
  })
}, error = identity)
print(f)
stopifnot(inherits(f, "FutureError"))

message("*** future() - exceptions ... DONE")

message("*** future() with prologue expression ... DONE")
