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
}
\usage{
synSetPermissions(entity, principalId=NULL, accessType=c("READ", "DOWNLOAD"), modify_benefactor=FALSE, warn_if_inherits=TRUE, overwrite=TRUE)
}
\arguments{
\item{entity}{              An Entity or Synapse ID to modify\cr
}
\item{principalId}{         Identifier of a user or group\cr
}
\item{accessType}{          Type of permission to be granted. One or more of CREATE, READ, DOWNLOAD, UPDATE,\cr
                            DELETE, CHANGE_PERMISSIONS\cr
}
\item{modify_benefactor}{   Set as True when modifying a benefactor's ACL\cr
}
\item{warn_if_inherits}{    Set as False, when creating a new ACL.\cr
                            Trying to modify the ACL of an Entity that inherits its ACL will result in a warning\cr
}
\item{overwrite}{           By default this function overwrites existing permissions for the specified user.\cr
                            Set this flag to False to add new permissions non-destructively.}
}
\value{
 an Access Control List object
}


