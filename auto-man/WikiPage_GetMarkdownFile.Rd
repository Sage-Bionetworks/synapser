%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetMarkdownFile}
\alias{synGetMarkdownFile}
\docType{methods}
\title{
WikiPage :  get_markdown_file
}
\description{
Get the markdown URL of this wiki page. --> modify this to print the markdown file
}
\usage{
synGetMarkdownFile(instance, download_file=TRUE, download_location=NULL, synapse_client=NULL)
}
\arguments{
\item{instance}{(WikiPage) The WikiPage instance to operate on.}
\item{download_file}{(bool) Whether associated files should be downloaded. Default is True.}
\item{download_location}{(Optional[str]) The directory to download the file to. Required if download_file is True.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) Optionally provide a Synapse client.}
}
\value{
If download_file is True, the markdown file will be downloaded to the download_location. Otherwise, the URL will be returned.
}
\section{Errors}{
ValueError: If owner_id or id is not provided.
}
\examples{
\dontrun{
## Example 1: Get the markdown URL for a wiki page
    # This example shows how to get the markdown URL for a wiki page.
    markdown_url = await WikiPage(owner_id=project.id, id=wiki_page.id).get_markdown_file_async(download_file=False)
    print(f"Markdown URL: {markdown_url}")

## Example 2: Download the markdown file for a wiki page
    # This example shows how to download the markdown file for a wiki page.
    markdown_file_path = await WikiPage(owner_id=project.id, id=wiki_page.id).get_markdown_file_async(download_file=True, download_location="~/temp")
    print(f"Markdown file path: {markdown_file_path}")
}
}
\keyword{WikiPage}
