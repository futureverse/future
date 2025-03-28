#' @tags connections
#' @tags misuse
#' @tags sequential multisession multicore

library(future)
options(future.debug = FALSE)

for (onMisuse in c("ignore", "warning", "error")) {
  message("onMisuse = ", sQuote(onMisuse))
  options(future.connections.onMisuse = onMisuse)

  f <- future({
    con <- textConnection("abc")
    42L
  })
  r <- result(f)
  diff <- r[["misuse_connections"]]
  message("Misused connections:")
  v <- tryCatch(value(f), condition = identity)
  str(v)
  if (onMisuse == "error") {
    message(conditionMessage(v))
    stopifnot(inherits(v, "FutureError"))
  } else if (onMisuse == "warning") {
    message(conditionMessage(v))
    stopifnot(inherits(v, "FutureWarning"))
  } else {
    message("None.")
    stopifnot(
      !inherits(v, "condition"),
      identical(v, 42L)
    )
  }
}

