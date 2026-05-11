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
**Deprecated with replacement.** This method will be removed in 5.0.0.
Use the `set_permissions` method on the dataclass models that inherit from `AccessControllable` mixin instead.

Sets permission that a user or group has on an Entity.
An Entity may have its own ACL or inherit its ACL from a benefactor.

Arguments:
    entity: An Entity or Synapse ID to modify
    principalId: Identifier of a user or group. '273948' is for all registered Synapse users
                    and '273949' is for public access. None implies public access.
    accessType: Type of permission to be granted. One or more of CREATE, READ, DOWNLOAD, UPDATE,
                    DELETE, CHANGE_PERMISSIONS
    modify_benefactor: Set as True when modifying a benefactor's ACL. The term
        'benefactor' is used to indicate which Entity an Entity inherits its
        ACL from. For example, a newly created Project will be its own
        benefactor, while a new FileEntity's benefactor will start off as its
        containing Project. If the entity already has local sharing settings
        the benefactor would be itself. It may also be the immediate parent,
        somewhere in the parent tree, or the project itself.
    warn_if_inherits: When `modify_benefactor` is True, this does not have any
        effect. When `modify_benefactor` is False, and `warn_if_inherits` is
        True, a warning log message is produced if the benefactor for the
        entity you passed into the function is not itself, i.e., it's the
        parent folder, or another entity in the parent tree.
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


