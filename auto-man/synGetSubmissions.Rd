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
Arguments:
    evaluation: Evaluation to get submissions from.
    status: Optionally filter submissions for a specific status.
            One of:

        - `OPEN`
        - `CLOSED`
        - `SCORED`
        - `INVALID`
        - `VALIDATED`
        - `EVALUATION_IN_PROGRESS`
        - `RECEIVED`
        - `REJECTED`
        - `ACCEPTED`

    myOwn: Determines if only your Submissions should be fetched.
             Defaults to False (all Submissions)
    limit: Limits the number of submissions in a single response.
                Because this method returns a generator and repeatedly
                fetches submissions, this argument is limiting the
                size of a single request and NOT the number of sub-
                missions returned in total.
    offset: Start iterating at a submission offset from the first submission.

Yields:
    A generator over [synapseclient.evaluation.Submission][] objects for an Evaluation
}
\usage{
synGetSubmissions(evaluation, status=NULL, myOwn=FALSE, limit=20, offset=0)
}
\arguments{
\item{evaluation}{}
\item{status}{}
\item{myOwn}{}
\item{limit}{}
\item{offset}{}
}
\value{

}


