\name{synGetWikiHeaders}
\alias{synGetWikiHeaders}
\docType{methods}
\title{
synGetWikiHeaders
}
\description{
Retrieves the headers of all Wikis belonging to the owner (the entity to which the Wiki is attached).
}
\usage{
synGetWikiHeaders(owner)
}
\arguments{
\item{owner}{ An Entity}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
 A list of Objects with three fields: id, title and parentId.
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
synGetWikiHeaders(project)
}



