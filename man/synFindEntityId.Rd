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
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
 the Entity ID or NULL if not found
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
synFindEntityId("my_test_file.txt", parent = "syn123")
}



