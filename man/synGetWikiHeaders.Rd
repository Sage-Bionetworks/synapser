\name{synGetWikiHeaders}
\alias{synGetWikiHeaders}
\title{
synGetWikiHeaders
}
\description{
Function to retrieve the headers of all the Wiki pages belonging to an owner.
}
\usage{
synGetWikiHeaders(owner)
}
\details{
Retrieves a list of WikiHeader objects given an owner (Entity or Evaluation).
WikiHeader includes the Wiki's ID and that of its parent Wiki.  This information is
necessary to know the tree structure of the Wiki pages belonging to a given owner.
}
\examples{
\dontrun{
entity<-synGet("syn123456")
wikiHeaders<-synGetWikiHeaders(entity)
}
}
\seealso{
\code{\link{synGetWiki}}
\code{\link{WikiHeader}}
}
