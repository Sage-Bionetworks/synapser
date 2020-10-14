%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{SubmissionStatus}
\alias{SubmissionStatus}
\docType{methods}
\title{
Constructor for objects of type SubmissionStatus
}
\description{
Builds an Synapse submission status object.
https://rest-docs.synapse.org/rest/org/sagebionetworks/evaluation/model/SubmissionStatus.html
}
\usage{
SubmissionStatus(id=NULL, status=NULL, submissionAnnotations=NULL, canCancel=NULL, cancelRequested=NULL)
}
\arguments{
\item{id}{optional named parameter:  Unique immutable Synapse Id of the Submission\cr
}
\item{status}{optional named parameter:  Status can be one of\cr
               https://rest-docs.synapse.org/rest/org/sagebionetworks/evaluation/model/SubmissionStatusEnum.html.\cr
}
\item{submissionAnnotations}{optional named parameter:  synapseclient.Annotations to store annotations of submission\cr
}
\item{canCancel}{optional named parameter:  Can this submission be cancelled?\cr
}
\item{cancelRequested}{optional named parameter:  Has user requested to cancel this submission?}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
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
% Pointers to related R objects, using \code{\link{...}} to refer to them.
}
% Examples of how to use the function. 
% Examples are not only useful for documentation purposes, but also provide test code used for diagnostic checking of R code. 
% By default, text will be displayed in the output of the help page and run by example() and by R CMD check. 
% You can use \dontrun{} for text that should only be shown, but not run, and \dontshow{} for extra commands 
% for testing that should not be shown to users, but will be run by example(). 
\examples{

}



