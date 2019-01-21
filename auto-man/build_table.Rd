%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{build_table}
\alias{build_table}
\docType{methods}
\title{
build_table
}
\description{
Build a Table object
}
\usage{
build_table(name, parent, values)
}
\arguments{
\item{name}{    the name for the Table Schema object\cr
}
\item{parent}{  the project in Synapse to which this table belongs\cr
}
\item{values}{  an object that holds the content of the tables\cr
                    - a string holding the path to a CSV file\cr
                    - a Pandas \href{http://pandas.pydata.org/pandas-docs/stable/api.html#dataframe}{DataFrame}}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
 a Table object suitable for storing
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
%    path = "/path/to/file.csv"
%    table = build_table("simple_table", "syn123", path)
%    table = syn.store(table)
%}
}



