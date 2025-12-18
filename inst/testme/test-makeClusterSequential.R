if (getRversion() >= "4.4.0") {
  library(future)
  options(future.debug = FALSE)
  
  message("plan(cluster, workers = parallelly::makeClusterSequential()) ...")
  cl <- parallelly::makeClusterSequential()
  print(cl)
  plan(cluster, workers = cl)
  print(plan())

  message("future(42)")
  f <- future(42)
  v <- value(f)
  print(v)
  stopifnot(v == 42)

  message("future(2 * a, lazy = TRUE)")
  a <- 42
  f <- future(2 * a, lazy = TRUE)
  rm(a)
  v <- value(f)
  print(v)
  stopifnot(v == 2 * 42)

  message("future(2 * a)")
  a <- 42
  f <- future(2 * a)
  v <- value(f)
  print(v)
  stopifnot(v == 2 * a)

  plan(sequential)
}
