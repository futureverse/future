% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/infix_api-tweak_OP.R
\name{\%tweak\%}
\alias{\%tweak\%}
\title{Temporarily tweaks the arguments of the current strategy}
\usage{
fassignment \%tweak\% tweaks
}
\arguments{
\item{fassignment}{The future assignment, e.g.
\code{x \%<-\% { expr }}.}

\item{tweaks}{A named list (or vector) with arguments that
should be changed relative to the current strategy.}
}
\description{
Temporarily tweaks the arguments of the current strategy
}
