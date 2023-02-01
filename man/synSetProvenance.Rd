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
\value{
 An updated Activity object
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



