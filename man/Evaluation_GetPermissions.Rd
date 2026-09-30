\name{synGetPermissions}
\alias{Evaluation_synGetPermissions}
\docType{methods}
\title{
Evaluation :  get_permissions
}
\description{
Get the user permissions for this evaluation.
}
\usage{
synGetPermissions(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Evaluation) The Evaluation instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
A named list of the permissions the current user has on this evaluation.
}
\section{Errors}{
- An error is raised if the evaluation's \code{id} is not set.\cr
- An error is also raised if the service rejects the request or an HTTP error occurs.
}
\examples{
\dontrun{
## Get permissions for the current user
    library(synapser)
    synLogin()

    PROJECT_ID = "syn123456"  # replace with your project ID

    # Store a new evaluation in the project first
    evaluation = Evaluation(
        name = "My Challenge Evaluation",
        description = "Evaluation for my data challenge",
        content_source = PROJECT_ID,
        submission_instructions_message = "Submit CSV files only",
        submission_receipt_message = "Thank you for your submission!"
    ) |> synStore()

    # Get the permissions for the current user
    my_permissions = evaluation |> synGetPermissions()
    my_permissions
}
}
\keyword{Evaluation}
