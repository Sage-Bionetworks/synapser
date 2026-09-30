%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGenerateSyncManifest}
\alias{Folder_synGenerateSyncManifest}
\docType{methods}
\title{
Folder :  generate_sync_manifest
}
\description{
Walk a local directory, mirror its folder hierarchy under this
container in Synapse, and write a CSV manifest ready for
[sync_to_synapse_async][synapseclient.models.mixins.StorableContainer.sync_to_synapse_async].

The manifest has two columns: path (absolute, symlink-resolved) and
parentId (the Synapse ID of the file's containing folder). Existing
Synapse folders with matching names and parents are reused. Directory
symlinks inside directory_path are not followed; file symlinks record
the symlink path and upload the target's contents. Zero-byte files are
skipped with a warning — Synapse rejects empty files. I/O errors during
walk are logged and skipped; an empty source directory produces a
warning and a header-only manifest.
}
\usage{
synGenerateSyncManifest(instance, directory_path, manifest_path, synapse_client=NULL)
}
\arguments{
\item{instance}{(Folder) The Folder instance to operate on.}
\item{directory_path}{(str) Path to the local directory to be pushed to Synapse.}
\item{manifest_path}{(str) Path where the generated manifest CSV will be written.}
\item{synapse_client}{(UnionType[Synapse, NoneType]) If not passed in and caching was not disabled by Synapse.allow_client_caching(False) this will use the last created instance from the Synapse class constructor.}
}
\value{
NULL
}
\section{Errors}{
ValueError: If this container's id is None, or if directory_path
        does not exist or is not a directory, or if this container's
        id exists in Synapse but is not a Folder or Project.
    SynapseHTTPError: If this container's id does not exist in
        Synapse.
}
\examples{
\dontrun{
## Generate a manifest and upload the files
    # Mirror ./my_data under a Synapse project and then upload it.

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Project

    async def main():
        syn = Synapse()
        syn.login()

        project = Project(id="syn12345")
        await project.generate_sync_manifest_async(
            directory_path="./my_data",
            manifest_path="manifest.csv",
        )
        await project.sync_to_synapse_async(manifest_path="manifest.csv")

    asyncio.run(main())
}
}
\keyword{Folder}
