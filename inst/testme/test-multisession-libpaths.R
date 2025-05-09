#' @tags libPaths
#' @tags detritus-files
#' @tags detritus-connections
#' @tags multisession
#' @tags skip_on_cran

## These tests requires multisession workers
if (parallelly::availableCores() >= 2L) {
  library(future)
  options(future.debug = FALSE)
  
  normalize_libs <- function(paths) {
    gsub("\\\\", "/", paths)
  }
  
  assert_libs <- function(libs_worker, libs_main) {
    if (identical(libs_worker, libs_main)) return()
    libs_worker <- normalize_libs(libs_worker)
    libs_main <- normalize_libs(libs_main)
    if (identical(libs_worker, libs_main)) return()
    libs_main_added <- setdiff(libs_main, libs_worker)
    stopifnot(length(libs_main_added) == 0L)
    libs_main_worker <- setdiff(libs_worker, libs_main)
    if (length(libs_main_added) > 0L) {
      warning("The worker's library path has extra components: ",
              paste(sQuote(libs_main_added), collapse = ", "))
    }
    n_worker <- length(libs_worker)
    n_main <- length(libs_main)
    n <- max(n_worker, n_main)
    libs_worker <- c(libs_worker, rep("", times = n - n_worker))
    libs_main <- c(libs_main, rep("", times = n - n_main))
    is_equal <- (libs_worker == libs_main)
    print(is_equal)
  } # assert_libs()
  
  
  
  message("Main R session library path:")
  libs <- .libPaths()
  print(libs)
  
  message("Multisession worker with same library path:")
  with(plan(multisession), {
    f <- future(.libPaths())
    libs_w <- value(f)
  })
  print(libs_w)
  assert_libs(libs_w, libs)
  message("OK")
  
  
  message("Multisession worker with broken library path:")
  libs_tmp <- tempdir()
  with(plan(multisession, rscript_libs = normalize_libs(libs_tmp)), {
    f <- future(.libPaths())
    libs_w <- tryCatch(value(f), error = identity)
  })
  print(libs_w)
  stopifnot(inherits(libs_w, "FutureLaunchError"))
  message("OK")
  
  
  message("Main with broken and multisession worker with working library path:")
  .libPaths(libs_tmp)
  with(plan(multisession, rscript_libs = normalize_libs(libs)), {
    f <- future(.libPaths())
    libs_w <- value(f)
  })
  print(libs_w)
  assert_libs(libs_w, libs)
  .libPaths(libs)
  message("OK")
  
  
  message("Multisession worker with same library path:")
  with(plan(multisession), {
    f <- future(.libPaths())
    libs_w <- value(f)
  })
  print(libs_w)
  assert_libs(libs_w, libs)
  message("OK")
  
  
  message("Main and multisession worker with broken library path:")
  .libPaths(libs_tmp)
  with(plan(multisession), {
    f <- future(.libPaths())
    libs_w <- tryCatch(value(f), error = identity)
  })
  print(libs_w)
  stopifnot(inherits(libs_w, "FutureLaunchError"))
  .libPaths(libs)
  message("OK")
} ## if (parallelly::availableCores() >= 2L)
