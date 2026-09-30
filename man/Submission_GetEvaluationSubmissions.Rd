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
\item{evaluation_id}{(character) The ID of the evaluation queue.}
\item{status}{(Optional[character]) Optionally filter submissions by a submission status, such as SCORED, VALID, INVALID, OPEN, CLOSED or EVALUATION_IN_PROGRESS.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
A \code{GeneratorWrapper} object that yields \code{\link{Submission}} objects as they are retrieved from the API. Use \code{as.list()} to materialize all results into a list, or \code{nextElem()} to retrieve one \code{\link{Submission}} at a time.
}
\examples{
\dontrun{
## Getting submissions for an evaluation
    # Get SCORED submissions from a specific evaluation.
    library(synapser)
    synLogin()

    submissions = as.list(Submission() |> synGetEvaluationSubmissions(
        evaluation_id = "9999999",
        status = "SCORED"
    ))
    print(sprintf("Found \%d submissions", length(submissions)))
}
}
\keyword{Submission}
