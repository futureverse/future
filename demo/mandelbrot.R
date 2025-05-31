library(future)
library(graphics)

## Signal a condition object that holds data
signalData <- function(..., message = character(0L), call = NULL, immediate = TRUE, signal = TRUE) {
  cond <- simpleCondition(message = message, call = call)
  cond[["data"]] <- list(...)
  class(cond) <- c("dataCondition", if (immediate) "immediateCondition", class(cond))
  if (signal) signalCondition(cond)
  invisible(cond)
}


## Options
region <- getOption("future.demo.mandelbrot.region", 1L)
if (!is.list(region)) {
  if (region == 1L) {
    region <- list(xmid = -0.75, ymid = 0.0, side = 3.0)
  } else if (region == 2L) {
    region <- list(xmid = 0.283, ymid = -0.0095, side = 0.00026)
  } else if (region == 3L) {
    region <- list(xmid = 0.282989, ymid = -0.01, side = 3e-8)
  }
}
nrow <- getOption("future.demo.mandelbrot.nrow", 3L)
resolution <- getOption("future.demo.mandelbrot.resolution", 400L)
delay <- getOption("future.demo.mandelbrot.delay", interactive())
if (isTRUE(delay)) {
  delay <- function(counts) Sys.sleep(proc.time() %% 1 * 2.0)
} else if (!is.function(delay)) {
  delay <- function(counts) {}
}

## Generate Mandelbrot tiles to be computed
Cs <- mandelbrot_tiles(xmid = region$xmid, ymid = region$ymid,
                       side = region$side, nrow = nrow,
                       resolution = resolution)
if (interactive()) {
  dev.new()
  plot.new()
  split.screen(dim(Cs))
  for (ii in seq_along(Cs)) {
    screen(ii)
    par(mar = c(0, 0, 0, 0))
    text(x = 1 / 2, y = 1 / 2, sprintf("Future #%d\nunresolved", ii), cex = 2)
  }
} else {
  split.screen(dim(Cs))
}


## Calculate and plot Mandelbrot tiles via futures
n <- length(Cs)
message(sprintf("Creating %d Mandelbrot tiles:\n", n), appendLF = FALSE)

withCallingHandlers({
  fs <- lapply(seq_along(Cs), FUN = function(idx) {
    C <- Cs[[idx]]
    future({
      ## Emulate slowness
      delay(fit)
      tile <- mandelbrot(C)
      signalData(
        idx = idx, tile = tile,
        message = sprintf("Tile %d", idx)
      )
      tile
    }, stdout = NA)
  })
  message("value(fs):")
  tiles <- value(fs)
}, dataCondition = function(cond) {
  if (length(msg <- conditionMessage(cond)) > 0L) message(msg)
  with(cond[["data"]], {
    screen(idx)
    plot(tile)
  })
})

close.screen()


message("SUGGESTION: Try to rerun this demo after changing strategy for how futures are resolved, e.g. plan(multisession).\n")
