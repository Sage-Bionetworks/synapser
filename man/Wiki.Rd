\name{Wiki}
\alias{Wiki}
\docType{methods}
\title{
Constructor for objects of type Wiki
}
\description{
Represents a wiki page in Synapse with content specified in markdown.
}
\usage{
Wiki(title=NULL, owner=NULL, markdown=NULL, markdownFile=NULL, attachments=NULL, fileHandles=NULL, parentWikiId=NULL)
}
\arguments{
\item{title}{optional named parameter:        Title of the Wiki\cr
}
\item{owner}{optional named parameter:        Parent Entity that the Wiki will belong to\cr
}
\item{markdown}{optional named parameter:     Content of the Wiki (cannot be defined if markdownFile is defined)\cr
}
\item{markdownFile}{optional named parameter:  Path to file which contains the Content of Wiki (cannot be defined if markdown is defined)\cr
}
\item{attachments}{optional named parameter:  List of paths to files to attach\cr
}
\item{fileHandles}{optional named parameter:  List of file handle IDs representing files to be attached\cr
}
\item{parentWikiId}{optional named parameter:  (optional) For subpages, specify parent wiki page}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
An object of type Wiki
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
# Create a Wiki
content <- "
# My Wiki Page

Here is a description of my **fantastic** project!
"
# attachment
filePath <- tempfile()
connection <- file(filePath)
writeChar("this is the content of the file", connection, eos = NULL)
close(connection)

wiki <- Wiki(owner = project,
             title = "My Wiki Page",
             markdown = content,
             attachments = list(filePath))
wiki <- synStore(wiki)

# Update a Wiki
wiki <- synGetWiki(project)
wiki.markdown <- "
# My Wiki Page

Here is a description of my **fantastic** project! Let's
*emphasize* the important stuff.
"

wiki <- synStore(wiki)
}



