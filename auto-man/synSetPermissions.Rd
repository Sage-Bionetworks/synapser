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
synSetPermissions(entity, principalId=NULL, accessType=list("READ", "DOWNLOAD"), modify_benefactor=FALSE, warn_if_inherits=TRUE, overwrite=TRUE)
}
\arguments{
\item{entity}{            An Entity or Synapse ID to modify\cr
}
\item{principalId}{       Identifier of a user or group\cr
}
\item{accessType}{        Type of permission to be granted\cr
}
\item{modify_benefactor}{ Set as True when modifying a benefactor's ACL\cr
}
\item{warn_if_inherits}{  Set as False, when creating a new ACL.\cr
                          Trying to modify the ACL of an Entity that\cr
                          inherits its ACL will result in a warning\cr
}
\item{overwrite}{         By default this function overwrites existing\cr
                          permissions for the specified user. Set this\cr
                          flag to False to add new permissions nondestructively.}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
 an Access Control List object
}
\references{
% A section with references to the literature. Use \url{} or \href{}{} for web pointers.
}
\note{
% Use this for a special note you want to have pointed out. 
}
\seealso{
% Pointers to related R objects, using \code{\link{...}} to refer to them.
}
\examples{
% Examples of how to use the function. 
% Examples are not only useful for documentation purposes, but also provide test code used for diagnostic checking of R code. 
% By default, text will be displayed in the output of the help page and run by example() and by R CMD check. 
% You can use \dontrun{} for text that should only be shown, but not run, and \dontshow{} for extra commands 
% for testing that should not be shown to users, but will be run by example(). 
%\dontrun{
%
%}
}



