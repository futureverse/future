## Set up two parallel workers
plan(multisession, workers = 2)

## Launch two long running future
fs <- lapply(c(1, 2), function(duration) {
  future({
    Sys.sleep(duration)
    42
  })
})

## Wait until at least one of the futures is resolved
while (!any(resolved(fs))) Sys.sleep(0.1)

## Cancel the future that is not yet resolved
r <- resolved(fs)
cancel(fs[!r])

## Get the value of the resolved future
f <- fs[r]
v <- value(f)
message("Result: ", v)

## The value of the canceled future is an error
try(v <- value(fs[!r]))

## Shut down parallel workers
plan(sequential)

