\name{synUpdateActivity}
\alias{synUpdateActivity}
\docType{methods}
\title{
synUpdateActivity
}
\description{
Modifies an existing Activity.
}
\usage{
synUpdateActivity(activity)
}
\arguments{
\item{activity}{  The Activity to be updated.}
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
}
%
% Verified that the following works on 2018Jan23.
%
\examples{
\dontrun{
activity<-Activity()
activity$used("syn123")
activity<-synSetProvenance("syn11678572", activity)
activity$used("syn456")
activity<-synUpdateActivity(activity)
}
}



