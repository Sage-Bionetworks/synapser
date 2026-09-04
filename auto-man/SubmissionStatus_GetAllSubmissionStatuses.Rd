%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetAllSubmissionStatuses}
\alias{synGetAllSubmissionStatuses}
\docType{methods}
\title{
SubmissionStatus :  get_all_submission_statuses
}
\description{
Gets a collection of SubmissionStatuses to a specified Evaluation.
}
\usage{
synGetAllSubmissionStatuses(instance, evaluation_id, status=NULL, limit=10L, offset=0L, synapse_client=NULL)
}
\arguments{
\item{instance}{(SubmissionStatus) The SubmissionStatus instance to operate on.}
\item{evaluation_id}{(str) The ID of the specified Evaluation.}
\item{status}{(Optional[str]) Optionally filter submission statuses by status.}
\item{limit}{(int) Limits the number of entities that will be fetched for this page. When null it will default to 10, max value 100. Default to 10.}
\item{offset}{(int) The offset index determines where this page will start from. An index of 0 is the first entity. Default to 0.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
A list of SubmissionStatus objects for the evaluation queue.
}
\examples{
\dontrun{
## Getting all submission statuses for an evaluation
    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import SubmissionStatus

    syn = Synapse()
    syn.login()

    async def main():
        statuses = await SubmissionStatus.get_all_submission_statuses_async(
            evaluation_id="9999999",
            status="SCORED",
            limit=50
        )
        print(f"Found {len(statuses)} submission statuses")
        for status in statuses:
            print(f"Status ID: {status.id}, Status: {status.status}")

    asyncio.run(main())
}
}
\keyword{SubmissionStatus}
