%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synSyncToSynapse}
\alias{Project_synSyncToSynapse}
\docType{methods}
\title{
Project :  sync_to_synapse
}
\description{
Upload files to Synapse using a manifest CSV file.

Accepts manifests produced by sync_from_synapse, the
synapse get-download-list CLI, or the Synapse UI download cart.
The manifest must have at minimum a path and parentId column.
All other columns that are not part of the standard manifest column set
are treated as file annotations.

Standard manifest columns:
[ID, name, parentId, contentType, path, synapseStore, activityName,
activityDescription, forceVersion, used, executed]
}
\usage{
synSyncToSynapse(instance, manifest_path, dry_run=FALSE, send_messages=TRUE, retries=4L, merge_existing_annotations=TRUE, associate_activity_to_new_version=FALSE, synapse_client=NULL)
}
\arguments{
\item{instance}{(Project) The Project instance to operate on.}
\item{manifest_path}{(str) Path to the CSV manifest file.}
\item{dry_run}{(bool) If True, perform full validation of the manifest (including verifying that all parent containers exist in Synapse) but skip the actual file upload.}
\item{send_messages}{(bool) If True, send a Synapse notification message on completion.}
\item{retries}{(int) Number of notification retries (only relevant when send_messages=True).}
\item{merge_existing_annotations}{(bool) If True, merge manifest annotations with existing annotations on Synapse. If False, overwrite them.}
\item{associate_activity_to_new_version}{(bool) If True and a version update occurs, the existing Synapse activity is associated with the new version.}
\item{synapse_client}{(UnionType[Synapse, NoneType]) If not passed in and caching was not disabled by Synapse.allow_client_caching(False) this will use the last created instance from the Synapse class constructor.}
}
\value{
List of File entities that were created or updated. Returns an
    empty list if dry_run=True or if no rows were eligible for
    upload.
}
\examples{
\dontrun{
## Using this function

    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Project

    async def main():
        syn = Synapse()
        syn.login()

        project = Project(id="syn12345")
        await project.sync_to_synapse_async(
            manifest_path="/path/to/manifest.csv"
        )

    asyncio.run(main())
}
}
\keyword{Project}
