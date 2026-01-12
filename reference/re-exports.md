# Functions Moved to 'parallelly'

The following function used to be part of future, but has since been
migrated to parallelly. The migration started with future 1.20.0
(November 2020). They were moved because they are also useful outside of
the future framework.

## Details

*If you are using any of these from the future package, please switch to
use the ones from the parallelly package. Thank you!*

- [`parallelly::as.cluster()`](https://parallelly.futureverse.org/reference/as.cluster.html)
  (no longer re-exported)

- [`parallelly::autoStopCluster()`](https://parallelly.futureverse.org/reference/autoStopCluster.html)
  (no longer re-exported)

- [`parallelly::availableCores()`](https://parallelly.futureverse.org/reference/availableCores.html)

- [`parallelly::availableWorkers()`](https://parallelly.futureverse.org/reference/availableWorkers.html)

- [`parallelly::makeClusterMPI()`](https://parallelly.futureverse.org/reference/makeClusterMPI.html)
  (no longer re-exported)

- [`parallelly::makeClusterPSOCK()`](https://parallelly.futureverse.org/reference/makeClusterPSOCK.html)

- [`parallelly::makeNodePSOCK()`](https://parallelly.futureverse.org/reference/makeClusterPSOCK.html)
  (no longer re-exported)

- [`parallelly::supportsMulticore()`](https://parallelly.futureverse.org/reference/supportsMulticore.html)

For backward-compatible reasons, *some* of these functions remain
available as exact copies also from this package (as re-exports), e.g.

    cl <- parallelly::makeClusterPSOCK(2)

can still be accessed as:

    cl <- future::makeClusterPSOCK(2)

*Note that it is the goal to remove all of the above from this package.*
