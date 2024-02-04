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
Get the [ACL](https://rest-docs.synapse.org/rest/org/
sagebionetworks/repo/model/ACCESS_TYPE.html)
that a user or group has on an Entity.

Arguments:
    entity:      An Entity or Synapse ID to lookup
    principal_id: Identifier of a user or group (defaults to PUBLIC users)

Returns:
    An array containing some combination of
        ['READ', 'UPDATE', 'CREATE', 'DELETE', 'DOWNLOAD', 'MODERATE',
        'CHANGE_PERMISSIONS', 'CHANGE_SETTINGS']
        or an empty array
}
\usage{
synGetAcl(entity, principal_id=NULL)
}
\arguments{
\item{entity}{}
\item{principal_id}{}
}
\value{

}


