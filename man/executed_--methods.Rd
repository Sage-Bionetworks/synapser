\name{executed<--methods}
\alias{executed<-}
\title{
	\code{executed<-}
}
\description{
	Function for setting the entities executed to generate an Entity or Activity.
}
\usage{
executed(entity)<-list(entity1, entity2, entity3)
executed(entity)<-c(entity1, entity2, entity3)
executed(activity)<-list(entity1, entity2, entity3)
executed(activity)<-c(entity1, entity2, entity3)
activity$executed<-list(entity1, entity2, entity3)
activity$executed<-c(entity1, entity2, entity3)
}
\details{
Sets the vector or list of entities/entity IDs/URLs executed to generate the given Entity or Activity.    
No server interaction takes place. (That is done when \code{storeEntity} is called.)  To set the non-executed Entities, see \code{used}.
}


\author{
Bruce Hoff
}


