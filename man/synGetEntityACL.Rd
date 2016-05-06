\name{Get Entity Access Control List}
\alias{synGetEntityACL}
\docType{methods}
\title{
Get Entity Access Control List
}

\description{
Retrieves an Access Control List (ACL) for an entity (e.g. Project, File, Folder, Table).
}
\usage{synGetEntityACL(id)}
\arguments{
	\item{id}{
	The ID of the entity whose ACL is to be retrieved.  If the entity inherits its ACL from a parent, an error 
	is thrown.
	}
}
\value{
The entity's ACL.  If the entity inherits the permissions of a parent, an error is thrown.
}

\seealso{
\code{\link{synCreateEntityACL}}
\code{\link{synUpdateEntityACL}}
\code{\link{synDeleteEntityACL}}
\code{\link{AccessControlList}}
\code{\link{ResourceAccessList}}
\code{\link{ResourceAccess}}
}
