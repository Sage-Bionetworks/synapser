\name{synDownloadListClear}
\alias{synDownloadListClear}
\docType{methods}
\title{
synDownloadListClear
}
\description{
Clear all files from the Synapse download list (cart).
}
\usage{
synDownloadListClear(synapse_client=NULL)
}
\arguments{
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
NULL
}
\examples{
\dontrun{
## Clear the download list
    # Remove all files from the cart.
    library(synapser)
    synLogin()

    synDownloadListClear()
}
}
