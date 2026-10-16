\name{synGetAcl}
\alias{Organization_synGetAcl}
\docType{methods}
\title{
Organization :  get_acl
}
\description{
Gets the ACL for this organization
}
\usage{
synGetAcl(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Organization) The Organization instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
A named list in the form of this response:
\href{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/AccessControlList.html}{AccessControlList}
}
\examples{
\dontrun{
## Get the ACL for a Organization
    library(synapser)
    synLogin()

    org = Organization(name = "dpetest")
    acl = org |> synGetAcl()

    etag = acl[["etag"]]
    print(etag)
    resource_access = acl[["resourceAccess"]]
    for (item in resource_access) {
        principal_id = item[["principalId"]]
        print(principal_id)
        access_types = item[["accessType"]]
        print(access_types)
    }
}
}
\keyword{Organization}
