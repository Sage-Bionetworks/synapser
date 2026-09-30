%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
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
\item{download_location}{(Optional[str]) Directory to download files to. Defaults to the current working directory.}
\item{parallel}{(bool) If True, files are downloaded concurrently up to max_concurrent at a time using asyncio.gather. If False (default), files are downloaded sequentially.}
\item{max_concurrent}{(int) Maximum number of files to download concurrently when parallel=True. Defaults to 10. Has no effect when parallel=False.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by Synapse.allow_client_caching(False) this will use the last created instance from the Synapse class constructor.}
}
\value{
Path to the result manifest CSV, which contains all original manifest
    columns plus path (local file path) and error (error message or
    empty string) columns.
}
\section{Errors}{
SynapseHTTPError: If the manifest async job fails or the cart is empty
        ("No files available for download").
    SynapseError: If the manifest job completes but produces no local file,
        or if the downloaded CSV has no headers or contains reserved column
        names ("path" or "error").
}
\examples{
\dontrun{
## Download all files in the cart
    # Download all files in the user's download list to a local directory.
    from synapseclient import Synapse
    from synapseclient.operations import download_list_files

    syn = Synapse()
    syn.login()

    manifest_path = download_list_files(download_location="./data")
}
}

