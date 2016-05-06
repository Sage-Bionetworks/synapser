\name{executed}
\alias{executed}
\title{
	\code{executed}
}
\description{
Function for getting the entities executed to generate an Entity or Activity
}
\usage{
executed(entity)
executed(activity)
activity$executed
}
\arguments{
  \item{entity}{
  The entity/activity of interest.
}
}
\details{
This method returns information already in the session.  There is no server interaction.
}
\value{
A list of entities involved in generating the given entity/activity, but only if "executed". (See also \code{used(entity)}.)
}

\author{
Bruce Hoff
}


