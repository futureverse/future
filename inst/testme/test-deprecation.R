#' @tags utils-internal deprecation

library(future)

deprecateArgument <- future:::deprecateArgument

message("*** deprecateArgument() ...")

## Only a known set of functions is accepted
res <- tryCatch(deprecateArgument("<unknown>", name = "a", value = 1L),
                error = identity)
print(res)
stopifnot(inherits(res, "error"))

message("*** deprecateArgument() ... DONE")


message("*** deprecateArgument() - action 'ignore' ...")

local({
  oopts <- options(future.future.myarg = "ignore")
  on.exit(options(oopts))
  ## Nothing is signalled, and nothing is returned
  res <- withCallingHandlers({
    deprecateArgument("future", name = "myarg", value = 1L)
  }, condition = function(c) {
    if (inherits(c, c("warning", "error"))) stop("Unexpected condition signalled")
  })
  stopifnot(is.null(res))
})

message("*** deprecateArgument() - action 'ignore' ... DONE")


message("*** deprecateArgument() - action 'deprecated' ...")

## The default action is to signal a deprecation warning
local({
  oopts <- options(future.plan.myarg = NULL)
  on.exit(options(oopts))
  res <- tryCatch(deprecateArgument("plan", name = "myarg", value = 1L),
                  warning = identity)
  print(res)
  stopifnot(inherits(res, "warning"))
  msg <- conditionMessage(res)
  ## The message names the function, the argument, and its value
  stopifnot(
    grepl("plan()", msg, fixed = TRUE),
    grepl("myarg", msg, fixed = TRUE)
  )
})

## The action can also be requested explicitly
local({
  oopts <- options(future.resolved.myarg = "deprecated")
  on.exit(options(oopts))
  res <- tryCatch(deprecateArgument("resolved", name = "myarg", value = "abc"),
                  warning = identity)
  stopifnot(inherits(res, "warning"))
  stopifnot(grepl("abc", conditionMessage(res), fixed = TRUE))
})

message("*** deprecateArgument() - action 'deprecated' ... DONE")


message("*** deprecateArgument() - action 'defunct' ...")

local({
  oopts <- options(future.future.myarg = "defunct")
  on.exit(options(oopts))
  res <- tryCatch(deprecateArgument("future", name = "myarg", value = 1L),
                  error = identity)
  print(res)
  stopifnot(inherits(res, "error"))
  stopifnot(grepl("myarg", conditionMessage(res), fixed = TRUE))
})

message("*** deprecateArgument() - action 'defunct' ... DONE")


message("*** deprecateArgument() - unknown action ...")

local({
  oopts <- options(future.future.myarg = "<unknown action>")
  on.exit(options(oopts))
  res <- tryCatch(deprecateArgument("future", name = "myarg", value = 1L),
                  error = identity)
  print(res)
  stopifnot(inherits(res, "error"))
})

message("*** deprecateArgument() - unknown action ... DONE")


message("*** deprecateArgument() - call stack in message ...")

## When called from the deprecated function itself, the reported call stack
## is truncated at that function
local({
  oopts <- options(future.future.myarg = "deprecated")
  on.exit(options(oopts))
  future <- function() deprecateArgument("future", name = "myarg", value = 1L)
  res <- tryCatch(future(), warning = identity)
  stopifnot(inherits(res, "warning"))
  print(conditionMessage(res))
})

message("*** deprecateArgument() - call stack in message ... DONE")
