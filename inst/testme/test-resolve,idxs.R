#' @tags resolve
#' @tags listenv
#' @tags sequential

library(future)
library(listenv)

options(future.debug = FALSE)

message("*** resolve(..., idxs = ...) only resolves the selected elements ...")

plan(sequential)

state_of <- function(x) vapply(as.list(x), FUN = function(f) f[["state"]], FUN.VALUE = NA_character_)

message("- list")
x <- list(a = future(1, lazy = TRUE), b = future(2, lazy = TRUE), c = future(3, lazy = TRUE))
y <- resolve(x, idxs = "a")
print(state_of(x))
stopifnot(
  identical(y, x),
  x$a$state == "finished", x$b$state == "created", x$c$state == "created"
)
y <- resolve(x, idxs = 3L)
print(state_of(x))
stopifnot(
  x$a$state == "finished", x$b$state == "created", x$c$state == "finished"
)

message("- environment")
x <- new.env()
x$a <- future(1, lazy = TRUE)
x$b <- future(2, lazy = TRUE)
x$c <- future(3, lazy = TRUE)
y <- resolve(x, idxs = "a")
print(state_of(x)[c("a", "b", "c")])
stopifnot(
  identical(y, x),
  x$a$state == "finished", x$b$state == "created", x$c$state == "created"
)
y <- resolve(x, idxs = c("c", "a"))
print(state_of(x)[c("a", "b", "c")])
stopifnot(
  x$a$state == "finished", x$b$state == "created", x$c$state == "finished"
)
y <- resolve(x)
print(state_of(x)[c("a", "b", "c")])
stopifnot(all(state_of(x) == "finished"))

message("- list environment")
x <- listenv(a = future(1, lazy = TRUE), b = future(2, lazy = TRUE), c = future(3, lazy = TRUE))
y <- resolve(x, idxs = "a")
print(state_of(x))
stopifnot(
  identical(y, x),
  x$a$state == "finished", x$b$state == "created", x$c$state == "created"
)
y <- resolve(x, idxs = 3L)
print(state_of(x))
stopifnot(
  x$a$state == "finished", x$b$state == "created", x$c$state == "finished"
)
y <- resolve(x)
print(state_of(x))
stopifnot(all(state_of(x) == "finished"))

message("- list environment with dimensions")
x <- listenv()
for (kk in 1:4) x[[kk]] <- future(kk, lazy = TRUE)
dim(x) <- c(2L, 2L)
y <- resolve(x, idxs = matrix(c(1L, 2L), ncol = 2L))
states <- state_of(x)
print(states)
stopifnot(
  identical(dim(y), c(2L, 2L)),
  states[3] == "finished", all(states[-3] == "created")
)

message("*** resolve(..., idxs = ...) only resolves the selected elements ... DONE")
