\name{synGetColumns}
\alias{synGetColumns}
\docType{methods}
\title{
synGetColumns
}
\description{
Get the columns defined in Synapse either (1) corresponding to a set of column
headers, (2) those for a given schema, or (3) those whose names start with a given prefix.
}
\usage{
synGetColumns(x, limit=100, offset=0)
}
\arguments{
\item{x}{ a list of column headers, a Table Entity object (Schem/EntityViewSchema), a Table's Synapse ID, or a string prefix\cr
}
\item{limit}{ maximum number of columns to return (pagination parameter)\cr
}
\item{offset}{ the index of the first column to return (pagination parameter)}
}
\value{
 a generator of Column objects.  Use \code{\link{nextElem}} or \code{\link{as.list}} to access the values.
}
\seealso{
\code{\link{nextElem}}
\code{\link{as.list}}
}
\examples{
\dontrun{
columns<-as.list(synGetColumns("syn1234567", limit=100, offset=0))
}
}



