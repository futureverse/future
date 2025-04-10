#' @tags connections
#' @tags misuse
#' @tags sequential multisession multicore

library(future)
options(
  future.debug = FALSE,
  future.globals.onReference = "ignore" ## because we return a connection
)

for (onMisuse in c("ignore", "warning", "error")) {
  message("onMisuse = ", sQuote(onMisuse))
  options(future.connections.onMisuse = onMisuse)

  cons_before <- getAllConnections()
  
  f <- future({
    con <- textConnection("abc")
    ## Return connection, to avoid it being
    ## garbage collected before we return
    structure(42L, con = con)
  })
  r <- result(f)
  diff <- r[["misuseConnections"]]
  message("Misused connections:")
  v <- tryCatch({
    value(f)
  }, condition = identity)
  str(v)
  
  if (onMisuse == "error") {
    if (inherits(v, "condition")) message(conditionMessage(v))
    stopifnot(inherits(v, "FutureError"))
  } else if (onMisuse == "warning") {
    if (inherits(v, "condition")) message(conditionMessage(v))
    stopifnot(inherits(v, "FutureWarning"))
  } else {
    message("None")
    if (inherits(v, "condition")) message(conditionMessage(v))
    stopifnot(
      !inherits(v, "condition"),
      v == 42L
    )
  }

  ## Close stray connection?
  cons_diff <- setdiff(getAllConnections(), cons_before)
  message("Closing stray connections: ", paste(cons_diff, collapse = ", "))
  lapply(cons_diff, FUN = function(idx) {
    tryCatch(close(getConnection(idx)), error = identity)
  })
}

