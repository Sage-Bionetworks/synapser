%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetAcl}
\alias{synGetAcl}
\docType{methods}
\title{
Folder :  get_acl
}
\description{
Get the [ACL][synapseclient.core.models.permission.Permissions.access_types]
that a user or group has on an Entity.
}
\usage{
synGetAcl(instance, principal_id=NULL, check_benefactor=TRUE, synapse_client=NULL)
}
\arguments{
\item{instance}{(Folder) The Folder instance to operate on.}
\item{principal_id}{(int) Identifier of a user or group (defaults to PUBLIC users)}
\item{check_benefactor}{(bool) If True (default), check the benefactor for the entity to get the ACL. If False, only check the entity itself. This is useful for checking the ACL of an entity that has local sharing settings, but you want to check the ACL of the entity itself and not the benefactor it may inherit from.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
An array containing some combination of
        ['READ', 'UPDATE', 'CREATE', 'DELETE', 'DOWNLOAD', 'MODERATE',
        'CHANGE_PERMISSIONS', 'CHANGE_SETTINGS']
        or an empty array
}
\note{
on it, this will look up the ACL on the benefactor of the entity. The
benefactor is the entity that the current entity inherits its permissions from.
The benefactor is usually the parent entity, but it can be any ancestor in the
hierarchy. For example, a newly created Project will be its own benefactor,
while a new FileEntity's benefactor will start off as its containing Project or
Folder. If the entity already has local sharing settings, the benefactor would
be itself.
}
\keyword{Folder}
