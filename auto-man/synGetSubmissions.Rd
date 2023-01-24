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
                   fetches submissions, this argument is limiting the\cr
                   size of a single request and NOT the number of sub-\cr
                   missions returned in total.\cr
}
\item{offset}{     Start iterating at a submission offset from the first\cr
                   submission.}
}
\value{
 A generator over Submission objects for an Evaluation
}

 
\examples{
%\dontrun{
%    for submission in syn.getSubmissions(1234567):
%        print(submission['entityId'])
%}
}
