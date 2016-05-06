\name{used}
\alias{used}
\title{
	\code{used}
}
\description{
Function for getting the entities used to generate an Entity or Activity
}
\usage{
used(entity)
used(activity)
activity$used
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
A list of entities involved in generating the given entity/activity, but not "executed". (See also \code{executed(entity)}.)
}

\author{
Bruce Hoff
}


