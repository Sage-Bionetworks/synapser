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
\item{evaluation_id}{(character) The ID of the specified Evaluation.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
A \code{GeneratorWrapper} object that yields \code{\link{SubmissionBundle}} objects as they are retrieved from the API. Use \code{as.list()} to materialize all results into a list, or \code{nextElem()} to retrieve one \code{\link{SubmissionBundle}} at a time.
}
\examples{
\dontrun{
## Getting user submission bundles
    library(synapser)
    synLogin()

    bundles = as.list(SubmissionBundle() |> synGetUserSubmissionBundles(
        evaluation_id = "9999999"
    ))
    print(sprintf("Found \%d user submission bundles", length(bundles)))
    for (bundle in bundles) {
        print(sprintf("Submission ID: \%s", bundle$submission$id))
    }
}
}
\keyword{SubmissionBundle}
