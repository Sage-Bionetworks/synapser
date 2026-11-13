\name{synSyncToSynapse}
\alias{Project_synSyncToSynapse}
\docType{methods}
\title{
Project :  sync_to_synapse
}
\description{
Upload files to Synapse using a manifest CSV file.

Accepts manifests produced by \code{\link[=Project_synSyncFromSynapse]{synSyncFromSynapse}()},
\code{\link[=synDownloadListFiles]{synDownloadListFiles}()}, or the Synapse UI download cart.
The manifest must have at minimum a path and parentId column.
All other columns that are not part of the standard manifest column set
are treated as file annotations.

Standard manifest columns:
ID, name, parentId, contentType, path, synapseStore, activityName,
activityDescription, forceVersion, used, executed
}
\usage{
synSyncToSynapse(instance, manifest_path, dry_run=FALSE, send_messages=TRUE, retries=4L, merge_existing_annotations=TRUE, associate_activity_to_new_version=FALSE, synapse_client=NULL)
}
\arguments{
\item{instance}{(Project) The Project instance to operate on.}
\item{manifest_path}{(character) Path to the CSV manifest file.}
\item{dry_run}{(logical) If TRUE, perform full validation of the manifest (including verifying that all parent containers exist in Synapse) but skip the actual file upload.}
\item{send_messages}{(logical) If TRUE, send a Synapse notification message on completion.}
\item{retries}{(integer) Number of notification retries (only relevant when send_messages=TRUE).}
\item{merge_existing_annotations}{(logical) If TRUE, merge manifest annotations with existing annotations on Synapse. If FALSE, overwrite them.}
\item{associate_activity_to_new_version}{(logical) If TRUE and a version update occurs, the existing Synapse activity is associated with the new version.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
List of File entities that were created or updated. Returns an
empty list if dry_run=TRUE or if no rows were eligible for
upload.
}
\examples{
\dontrun{
## Using this function
    library(synapser)
    synLogin()

    project = Project(id = "syn12345")
    uploaded = project |> synSyncToSynapse(manifest_path = "/path/to/manifest.csv")
}
}
\keyword{Project}
