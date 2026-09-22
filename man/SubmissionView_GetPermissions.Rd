\name{synGetPermissions}
\alias{SubmissionView_synGetPermissions}
\docType{methods}
\title{
SubmissionView :  get_permissions
}
\description{
Get the \href{https://python-docs.synapse.org/reference/permissions/}{permissions}
that the caller has on an Entity.
}
\usage{
synGetPermissions(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(SubmissionView) The SubmissionView instance to operate on.}
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

    permissions = File(id = "syn123") |> synGetPermissions()

    # Getting access types list from the Permissions object
    permissions$access_types
}
}
\keyword{SubmissionView}
