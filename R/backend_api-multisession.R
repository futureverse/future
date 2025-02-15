#' Create a multisession future whose value will be resolved asynchronously in a parallel \R session
#'
#' A multisession future is a future that uses multisession evaluation,
#' which means that its _value is computed and resolved in
#' parallel in another \R session_.
#'
#' @details
#' This function is _not_ meant to be called directly.  Instead, the
#' typical usages are:
#'
#' ```r
#' # Evaluate futures in parallel on the local machine via as many background
#' # processes as available to the current R process
#' plan(multisession)
#'
#' # Evaluate futures in parallel on the local machine via two background
#' # processes
#' plan(multisession, workers = 2)
#' ```
#'
#' @inheritParams multicore
#' @inheritParams cluster
#' @inheritParams Future-class
#' @inheritParams future
#' 
#' @param \dots Additional arguments passed to [Future()].
#'
#' @param rscript_libs A character vector of \R package library folders that
#' the workers should use.  The default is `.libPaths()` so that multisession
#' workers inherits the same library path as the main \R session.
#' To avoid this, use `plan(multisession, ..., rscript_libs = NULL)`.
#' _Important: Note that the library path is set on the workers when they are
#' created, i.e. when `plan(multisession)` is called.  Any changes to
#' `.libPaths()` in the main R session after the workers have been created
#' will have no effect._
#' This is passed down as-is to [parallelly::makeClusterPSOCK()].
#'
#' @return
#' A \link{MultisessionFuture}.
#' If `workers == 1`, then all processing is done in the
#' current/main \R session and we therefore fall back to using a
#' lazy future.  To override this fallback, use `workers = I(1)`.
#'
## FIXME: It seem that multisession futures in examples gives errors
##        with R CMD check, e.g. "cannot open file 'future-Ex.Rout':
##        Permission denied".  Because of this we use \donttest{}.
#'@example incl/multisession.R
#'
#' @details
#' The background \R sessions (the "workers") are created using
#' [makeClusterPSOCK()].
#' 
#' For the total number of
#' \R sessions available including the current/main \R process, see
#' [parallelly::availableCores()].
#'
#' A multisession future is a special type of cluster future.
#'
#' @seealso
#' For processing in multiple forked \R sessions, see
#' [multicore] futures.
#'
#' Use [parallelly::availableCores()] to see the total number of
#' cores that are available for the current \R session.
#'
#' @export
multisession <- function(..., workers = availableCores(), lazy = FALSE, rscript_libs = .libPaths(), envir = parent.frame()) {
  if (is.function(workers)) workers <- workers()
  workers <- structure(as.integer(workers), class = class(workers))
  stop_if_not(length(workers) == 1, is.finite(workers), workers >= 1)

  ## Fall back to lazy sequential futures if only a single R session can be used,
  ## that is, then use the current main R process.
  if (workers == 1L && !inherits(workers, "AsIs")) {
    return(sequential(..., lazy = TRUE, envir = envir))
  }

  future <- MultisessionFuture(..., workers = workers, lazy = lazy, rscript_libs = rscript_libs, envir = envir)
  if (!future$lazy) future <- run(future)
  invisible(future)
}
class(multisession) <- c("multisession", "cluster", "multiprocess", "future", "function")
attr(multisession, "init") <- TRUE
attr(multisession, "cleanup") <- function() {
  ClusterRegistry(action = "stop")
}
attr(multisession, "untweakable") <- c("persistent")
