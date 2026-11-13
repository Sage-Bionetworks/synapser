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
\item{destination}{(character) Directory to download the manifest CSV to. Defaults to the current working directory.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
Path to the downloaded manifest CSV.
}
\section{Errors}{
Raises an error if the async job completes without producing a manifest.
}
\examples{
\dontrun{
## Get the download list manifest
    # Inspect the cart contents before downloading.
    library(synapser)
    synLogin()

    manifest_path = synDownloadListManifest()
}
}
