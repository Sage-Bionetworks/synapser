\name{synSetProvenance}
\alias{synSetProvenance}
\docType{methods}
\title{
synSetProvenance
}
\description{
Stores a record of the code and data used to derive a Synapse entity.
}
\usage{
synSetProvenance(entity, activity)
}
\arguments{
\item{entity}{   An Entity or Synapse ID to modify\cr
}
\item{activity}{ an Activity}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
 An updated Activity object
}
\references{
% A section with references to the literature. Use \url{} or \href{}{} for web pointers.
}
\note{
% Use this for a special note you want to have pointed out. 
}
\seealso{
% Pointers to related R objects, using \code{\link{...}} to refer to them.
\code{\link{Activity}}
}
%
% Verified that the following works on 2018Jan23.
% 
\examples{
\dontrun{
act <- Activity(name='clustering', description='whizzy clustering')
act$used(c('syn12345', 'syn12346'))
file<-synGet("syn1234567")
synSetProvenance(file, act)
}
}



