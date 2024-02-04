%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synSetPermissions}
\alias{synSetPermissions}
\docType{methods}
\title{
synSetPermissions
}
\description{
Sets permission that a user or group has on an Entity.
An Entity may have its own ACL or inherit its ACL from a benefactor.

Arguments:
    entity: An Entity or Synapse ID to modify
    principalId: Identifier of a user or group. '273948' is for all registered Synapse users
                    and '273949' is for public access.
    accessType: Type of permission to be granted. One or more of CREATE, READ, DOWNLOAD, UPDATE,
                    DELETE, CHANGE_PERMISSIONS
    modify_benefactor: Set as True when modifying a benefactor's ACL
    warn_if_inherits: Set as False, when creating a new ACL.
                        Trying to modify the ACL of an Entity that inherits its ACL will result in a warning
    overwrite: By default this function overwrites existing permissions for the specified user.
                Set this flag to False to add new permissions non-destructively.

Returns:
    An Access Control List object
}
\usage{
synSetPermissions(entity, principalId=NULL, accessType=c("READ", "DOWNLOAD"), modify_benefactor=FALSE, warn_if_inherits=TRUE, overwrite=TRUE)
}
\arguments{
\item{entity}{}
\item{principalId}{}
\item{accessType}{}
\item{modify_benefactor}{}
\item{warn_if_inherits}{}
\item{overwrite}{}
}
\value{

}


