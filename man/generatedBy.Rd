\name{generatedBy}
\alias{generatedBy}
\title{
\code{generatedBy}
}
\description{
Function for retrieving the Activity which generated an Entity
}
\usage{
generatedBy(entity)
}
\arguments{
  \item{entity}{
the entity of interest
}
}
\details{
This method returns information already in the session.  There is no server interaction.
}
\value{
The Activity which generated the given Entity, or NULL if there is no activity.
}

\author{
Bruce Hoff
}

