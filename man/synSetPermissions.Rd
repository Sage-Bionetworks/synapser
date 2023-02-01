\name{synSetPermissions}
\alias{synSetPermissions}
\docType{methods}
\title{
synSetPermissions
}
\description{
Sets permission that a user or group has on an Entity.
An Entity may have its own ACL or inherit its ACL from a benefactor.
}
\usage{
synSetPermissions(entity, principalId=NULL, accessType=list("READ", "DOWNLOAD"), modify_benefactor=FALSE, warn_if_inherits=TRUE, overwrite=TRUE)
}
\arguments{
\item{entity}{            An Entity or Synapse ID to modify\cr
}
\item{principalId}{       Identifier of a user or group\cr
}
\item{accessType}{        Type of permission to be granted. One or more of CREATE, READ, DOWNLOAD, UPDATE, DELETE, CHANGE_PERMISSIONS\cr
}
\item{modify_benefactor}{ Set as TRUE when modifying a benefactor's ACL\cr
}
\item{warn_if_inherits}{  Set as FALSE, when creating a new ACL.\cr
                          Trying to modify the ACL of an Entity that\cr
                          inherits its ACL will result in a warning\cr
}
\item{overwrite}{         By default this function overwrites existing\cr
                          permissions for the specified user. Set this\cr
                          flag to FALSE to add new permissions nondestructively.}
}
\value{
 an Access Control List object
}
%
% Verified that the following works on 2018Jan23.
%
\examples{
\dontrun{
synSetPermissions("syn11705401", 273950, c("READ", "DOWNLOAD"))
}
}



