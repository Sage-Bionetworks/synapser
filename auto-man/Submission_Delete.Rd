%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synDelete}
\alias{Submission_synDelete}
\docType{methods}
\title{
Submission :  delete
}
\description{
Delete a Submission from Synapse.
}
\usage{
synDelete(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Submission) The Submission instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
NULL
}
\section{Errors}{
ValueError: If the submission does not have an ID to delete.
}
\examples{
\dontrun{
## Delete a submission
    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Submission

    syn = Synapse()
    syn.login()

    async def delete_submission_example():
        submission = Submission(id="9999999")
        await submission.delete_async()
        print("Submission deleted successfully")

    # Run the async function
    asyncio.run(delete_submission_example())
}
}
\keyword{Submission}
