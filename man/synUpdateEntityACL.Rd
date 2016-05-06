\name{Update Entity Access Control List}
\alias{synUpdateEntityACL}
\docType{methods}
\title{
Update Entity Access Control List
}

\description{
Updates an ACL for an entity (e.g. File, Folder, Table).
}
\usage{synUpdateEntityACL(acl)}
\arguments{
	\item{acl}{
	The updated AccessControlList.  This allows principals (users or teams) to be added or removed, or
	to change the access permissions of principals already in the ACL.
	}
}
\value{
The updated ACL.
}

\seealso{
\code{\link{synCreateEntityACL}}
\code{\link{synGetEntityACL}}
\code{\link{synDeleteEntityACL}}
\code{\link{AccessControlList}}
\code{\link{ResourceAccessList}}
\code{\link{ResourceAccess}}
}
