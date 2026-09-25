%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetUserSubmissions}
\alias{Submission_synGetUserSubmissions}
\docType{methods}
\title{
Submission :  get_user_submissions
}
\description{
Retrieves all user Submissions for a specified Evaluation queue.
}
\usage{
synGetUserSubmissions(cls, evaluation_id, synapse_client=NULL)
}
\arguments{
\item{cls}{(Submission) The Submission class (or an existing Submission instance) to dispatch this call to.}
\item{evaluation_id}{(str) The ID of the evaluation queue.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
Submission objects as they are retrieved from the API.
}
\examples{
\dontrun{
## Getting user submissions
    from synapseclient import Synapse
    from synapseclient.models import Submission

    syn = Synapse()
    syn.login()

    submissions = list(Submission.get_user_submissions(
        evaluation_id="9999999"
    ))
    print(f"Found {len(submissions)} user submissions")
}
}
\keyword{Submission}
