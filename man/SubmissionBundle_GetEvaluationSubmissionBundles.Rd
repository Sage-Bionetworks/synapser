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
\item{evaluation_id}{(character) The ID of the specified Evaluation.}
\item{status}{(Optional[character]) Optionally filter submission bundles by status.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
A \code{GeneratorWrapper} object that yields \code{\link{SubmissionBundle}} objects as they are retrieved from the API. Use \code{as.list()} to materialize all results into a list, or \code{nextElem()} to retrieve one \code{\link{SubmissionBundle}} at a time.
}
\note{
The caller must be granted the READ_PRIVATE_SUBMISSION \href{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/ACCESS_TYPE.html}{access type} on the specified Evaluation.
}
\examples{
\dontrun{
## Getting submission bundles for an evaluation
    library(synapser)
    synLogin()

    bundles = as.list(SubmissionBundle() |> synGetEvaluationSubmissionBundles(
        evaluation_id = "9999999",
        status = "SCORED"
    ))
    print(sprintf("Found \%d submission bundles", length(bundles)))
    for (bundle in bundles) {
        submission_id = if (is.null(bundle$submission)) "N/A" else bundle$submission$id
        print(sprintf("Submission ID: \%s", submission_id))
    }
}
}
\keyword{SubmissionBundle}
