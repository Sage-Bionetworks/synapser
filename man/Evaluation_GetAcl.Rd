\name{synGetAcl}
\alias{Evaluation_synGetAcl}
\docType{methods}
\title{
Evaluation :  get_acl
}
\description{
Get the access control list (ACL) governing this evaluation.
}
\usage{
synGetAcl(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Evaluation) The Evaluation instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
The \href{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/AccessControlList.html}{AccessControlList} response object as a named list.
}
\section{Errors}{
- An error is raised if the evaluation's \code{id} is not set.\cr
- An error is also raised if the service rejects the request or an HTTP error occurs.
}
\examples{
\dontrun{
## Get the ACL for an evaluation
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

    # Get the evaluation back from Synapse
    evaluations = synGetEvaluationsByProject(
        project_id = PROJECT_ID,
        evaluation_ids = list(evaluation$id)
    )
    evaluation = evaluations[[1]]

    # Get the ACL for the evaluation
    acl = evaluation |> synGetAcl()
    acl
}
}
\keyword{Evaluation}
