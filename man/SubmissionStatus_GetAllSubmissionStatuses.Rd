\name{synGetAllSubmissionStatuses}
\alias{SubmissionStatus_synGetAllSubmissionStatuses}
\docType{methods}
\title{
SubmissionStatus :  get_all_submission_statuses
}
\description{
Gets a collection of SubmissionStatuses to a specified Evaluation.
}
\usage{
synGetAllSubmissionStatuses(evaluation_id, status=NULL, limit=10L, offset=0L, synapse_client=NULL)
}
\arguments{
\item{evaluation_id}{(character) The ID of the specified Evaluation.}
\item{status}{(Optional[character]) Optionally filter submission statuses by status.}
\item{limit}{(integer) Limits the number of entities that will be fetched for this page. When NULL it will default to 10, max value 100. Defaults to 10.}
\item{offset}{(integer) The offset index determines where this page will start from. An index of 0 is the first entity. Defaults to 0.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
A list of SubmissionStatus objects for the evaluation queue.
}
\examples{
\dontrun{
## Getting all submission statuses for an evaluation
    # Retrieve a list of submission statuses for a specific evaluation, optionally filtered by status.
    library(synapser)
    synLogin()

    statuses = synGetAllSubmissionStatuses(
        evaluation_id = "9999999",
        status = "SCORED",
        limit = 50L
    )
    print(sprintf("Found \%d submission statuses", length(statuses)))
    for (status in statuses) {
        print(sprintf("Status ID: \%s, Status: \%s", status$id, status$status))
    }
}
}
\keyword{SubmissionStatus}
