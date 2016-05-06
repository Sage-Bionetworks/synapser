\name{synRemoveColumn}
\alias{synRemoveColumn}
\docType{methods}
\title{
synRemoveColumn
}
\description{Remove a column from a Table Schema}
\usage{synRemoveColumn(arg, column)}
\arguments{
  \item{arg}{
  the Table, TableSchema, or ID of the table of interest.
  }
  \item{column}{
  the TableColumn or column ID to remove from the table.
  }
}
\details{
Note: No server interaction takes place. (That is done when \code{synStore} is called.)
}
\seealso{
\code{\link{TableColumn},\link{synGetColumn},\link{synRemoveColumn},\link{Table},\link{TableSchema},\link{synStore}}
}
