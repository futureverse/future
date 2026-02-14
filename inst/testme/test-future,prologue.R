#' @tags future
#' @tags sequential

library(future)
options(future.debug = FALSE)

message("*** future() with prologue expression ...")

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
  stdout == "prologue evaluation"
)

v <- value(f)
stopifnot(identical(v, c(3.14, 42)))

f <- reset(f)
v <- value(f)
stopifnot(identical(v, c(3.14, 42)))


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
