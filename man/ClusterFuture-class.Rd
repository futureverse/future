% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/backend_api-ClusterFuture-class.R,
%   R/backend_api-MultisessionFuture-class.R
\name{ClusterFuture-class}
\alias{ClusterFuture-class}
\alias{ClusterFuture}
\alias{MultisessionFuture}
\alias{MultisessionFuture-class}
\title{A cluster future is a future whose value will be resolved asynchronously in a parallel process}
\usage{
ClusterFuture(
  expr = NULL,
  substitute = TRUE,
  envir = parent.frame(),
  persistent = FALSE,
  workers = NULL,
  ...
)

MultisessionFuture(
  expr = NULL,
  substitute = TRUE,
  envir = parent.frame(),
  workers = NULL,
  ...
)
}
\arguments{
\item{expr}{An \R \link[base]{expression}.}

\item{substitute}{If TRUE, argument \code{expr} is
\code{\link[base]{substitute}()}:ed, otherwise not.}

\item{envir}{The \link{environment} from where global objects should be
identified.}

\item{persistent}{If FALSE, the evaluation environment is cleared
from objects prior to the evaluation of the future.}

\item{workers}{A \code{\link[parallel:makeCluster]{cluster}} object,
a character vector of host names, a positive numeric scalar,
or a function.
If a character vector or a numeric scalar, a \code{cluster} object
is created using \code{\link[parallelly:makeClusterPSOCK]{makeClusterPSOCK}(workers)}.
If a function, it is called without arguments \emph{when the future
is created} and its value is used to configure the workers.
The function should return any of the above types.}

\item{...}{Additional named elements passed to \code{\link[=Future]{Future()}}.}
}
\value{
\code{ClusterFuture()} returns an object of class \code{ClusterFuture}.

\code{MultisessionFuture()} returns an object of class \code{MultisessionFuture},
which inherits from \code{ClusterFuture}.
}
\description{
A cluster future is a future whose value will be resolved asynchronously in a parallel process
}
\section{Usage}{

To use 'cluster' futures, use \code{plan(cluster, ...)}, cf. \link{cluster}.


To use 'multisession' futures, use \code{plan(multisession, ...)}, cf. \link{multisession}.
}

\keyword{internal}
