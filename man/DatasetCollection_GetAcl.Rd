\name{synGetAcl}
\alias{DatasetCollection_synGetAcl}
\docType{methods}
\title{
DatasetCollection :  get_acl
}
\description{
Get the \href{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/ACCESS_TYPE.html}{ACL}
that a user or group has on an Entity.
}
\usage{
synGetAcl(instance, principal_id=NULL, check_benefactor=TRUE, synapse_client=NULL)
}
\arguments{
\item{instance}{(DatasetCollection) The DatasetCollection instance to operate on.}
\item{principal_id}{(integer) Identifier of a user or group (defaults to PUBLIC users)}
\item{check_benefactor}{(logical) If TRUE (default), check the benefactor for the entity to get the ACL. If FALSE, only check the entity itself. This is useful for checking the ACL of an entity that has local sharing settings, but you want to check the ACL of the entity itself and not the benefactor it may inherit from.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
A list containing some combination of READ, UPDATE, CREATE, DELETE, DOWNLOAD, MODERATE, CHANGE_PERMISSIONS, CHANGE_SETTINGS, or an empty list.
}
\note{
If the entity does not have local sharing settings, or ACL set directly
on it, this will look up the ACL on the benefactor of the entity. The
benefactor is the entity that the current entity inherits its permissions from.
The benefactor is usually the parent entity, but it can be any ancestor in the
hierarchy. For example, a newly created Project will be its own benefactor,
while a new FileEntity's benefactor will start off as its containing Project or
Folder. If the entity already has local sharing settings, the benefactor would
be itself.

The \code{principal_id} and \code{check_benefactor} arguments apply to entities only.
For an \code{\link{Evaluation}}, \code{synGetAcl()} takes neither and returns the full
ACL for all principals instead.
}
\examples{
\dontrun{
## Using this function
    # Get the permissions the PUBLIC group has on a DatasetCollection
    library(synapser)
    synLogin()

    acl = DatasetCollection(id = "syn123") |> synGetAcl()
    print(acl)

    # Get the permissions a specific user or team has on the DatasetCollection
    acl = DatasetCollection(id = "syn123") |> synGetAcl(principal_id = 273948L)
    print(acl)

    # Only look at the ACL set directly on the DatasetCollection, not the one it inherits
    acl = DatasetCollection(id = "syn123") |> synGetAcl(principal_id = 273948L, check_benefactor = FALSE)
    print(acl)
}
}
\keyword{DatasetCollection}
