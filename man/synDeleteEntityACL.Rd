\name{Delete Entity Access Control List}
\alias{synDeleteEntityACL}
\docType{methods}
\title{
Delete Entity Access Control List
}

\description{
Deletes the ACL for an entity, forcing it to inherit the sharing settings of its parent.
}
\usage{synDeleteEntityACL(id)}
\arguments{
	\item{id}{
	The ID of the entity whose ACL is to be delete.
	}
}

\seealso{
\code{\link{synCreateEntityACL}}
\code{\link{synGetEntityACL}}
\code{\link{synUpdateEntityACL}}
\code{\link{AccessControlList}}
\code{\link{ResourceAccessList}}
\code{\link{ResourceAccess}}
}
