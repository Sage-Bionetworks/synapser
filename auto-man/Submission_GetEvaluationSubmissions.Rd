%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetEvaluationSubmissions}
\alias{Submission_synGetEvaluationSubmissions}
\docType{methods}
\title{
Submission :  get_evaluation_submissions
}
\description{
Retrieves all Submissions for a specified Evaluation queue.
}
\usage{
synGetEvaluationSubmissions(cls, evaluation_id, status=NULL, synapse_client=NULL)
}
\arguments{
\item{cls}{(Submission) The Submission class (or an existing Submission instance) to dispatch this call to.}
\item{evaluation_id}{(str) The ID of the evaluation queue.}
\item{status}{(Optional[str]) Optionally filter submissions by a submission status, such as SCORED, VALID, INVALID, OPEN, CLOSED or EVALUATION_IN_PROGRESS.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
Submission objects as they are retrieved from the API.
}
\examples{
\dontrun{
## Getting submissions for an evaluation
    # Get SCORED submissions from a specific evaluation.
    from synapseclient import Synapse
    from synapseclient.models import Submission

    syn = Synapse()
    syn.login()

    submissions = list(Submission.get_evaluation_submissions(
        evaluation_id="9999999",
        status="SCORED"
    ))
    print(f"Found {len(submissions)} submissions")
}
}
\keyword{Submission}
