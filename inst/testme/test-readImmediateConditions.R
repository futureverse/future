#' @tags immediateCondition utils-internal

library(future)

immediateConditionsPath <- future:::immediateConditionsPath
readImmediateConditions <- future:::readImmediateConditions
saveImmediateCondition <- future:::saveImmediateCondition
save_rds <- future:::save_rds
fileImmediateConditionHandler <- future:::fileImmediateConditionHandler

## A fresh root folder, so that we do not disturb anything else
root <- file.path(tempdir(), "test-readImmediateConditions")
dir.create(root, recursive = TRUE, showWarnings = FALSE)

make_cond <- function(msg, class) {
  structure(list(message = msg, call = NULL),
            class = c("immediateCondition", class, "condition"))
}

message("*** immediateConditionsPath() ...")

path <- immediateConditionsPath(rootPath = root)
stopifnot(utils::file_test("-d", path))

## The result is cached, so a second call gives the same path
stopifnot(identical(immediateConditionsPath(rootPath = root), path))

message("*** immediateConditionsPath() ... DONE")


message("*** save_rds() ...")

file <- file.path(root, "obj.rds")
res <- save_rds(list(a = 1L), file)
stopifnot(identical(res, file), utils::file_test("-f", file))
stopifnot(identical(readRDS(file), list(a = 1L)))
## No temporary file is left behind
stopifnot(!utils::file_test("-f", sprintf("%s.tmp", file)))

## A left-over temporary file is an error
file2 <- file.path(root, "obj2.rds")
cat("stale", file = sprintf("%s.tmp", file2))
res <- tryCatch(save_rds(list(a = 1L), file2), error = identity)
print(res)
stopifnot(inherits(res, "error"))
file.remove(sprintf("%s.tmp", file2))

## Failing to write is an error too
res <- tryCatch(save_rds(list(a = 1L), file.path(root, "<no such dir>", "x.rds")),
                error = identity)
print(res)
stopifnot(inherits(res, "error"))

message("*** save_rds() ... DONE")


message("*** readImmediateConditions() - nothing to do ...")

## A non-existing folder gives an empty list
stopifnot(identical(readImmediateConditions(path = file.path(root, "<none>")), list()))

## An empty folder gives an empty list
empty <- file.path(root, "empty")
dir.create(empty, showWarnings = FALSE)
stopifnot(identical(readImmediateConditions(path = empty), list()))

message("*** readImmediateConditions() - nothing to do ... DONE")


message("*** readImmediateConditions() - signalling ...")

## Save one condition of each kind
saveImmediateCondition(make_cond("a message", "message"), path = path)
saveImmediateCondition(make_cond("a warning", "warning"), path = path)
saveImmediateCondition(make_cond("plain", character(0)), path = path)

## They are signalled when read
msgs <- character(0L)
warns <- character(0L)
conds <- withCallingHandlers({
  readImmediateConditions(path = path)
}, message = function(c) {
  msgs <<- c(msgs, conditionMessage(c))
  invokeRestart("muffleMessage")
}, warning = function(c) {
  warns <<- c(warns, conditionMessage(c))
  invokeRestart("muffleWarning")
})

stopifnot(length(conds) == 3L)
stopifnot(any(grepl("a message", msgs, fixed = TRUE)))
stopifnot(any(grepl("a warning", warns, fixed = TRUE)))

## Each was signalled once
for (obj in conds) stopifnot(identical(obj[["signaled"]], 1L))

## The files were removed
stopifnot(length(dir(path, pattern = "[.]rds$")) == 0L)

message("*** readImmediateConditions() - signalling ... DONE")


message("*** readImmediateConditions() - remove = FALSE ...")

saveImmediateCondition(make_cond("keep me", character(0)), path = path)
conds <- readImmediateConditions(path = path, remove = FALSE)
stopifnot(length(conds) == 1L)
## The file is still there
stopifnot(length(dir(path, pattern = "[.]rds$")) == 1L)

## 'remove' must be a proper logical
res <- tryCatch(readImmediateConditions(path = path, remove = NA), error = identity)
print(res)
stopifnot(inherits(res, "error"))

## Clean up
file.remove(dir(path, pattern = "[.]rds$", full.names = TRUE))

message("*** readImmediateConditions() - remove = FALSE ... DONE")


message("*** readImmediateConditions() - filtering ...")

saveImmediateCondition(make_cond("kept", character(0)), path = path)

## Conditions not inheriting from 'include' are dropped
stopifnot(length(readImmediateConditions(path = path, include = "<no such class>",
                                         remove = FALSE)) == 0L)

## An empty 'include' keeps everything
stopifnot(length(readImmediateConditions(path = path, include = character(0),
                                         remove = FALSE)) == 1L)

## Objects lacking 'time'/'condition' are dropped
save_rds(list(nope = TRUE), file.path(path, "bogus.rds"))
stopifnot(length(readImmediateConditions(path = path, remove = FALSE)) == 1L)

## Cleanup files (for remaining tests)
file.remove(dir(path, pattern = "[.]rds$", full.names = TRUE))
files <- dir(path, pattern = "[.]rds$", full.names = TRUE)
stopifnot(length(files) == 0)

## Files that cannot be read as RDS are silently ignored
cat("not an RDS file", file = file.path(path, "corrupt.rds"))
res <- readImmediateConditions(path = path, remove = FALSE)
print(res)
stopifnot(length(res) == 0L, is.list(res))

file.remove(dir(path, pattern = "[.]rds$", full.names = TRUE))

message("*** readImmediateConditions() - filtering ... DONE")


message("*** readImmediateConditions() - ordering ...")

## Conditions are returned in timestamp order, not file order
for (kk in 1:3) {
  obj <- list(time = Sys.time() + (4L - kk), condition = make_cond(sprintf("c%d", kk), character(0)))
  save_rds(obj, file.path(path, sprintf("cond-%d.rds", kk)))
}
conds <- readImmediateConditions(path = path)
stopifnot(length(conds) == 3L)
msgs <- vapply(conds, FUN = function(x) conditionMessage(x[["condition"]]),
               FUN.VALUE = NA_character_)
stopifnot(identical(msgs, c("c3", "c2", "c1")))

message("*** readImmediateConditions() - ordering ... DONE")


message("*** readImmediateConditions() - with debug output ...")

local({
  oopts <- options(future.debug = TRUE)
  on.exit(options(oopts))
  saveImmediateCondition(make_cond("debugged", character(0)), path = path)
  conds <- readImmediateConditions(path = path)
  stopifnot(length(conds) == 1L)
  ## Also with nothing to read
  stopifnot(length(readImmediateConditions(path = path)) == 0L)
})

message("*** readImmediateConditions() - with debug output ... DONE")


message("*** fileImmediateConditionHandler() ...")

res <- fileImmediateConditionHandler(make_cond("handled", character(0)), path = path)
stopifnot(utils::file_test("-f", res))
conds <- readImmediateConditions(path = path)
stopifnot(length(conds) == 1L)
stopifnot(identical(conditionMessage(conds[[1]][["condition"]]), "handled"))

message("*** fileImmediateConditionHandler() ... DONE")

## Clean up
unlink(root, recursive = TRUE)
