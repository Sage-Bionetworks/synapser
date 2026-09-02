%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetEvaluationsByProject}
\alias{synGetEvaluationsByProject}
\docType{methods}
\title{
Evaluation :  get_evaluations_by_project
}
\description{
Get Evaluations tied to a project.
}
\usage{
synGetEvaluationsByProject(instance, project_id, access_type=NULL, active_only=NULL, evaluation_ids=NULL, offset=NULL, limit=NULL, synapse_client=NULL)
}
\arguments{
\item{instance}{(Evaluation) The Evaluation instance to operate on.}
\item{project_id}{(str) The ID of the project (e.g., "syn123456").}
\item{access_type}{(Optional[str]) The type of access for the user to filter for, optional and defaults to ACCESS_TYPE.READ.}
\item{active_only}{(Optional[bool]) If True then return only those evaluations with rounds defined and for which the current time is in one of the rounds.}
\item{evaluation_ids}{(Optional[list[str]]) An optional list of evaluation IDs to which the response is limited.}
\item{offset}{(Optional[int]) The offset index determines where this page will start from. An index of 0 is the first entity. When null it will default to 0.}
\item{limit}{(Optional[int]) Limits the number of entities that will be fetched for this page. When null it will default to 10.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
List[Evaluation]: A list of Evaluations tied to the project.
}
\section{Errors}{
SynapseHTTPError: If the service rejects the request or an HTTP error occurs.
}
\examples{
\dontrun{
## Example 1: Get all evaluations for a project
    # The user must have at least READ access to the evaluations to retrieve the evaluations from a given project.
    from synapseclient.models import Evaluation
    from synapseclient import Synapse
    import asyncio

    syn = Synapse()
    syn.login()

    async def get_project_evaluations():
        project_evaluations = await Evaluation.get_evaluations_by_project_async(
            project_id="syn123456"
        )
        return project_evaluations

    project_evaluations = asyncio.run(get_project_evaluations())

## Example 2: Get only active evaluations for a project

    from synapseclient.models import Evaluation
    from synapseclient import Synapse
    import asyncio

    syn = Synapse()
    syn.login()

    async def get_active_project_evaluations():
        active_project_evaluations = await Evaluation.get_evaluations_by_project_async(
            project_id="syn123456",
            active_only=True
        )
        return active_project_evaluations

    active_project_evaluations = asyncio.run(get_active_project_evaluations())

## Example 3: Get a limited set of evaluations for a project

    from synapseclient.models import Evaluation
    from synapseclient import Synapse
    import asyncio

    syn = Synapse()
    syn.login()

    async def get_limited_project_evaluations():
        limited_project_evaluations = await Evaluation.get_evaluations_by_project_async(
            project_id="syn123456",
            limit=5
        )
        return limited_project_evaluations

    limited_project_evaluations = asyncio.run(get_limited_project_evaluations())
}
}
\keyword{Evaluation}
