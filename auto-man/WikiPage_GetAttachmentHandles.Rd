%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetAttachmentHandles}
\alias{WikiPage_synGetAttachmentHandles}
\docType{methods}
\title{
WikiPage :  get_attachment_handles
}
\description{
Get the file handles of all attachments on this wiki page.
}
\usage{
synGetAttachmentHandles(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(WikiPage) The WikiPage instance to operate on.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) Optionally provide a Synapse client.}
}
\value{
The list of FileHandles for all file attachments of this WikiPage.
}
\section{Errors}{
ValueError: If owner_id or id is not provided.
}
\examples{
\dontrun{
## Get the file handles of all attachments on a wiki page
    # This example shows how to get the file handles of all attachments on a wiki page.
    attachment_handles = await WikiPage(owner_id=project.id, id=wiki_page.id).get_attachment_handles_async()
    print(f"Attachment handles: {attachment_handles['list']}")
}
}
\keyword{WikiPage}
