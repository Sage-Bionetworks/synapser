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
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
 A list of file handles for the files attached to the Wiki.
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
wiki <- synGetWiki(project)
attachments <- synGetWikiAttachments(wiki)
}



