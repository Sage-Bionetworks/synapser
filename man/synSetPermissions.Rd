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
\item{principalId}{       Identifier of a user or group. '273948' is for all registered Synapse users
                    and '273949' is for public access. None implies public access.\cr
}
\item{accessType}{        Type of permission to be granted. One or more of CREATE, READ, DOWNLOAD, UPDATE, DELETE, CHANGE_PERMISSIONS\cr
}
\item{modify_benefactor}{ Set as TRUE when modifying a benefactor's ACL\cr
}
\item{warn_if_inherits}{  Set as FALSE, when creating a new ACL.
                        Trying to modify the ACL of an Entity that inherits its ACL will result in a warning
}
\item{overwrite}{        By default this function overwrites existing permissions for the specified user.
                Set this flag to FALSE to add new permissions non-destructively.}
}
\value{
 An Access Control List object
}
%
% Verified that the following works on 2024July2.
%
\examples{
\dontrun{
# assign the Public group "can read"" permission to the entity
synSetPermissions("entity_id", 273949, list("READ"))
}
}



