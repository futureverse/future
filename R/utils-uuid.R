## Create a universally unique identifier (UUID) for an R object
#' @importFrom tools md5sum
#' @importFrom digest digest
uuid <- local({
  ## Use tools::md5sum(), if R (>= 4.5.0). Fall back to digest::digest().
  if ("bytes" %in% names(formals(md5sum))) {
    md5 <- function(x) md5sum(bytes = serialize(x, connection = NULL))
  } else {
    md5 <- function(x) digest(x, skip = 0L)
  }
  
  function(source, keep_source = FALSE) {
    uuid <- md5(source)
    if (keep_source) attr(uuid, "source") <- source
    uuid
  }
}) ## uuid()

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
      random = stealth_sample(.Machine[["integer.max"]], size = 1L)
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
