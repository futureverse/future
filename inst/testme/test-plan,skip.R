#' @tags plan
#' @tags sequential multisession

library(future)

options(future.debug = FALSE)

message("*** plan(..., .skip = ...) ...")

## A FutureBackend is an environment, so identical() tells whether
## it is the same backend instance or a new one. Note, we cannot use
## the backend 'uuid', because it is derived from proc.time(), which
## may be the same for two backends created in quick succession on
## MS Windows
same_backend <- function(backend) identical(plan("backend"), backend)

strategies <- list(sequential = list(sequential))
if (parallelly::availableCores() >= 2L) {
  strategies[["multisession"]] <- list(multisession, workers = 2L)
}

for (name in names(strategies)) {
  args <- strategies[[name]]
  set_plan <- function(...) do.call(plan, args = c(args, list(...)))
  message(sprintf("- plan('%s')", name))

  set_plan()
  backend0 <- plan("backend")

  message("  - default: setting the same plan again is skipped")
  set_plan()
  stopifnot(same_backend(backend0))

  message("  - .skip = TRUE: setting the same plan again is skipped")
  set_plan(.skip = TRUE)
  stopifnot(same_backend(backend0))

  message("  - .skip = FALSE: setting the same plan again replaces it")
  set_plan(.skip = FALSE)
  backend1 <- plan("backend")
  stopifnot(!same_backend(backend0))

  ## The new backend works
  f <- future(42L)
  stopifnot(identical(value(f), 42L))

  message("  - .skip = TRUE: setting a different plan is not skipped")
  set_plan(gc = TRUE, .skip = TRUE)
  stopifnot(!same_backend(backend1))
}

plan(sequential)

message("*** plan(..., .skip = ...) ... DONE")
