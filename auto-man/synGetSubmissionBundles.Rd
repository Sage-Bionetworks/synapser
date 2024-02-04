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

Arguments:
    evaluation: Evaluation to get submissions from.
    status:     Optionally filter submissions for a specific status.
                One of:

        - `OPEN`
        - `CLOSED`
        - `SCORED`
        - `INVALID`

    myOwn:      Determines if only your Submissions should be fetched.
                Defaults to False (all Submissions)
    limit:      Limits the number of submissions coming back from the
                service in a single response.
    offset:     Start iterating at a submission offset from the first submission.

Yields:
    A generator over tuples containing a [synapseclient.evaluation.Submission][] and a [synapseclient.evaluation.SubmissionStatus][].
}
\usage{
synGetSubmissionBundles(evaluation, status=NULL, myOwn=FALSE, limit=20, offset=0)
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


