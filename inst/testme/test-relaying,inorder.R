#' @tags relaying
#' @tags sequential multisession

library(future)

options(future.debug = FALSE)

message("*** Relaying in order with non-future elements ...")

make_signalConditionsASAP <- future:::make_signalConditionsASAP

message("- signalConditionsASAP() does not relay past a non-resolved future")
plan(sequential)
f1 <- future({ cat("A\n"); 1 })
f2 <- future({ cat("B\n"); 2 })
signalConditionsASAP <- make_signalConditionsASAP(3L, stdout = TRUE, signal = TRUE)

## Future #2 and non-future element #3 are ready, but future #1 is not
out <- utils::capture.output({
  relayed2 <- signalConditionsASAP(f2, pos = 2L)
  relayed3 <- signalConditionsASAP(3, pos = 3L)
})
print(out)
stopifnot(
  identical(out, character(0L)),
  !relayed2,
  relayed3
)

## Future #1 is ready, which should relay future #1 and then future #2
out <- utils::capture.output({
  relayed1 <- signalConditionsASAP(f1, pos = 1L)
})
print(out)
stopifnot(
  identical(out, c("A", "B")),
  relayed1
)

## Nothing more to relay
out <- utils::capture.output({
  res <- signalConditionsASAP(pos = 0L)
})
print(out)
stopifnot(identical(out, character(0L)))


if (parallelly::availableCores() >= 2L) {
  plan(multisession, workers = 2L)

  message("- value() relays in order when list has non-future elements")
  f1 <- future({ Sys.sleep(1.0); cat("A\n"); 1 })
  f2 <- future({ cat("B\n"); 2 })
  out <- utils::capture.output({
    vs <- value(list(f1, f2, 3))
  })
  print(out)
  stopifnot(
    identical(out, c("A", "B")),
    identical(vs, list(1, 2, 3))
  )

  message("- resolve() relays in order when list has non-future elements")
  f1 <- future({ Sys.sleep(1.0); cat("A\n"); 1 })
  f2 <- future({ cat("B\n"); 2 })
  out <- utils::capture.output({
    fs <- resolve(list(f1, f2, 3), stdout = TRUE)
  })
  print(out)
  stopifnot(identical(out, c("A", "B")))

  plan(sequential)
}

message("*** Relaying in order with non-future elements ... DONE")
