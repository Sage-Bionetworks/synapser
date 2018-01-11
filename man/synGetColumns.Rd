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
\item{x}{ a list of column headers, a Schema, a TableSchema's Synapse ID, or a string prefix\cr
}
\item{limit}{ maximum number of columns to return (pagination parameter)\cr
}
\item{offset}{ the index of the first column to return (pagination parameter)}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
 a generator of Column objects
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
% Examples of how to use the function. 
% Examples are not only useful for documentation purposes, but also provide test code used for diagnostic checking of R code. 
% By default, text will be displayed in the output of the help page and run by example() and by R CMD check. 
% You can use \dontrun{} for text that should only be shown, but not run, and \dontshow{} for extra commands 
% for testing that should not be shown to users, but will be run by example(). 
%\dontrun{
%
%}
}



