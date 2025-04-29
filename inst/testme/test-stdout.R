#' @tags relaying stdout
#' @tags sequential multisession multicore
library(future)

message("*** Standard output ...")

truth_rows <- utils::capture.output({
  print(1:50)
  str(1:50)
  cat(letters, sep = "-")
  cat(1:6, collapse = "\n")
  write.table(datasets::iris[1:10,], sep = "\t")
})
truth <- paste0(paste(truth_rows, collapse = "\n"), "\n")
print(truth)

for (cores in seq_len(min(2L, availCores))) {
  message(sprintf("Testing with %d cores ...", cores))
  options(mc.cores = cores)

  for (strategy in supportedStrategies(cores)) {
    message(sprintf("%s ...", strategy))
    plan(strategy)

    for (stdout in c(TRUE, FALSE, NA)) {
      message(sprintf("- stdout = %s", stdout))

      f <- future({
        print(1:50)
        str(1:50)
        cat(letters, sep = "-")
        cat(1:6, collapse = "\n")
        write.table(datasets::iris[1:10,], sep = "\t")
        42L
      }, stdout = stdout)
      r <- result(f)
      str(r)
      stopifnot(value(f) == 42L)
      if (is.na(stdout)) {
        stopifnot(is.null(r$stdout) || r$stdout == "")
      } else if (stdout) {
        print(r)
        stopifnot(identical(r$stdout, truth))
      } else {
        stopifnot(is.null(r$stdout))
      }

      v %<-% {
        print(1:50)
        str(1:50)
        cat(letters, sep = "-")
        cat(1:6, collapse = "\n")
        write.table(datasets::iris[1:10,], sep = "\t")
        42L
      } %stdout% stdout
      out <- utils::capture.output(y <- v)
      stopifnot(y == 42L)
      if (is.na(stdout)) {
        ## Single-core multisession => sequential
        if (cores > 1L || strategy != "multisession") {
          stopifnot(out == "")
        }
      } else if (stdout) {
        print(out)
        stopifnot(identical(out, truth_rows))
      } else {
        stopifnot(out == "")
      }

      message("- stdout = structure(TRUE, drop = TRUE)")
      f <- future(print(42), stdout = structure(TRUE, drop = TRUE))
      r <- result(f)
      stopifnot(inherits(r$stdout, "character"))
      v <- value(f)
      r <- result(f)
      stopifnot(is.null(r$stdout))
    } ## for (stdout ...)

    message(sprintf("%s ... done", strategy))
  } ## for (strategy ...)

  message(sprintf("Testing with %d cores ... done", cores))
} ## for (cores ...)

message("*** Standard output ... DONE")

