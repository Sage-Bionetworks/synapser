%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetAttachment}
\alias{WikiPage_synGetAttachment}
\docType{methods}
\title{
WikiPage :  get_attachment
}
\description{
Download the wiki page attachment to a local file or return the URL.
}
\usage{
synGetAttachment(instance, file_name, download_file=TRUE, download_location=NULL, synapse_client=NULL)
}
\arguments{
\item{instance}{(WikiPage) The WikiPage instance to operate on.}
\item{file_name}{(str) The name of the file to get. The file name can be in either non-gzipped or gzipped format.}
\item{download_file}{(bool) Whether associated files should be downloaded. Default is True.}
\item{download_location}{(Optional[str]) The directory to download the file to. Required if download_file is True.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) Optionally provide a Synapse client.}
}
\value{
If download_file is True, the attachment file will be downloaded to the download_location. Otherwise, the URL will be returned.
}
\section{Errors}{
ValueError: If owner_id or id is not provided.
}
\examples{
\dontrun{
## Example 1: Get the attachment URL for a wiki page
    # This example shows how to get the attachment file or URL for a wiki page.
    attachment_file_or_url = await WikiPage(owner_id=project.id, id=wiki_page.id).get_attachment_async(file_name="attachment.txt", download_file=False)
    print(f"Attachment URL: {attachment_file_or_url}")

## Example 2: Download the attachment file for a wiki page
    # This example shows how to download the attachment file for a wiki page.
    attachment_file_path = await WikiPage(owner_id=project.id, id=wiki_page.id).get_attachment_async(file_name="attachment.txt", download_file=True, download_location="~/temp")
    print(f"Attachment file path: {attachment_file_path}")
}
}
\keyword{WikiPage}
