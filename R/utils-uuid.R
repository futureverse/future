## Create a universally unique identifier (UUID) for an R object
#' @importFrom digest digest
uuid <- function(source, keep_source = FALSE) {
  uuid <- digest(source, skip = 0L)
  if (keep_source) attr(uuid, "source") <- source
  uuid
} ## uuid()

## A universally unique identifier (UUID) for the current
## R process UUID. Generated only once per process ID 'pid'.
## The 'pid' may differ when using forked processes.
session_uuid <- local({
  uuids <- list()

  function(pid = Sys.getpid(), attributes = TRUE) {
    pidstr <- as.character(pid)
    uuid <- uuids[[pidstr]]
    if (!is.null(uuid)) {
      if (!attributes) attr(uuid, "source") <- NULL
      return(uuid)
    }

    info <- Sys.info()
    host <- Sys.getenv(c("HOST", "HOSTNAME", "COMPUTERNAME"))
    host <- host[nzchar(host)]
    host <- if (length(host) == 0L) info[["nodename"]] else host[1L]
    info <- list(
      host = host,
      info = info,
      pid = pid,
      time = Sys.time(),
      random = stealth_sample(.Machine$integer.max, size = 1L)
    )
    uuid <- uuid(info, keep_source = TRUE)
    uuids[[pidstr]] <<- uuid
    if (!attributes) attr(uuid, "source") <- NULL
    uuid
  }
})

future_uuid <- function(owner, counter) {
  c(owner, counter)
}

uuid_of_connection <- function(con, ..., must_work = TRUE) {
  stop_if_not(inherits(con, "connection"))
  if (must_work) {
    info <- summary(con)
    info$opened <- NULL
    uuid <- uuid(info, ...)
  } else {
    uuid <- tryCatch({
      info <- summary(con)
      info$opened <- NULL
      uuid(info, ...)
    }, error = function(ex) {
      attr(con, "uuid", exact = TRUE)
    })
  }
  uuid
} ## uuid_of_connection()
