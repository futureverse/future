## Used only internally
constant <- function(...) {
  ConstantFuture(...)
}
class(constant) <- c("constant", "uniprocess", "future", "function")
