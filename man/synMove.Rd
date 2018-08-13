\name{synMove}
\alias{synMove}
\docType{methods}
\title{
synMove
}
\description{
Move a Synapse entity to a new container.
}
\usage{
synMove(entity, new_parent)
}
\arguments{
\item{entity}{           A Synapse ID, a Synapse Entity object, or a local file that is stored in Synapse\cr
}
\item{new_parent}{       The new parent container (Folder or Project) to which the entity should be moved.}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
 The Synapse Entity object that has been moved.
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
\dontrun{
    entity <- synMove('syn456', 'syn123')
}
}



