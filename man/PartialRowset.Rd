\name{PartialRowset}
\alias{PartialRowset}
\docType{methods}
\title{
Constructor for objects of type PartialRowset
}
\description{
A set of Partial Rows used for updating cells of a table.
PartialRowsets allow you to push only the individual cells you wish to change
instead of pushing entire rows with many unchanged cells.
}
\usage{
PartialRowset(schema, rows)
}
\arguments{
\item{schema}{ The Schema of the table to update or its tableId as a string\cr
}
\item{rows}{ A list of PartialRows}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
An object of type PartialRowset
}
\references{
% A section with references to the literature. Use \url{} or \href{}{} for web pointers.
}
\note{
% Use this for a special note you want to have pointed out. 
}
\seealso{
% Pointers to related R objects, using \code{\link{...}} to refer to them.
}
\examples{
}



