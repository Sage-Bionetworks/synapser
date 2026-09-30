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
\item{evaluation_id}{(character) The ID of the evaluation queue.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
A \code{GeneratorWrapper} object that yields \code{\link{Submission}} objects as they are retrieved from the API. Use \code{as.list()} to materialize all results into a list, or \code{nextElem()} to retrieve one \code{\link{Submission}} at a time.
}
\examples{
\dontrun{
## Getting user submissions
    library(synapser)
    synLogin()

    submissions = as.list(Submission() |> synGetUserSubmissions(
        evaluation_id = "9999999"
    ))
    print(sprintf("Found \%d user submissions", length(submissions)))
}
}
\keyword{Submission}
