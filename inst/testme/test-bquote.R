#' @tags bquote

library(future)

bquote_compile <- future:::bquote_compile
bquote_apply <- future:::bquote_apply

message("*** bquote_compile() & bquote_apply() ...")

exprs <- list(
  A = quote(.(a)),
  B = quote(1 + .(a)),
  C = quote(.(a) + 2),
  D = quote({ .(a) }),
  E = quote({ 1 + .(a) }),
  F = quote(function(x = 42) { x + .(a) }),
  G = quote({ 1 + .(a + 2) * c(1, 2, .(b)) }),
  H = quote(.(a + 1)),
  I = quote(.(a + 1) + .(a)),
  J = quote(function(a=.(a)) NULL)
)


for (kk in seq_along(exprs)) {
  name <- names(exprs)[kk]
  message(sprintf("Expression #%d (%s) of %d:",
                  kk, sQuote(name), length(exprs)))
  expr <- exprs[[kk]]
  print(expr)
      
  for (a in list(1, quote(A), quote(c()), NULL)) {
    for (b in list(1, quote(B), quote(c()), NULL)) {
      str(list(a = a, b = b))

      truth <- tryCatch({
        eval(as.call(list(quote(base::bquote), expr)))
      }, error = identity)
      if (inherits(truth, "error")) next
      
      tmpl <- bquote_compile(expr, substitute = FALSE)
      expr2 <- bquote_apply(tmpl)
      print(expr2)

      if (!isTRUE(all.equal(expr2, truth))) {
        str(list(name = name, a = a, b = b, truth = truth, expr2 = expr2))  
        stopifnot(all.equal(expr2, truth))
      }
    }
  }
}

message("*** bquote_compile() & bquote_apply() ... DONE")
