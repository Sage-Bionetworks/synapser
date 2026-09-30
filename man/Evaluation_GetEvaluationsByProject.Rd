\name{synGetEvaluationsByProject}
\alias{Evaluation_synGetEvaluationsByProject}
\docType{methods}
\title{
Evaluation :  get_evaluations_by_project
}
\description{
Get Evaluations tied to a project.
}
\usage{
synGetEvaluationsByProject(project_id, access_type=NULL, active_only=NULL, evaluation_ids=NULL, offset=NULL, limit=NULL, synapse_client=NULL)
}
\arguments{
\item{project_id}{(str) The ID of the project (e.g., "syn123456").}
\item{access_type}{(Optional[str]) The type of access for the user to filter for, optional and defaults to \code{"READ"}. See \href{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/ACCESS_TYPE.html}{ACCESS_TYPE} for the available values.}
\item{active_only}{(Optional[bool]) If TRUE then return only those evaluations with rounds defined and for which the current time is in one of the rounds.}
\item{evaluation_ids}{(Optional[list[str]]) An optional list of evaluation IDs to which the response is limited.}
\item{offset}{(Optional[int]) The offset index determines where this page will start from. An index of 0 is the first entity. When NULL it will default to 0.}
\item{limit}{(Optional[int]) Limits the number of entities that will be fetched for this page. When NULL it will default to 10.}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
A list of Evaluations tied to the project, as Evaluation objects.
}
\section{Errors}{
An error is raised if the service rejects the request or an HTTP error occurs.
}
\examples{
\dontrun{
## Example 1: Get all evaluations for a project
    # The user must have at least READ access to the evaluations to retrieve the evaluations from a given project.
    library(synapser)
    synLogin()

    project_evaluations = synGetEvaluationsByProject(
        project_id = "syn123456"
    )
    project_evaluations

## Example 2: Get only active evaluations for a project
    library(synapser)
    synLogin()

    active_project_evaluations = synGetEvaluationsByProject(
        project_id = "syn123456",
        active_only = TRUE
    )
    active_project_evaluations

## Example 3: Get a limited set of evaluations for a project
    library(synapser)
    synLogin()

    limited_project_evaluations = synGetEvaluationsByProject(
        project_id = "syn123456",
        limit = 5L
    )
    limited_project_evaluations
}
}
\keyword{Evaluation}
