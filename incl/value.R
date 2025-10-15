## ------------------------------------------------------
## A single future
## ------------------------------------------------------
x <- sample(100, size = 50)
f <- future(mean(x))
v <- value(f)
message("The average of 50 random numbers in [1,100] is: ", v)



## ------------------------------------------------------
## Ten futures
## ------------------------------------------------------
xs <- replicate(10, { list(sample(100, size = 50)) })
fs <- lapply(xs, function(x) { future(mean(x)) })

## The 10 values as a list (because 'fs' is a list)
vs <- value(fs)
message("The ten averages are:")
str(vs)

## The 10 values as a vector (by manually unlisting)
vs <- value(fs)
vs <- unlist(vs)
message("The ten averages are: ", paste(vs, collapse = ", "))

## The values as a vector (by reducing)
vs <- value(fs, reduce = c)
message("The ten averages are: ", paste(vs, collapse = ", "))

## Calculate the sum of the averages (by reducing)
total <- value(fs, reduce = `+`)
message("The sum of the ten averages is: ", total)
