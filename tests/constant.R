source("incl/start.R")
library("listenv")

message("*** constant() ...")

## No global variables
f <- try(constant(42L), silent = FALSE)
print(f)
stopifnot(inherits(f, "ConstantFuture"))

print(resolved(f))
y <- value(f)
print(y)
stopifnot(y == 42L)

message("*** constant() ... DONE")

source("incl/end.R")
