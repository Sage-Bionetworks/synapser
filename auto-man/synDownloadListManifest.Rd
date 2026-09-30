%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synDownloadListManifest}
\alias{synDownloadListManifest}
\docType{methods}
\title{
synDownloadListManifest
}
\description{
Generate and download the manifest CSV for the current cart contents.

Submits an async job to Synapse to generate the manifest, then downloads
the resulting CSV. The manifest contains the same columns as the zip
manifest downloaded from the Synapse web UI.
}
\usage{
synDownloadListManifest(csv_table_descriptor=NULL, destination=".", synapse_client=NULL)
}
\arguments{
\item{csv_table_descriptor}{(Optional[CsvTableDescriptor]) Optional CsvTableDescriptor controlling the format of the generated CSV (separator, quote character, escape character, line ending, and whether the first line is a header). When omitted the Synapse defaults are used.}
\item{destination}{(str) Directory to download the manifest CSV to. Defaults to the current working directory.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by Synapse.allow_client_caching(False) this will use the last created instance from the Synapse class constructor.}
}
\value{
Path to the downloaded manifest CSV.
}
\section{Errors}{
SynapseError: If the async job completes without producing a manifest.
}
\examples{
\dontrun{
## Get the download list manifest
    # Inspect the cart contents before downloading.
    from synapseclient import Synapse
    from synapseclient.operations import download_list_manifest

    syn = Synapse()
    syn.login()

    manifest_path = download_list_manifest()
}
}

