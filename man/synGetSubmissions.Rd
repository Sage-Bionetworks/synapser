\name{synGetSubmissions}
\alias{synGetSubmissions}
\docType{methods}
\title{
synGetSubmissions
}
\description{}
\usage{
	synGetSubmissions(status=NULL, myOwn=FALSE, limit=100, offset=0)
}
\arguments{
\item{status=NULL}{}
\item{myOwn=FALSE}{}
\item{limit=100}{}
\item{offset=0}{}
}
\details{
:param evaluation: Evaluation to get submissions from.
:param status:     Optionally filter submissions for a specific status.
                   One of {OPEN, CLOSED, SCORED,INVALID,VALIDATED,
                   EVALUATION_IN_PROGRESS,RECEIVED, REJECTED, ACCEPTED}
:param myOwn:      Determines if only your Submissions should be fetched.
                   Defaults to False (all Submissions)
:param limit:      Limits the number of submissions in a single response.
                   Because this method returns a generator and repeatedly
                   fetches submissions, this arguement is limiting the
                   size of a single request and NOT the number of sub-
                   missions returned in total.
:param offset:     Start iterating at a submission offset from the first
                   submission.

:returns: A generator over :py:class:`synapseclient.evaluation.Submission` objects for an Evaluation

Example::

    for submission in syn.getSubmissions(1234567):
        print(submission['entityId'])

See: :py:mod:`synapseclient.evaluation`
}

