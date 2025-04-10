## Default options
oopts <- options(
  warn = 1L,
  showNCalls = 500L,
  mc.cores = 2L,
  future.debug = TRUE,
  ## Reset the following during testing in case
  ## they are set on the test system
  future.availableCores.system = NULL,
  future.availableCores.fallback = NULL
)
