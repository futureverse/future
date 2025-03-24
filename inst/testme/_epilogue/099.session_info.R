testme <- as.environment("testme")
if (testme[["debug"]]) {
  info <- utils::sessionInfo()
  message("Session information:")
  print(info)
}
