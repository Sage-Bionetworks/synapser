%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetAcl}
\alias{synGetAcl}
\docType{methods}
\title{
synGetAcl
}
\description{
**Deprecated with replacement.** This method will be removed in 5.0.0.
Use the `get_acl` method on the dataclass models that inherit from `AccessControllable` mixin instead.

Get the [ACL](https://rest-docs.synapse.org/rest/org/
sagebionetworks/repo/model/ACCESS_TYPE.html)
that a user or group has on an Entity.

}
\usage{
synGetAcl(entity, principal_id=NULL, check_benefactor=TRUE)
}
\arguments{
\item{entity}{An Entity or Synapse ID to lookup}
\item{principal_id}{optional named parameter: Identifier of a user or group (defaults to PUBLIC users)}
\item{check_benefactor}{optional named parameter: If TRUE (default), check the benefactor for the entity to get the ACL. If FALSE, only check the entity itself.}
}
\value{
An array containing some combination of ['READ', 'UPDATE', 'CREATE', 'DELETE', 'DOWNLOAD', 'MODERATE', 'CHANGE_PERMISSIONS', 'CHANGE_SETTINGS'] or an empty array
}


