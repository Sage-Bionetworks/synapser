\name{WikiPage}
\alias{WikiPage}
\docType{methods}
\title{
Constructor for WikiPage
}
\description{
Constructor for WikiPage
}
\usage{
WikiPage(owner, title="Wiki Page for Entity", markdown="markdown goes here", attachments=list(file1, file2, ...) )
WikiPage(owner, title="Sub-Wiki Page for Entity", markdown="sub-page markdown goes here", parentWikiId="123456")
}
\details{
This creates a wiki page (in memory), or sub-page beneath an existing page for the given entity.
}

\section{Slots}{
  \describe{
    \item{\code{createUri}}{uri to create this WikiPage}
    \item{\code{updateUri}}{uri to update this WikiPage}
    \item{\code{attachments}}{attachments to be uploaded with the WikiPage}
    \item{\code{properties}}{
    Synapse properties for a WikiPage. Properties of interest include:
      \describe{
        \item{\code{id}}{unique Synapse ID as set by the system upon synStore (not set by user)}
        \item{\code{parentWikiId}}{the id of another WikiPage, if this WikiPage is a subpage of another WikiPage}
        \item{\code{title}}{user supplied title for the WikiPage}
        \item{\code{markdown}}{character string containing the markdown to be rendered on the WikiPage}
      }
    }
  }
}


\examples{
\dontrun{
entity<-synGet("syn123456")
page<-WikiPage(owner=entity, title="Wiki Page for Entity", markdown="markdown goes here")
page<-synStore(page)
}
}
\seealso{
\code{\link{synGetWiki}}
\code{\link{synStore}}
}
