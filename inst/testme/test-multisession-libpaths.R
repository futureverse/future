#' @tags libPaths
#' @tags detritus-files
#' @tags detritus-connections
#' @tags sequential multisession

library(future)
options(future.debug = FALSE)

message("Main R session library path:")
libs <- .libPaths()
print(libs)

message("Multisession worker with same library path:")
with(plan(multisession), {
  f <- future(.libPaths())
  libs_w <- value(f)
})
print(libs_w)
stopifnot(identical(libs_w, libs))
message("OK")


message("Multisession worker with broken library path:")
libs_tmp <- tempdir()
with(plan(multisession, rscript_libs = libs_tmp), {
  f <- future(.libPaths())
  libs_w <- tryCatch(value(f), error = identity)
})
print(libs_w)
stopifnot(inherits(libs_w, "FutureLaunchError"))
message("OK")


message("Main with broken and multisession worker with working library path:")
.libPaths(libs_tmp)
with(plan(multisession, rscript_libs = libs), {
  f <- future(.libPaths())
  libs_w <- value(f)
})
print(libs_w)
stopifnot(identical(libs_w, libs))
.libPaths(libs)
message("OK")


message("Multisession worker with same library path:")
with(plan(multisession), {
  f <- future(.libPaths())
  libs_w <- value(f)
})
print(libs_w)
stopifnot(identical(libs_w, libs))
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
