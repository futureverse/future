#' @tags FutureGlobals

library(future)

message("*** FutureGlobals() ...")

fg1 <- FutureGlobals()
print(fg1)

fg2 <- FutureGlobals(fg1)
print(fg2)

g <- globals::as.Globals(list(a = 1, b = 1:3))
print(g)

fg3 <- FutureGlobals(g)
print(fg3)

fg4 <- as.FutureGlobals(g)
print(fg4)

print(resolved(fg3))

fg <- fg4

fg_unique <- unique(fg)
print(fg_unique)

fg_resolved <- resolve(fg)
print(fg_resolved)

message("- FutureGlobals() - exceptions ...")

res <- tryCatch(g <- FutureGlobals(NULL), error = identity)
print(res)
stopifnot(inherits(res, "error"))

message("*** FutureGlobals() ... DONE")

