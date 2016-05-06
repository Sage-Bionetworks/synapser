\name{propertyNames}
\alias{propertyNames}
\title{
propertyNames
}
\description{
Returns the names of the properties defined for a given Synapse object.
}
\usage{
propertyNames(object)
}
\arguments{
  \item{entity}{
The Synapse object of interest.
}
}
\value{
A vector of character strings giving the names of the properties defined for a given Synapse object.
}
\examples{
propertyNames(File(parentId="syn101"))
propertyNames(Evaluation())
}
\seealso{
\code{\link{propertyValue}}
}

