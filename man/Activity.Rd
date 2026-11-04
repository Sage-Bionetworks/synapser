\name{Activity}
\alias{Activity}
\docType{class}
\title{
Activity
}
\format{An S3-style class object.}
\description{
An activity is a Synapse object that helps to keep track of what objects were used
in an analysis step, as well as what objects were generated. Thus, all relationships
between Synapse objects and an activity are governed by dependencies. That is, an
activity needs to know what it \code{used}, and outputs need to know what activity
they were \code{generatedBy}.
}
\usage{
Activity(id=NULL, name=NULL, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, used=list(), executed=list())
}
\arguments{
\item{id}{(Optional[str]) The unique immutable ID for this activity.}
\item{name}{(Optional[str]) A name for this Activity.}
\item{description}{(Optional[str]) A description for this Activity.}
\item{etag}{(Optional[str]) Synapse employs an Optimistic Concurrency Control (OCC) scheme to handle concurrent updates. Since the E-Tag changes every time an entity is updated it is used to detect when a client's current representation of an entity is out-of-date.}
\item{created_on}{(Optional[str]) The date this object was created.}
\item{modified_on}{(Optional[str]) The date this object was last modified.}
\item{created_by}{(Optional[str]) The user that created this object.}
\item{modified_by}{(Optional[str]) The user that last modified this object.}
\item{used}{(list[Union[UsedEntity, UsedURL]]) The entities or URLs used by this Activity. Only \code{\link{UsedEntity}} and \code{\link{UsedURL}} objects are accepted. Other values, such as a plain Synapse ID string (for example \code{"syn123"}), are dropped with no error.}
\item{executed}{(list[Union[UsedEntity, UsedURL]]) The entities or URLs executed by this Activity. Only \code{\link{UsedEntity}} and \code{\link{UsedURL}} objects are accepted. Other values, such as a plain Synapse ID string (for example \code{"syn123"}), are dropped with no error.}
}
\value{
NULL
}
\examples{
\dontrun{
## Example 1: Store an Activity on a File
    # Record the provenance of a file: what it used, and what was executed to
    # create it. Storing the Activity with a parent associates it with that entity.
    library(synapser)
    synLogin()

    file = synGet("syn123", file_options = FileOptions(download_file = FALSE))

    activity = Activity(
        name = "Normalization",
        description = "Normalized the raw counts",
        used = list(
            UsedEntity(target_id = "syn456", target_version_number = 1L),
            UsedURL(name = "Reference genome", url = "https://www.ncbi.nlm.nih.gov/grc/human")
        ),
        executed = list(
            UsedURL(name = "Analysis code", url = "https://github.com/my-org/my-analysis")
        )
    )
    activity = activity |> synStore(parent = file)
    print(activity$id)

## Example 2: Delete an Activity
    # Disassociate the Activity from its parent entity. The Activity itself is
    # deleted once it has been disassociated from every entity it is attached to;
    # until then you'll receive an error for each remaining entity.
    library(synapser)
    synLogin()

    Activity() |> synDelete(parent = "syn123") # parent is the entity that the Activity is associated with
}
}
\section{Methods}{
\itemize{
\item \code{Activity(id=NULL, name=NULL, description=NULL, etag=NULL, created_on=NULL, modified_on=NULL, created_by=NULL, modified_by=NULL, used=list(), executed=list())}: Constructor for \code{\link{Activity}}
\item \code{\link[=Activity_synDisassociateActivityFromEntity]{synDisassociateActivityFromEntity}(cls, parent, synapse_client=NULL)}: Disassociate the Activity from the parent entity. This is the first step in
deleting the Activity. If you have other entities that are associated with this
Activity you must disassociate them by calling this method on them as well.
\item \code{\link[=Activity_synGetFromParent]{synGetFromParent}(cls, parent, parent_version_number=NULL, synapse_client=NULL)}: Get the Activity from Synapse based on the parent entity.
}
}

