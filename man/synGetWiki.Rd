\name{synGetWiki}
\alias{synGetWiki}
\title{
synGetWiki
}
\description{
Function to retrieve a Wiki Page.
}
\usage{
synGetWiki(owner)
synGetWiki(owner, id)
}
\details{
Retrieves a WikiPage given its owner (Entity or Evaluation) and, optionally, its ID.  If no ID is specified then 
the root ID is returned.   To get the IDs of all the WikiPages for an owner, see synGetWikiHeaders.
}
\examples{
\dontrun{
entity<-synGet("syn123456")
wikiPage<-synGetWiki(entity)
}
}
\seealso{
\code{\link{synGetWikiHeaders}}
\code{\link{synStore}}
}
