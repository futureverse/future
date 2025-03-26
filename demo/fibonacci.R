library(future)
library(listenv)

## IMPORTANT:
## 1. The below usage of lazy futures will only work when they are
##    all evaluated in the same process.
## 2. We disable the capturing of standard output (stdout=NA) to avoid
##    'sink stack is full' errors
## 3. We disable the capturing of most conditions (condition="error") to
##    avoid stacking up too many conditions
oplan <- plan(sequential)

## Defines the first 100 Fibonacci numbers
## (0, 1, 1, 2, 3, 5, 8, ...)
## but calculate only the ones need when
## a number is actually requested.

x <- listenv()
x[[1]] <- 0
x[[2]] <- 1
for (i in 3:100) {
  x[[i]] %<-% { x[[i - 2]] + x[[i - 1]] } %lazy% TRUE %stdout% NA %conditions% "error"
}

## At this point nothing has been calculated,
## because lazy evaluation is in place.

## Get the 7:th Fibonnaci numbers (should be 8)
print(x[[7]])

## At this point x[1:7] have been calculated,
## but nothing beyond.

## Let's get the 50:th number.
print(x[[50]])

## Reset plan
plan(oplan)
