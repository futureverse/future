#' @tags utils-internal

message("*** utils ...")

message("*** hpaste() ...")

# Some vectors
x <- 1:6
y <- 10:1
z <- LETTERS[x]

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Abbreviation of output vector
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
printf("x = %s.\n", hpaste(x))
## x = 1, 2, 3, ..., 6.

printf("x = %s.\n", hpaste(x, maxHead = 2))
## x = 1, 2, ..., 6.

printf("x = %s.\n", hpaste(x, maxHead = 3)) # Default
## x = 1, 2, 3, ..., 6.

# It will never output 1, 2, 3, 4, ..., 6
printf("x = %s.\n", hpaste(x, maxHead = 4))
## x = 1, 2, 3, 4, 5 and 6.

# Showing the tail
printf("x = %s.\n", hpaste(x, maxHead = 1, maxTail = 2))
## x = 1, ..., 5, 6.

# Turning off abbreviation
printf("y = %s.\n", hpaste(y, maxHead = Inf))
## y = 10, 9, 8, 7, 6, 5, 4, 3, 2, 1

## ...or simply
printf("y = %s.\n", paste(y, collapse = ", "))
## y = 10, 9, 8, 7, 6, 5, 4, 3, 2, 1

# Change last separator
printf("x = %s.\n", hpaste(x, lastCollapse = " and "))
## x = 1, 2, 3, 4, 5 and 6.

# No collapse
stopifnot(all(hpaste(x, collapse = NULL) == x))

# Empty input
stopifnot(identical(hpaste(character(0)), character(0)))

message("*** hpaste() ... DONE")


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# asIEC()
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
message("*** asIEC() ...")

for (size in c(0, 10 ^ (0:20))) {
  cat(sprintf("Size: %.f bytes = %s\n", size, asIEC(size)))
}

message("*** asIEC() ... DONE")


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# .length()
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
message("*** .length() ...")
.length <- future:::.length

objs <- list(
  a = 1:3,
  b = as.list(1:3),
  c = structure(as.list(1:3), class = c("foo", "list")),
  d = data.frame(a = 1:3),
  e = as.environment(list(a = 1:3))
)
truth <- c(a = 3L, b = 3L, c = 3L, d = 1L, e = 1L)

## Special case: length(x) == 5, but .length(x) == 2
## BUG FIX: https://github.com/futureverse/future/issues/164
if (requireNamespace("tools")) {
  objs[["f"]] <- structure(list("foo", length = 5L), class = "pdf_doc")
  truth["f"] <- 2L
}

for (name in names(objs)) {
  obj <- objs[[name]]
  len <- length(obj)
  .len <- .length(obj)
  cat(sprintf("%s: length = %d, .length = %d, expected = %d\n",
              name, len, .len, truth[name]))
  stopifnot(.len == truth[name])
}

message("*** .length() ... DONE")

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# debug()
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
message("*** mdebug() ...")

mdebug("Hello #", 1)
mdebugf("Hello #%d", 1)
options(future.debug = TRUE)

mdebug("Hello #", 2)
mdebugf("Hello #%d", 2)
options(future.debug = FALSE)

mdebug("Hello #", 3)
mdebugf("Hello #%d", 3)

message("*** mdebug() ... DONE")


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# geval() et al.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
message("*** geval() et al. ...")

gls <- function(..., envir = .GlobalEnv) ls(..., envir = envir)

message("- gls() ...")
genv <- new.env(parent = globalenv())
vars <- gls(envir = genv)
print(vars)
stopifnot(length(vars) == 0)

message("- gassign() ...")
gassign("a", 1, envir = genv)
vars <- gls(envir = genv)
print(vars)
stopifnot(length(vars) == 1)

message("- grmall() ...")
grmall(envir = genv)
vars <- gls(envir = genv)
print(vars)
stopifnot(length(vars) == 0)

message("- geval() ...")
gassign("a", 1, envir = genv)
res <- geval(substitute(a), envir = genv)
print(res)
vars <- gls(envir = genv)
print(vars)
stopifnot(length(vars) == 1)


message("*** geval() et al. ... DONE")


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# requirePackages()
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
message("*** requirePackages() ...")

res <- requirePackages("future")
res <- requirePackages(c("future", "listenv"))

res <- try(requirePackages("<unknown package>"), silent = TRUE)
stopifnot(inherits(res, "try-error"))

message("*** requirePackages() ... DONE")


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# importParallel()
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
message("*** importParallel() ...")

mclapply <- importParallel("mclapply")
stopifnot(identical(mclapply, parallel::mclapply))

ns <- getNamespace("parallel")
if (exists("sendCall", envir = ns, mode = "function")) {
  sendCall <- importParallel("sendCall")
  stopifnot(identical(sendCall, parallel:::sendCall))
} else {
  res <- try(importParallel("sendCall"), silent = TRUE)
  stopifnot(inherits(res, "try-error"))
}

res <- try(importParallel("<unknown function>"), silent = TRUE)
stopifnot(inherits(res, "try-error"))

message("*** importParallel() ... DONE")

message("*** utils ... DONE")

