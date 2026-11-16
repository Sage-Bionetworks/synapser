%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synStore}
\alias{SubmissionStatus_synStore}
\docType{methods}
\title{
SubmissionStatus :  store
}
\description{
Store (update) the SubmissionStatus in Synapse.
}
\usage{
synStore(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(SubmissionStatus) The SubmissionStatus instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The updated SubmissionStatus object.
}
\section{Errors}{
ValueError: If the submission status is missing required fields.
}
\examples{
\dontrun{
## Update a submission status
    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import SubmissionStatus

    syn = Synapse()
    syn.login()

    async def main():
        # Get existing status
        status = await SubmissionStatus(id="9999999").get_async()

        # Update fields
        status.status = "SCORED"
        status.submission_annotations = {"score": [85.5]}

        # Store the update
        status = await status.store_async()
        print(f"Updated status: {status.status}")

    asyncio.run(main())
}
}
\keyword{SubmissionStatus}
