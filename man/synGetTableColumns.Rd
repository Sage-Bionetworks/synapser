\name{synGetTableColumns}
\alias{synGetTableColumns}
\docType{methods}
\title{
synGetTableColumns
}
\description{
Retrieve the column models used in the given table schema.
}
\usage{
synGetTableColumns(table)
}
\arguments{
\item{table}{  the schema of the Table whose columns are to be retrieved}
}
\value{
  a Generator over the Table's columns.  Use \code{\link{nextElem}} or \code{\link{as.list}} to access the values.
}
\seealso{
\code{\link{nextElem}}
\code{\link{as.list}}
}
\examples{
\dontrun{
schema<-synGet("syn1234567")
columns<-synGetTableColumns(schema)
}
}



