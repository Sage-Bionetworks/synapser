%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
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
\item{files}{(list[DownloadListItem]) List of DownloadListItem objects identifying the file versions to add.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by Synapse.allow_client_caching(False) this will use the last created instance from the Synapse class constructor.}
}
\value{
The number of files added.
}
\examples{
\dontrun{
## Add files to the download list
    # Add specific file versions to the cart.
    from synapseclient import Synapse
    from synapseclient.operations import download_list_add, DownloadListItem

    syn = Synapse()
    syn.login()

    count = download_list_add([
        DownloadListItem(file_entity_id="syn123", version_number=1),
        DownloadListItem(file_entity_id="syn456", version_number=2),
    ])
}
}

