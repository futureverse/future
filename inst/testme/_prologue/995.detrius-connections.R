get_connections <- function() {
  cons <- lapply(getAllConnections(), FUN = function(idx) {
    tryCatch({
      con <- getConnection(idx)
      as.data.frame(c(index = idx, summary(con)))
    }, error = function(e) {
      NULL
    })
  })
  do.call(rbind, cons)
}

diff_connections <- function(after, before) {
  index <- NULL ## To please R CMD check
  
  ## Nothing to do?
  if (length(before) + length(after) == 0L) {
    return(c(added = NULL, removed = NULL, replaced = NULL))
  }

  idxs <- setdiff(after[["index"]], before[["index"]])
  if (length(idxs) > 0) {
    added <- subset(after, index %in% idxs)
    after <- subset(after, ! index %in% idxs)
  } else {
    added <- NULL
  }
  
  idxs <- setdiff(before[["index"]], after[["index"]])
  if (length(idxs) > 0) {
    removed <- subset(before, index %in% idxs)
    before <- subset(before, ! index %in% idxs)
  } else {
    removed <- NULL
  }

  idxs <- intersect(before[["index"]], after[["index"]])
  if (length(idxs) > 0) {
    replaced <- list()
    for (idx in idxs) {
      before_idx <- subset(before, index == idx)
      after_idx <- subset(after, index == idx)
      if (!identical(before_idx, after_idx)) {
        for (name in colnames(after_idx)) {
          value <- after_idx[[name]]
          if (!identical(before_idx[[name]], value)) {
            value <- sprintf("%s (was %s)", value, before_idx[[name]])
            after_idx[[name]] <- value
          }
        }
        replaced <- c(replaced, list(after_idx))
      }
    }
    replaced <- do.call(rbind, replaced)
  } else {
    replaced <- NULL
  }

  list(added = added, removed = removed, replaced = replaced)
}

testme <- as.environment("testme")
testme[["testme_connections"]] <- get_connections()
