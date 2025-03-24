#' @tags sessionDetails

library(future)

sd <- sessionDetails()
print(sd)
print(sd, output = "message")

rm(list = "sd")
