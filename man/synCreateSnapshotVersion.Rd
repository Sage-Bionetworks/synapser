\name{synCreateSnapshotVersion}
\alias{synCreateSnapshotVersion}
\docType{methods}
\title{
synCreateSnapshotVersion
}
\description{
Create a new Table Version, new View version, or new Dataset version.
}
\usage{
synCreateSnapshotVersion(table, comment=NULL, label=NULL, activity=NULL, wait=TRUE)
}
\arguments{
\item{table}{  The schema of the Table/View, or its ID.\cr
}
\item{comment}{  Optional snapshot comment.\cr
}
\item{label}{  Optional snapshot label.\cr
}
\item{activity}{  Optional activity ID applied to snapshot version.\cr
}
\item{wait}{ True if this method should return the snapshot version after waiting for any necessary\cr
                asynchronous table updates to complete. If False this method will return\cr
                as soon as any updates are initiated.}
}
\value{
 the snapshot version number if wait=True, None if wait=False
}

\examples{
\dontrun{
synCreateSnapshotVersion(table='syn123', comment='snapshot comment', wait=TRUE)
}
}



