%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{Schema}
\alias{Schema}
\docType{methods}
\title{
Constructor for objects of type Schema
}
\description{
A Schema is an Entity that defines a set of columns in a table.
}
\usage{
Schema(name=NULL, columns=NULL, parent=NULL, properties=NULL, annotations=NULL, local_state=NULL, description=NULL)
}
\arguments{
\item{name}{            the name for the Table Schema object\cr
}
\item{columns}{         a list of Column objects or their IDs\cr
}
\item{parent}{          the project in Synapse to which this table belongs\cr
}
\item{properties}{      A map of Synapse properties\cr
}
\item{annotations}{     A map of user defined annotations\cr
}
\item{local_state}{     Internal use only}
\item{description}{optional named parameter:      User readable description of the schema\cr
}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
An object of type Schema
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
% Examples of how to use the function. 
% Examples are not only useful for documentation purposes, but also provide test code used for diagnostic checking of R code. 
% By default, text will be displayed in the output of the help page and run by example() and by R CMD check. 
% You can use \dontrun{} for text that should only be shown, but not run, and \dontshow{} for extra commands 
% for testing that should not be shown to users, but will be run by example(). 
\examples{
%\dontrun{
%    cols = [Column(name='Isotope', columnType='STRING'),
%            Column(name='Atomic Mass', columnType='INTEGER'),
%            Column(name='Halflife', columnType='DOUBLE'),
%            Column(name='Discovered', columnType='DATE')]
%}
}



