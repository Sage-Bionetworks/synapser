%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synBatchUpdateSubmissionStatuses}
\alias{synBatchUpdateSubmissionStatuses}
\docType{methods}
\title{
SubmissionStatus :  batch_update_submission_statuses
}
\description{
Update multiple SubmissionStatuses. The maximum batch size is 500.
}
\usage{
synBatchUpdateSubmissionStatuses(instance, evaluation_id, statuses, is_first_batch=TRUE, is_last_batch=TRUE, batch_token=NULL, synapse_client=NULL)
}
\arguments{
\item{instance}{(SubmissionStatus) The SubmissionStatus instance to operate on.}
\item{evaluation_id}{(str) The ID of the Evaluation to which the SubmissionStatus objects belong.}
\item{statuses}{(list[SubmissionStatus]) List of SubmissionStatus objects to update.}
\item{is_first_batch}{(bool) Boolean indicating if this is the first batch in the series. Default True.}
\item{is_last_batch}{(bool) Boolean indicating if this is the last batch in the series. Default True.}
\item{batch_token}{(Optional[str]) Token from previous batch response (required for all but first batch).}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
A BatchUploadResponse object as a JSON dict containing the batch token
    and other response information.
}
\examples{
\dontrun{
## Batch update submission statuses
    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import SubmissionStatus

    syn = Synapse()
    syn.login()

    async def main():
        # Retrieve existing statuses to update
        statuses = await SubmissionStatus.get_all_submission_statuses_async(
            evaluation_id="9999999",
            status="RECEIVED"
            )

        # Modify statuses as needed
        for status in statuses:
            status.status = "SCORED"

        # Update statuses in batch
        response = await SubmissionStatus.batch_update_submission_statuses_async(
            evaluation_id="9999999",
            statuses=statuses,
            is_first_batch=True,
            is_last_batch=True
        )
        print(f"Batch update completed: {response}")

    asyncio.run(main())
}
}
\keyword{SubmissionStatus}
