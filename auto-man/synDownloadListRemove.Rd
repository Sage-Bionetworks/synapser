%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
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
\item{files}{(list[DownloadListItem]) List of DownloadListItem objects identifying the file versions to remove.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by Synapse.allow_client_caching(False) this will use the last created instance from the Synapse class constructor.}
}
\value{
The number of files removed.
}
\examples{
\dontrun{
## Remove files from the download list
    # Remove specific file versions from the cart.
    from synapseclient import Synapse
    from synapseclient.operations import download_list_remove, DownloadListItem

    syn = Synapse()
    syn.login()

    count = download_list_remove([
        DownloadListItem(file_entity_id="syn123", version_number=1),
    ])
}
}

