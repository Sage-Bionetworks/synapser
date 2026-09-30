\name{synGetMarkdownFile}
\alias{WikiPage_synGetMarkdownFile}
\docType{methods}
\title{
WikiPage :  get_markdown_file
}
\description{
Get the markdown URL of this wiki page.
}
\usage{
synGetMarkdownFile(instance, download_file=TRUE, download_location=NULL, synapse_client=NULL)
}
\arguments{
\item{instance}{(WikiPage) The WikiPage instance to operate on.}
\item{download_file}{(bool) Whether associated files should be downloaded. Default is TRUE.}
\item{download_location}{(Optional[str]) The directory to download the file to. Required if download_file is TRUE.}
\item{synapse_client}{(Optional[Synapse]) Optionally provide a Synapse client.}
}
\value{
If download_file is TRUE, the markdown file will be downloaded to the download_location. Otherwise, the URL will be returned.
}
\section{Errors}{
An error is raised if owner_id or id is not provided.
}
\examples{
\dontrun{
## Example 1: Get the markdown URL for a wiki page
    # This example shows how to get the markdown URL for a wiki page.
    markdown_url = WikiPage(owner_id = project$id, id = wiki_page$id) |> synGetMarkdownFile(download_file = FALSE)
    cat("Markdown URL:", markdown_url, "\n")

## Example 2: Download the markdown file for a wiki page
    # This example shows how to download the markdown file for a wiki page.
    markdown_file_path = WikiPage(owner_id = project$id, id = wiki_page$id) |> synGetMarkdownFile(download_file = TRUE, download_location = "~/temp")
    cat("Markdown file path:", markdown_file_path, "\n")
}
}
\keyword{WikiPage}
