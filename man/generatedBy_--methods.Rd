\name{generatedBy<--methods}
\alias{generatedBy<-}
\title{
\code{generatedBy<-}
}
\description{
 	Method for setting the Activity which generated an Entity
}
\usage{
	generatedBy(entity)<-activity
}
\arguments{
  \item{entity}{
the entity of interest
}
 \item{activity}{
the activity which generated the entity
}
}
\details{
Sets the Activity which generated an entity.  NULL is allowed.  No server interaction takes place. (That is done when \code{storeEntity} is called.)
}

\author{
Bruce Hoff
}