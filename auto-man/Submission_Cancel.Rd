%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synCancel}
\alias{synCancel}
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
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The updated Submission object.
}
\section{Errors}{
ValueError: If the submission does not have an ID to cancel.
}
\examples{
\dontrun{
## Cancel a submission
    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Submission

    syn = Synapse()
    syn.login()

    async def cancel_submission_example():
        submission = Submission(id="syn1234")
        canceled_submission = await submission.cancel_async()
        print(f"Canceled submission: {canceled_submission.id}")

    # Run the async function
    asyncio.run(cancel_submission_example())
}
}
\keyword{Submission}
