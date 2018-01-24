%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetSubmissions}
\alias{synGetSubmissions}
\docType{methods}
\title{
synGetSubmissions
}
\description{

}
\usage{
synGetSubmissions(evaluation, status=NULL, myOwn=FALSE, limit=20, offset=0)
}
\arguments{
\item{evaluation}{ Evaluation to get submissions from.\cr
}
\item{status}{     Optionally filter submissions for a specific status.\cr
                   One of {OPEN, CLOSED, SCORED,INVALID,VALIDATED,\cr
                   EVALUATION_IN_PROGRESS,RECEIVED, REJECTED, ACCEPTED}\cr
}
\item{myOwn}{      Determines if only your Submissions should be fetched.\cr
                   Defaults to False (all Submissions)\cr
}
\item{limit}{      Limits the number of submissions in a single response.\cr
                   Because this method returns a generator and repeatedly\cr
                   fetches submissions, this arguement is limiting the\cr
                   size of a single request and NOT the number of sub-\cr
                   missions returned in total.\cr
}
\item{offset}{     Start iterating at a submission offset from the first\cr
                   submission.}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
 A generator over Submission objects for an Evaluation
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
% Examples of how to use the function. 
% Examples are not only useful for documentation purposes, but also provide test code used for diagnostic checking of R code. 
% By default, text will be displayed in the output of the help page and run by example() and by R CMD check. 
% You can use \dontrun{} for text that should only be shown, but not run, and \dontshow{} for extra commands 
% for testing that should not be shown to users, but will be run by example(). 
%\dontrun{
%    for submission in syn.getSubmissions(1234567):
%        print(submission['entityId'])
%}
}



