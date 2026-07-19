#' @tags utils-internal connections sequential

library(future)

check_connection_details <- future:::check_connection_details

plan(sequential)

f <- future(42L)
v <- value(f)

message("*** check_connection_details() ...")

## A worker without a connection is not checked
stopifnot(is.null(check_connection_details(list(con = NULL), f)))
stopifnot(is.null(check_connection_details(list(con = 42L), f)))
stopifnot(is.null(check_connection_details(list(), f)))

## A valid connection gives nothing to report
con <- file()
stopifnot(parallelly::isConnectionValid(con))
stopifnot(is.null(check_connection_details(list(con = con), f)))

## A closed connection is reported
close(con)
stopifnot(!parallelly::isConnectionValid(con))
msg <- check_connection_details(list(con = con), f)
print(msg)
stopifnot(is.character(msg), length(msg) == 1L, nchar(msg) > 0L)

## The message names the class of the future and mentions the process
stopifnot(
  grepl(class(f)[1], msg, fixed = TRUE),
  grepl("closeAllConnections", msg, fixed = TRUE),
  grepl(as.character(Sys.getpid()), msg, fixed = TRUE)
)

message("*** check_connection_details() ... DONE")


message("*** check_connection_details() - labelled future ...")

g <- future(42L, label = "my-label")
v <- value(g)
con2 <- file()
close(con2)
msg <- check_connection_details(list(con = con2), g)
print(msg)
stopifnot(grepl("my-label", msg, fixed = TRUE))

message("*** check_connection_details() - labelled future ... DONE")
