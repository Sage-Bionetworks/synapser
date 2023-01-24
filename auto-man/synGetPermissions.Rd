%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetPermissions}
\alias{synGetPermissions}
\docType{methods}
\title{
synGetPermissions
}
\description{
Get the permissions that a user or group has on an Entity.
}
\usage{
synGetPermissions(entity, principalId=NULL)
}
\arguments{
\item{entity}{      An Entity or Synapse ID to lookup\cr
}
\item{principalId}{ Identifier of a user or group (defaults to PUBLIC users)}
}
\value{
 An array containing some combination of
          ['READ', 'CREATE', 'UPDATE', 'DELETE', 'CHANGE_PERMISSIONS', 'DOWNLOAD']
          or an empty array
}


