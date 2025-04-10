#' @tags demo mandelbrot
#' @tags sequential

library(future)

message("mandelbrot() ...")

counts <- mandelbrot(xmid = -0.75, ymid = 0.0, side = 3.0, resolution = 100L)
img <- as.raster(counts)
plot(img)
plot(counts)

message("mandelbrot() ... DONE")

