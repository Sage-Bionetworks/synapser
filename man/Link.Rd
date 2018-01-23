\name{Link}
\alias{Link}
\docType{methods}
\title{
Constructor for objects of type Link
}
\description{
Represents a link in Synapse.

Links must have a target ID and a parent. When you do synGet on a Link object,
the Link object is returned. If the target is desired, specify followLink=TRUE in synGet().
}
\usage{
Link(targetId=NULL, targetVersion=NULL, parent=NULL, properties=NULL, annotations=NULL)
}
\arguments{
\item{targetId}{        The ID of the entity to be linked\cr
}
\item{targetVersion}{   The version of the entity to be linked\cr
}
\item{parent}{          The parent project or folder\cr
}
\item{properties}{      A map of Synapse properties\cr
}
\item{annotations}{     A map of user defined annotations\cr
}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
An object of type Link
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
%    link = Link('targetID', parent=folder)
%    link = syn.store(link)
%}
}



