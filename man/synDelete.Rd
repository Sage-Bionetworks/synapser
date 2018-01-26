\name{synDelete}
\alias{synDelete}
\docType{methods}
\title{
synDelete
}
\description{
Removes an object from Synapse.
}
\usage{
synDelete(obj, version=NULL)
}
\arguments{
\item{obj}{ An existing object stored on Synapse\cr
            such as Evaluation, File, Project, or Wiki}
\item{version}{ For entities, specify a particular version to delete.}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{

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
%
% Verified that the following works on 2018Jan23.
% 
\examples{
\dontrun{
file<-synGet("syn12345")
synDelete(file)
}
}



