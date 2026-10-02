\name{synDownloadListAdd}
\alias{synDownloadListAdd}
\docType{methods}
\title{
synDownloadListAdd
}
\description{
Add files to the Synapse download list.

If a file is added with no version specified, the latest version will be downloaded.
}
\usage{
synDownloadListAdd(files, synapse_client=NULL)
}
\arguments{
\item{files}{(list[DownloadListItem]) List of \code{\link{DownloadListItem}} objects identifying the file versions to add.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
The number of files added.
}
\examples{
\dontrun{
## Add files to the download list
    # Add specific file versions to the cart.
    library(synapser)
    synLogin()

    count = synDownloadListAdd(list(
        DownloadListItem(file_entity_id = "syn123", version_number = 1L),
        DownloadListItem(file_entity_id = "syn456", version_number = 2L)
    ))
}
}
