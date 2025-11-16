# Export globals to the sticky-globals environment of the cluster nodes

Export globals to the sticky-globals environment of the cluster nodes

## Usage

``` r
clusterExportSticky(cl, globals)
```

## Arguments

- cl:

  (cluster) A cluster object as returned by
  [`parallel::makeCluster()`](https://rdrr.io/r/parallel/makeCluster.html).

- globals:

  (list) A named list of sticky globals to be exported.

## Value

(invisible; cluster) The cluster object.

## Details

This requires that the future package is installed on the cluster nodes.
