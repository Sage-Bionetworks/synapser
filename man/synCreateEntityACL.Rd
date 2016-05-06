\name{Create Entity Access Control List}
\alias{synCreateEntityACL}
\docType{methods}
\title{
Create Entity Access Control List
}

\description{
Creates an ACL for an entity (e.g. File, Folder, Table), overriding ACL inheritance.
}
\usage{synCreateEntityACL(acl)}
\arguments{
	\item{acl}{
	The AccessControlList to create.  The ID field is that of the entity which is to have the ACL.
	}
}
\value{
The created ACL.
}

\seealso{
\code{\link{synGetEntityACL}}
\code{\link{synUpdateEntityACL}}
\code{\link{synDeleteEntityACL}}
\code{\link{AccessControlList}}
\code{\link{ResourceAccessList}}
\code{\link{ResourceAccess}}
}
