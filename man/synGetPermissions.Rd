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
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
 An array containing some combination of
          ['READ', 'CREATE', 'UPDATE', 'DELETE', 'CHANGE_PERMISSIONS', 'DOWNLOAD']
          or an empty array
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
%
% Verified that the following works on 2018Jan23.
%
\examples{
\dontrun{
synGetPermissions("syn11705401", "3320560")
}
}



