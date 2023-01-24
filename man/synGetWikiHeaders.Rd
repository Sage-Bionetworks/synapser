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
\value{
 A list of Objects with three fields: id, title and parentId.
}
\examples{
\dontrun{
synGetWikiHeaders(project)
}
}


