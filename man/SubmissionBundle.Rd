\name{SubmissionBundle}
\alias{SubmissionBundle}
\docType{class}
\title{
SubmissionBundle
}
\format{An S3-style class object.}
\description{
A \code{SubmissionBundle} object represents a bundle containing a Synapse Submission
and its accompanying SubmissionStatus. This bundle provides convenient access to both
the submission data and its current status in a single object.

\url{https://rest-docs.synapse.org/rest/org/sagebionetworks/evaluation/model/SubmissionBundle.html}
}
\usage{
SubmissionBundle(submission=NULL, submission_status=NULL)
}
\arguments{
\item{submission}{(Optional[Submission]) A Submission to a Synapse Evaluation is a pointer to a versioned Entity. Submissions are immutable, so we archive a copy of the EntityBundle at the time of submission.}
\item{submission_status}{(Optional[SubmissionStatus]) A SubmissionStatus is a secondary, mutable object associated with a Submission. This object should be used to contain scoring data about the Submission.}
}
\value{
NULL
}
\examples{
\dontrun{
## Example 1: Retrieve submission bundles for an evaluation.
    library(synapser)
    synLogin()

    # Get all submission bundles for an evaluation
    bundles = SubmissionBundle() |> synGetEvaluationSubmissionBundles(
        evaluation_id = "9999999",
        status = "SCORED"
    )

    for (bundle in as.list(bundles)) {
        submission_id = if (is.null(bundle$submission)) "N/A" else bundle$submission$id
        status = if (is.null(bundle$submission_status)) "N/A" else bundle$submission_status$status
        print(sprintf("Submission ID: \%s", submission_id))
        print(sprintf("Status: \%s", status))
    }

## Example 2: Retrieve user submission bundles for an evaluation.
    library(synapser)
    synLogin()

    # Get current user's submission bundles for an evaluation
    user_bundles = SubmissionBundle() |> synGetUserSubmissionBundles(
        evaluation_id = "9999999"
    )

    for (bundle in as.list(user_bundles)) {
        print(sprintf("Submission ID: \%s", bundle$submission$id))
        print(sprintf("Status: \%s", bundle$submission_status$status))
    }
}
}
\section{Methods}{
\itemize{
\item \code{SubmissionBundle(submission=NULL, submission_status=NULL)}: Constructor for \code{\link{SubmissionBundle}}
\item \code{\link[=SubmissionBundle_synGetEvaluationSubmissionBundles]{synGetEvaluationSubmissionBundles}(cls, evaluation_id, status=NULL, synapse_client=NULL)}: Retrieves bundled Submissions and SubmissionStatuses for a given Evaluation.
\item \code{\link[=SubmissionBundle_synGetUserSubmissionBundles]{synGetUserSubmissionBundles}(cls, evaluation_id, synapse_client=NULL)}: Retrieves all user bundled Submissions and SubmissionStatuses for a specified Evaluation.
}
}
