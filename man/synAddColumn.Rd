\name{synAddColumn}
\alias{synAddColumn}
\docType{methods}
\title{
synAddColumn
}
\description{Add a column to a Table Schema}
\usage{synAddColumn(arg, column)}
\arguments{
  \item{arg}{
  the Table, TableSchema, or ID of the table of interest.
  }
  \item{column}{
  the TableColumn or column ID to add to the table.
  }
}
\details{
Note: No server interaction takes place. (That is done when \code{synStore} is called.)
}
\seealso{
\code{\link{TableColumn},\link{synGetColumn},\link{synAddColumn},\link{Table},\link{TableSchema},\link{synStore}}
}
