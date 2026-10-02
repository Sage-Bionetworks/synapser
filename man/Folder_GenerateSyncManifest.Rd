\name{synGenerateSyncManifest}
\alias{Folder_synGenerateSyncManifest}
\docType{methods}
\title{
Folder :  generate_sync_manifest
}
\description{
Walk a local directory, mirror its folder hierarchy under this
container in Synapse, and write a CSV manifest ready for
\code{\link[=Folder_synSyncToSynapse]{synSyncToSynapse}()}.

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
\item{directory_path}{(character) Path to the local directory to be pushed to Synapse.}
\item{manifest_path}{(character) Path where the generated manifest CSV will be written.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
NULL
}
\section{Errors}{
- An error is raised if this container's id is NULL, or if directory_path
    does not exist or is not a directory, or if this container's
    id exists in Synapse but is not a Folder or Project.\cr
- An error is also raised if this container's id does not exist in
    Synapse.
}
\examples{
\dontrun{
## Generate a manifest and upload the files
    # Mirror ./my_data under a Synapse folder and then upload it.
    library(synapser)
    synLogin()

    folder = Folder(id = "syn12345")
    folder |> synGenerateSyncManifest(
        directory_path = "./my_data",
        manifest_path = "manifest.csv"
    )
    folder |> synSyncToSynapse(manifest_path = "manifest.csv")
}
}
\keyword{Folder}
