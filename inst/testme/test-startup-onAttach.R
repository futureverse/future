#' @tags startup onAttach

library(future)
options(future.debug = FALSE)

plan("default")
 
message("*** .onAttach() ...")

pkgname <- "future"

message("- .onAttach() w/ option future.startup.loadScript ...")

for (value in list(NULL, FALSE, TRUE)) {
  options(future.startup.loadScript = value)
  .onAttach(pkgname, pkgname)
}

message("- .onAttach() w/ option future.startup.loadScript ... DONE")

message("- .onAttach() with ./.future.R ...")

pathname <- ".future.R"
xyz <- 0L
cat("xyz <- 42L; cat('ping\n')\n", file = pathname)
.onAttach(pkgname, pkgname)
print(xyz)
stopifnot(is.integer(xyz), xyz >= 0, xyz == 42L)
file.remove(pathname)

message("- .onAttach() with ./.future.R ... DONE")

message("*** .onAttach() ... DONE")


