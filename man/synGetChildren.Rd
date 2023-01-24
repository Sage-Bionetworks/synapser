\name{synGetChildren}
\alias{synGetChildren}
\docType{methods}
\title{
synGetChildren
}
\description{
Retrieves all of the entities stored within a parent such as folder or project.
}
\usage{
synGetChildren(parent, includeTypes=list("folder", "file", "table", "link", "entityview", "dockerrepo"), sortBy = 'NAME', sortDirection = 'ASC')
}
\arguments{
\item{parent}{       An id or an object of a Synapse container or NULL to retrieve all projects}
\item{includeTypes}{   Must be a list of entity types (ie. list("folder","file") which can be found here:\cr
                       http://docs.synapse.org/rest/org/sagebionetworks/repo/model/EntityType.html}
\item{sortBy}{        How results should be sorted. Can be 'NAME', or 'CREATED_ON'.}
\item{sortDirection}{ The direction of the result sort. Can be 'ASC', or 'DESC'}
}
\value{
              An iterator that shows all the children of the container.  Use \code{\link{nextElem}} or \code{\link{as.list}}
              to access the values.
}
\seealso{
\code{\link{nextElem}}
\code{\link{as.list}}
}
\examples{
\dontrun{
iterator <- synGetChildren("syn123456", includeTypes = list("file"), sortBy = "CREATED_ON")
}
}


