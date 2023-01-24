\name{synGetWikiAttachments}
\alias{synGetWikiAttachments}
\docType{methods}
\title{
synGetWikiAttachments
}
\description{
Retrieve the attachments to a wiki page.
}
\usage{
synGetWikiAttachments(wiki)
}
\arguments{
\item{wiki}{ the Wiki object for which the attachments are to be returned.}
}
\value{
 A list of file handles for the files attached to the Wiki.
}
\examples{
\dontrun{
wiki <- synGetWiki(project)
attachments <- synGetWikiAttachments(wiki)
}
}


