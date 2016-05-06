\name{used<--methods}
\alias{used<-}
\title{
	\code{used<-}
}
\description{
	Function for setting the entities used to generate an Entity or Activity.
}
\usage{
used(entity)<-list(entity1, entity2, entity3)
used(entity)<-c(entity1, entity2, entity3)
used(activity)<-list(entity1, entity2, entity3)
used(activity)<-c(entity1, entity2, entity3)
activity$used<-list(entity1, entity2, entity3)
activity$used<-c(entity1, entity2, entity3)
}
\details{
Sets the vector or list of entities/entity IDs/URLs used (but not *executed*) to generate the given Entity or Activity.    
No server interaction takes place. (That is done when \code{storeEntity} is called.)  To set the executed Entities, see \code{executed}.
}


\author{
Bruce Hoff
}


