\name{synDownloadListRemove}
\alias{synDownloadListRemove}
\docType{methods}
\title{
synDownloadListRemove
}
\description{
Remove files from the Synapse download list.

If a file was added with a version specified, then that version must be specified to remove it.
If a file was added with no version specified, then no version must be specified to remove it.
}
\usage{
synDownloadListRemove(files, synapse_client=NULL)
}
\arguments{
\item{files}{(list[DownloadListItem]) List of \code{\link{DownloadListItem}} objects identifying the file versions to remove.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
The number of files removed.
}
\examples{
\dontrun{
## Remove files from the download list
    # Remove specific file versions from the cart.
    library(synapser)
    synLogin()

    count = synDownloadListRemove(list(
        DownloadListItem(file_entity_id = "syn123", version_number = 1L)
    ))
}
}
