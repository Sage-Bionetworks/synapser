%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetUserSubmissionBundles}
\alias{SubmissionBundle_synGetUserSubmissionBundles}
\docType{methods}
\title{
SubmissionBundle :  get_user_submission_bundles
}
\description{
Retrieves all user bundled Submissions and SubmissionStatuses for a specified Evaluation.
}
\usage{
synGetUserSubmissionBundles(cls, evaluation_id, synapse_client=NULL)
}
\arguments{
\item{cls}{(SubmissionBundle) The SubmissionBundle class (or an existing SubmissionBundle instance) to dispatch this call to.}
\item{evaluation_id}{(str) The ID of the specified Evaluation.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
SubmissionBundle objects as they are retrieved from the API.
}
\examples{
\dontrun{
## Getting user submission bundles
    from synapseclient import Synapse
    from synapseclient.models import SubmissionBundle

    syn = Synapse()
    syn.login()

    bundles = list(SubmissionBundle.get_user_submission_bundles(
        evaluation_id="9999999"
    ))
    print(f"Found {len(bundles)} user submission bundles")
    for bundle in bundles:
        print(f"Submission ID: {bundle.submission.id}")
}
}
\keyword{SubmissionBundle}
