%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{WikiPage}
\alias{WikiPage}
\docType{class}
\title{
WikiPage
}
\format{An S3-style class object.}
\description{
Represents a \href{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/v2/wiki/V2WikiPage.html}{Wiki Page}.
}
\usage{
WikiPage(id=NULL, etag=NULL, title=NULL, parent_id=NULL, markdown=NULL, attachments=list(), owner_id=NULL, created_on=NULL, created_by=NULL, modified_on=NULL, modified_by=NULL, wiki_version=NULL, markdown_file_handle_id=NULL, attachment_file_handle_ids=list())
}
\arguments{
\item{id}{(Optional[str]) The unique identifier for this wiki page.}
\item{etag}{(Optional[str]) The etag of this object. Synapse employs an Optimistic Concurrency Control (OCC) scheme to handle concurrent updates. Since the E-Tag changes every time an entity is updated it is used to detect when a client's current representation of an entity is out-of-date.}
\item{title}{(Optional[str]) The title of this page.}
\item{parent_id}{(Optional[str]) When set, the WikiPage is a sub-page of the indicated parent WikiPage.}
\item{markdown}{(Optional[str]) The markdown content of the wiki page.}
\item{attachments}{(list[dict[str, Any]]) A list of file attachments associated with the wiki page.}
\item{owner_id}{(Optional[str]) The Synapse ID of the owning object (e.g., entity, evaluation, etc.).}
\item{created_on}{(Optional[str]) The timestamp when this page was created.}
\item{created_by}{(Optional[str]) The ID of the user that created this page.}
\item{modified_on}{(Optional[str]) The timestamp when this page was last modified.}
\item{modified_by}{(Optional[str]) The ID of the user that last modified this page.}
\item{wiki_version}{(Optional[str]) The version number of this wiki page.}
\item{markdown_file_handle_id}{(Optional[str]) The ID of the file handle containing the markdown content.}
\item{attachment_file_handle_ids}{(list[str]) The list of attachment file handle ids of this page.}
}
\value{
NULL
}
\section{Methods}{
\itemize{
\item \code{WikiPage(id=NULL, etag=NULL, title=NULL, parent_id=NULL, markdown=NULL, attachments=list(), owner_id=NULL, created_on=NULL, created_by=NULL, modified_on=NULL, modified_by=NULL, wiki_version=NULL, markdown_file_handle_id=NULL, attachment_file_handle_ids=list())}: Constructor for \code{\link{WikiPage}}
\item \code{get_attachment(file_name, download_file=TRUE, download_location=NULL, synapse_client=NULL)}: Wrapper for the function to be traced.
\item \code{get_attachment_handles(synapse_client=NULL)}: Wrapper for the function to be traced.
\item \code{get_attachment_preview(file_name, download_file=TRUE, download_location=NULL, synapse_client=NULL)}: Wrapper for the function to be traced.
\item \code{get_markdown_file(download_file=TRUE, download_location=NULL, synapse_client=NULL)}: Wrapper for the function to be traced.
\item \code{reformat_attachment_file_name(attachment_file_name)}: Reformat the attachment file name to be a valid attachment path.
\item \code{restore(synapse_client=NULL)}: Wrapper for the function to be traced.
\item \code{unzip_gzipped_file(file_path)}: Unzip the gzipped file and return the file path to the unzipped file.\cr
If the file is a markdown file, the content will be printed.
}
}

