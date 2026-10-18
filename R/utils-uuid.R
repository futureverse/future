## Create a universally unique identifier (UUID) for an R object
#' @importFrom tools md5sum
uuid <- local({
  ## We need to trick 'R CMD check' that 'md5' is a function already,
  ## because with md5 <- NULL, 'codetools' triggers a check NOTE.
  md5 <- function(x) {
    ## 1. Use the native tools::md5sum(bytes = ...), if R (>= 4.5.0).
    if ("bytes" %in% names(formals(md5sum))) {
      impl <- function(x) md5sum(bytes = serialize(x, connection = NULL))
    } else if (requireNamespace("digest", quietly = TRUE)) {
      ## 2. On R (< 4.5.0), use digest::digest(), if the 'digest' package
      ##    is available.
      impl <- function(x) {
        digest::digest(x, algo = "md5", serialize = TRUE, skip = 0L)
      }
    } else {
      ## 3. On R (< 4.5.0), fall back to tools::md5sum(files = ...)
      impl <- function(x) {
        bytes <- serialize(x, connection = NULL)
        tmp <- tempfile()
        on.exit(unlink(tmp))
        writeBin(bytes, tmp)
        unname(md5sum(tmp))
      }
    }

    ## Memoize md5() function, which will replace it for future calls
    md5 <<- impl

    ## But for this first call, we need to call it
    impl(x)
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
