\name{synFindEntityId}
\alias{synFindEntityId}
\docType{methods}
\title{
synFindEntityId
}
\description{
Find an Entity given its name and parent.
}
\usage{
synFindEntityId(name, parent=NULL)
}
\arguments{
\item{name}{ name of the entity to find\cr
}
\item{parent}{ An Entity object or the Id of an entity as a string. Omit if searching for a Project by name}
}
\value{
 the Entity ID or NULL if not found
}
\examples{
\dontrun{
synFindEntityId("my_test_file.txt", parent = "syn123")
}
}



