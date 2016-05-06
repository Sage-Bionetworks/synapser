\name{synapseCacheDir}
\alias{synapseCacheDir}
\title{
Synapse Local File Cache Directory
}
\description{
Set and retrieve the local directory path to be used for caching synapse data.
}
\usage{
synapseCacheDir(cacheDir)
}
\arguments{
  \item{cacheDir}{
A valid directory path on the local filesystem.
}
}

\value{
If called with no arguments, returns the path to the root of the local file cache.
}
\author{
Matt Furia
}
\seealso{
\code{\link{synGet}}
}
