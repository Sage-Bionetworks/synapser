\name{Activity}
\alias{Activity}
\docType{methods}
\title{
Constructor for objects of type Activity
}
\description{
Represents the provenance of a Synapse Entity.
}
\usage{
Activity(name=NULL, description=NULL, used=NULL, executed=NULL, data=list())
}
\arguments{
\item{name}{        name of the Activity\cr
}
\item{description}{ a short text description of the Activity\cr
}
\item{used}{        Either a list of:\cr
                    - \href{http://docs.synapse.org/rest/org/sagebionetworks/repo/model/Reference.html}{reference objects} (e.g. ``[{'targetId':'syn123456', 'targetVersionNumber':1}]``)\cr
                    - a list of Synapse Entities or Entity IDs\cr
                    - a list of URL's\cr
}
\item{executed}{    A code resource that was executed to generate the Entity.\cr
}
\item{data}{        A dictionary representation of an Activity,\cr
                    with fields 'name', 'description' and 'used'\cr
                    (a list of reference objects)}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
An object of type Activity
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



