\name{Organization}
\alias{Organization}
\docType{class}
\title{
Organization
}
\format{An S3-style class object.}
\description{
Represents an \href{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/schema/Organization.html}{Organization}.
}
\usage{
Organization(name=NULL, id=NULL, created_on=NULL, created_by=NULL)
}
\arguments{
\item{name}{(Optional[character]) The name of the organization}
\item{id}{(Optional[character]) The ID of the organization}
\item{created_on}{(Optional[character]) The date this organization was created}
\item{created_by}{(Optional[character]) The ID of the user that created this organization}
}
\value{
NULL
}
\section{Methods}{
\itemize{
\item \code{Organization(name=NULL, id=NULL, created_on=NULL, created_by=NULL)}: Constructor for \code{\link{Organization}}
\item \code{\link[=Organization_synGetAcl]{synGetAcl}(instance, synapse_client=NULL)}: Gets the ACL for this organization
\item \code{\link[=Organization_synGetJsonSchemas]{synGetJsonSchemas}(instance, synapse_client=NULL)}: Gets the JSON Schemas that are part of this organization
\item \code{\link[=Organization_synUpdateAcl]{synUpdateAcl}(instance, principal_id, access_type, synapse_client=NULL)}: Updates the ACL for a principal for this organization
}
}
