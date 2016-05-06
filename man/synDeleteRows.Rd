\name{synDeleteRows}
\alias{synDeleteRows}
\title{
synDeleteRows
}
\description{
Delete rows from a Synapse Table
}
\usage{
synDeleteRows(table)
}
\arguments{
 \item{table}{
A TableDataFrame, having a table schema and a data frame, whose row labels indicate which rows to delete from the Synapse table.
}
}
\details{
Deletes selected rows in Synapse.  The passed data frame must have row labels in the format <row ID>-<version>, i.e. two integers 
separated by a dash ('-').  This is the label format for the data frames returned by synStore and synTableQuery.
}

\seealso{
\code{\link{synStore}}
\code{\link{synTableQuery}}
}
\examples{
\dontrun{
	queryResult<-synTableQuery("select * from syn1234 where foo='bar'")
	synDeleteRows(queryResult)
}
}

