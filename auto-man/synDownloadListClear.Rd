%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
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
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by Synapse.allow_client_caching(False) this will use the last created instance from the Synapse class constructor.}
}
\value{
NULL
}
\examples{
\dontrun{
## Clear the download list
    # Remove all files from the cart.
    from synapseclient import Synapse
    from synapseclient.operations import download_list_clear

    syn = Synapse()
    syn.login()

    download_list_clear()
}
}

