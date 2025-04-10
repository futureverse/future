#' @tags futureSessionInfo
#' @tags sequential

library(future)

message("*** futureSessionInfo() ...")

message(" - test = FALSE")
futureSessionInfo(test = FALSE)

message(" - test = TRUE")
futureSessionInfo(test = TRUE)

message("*** futureSessionInfo() ... DONE")

