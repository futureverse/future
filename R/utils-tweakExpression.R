## Formula #1:
##   expression: ~ rhs
##   AST: (~ rhs)
##   tweaked expression: rhs; ~ rhs
##
## Formula #2:
##   expression: lhs ~ rhs
##   AST: (~ lhs rhs)
##   tweaked expression: rhs; lhs ~ rhs
tweakFormulaCall <- function(expr) {
  if (!is.call(expr)) return(expr)
  expr <- unclass(expr)  
  op <- expr[[1]]
  if (!is.symbol(op)) return(expr)
  op <- as.character(op)
  if (op != "~") return(expr)
  n <- length(expr)
  if (n == 2) {
    lhs <- NULL
    rhs <- expr[[2]]
  } else if (n == 3) {
    lhs <- expr[[2]]
    rhs <- expr[[3]]
  } else {
    return(expr)
  }
  
  substitute(
    { lhs; rhs; e },
    list(lhs = lhs, rhs = rhs, e = expr)
  )
} ## tweakFormulaCall()


## Subassignment #1:
##   expression: x$a <- value
##   AST: (<- ($ x a) value)
##   tweaked expression: x; x$a <- value
##
##   expression: value -> x$a
##   AST: (<- ($ x a) value)
##   tweaked expression: x; value -> x$a
##
## Subassignment #2:
##   expression: x[["a"]] <- value
##   AST: (<- ($ [[ a) value)
##   tweaked expression: x; x[["a"]] <- value
##
##   expression: value -> x[["a"]]
##   AST: (<- ([[ x a) value)
##   tweaked expression: x; value -> x[["a"]]
##
## Subassignment #3:
##   expression: x["a"] <- value
##   AST: (<- ([ x a) value)
##   tweaked expression: x; x["a"] <- value
##
##   expression: x[1, 2, 3] <- value
##   AST: (<- ([ x 1 2 3) value)
##   tweaked expression: x; x[1, 2, 3] <- value
tweakSubassignmentCall <- function(expr) {
  if (!is.call(expr)) return(expr)
  expr <- unclass(expr)  
  op <- expr[[1]]
  if (!is.symbol(op)) return(expr)
  op <- as.character(op)
  if (op != "<-") return(expr)
  n <- length(expr)
  if (n != 3) return(expr)

  ## expression #2: x$a, x[["a"]], or x[...]
  ## AST #2: ($ x a), ([[ x a), or ([ x ...)
  expr2 <- expr[[2]]
  if (!is.call(expr2)) return(expr)
  op2 <- expr2[[1]]
  if (!is.symbol(op2)) return(expr)
  op2 <- as.character(op2)
  if (!op2 %in% c("$", "[[", "[")) return(expr)
  n2 <- length(expr2)
  if (n2 < 3) return(expr)

  target <- expr2[[2]]
  
  substitute(
    { target; e },
    list(target = target, e = expr)
  )
} ## tweakSubassignmentCall()



## Future assignment #1:
##   expression: lhs %<-% rhs
##   AST: (%<-% lhs rhs)
##   tweaked expression: lhs <- rhs; lhs %<-% rhs
tweakFutureAssignmentCall <- function(expr) {
  if (!is.call(expr)) return(expr)
  expr <- unclass(expr)  
  op <- expr[[1]]
  if (!is.symbol(op)) return(expr)
  n <- length(expr)
  if (n != 3) return(expr)
  
  op <- as.character(op)
  if (op %in% c("<<-", "%<-%")) {
    lhs <- expr[[2]]
    rhs <- expr[[3]]
    expr <- substitute(
      {a <- b; e},
      list(a = lhs, b = rhs, e = expr)
    )
  } else if (op %in% c("->>", "%->%")) {
    lhs <- expr[[3]]
    rhs <- expr[[2]]
    expr <- substitute(
      {a <- b; e},
      list(a = lhs, b = rhs, e = expr)
    )
  }
  
  expr
} ## tweakFutureAssignmentCall()


# Tweaks a future expression prior to searching for globals
#
# @param expr An \R expression
#
# @return An \R expression
#
# @keywords internal
#
#' @importFrom globals walkAST
tweakExpression <- function(expr) {
  if (!is.language(expr)) return(expr)
 
  expr <- walkAST(expr, call = tweakFutureAssignmentCall)
  expr <- walkAST(expr, call = tweakFormulaCall)
  expr <- walkAST(expr, call = tweakSubassignmentCall)
 
  expr
}
