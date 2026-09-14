%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
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

<https://rest-docs.synapse.org/rest/org/sagebionetworks/evaluation/model/SubmissionBundle.html>
}
\usage{
SubmissionBundle(submission=NULL, submission_status=NULL)
}
\arguments{
\item{submission}{(Optional[ForwardRef('Submission')]) A Submission to a Synapse Evaluation is a pointer to a versioned Entity. Submissions are immutable, so we archive a copy of the EntityBundle at the time of submission.}
\item{submission_status}{(Optional[ForwardRef('SubmissionStatus')]) A SubmissionStatus is a secondary, mutable object associated with a Submission. This object should be used to contain scoring data about the Submission.}
}
\value{
NULL
}
\examples{
\dontrun{
## Example 1: Retrieve submission bundles for an evaluation.
    from synapseclient import Synapse
    from synapseclient.models import SubmissionBundle

    syn = Synapse()
    syn.login()

    # Get all submission bundles for an evaluation
    bundles = SubmissionBundle.get_evaluation_submission_bundles(
        evaluation_id="9999999",
        status="SCORED"
    )

    for bundle in bundles:
        print(f"Submission ID: {bundle.submission.id if bundle.submission else 'N/A'}")
        print(f"Status: {bundle.submission_status.status if bundle.submission_status else 'N/A'}")

## Example 2: Retrieve user submission bundles for an evaluation.
    from synapseclient import Synapse
    from synapseclient.models import SubmissionBundle

    syn = Synapse()
    syn.login()

    # Get current user's submission bundles for an evaluation
    user_bundles = SubmissionBundle.get_user_submission_bundles(
        evaluation_id="9999999",
        limit=25
    )

    for bundle in user_bundles:
        print(f"Submission ID: {bundle.submission.id}")
        print(f"Status: {bundle.submission_status.status}")
}
}
\section{Methods}{
\itemize{
\item \code{SubmissionBundle(submission=NULL, submission_status=NULL)}: Constructor for \code{\link{SubmissionBundle}}
}
}

