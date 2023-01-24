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
%
% Verified that the following works on 2018Jan23.
%
\examples{
\dontrun{
synGetPermissions("syn11705401", "3320560")
}
}



