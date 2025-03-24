## Travis CI specific: Explicit garbage collection because it
## looks like Travis CI might run out of memory during 'covr'
## testing and we now have so many tests. /HB 2017-01-11
if ("covr" %in% loadedNamespaces()) {
  res <- gc()
  testme <- as.environment("testme")
  if (testme[["debug"]]) print(res)
}
