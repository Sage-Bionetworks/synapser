%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetSubmissionBundles}
\alias{synGetSubmissionBundles}
\docType{methods}
\title{
synGetSubmissionBundles
}
\description{
Retrieve submission bundles (submission and submissions status) for an evaluation queue, optionally filtered by
submission status and/or owner.
}
\usage{
synGetSubmissionBundles(evaluation, status=NULL, myOwn=FALSE, limit=20, offset=0)
}
\arguments{
\item{evaluation}{ Evaluation to get submissions from.\cr
}
\item{status}{     Optionally filter submissions for a specific status.\cr
                   One of {OPEN, CLOSED, SCORED, INVALID}\cr
}
\item{myOwn}{      Determines if only your Submissions should be fetched.\cr
                   Defaults to False (all Submissions)\cr
}
\item{limit}{      Limits the number of submissions coming back from the\cr
                   service in a single response.\cr
}
\item{offset}{     Start iterating at a submission offset from the first\cr
                   submission.}
}
\value{
 A generator over tuples containing a Submission
          and a SubmissionStatus.
}

 
\examples{
%\dontrun{
%    for submission, status in syn.getSubmissionBundles(evaluation):
%        print(submission.name, \
%              submission.submitterAlias, \
%              status.status, \
%              status.score)
%}
}
