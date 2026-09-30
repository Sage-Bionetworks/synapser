\name{synCancel}
\alias{Submission_synCancel}
\docType{methods}
\title{
Submission :  cancel
}
\description{
Cancel a Submission. Only the user who created the Submission may cancel it.
}
\usage{
synCancel(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Submission) The Submission instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
The updated Submission object.
}
\section{Errors}{
Raises an error if the submission does not have an ID to cancel.
}
\examples{
\dontrun{
## Cancel a submission
library(synapser)

synLogin()

submission = Submission(id = "syn1234")
canceled_submission = submission |> synCancel()
print(sprintf("Canceled submission: \%s", canceled_submission$id))
}
}
\keyword{Submission}
