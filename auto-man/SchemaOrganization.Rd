%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{SchemaOrganization}
\alias{SchemaOrganization}
\docType{class}
\title{
SchemaOrganization
}
\format{An S3-style class object.}
\description{
Represents an \href{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/schema/Organization.html}{Organization}.
}
\usage{
SchemaOrganization(name=NULL, id=NULL, created_on=NULL, created_by=NULL)
}
\arguments{
\item{name}{(Optional[str]) The name of the organization}
\item{id}{(Optional[str]) The ID of the organization}
\item{created_on}{(Optional[str]) The date this organization was created}
\item{created_by}{(Optional[str]) The ID of the user that created this organization}
}
\value{
NULL
}
\section{Methods}{
\itemize{
\item \code{SchemaOrganization(name=NULL, id=NULL, created_on=NULL, created_by=NULL)}: Constructor for \code{\link{SchemaOrganization}}
\item \code{get_acl(synapse_client=NULL)}: Gets the ACL for this organization
\item \code{get_json_schemas(synapse_client=NULL)}: Gets the JSON Schemas that are part of this organization
\item \code{update_acl(principal_id, access_type, synapse_client=NULL)}: Updates the ACL for a principal for this organization
}
}

