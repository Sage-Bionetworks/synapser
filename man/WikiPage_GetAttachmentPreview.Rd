\name{synGetAttachmentPreview}
\alias{WikiPage_synGetAttachmentPreview}
\docType{methods}
\title{
WikiPage :  get_attachment_preview
}
\description{
Download the wiki page attachment preview to a local file or return the URL.
}
\usage{
synGetAttachmentPreview(instance, file_name, download_file=TRUE, download_location=NULL, synapse_client=NULL)
}
\arguments{
\item{instance}{(WikiPage) The WikiPage instance to operate on.}
\item{file_name}{(str) The name of the file to get. The file name can be in either non-gzipped or gzipped format.}
\item{download_file}{(bool) Whether associated files should be downloaded. Default is TRUE.}
\item{download_location}{(Optional[str]) The directory to download the file to. Required if download_file is TRUE.}
\item{synapse_client}{(Optional[Synapse]) Optionally provide a Synapse client.}
}
\value{
If download_file is TRUE, the attachment preview file will be downloaded to the download_location. Otherwise, the URL will be returned.
}
\section{Errors}{
An error is raised if owner_id or id is not provided.
}
\examples{
\dontrun{
## Example 1: Get the attachment preview URL for a wiki page
    # This example shows how to get the attachment preview URL for a wiki page.
    # Instead of using the file_name from the attachmenthandle response when isPreview=TRUE, you should use the original file name in the get_attachment_preview request.
    # The downloaded file will still be named according to the file_name provided in the response when isPreview=TRUE.
    attachment_preview_url = WikiPage(owner_id = project$id, id = wiki_page$id) |> synGetAttachmentPreview(file_name = "attachment.txt.gz", download_file = FALSE)
    cat("Attachment preview URL:", attachment_preview_url, "\n")

## Example 2: Download the attachment preview file for a wiki page
    # This example shows how to download the attachment preview file for a wiki page.
    attachment_preview_file_path = WikiPage(owner_id = project$id, id = wiki_page$id) |> synGetAttachmentPreview(file_name = "attachment.txt.gz", download_file = TRUE, download_location = "~/temp")
    cat("Attachment preview file path:", attachment_preview_file_path, "\n")
}
}
\keyword{WikiPage}
