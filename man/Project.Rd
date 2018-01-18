\name{Project}
\alias{Project}
\docType{methods}
\title{
Constructor for objects of type Project
}
\description{
Represents a project in Synapse.

Projects in Synapse must be uniquely named. Trying to create a project with
a name that's already taken, say 'My project', will result in an error
}
\usage{
Project(name=NULL, properties=NULL, annotations=NULL, local_state=NULL)
}
\arguments{
\item{name}{            The name of the project\cr
}
\item{properties}{      A named list/vector of Synapse properties.  The only valid property name is 'alias'.\cr
}
\item{annotations}{     A named list/vector of user defined annotations.\cr
}
\item{local_state}{     Internal use only}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
An object of type Project
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
%
% Verified that the following works on 2018Jan16.
%
\dontrun{
    project <- Project('Foobarbat project', properties=c(alias='foobarbat'), annotations=c(foo='bar', bat=101))
    project <- synStore(project)
    project$properties
}
}



