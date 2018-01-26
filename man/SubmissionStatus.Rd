\name{SubmissionStatus}
\alias{SubmissionStatus}
\docType{methods}
\title{
Constructor for objects of type SubmissionStatus
}
\description{
Builds an Synapse submission status object.
}
\usage{
SubmissionStatus(score=NULL, status=NULL)
}
\arguments{
\item{score}{optional named parameter:       The score of the submission\cr
}
\item{status}{optional named parameter:      Status can be one of {'OPEN', 'CLOSED', 'SCORED', 'INVALID'}.}
}
\details{
This constructor is not normally invoked by the client. The object is created as a side effect of calling \code{\link{synSubmit}} and 
is retrieved by \code{\link{synGetSubmissionStatus}}.
}
\value{
An object of type SubmissionStatus
}
\references{
% A section with references to the literature. Use \url{} or \href{}{} for web pointers.
}
\note{
% Use this for a special note you want to have pointed out. 
}
\seealso{
\code{\link{synSubmit}}
\code{\link{synGetSubmissionStatus}}
\code{\link{synGetSubmissionBundles}}

}
\examples{
}



