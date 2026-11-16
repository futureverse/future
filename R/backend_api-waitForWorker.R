#' Wait for a free worker
#'
#' Polls the registry of active futures of a future backend until fewer than
#' `workers` futures are registered, i.e. until at least one worker is
#' free. While waiting, resolved futures are collected, which frees up
#' their workers.
#'
#' @param backend A [FutureBackend]. Its `reg` field names the
#' registry to poll.
#'
#' @param workers (numeric) The total number of workers.
#'
#' @param timeout (numeric) The maximum number of seconds to wait.
#'
#' @param delta (numeric) The initial number of seconds to sleep
#' between polls.
#'
#' @param alpha (numeric) The factor by which the sleep interval is
#' scaled after each poll.
#'
#' @param registry (function) The registry of active futures to poll,
#' e.g. `FutureRegistry()`. It is called as `registry(reg, action = ...)`,
#' where `reg` is the registry name given by `backend[["reg"]]`.
#' Backends should pass the registry that they register their futures
#' in.
#'
#' @param debug (logical) If TRUE, debug messages are outputted.
#'
#' @return Nothing. A [FutureError] is produced if no worker became
#' available within `timeout` seconds.
#'
#' @details
#' This function is used by future backends implemented in other
#' packages, e.g. \pkg{future.callr} and \pkg{future.mirai}.
#'
#' @noRd
waitForWorker <- function(backend, workers = nbrOfWorkers(backend), timeout = backend[["timeout"]], delta = backend[["delta"]], alpha = backend[["alpha"]], registry = FutureRegistry, debug = FALSE) {
  stop_if_not(
    length(workers) == 1L, is.numeric(workers), !is.na(workers), workers >= 1,
    length(timeout) == 1L, is.numeric(timeout), !is.na(timeout), timeout >= 0,
    length(delta) == 1L, is.numeric(delta), is.finite(delta), delta > 0,
    length(alpha) == 1L, is.numeric(alpha), is.finite(alpha), alpha > 0,
    is.function(registry)
  )

  ## Name of the registry to poll
  reg <- backend[["reg"]]

  t0 <- Sys.time()
  dt <- 0
  iter <- 1L
  interval <- delta
  finished <- FALSE
  while (dt <= timeout) {
    ## Check for available workers
    used <- length(registry(reg, action = "list", earlySignal = FALSE))
    finished <- (used < workers)
    if (finished) break

    if (debug) mdebugf("Poll #%d (%s): usedWorkers() = %d, workers = %d", iter, format(round(dt, digits = 2L)), used, workers)

    ## Wait
    Sys.sleep(interval)
    interval <- alpha * interval

    ## Finish/close workers, iff possible
    registry(reg, action = "collect-first")

    iter <- iter + 1L
    dt <- difftime(Sys.time(), t0, units = "secs")
  }

  if (!finished) {
    msg <- sprintf("TIMEOUT: All %d workers are still occupied after %s (polled %d times)", workers, format(round(dt, digits = 2L)), iter)
    if (debug) mdebug(msg)
    stop(FutureError(msg))
  }

  invisible(NULL)
}
