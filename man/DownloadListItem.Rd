\name{DownloadListItem}
\alias{DownloadListItem}
\docType{class}
\title{
DownloadListItem
}
\format{An S3-style class object.}
\description{
A single item for a user's download list.

\url{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/download/DownloadListItem.html}
}
\usage{
DownloadListItem(file_entity_id, version_number=NULL)
}
\arguments{
\item{file_entity_id}{(character) Synapse ID of the file entity (e.g. "syn123").}
\item{version_number}{(Optional[integer]) Version of the file to target.}
}
\value{
NULL
}
\section{Methods}{
\itemize{
\item \code{DownloadListItem(file_entity_id, version_number=NULL)}: Constructor for \code{\link{DownloadListItem}}
}
}
