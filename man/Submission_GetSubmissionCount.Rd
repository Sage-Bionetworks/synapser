\name{synGetSubmissionCount}
\alias{Submission_synGetSubmissionCount}
\docType{methods}
\title{
Submission :  get_submission_count
}
\description{
Gets the number of Submissions for a specified Evaluation queue.
}
\usage{
synGetSubmissionCount(evaluation_id, synapse_client=NULL)
}
\arguments{
\item{evaluation_id}{(character) The ID of the evaluation queue.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
The API response containing the submission count.
}
\examples{
\dontrun{
## Getting submission count
    # Get the total number of submissions from a specific evaluation.
    library(synapser)
    synLogin()

    response = synGetSubmissionCount(evaluation_id = "9999999")
    print(response)
}
}
\keyword{Submission}
