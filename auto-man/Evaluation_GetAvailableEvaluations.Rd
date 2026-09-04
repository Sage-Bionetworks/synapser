%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetAvailableEvaluations}
\alias{synGetAvailableEvaluations}
\docType{methods}
\title{
Evaluation :  get_available_evaluations
}
\description{
Get a list of Evaluations to which the user has SUBMIT permission, within a given range.
}
\usage{
synGetAvailableEvaluations(instance, active_only=NULL, evaluation_ids=NULL, offset=NULL, limit=NULL, synapse_client=NULL)
}
\arguments{
\item{instance}{(Evaluation) The Evaluation instance to operate on.}
\item{active_only}{(Optional[bool]) If True then return only those evaluations with rounds defined and for which the current time is in one of the rounds.}
\item{evaluation_ids}{(Optional[list[str]]) An optional list of evaluation IDs to which the response is limited.}
\item{offset}{(Optional[int]) The offset index determines where this page will start from. An index of 0 is the first entity. When null it will default to 0.}
\item{limit}{(Optional[int]) Limits the number of entities that will be fetched for this page. When null it will default to 10.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
List[Evaluation]: A list of available evaluations.
}
\section{Errors}{
SynapseHTTPError: If the service rejects the request or an HTTP error occurs.
}
\examples{
\dontrun{
## Example 1: Get all evaluations where the current user has SUBMIT permission
    # A default call will return evaluations where the user has SUBMIT permission, without needing to specify access type.
    from synapseclient.models import Evaluation
    from synapseclient import Synapse
    import asyncio

    syn = Synapse()
    syn.login()

    async def get_available_evaluations():
        available_evaluations = await Evaluation.get_available_evaluations_async()
        return available_evaluations

    available_evaluations = asyncio.run(get_available_evaluations())

## Example 2: Get only active evaluations where the current user has SUBMIT permission

    from synapseclient.models import Evaluation
    from synapseclient import Synapse
    import asyncio

    syn = Synapse()
    syn.login()

    async def get_active_available_evaluations():
        active_available_evaluations = await Evaluation.get_available_evaluations_async(
            active_only=True
        )
        return active_available_evaluations

    active_available_evaluations = asyncio.run(get_active_available_evaluations())

## Example 3: Get the first 5 evaluations where the current user has SUBMIT permission

    from synapseclient.models import Evaluation
    from synapseclient import Synapse
    import asyncio

    syn = Synapse()
    syn.login()

    async def get_limited_evaluations():
        limited_evaluations = await Evaluation.get_available_evaluations_async(
            limit=5
        )
        return limited_evaluations

    limited_evaluations = asyncio.run(get_limited_evaluations())
}
}
\keyword{Evaluation}
