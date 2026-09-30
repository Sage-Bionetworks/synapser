%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetEvaluationSubmissionBundles}
\alias{SubmissionBundle_synGetEvaluationSubmissionBundles}
\docType{methods}
\title{
SubmissionBundle :  get_evaluation_submission_bundles
}
\description{
Retrieves bundled Submissions and SubmissionStatuses for a given Evaluation.
}
\usage{
synGetEvaluationSubmissionBundles(cls, evaluation_id, status=NULL, synapse_client=NULL)
}
\arguments{
\item{cls}{(SubmissionBundle) The SubmissionBundle class (or an existing SubmissionBundle instance) to dispatch this call to.}
\item{evaluation_id}{(str) The ID of the specified Evaluation.}
\item{status}{(Optional[str]) Optionally filter submission bundles by status.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
SubmissionBundle objects as they are retrieved from the API.
}
\note{
The caller must be granted the ACCESS_TYPE.READ_PRIVATE_SUBMISSION on the specified Evaluation.
}
\examples{
\dontrun{
## Getting submission bundles for an evaluation
    from synapseclient import Synapse
    from synapseclient.models import SubmissionBundle

    syn = Synapse()
    syn.login()

    bundles = list(SubmissionBundle.get_evaluation_submission_bundles(
        evaluation_id="9999999",
        status="SCORED"
    ))
    print(f"Found {len(bundles)} submission bundles")
    for bundle in bundles:
        print(f"Submission ID: {bundle.submission.id if bundle.submission else 'N/A'}")
}
}
\keyword{SubmissionBundle}
