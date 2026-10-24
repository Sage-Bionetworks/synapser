\name{synUpdateAcl}
\alias{Organization_synUpdateAcl}
\docType{methods}
\title{
Organization :  update_acl
}
\description{
Updates the ACL for a principal for this organization
}
\usage{
synUpdateAcl(instance, principal_id, access_type, synapse_client=NULL)
}
\arguments{
\item{instance}{(Organization) The Organization instance to operate on.}
\item{principal_id}{(integer) the id of the principal whose permissions are to be updated}
\item{access_type}{(list[character]) List of permission types (e.g., list("READ", "CREATE", "DELETE")) see: \href{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/ACCESS_TYPE.html}{ACCESS_TYPE}}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
NULL
}
\examples{
\dontrun{
## Update the ACL for a Organization
    library(synapser)
    synLogin()

    org = Organization(name = "dpetest")
    org |> synUpdateAcl(
        principal_id = 1L,
        access_type = list("READ")
    )
}
}
\keyword{Organization}
