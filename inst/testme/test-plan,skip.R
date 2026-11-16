#' @tags plan
#' @tags sequential multisession

library(future)

options(future.debug = FALSE)

message("*** plan(..., .skip = ...) ...")

backend_uuid <- function() plan("backend")[["uuid"]]

strategies <- list(sequential = list(sequential))
if (parallelly::availableCores() >= 2L) {
  strategies[["multisession"]] <- list(multisession, workers = 2L)
}

for (name in names(strategies)) {
  args <- strategies[[name]]
  set_plan <- function(...) do.call(plan, args = c(args, list(...)))
  message(sprintf("- plan('%s')", name))

  set_plan()
  uuid0 <- backend_uuid()

  message("  - default: setting the same plan again is skipped")
  set_plan()
  stopifnot(identical(backend_uuid(), uuid0))

  message("  - .skip = TRUE: setting the same plan again is skipped")
  set_plan(.skip = TRUE)
  stopifnot(identical(backend_uuid(), uuid0))

  message("  - .skip = FALSE: setting the same plan again replaces it")
  set_plan(.skip = FALSE)
  uuid1 <- backend_uuid()
  stopifnot(!identical(uuid1, uuid0))

  ## The new backend works
  f <- future(42L)
  stopifnot(identical(value(f), 42L))

  message("  - .skip = TRUE: setting a different plan is not skipped")
  set_plan(gc = TRUE, .skip = TRUE)
  stopifnot(!identical(backend_uuid(), uuid1))
}

plan(sequential)

message("*** plan(..., .skip = ...) ... DONE")
