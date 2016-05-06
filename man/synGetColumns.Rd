\name{synGetColumns}
\alias{synGetColumns}
\docType{methods}
\title{
synGetColumns
}
\description{Get the column objects for a Table, given the Table, TableSchema, or ID}
\usage{synGetColumns(arg)}
\arguments{
  \item{arg}{
  the Table, TableSchema, or ID of the table of interest.
  }
}
\value{
	A TableColumnList (a typed list of TableColumn objects) for the columns of the given Table.
}
\seealso{
\code{\link{TableColumn},\link{synAddColumn},\link{synRemoveColumn},\link{Table},\link{TableSchema}}
}
