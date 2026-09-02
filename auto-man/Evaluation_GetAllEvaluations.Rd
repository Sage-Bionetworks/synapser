%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetAllEvaluations}
\alias{synGetAllEvaluations}
\docType{methods}
\title{
Evaluation :  get_all_evaluations
}
\description{
Get a list of all Evaluations, within a given range.
}
\usage{
synGetAllEvaluations(instance, access_type=NULL, active_only=NULL, evaluation_ids=NULL, offset=NULL, limit=NULL, synapse_client=NULL)
}
\arguments{
\item{instance}{(Evaluation) The Evaluation instance to operate on.}
\item{access_type}{(Optional[str]) The type of access for the user to filter for, optional and defaults to ACCESS_TYPE.READ.}
\item{active_only}{(Optional[bool]) If True then return only those evaluations with rounds defined and for which the current time is in one of the rounds.}
\item{evaluation_ids}{(Optional[list[str]]) An optional list of evaluation IDs to which the response is limited.}
\item{offset}{(Optional[int]) The offset index determines where this page will start from. An index of 0 is the first entity. When null it will default to 0.}
\item{limit}{(Optional[int]) Limits the number of entities that will be fetched for this page. When null it will default to 10.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
List[Evaluation]: A list of all evaluations.
}
\section{Errors}{
SynapseHTTPError: If the service rejects the request or an HTTP error occurs.
}
\examples{
\dontrun{
## Example 1: Get all evaluations the user has at least READ access to
    # A default call will return evaluations where the user has read access, without needing to specify access type.
    from synapseclient.models import Evaluation
    from synapseclient import Synapse
    import asyncio

    syn = Synapse()
    syn.login()

    async def get_all_evaluations():
        all_evaluations = await Evaluation.get_all_evaluations_async()
        return all_evaluations

    all_evaluations = asyncio.run(get_all_evaluations())

## Example 2: Get only active evaluations with a limit

    from synapseclient.models import Evaluation
    from synapseclient import Synapse
    import asyncio

    syn = Synapse()
    syn.login()

    async def get_active_evaluations():
        active_evaluations = await Evaluation.get_all_evaluations_async(
            active_only=True,
            limit=20
        )
        return active_evaluations

    active_evaluations = asyncio.run(get_active_evaluations())

## Example 3: Get specific evaluations by ID

    from synapseclient.models import Evaluation
    from synapseclient import Synapse
    import asyncio

    syn = Synapse()
    syn.login()

    async def get_specific_evaluations():
        specific_evaluations = await Evaluation.get_all_evaluations_async(
            evaluation_ids=["9999991", "9999992"]
        )
        return specific_evaluations

    specific_evaluations = asyncio.run(get_specific_evaluations())
}
}
\keyword{Evaluation}
