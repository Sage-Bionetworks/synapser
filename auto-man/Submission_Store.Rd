%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synStore}
\alias{Submission_synStore}
\docType{methods}
\title{
Submission :  store
}
\description{
Store the submission in Synapse. This creates a new submission in an evaluation queue.
}
\usage{
synStore(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Submission) The Submission instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The Submission object with the ID set.
}
\section{Errors}{
ValueError: If the submission is missing required fields, or if unable to fetch entity etag.
}
\examples{
\dontrun{
## Creating a submission
    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Submission

    syn = Synapse()
    syn.login()

    async def create_submission_example():

        submission = Submission(
            entity_id="syn123456",
            evaluation_id="9999999",
            name="My Submission"
        )
        submission = await submission.store_async()
        print(submission.id)

    asyncio.run(create_submission_example())
}
}
\keyword{Submission}
