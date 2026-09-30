\name{synGetPermissions}
\alias{VirtualTable_synGetPermissions}
\docType{methods}
\title{
VirtualTable :  get_permissions
}
\description{
Get the \href{https://python-docs.synapse.org/reference/permissions/}{permissions}
that the caller has on an Entity.
}
\usage{
synGetPermissions(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(VirtualTable) The VirtualTable instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
A Permissions object
}
\examples{
\dontrun{
## Using this function:
    # Getting permissions for a Synapse Entity
    library(synapser)
    synLogin()

    permissions = VirtualTable(id = "syn123") |> synGetPermissions()

    # Getting access types list from the Permissions object
    permissions$access_types
}
}
\keyword{VirtualTable}
