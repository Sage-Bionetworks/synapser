\name{synDownloadListFiles}
\alias{synDownloadListFiles}
\docType{methods}
\title{
synDownloadListFiles
}
\description{
Download all files in the Synapse download list (cart) to a local directory.

Files are downloaded individually. The cart is not packaged into a zip because
download lists can exceed 100 GB. Only successfully downloaded files are removed
from the cart after the full pass completes, so interrupted runs are safely
resumable.

Files that cannot be accessed or fail to download are left in the cart and
recorded with an error value in the result manifest.
}
\usage{
synDownloadListFiles(download_location=NULL, parallel=FALSE, max_concurrent=10L, synapse_client=NULL)
}
\arguments{
\item{download_location}{(Optional[character]) Directory to download files to. Defaults to the current working directory.}
\item{parallel}{(logical) If TRUE, files are downloaded concurrently, up to max_concurrent at a time. If FALSE (default), files are downloaded sequentially.}
\item{max_concurrent}{(integer) Maximum number of files to download concurrently when parallel=TRUE. Defaults to 10. Has no effect when parallel=FALSE.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
Path to the result manifest CSV, which contains all original manifest
columns plus path (local file path) and error (error message or
empty string) columns.
}
\section{Errors}{
- An error is raised if the manifest async job fails or the cart is empty
    ("No files available for download").\cr
- An error is also raised if the manifest job completes but produces no local file,
    or if the downloaded CSV has no headers or contains reserved column
    names ("path" or "error").
}
\examples{
\dontrun{
## Download all files in the cart
    # Download all files in the user's download list to a local directory.
    library(synapser)
    synLogin()

    manifest_path = synDownloadListFiles(download_location = "./data")
}
}
