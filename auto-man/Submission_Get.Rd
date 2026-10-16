%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGet}
\alias{Submission_synGet}
\docType{methods}
\title{
Submission :  get
}
\description{
Retrieve a Submission from Synapse.
}
\usage{
synGet(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Submission) The Submission instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The Submission instance retrieved from Synapse.
}
\section{Errors}{
ValueError: If the submission does not have an ID to get.
}
\examples{
\dontrun{
## Retrieving a submission by ID
    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import Submission

    syn = Synapse()
    syn.login()

    async def get_submission_example():

        submission = await Submission(id="9999999").get_async()
        print(submission)

    asyncio.run(get_submission_example())
}
}
\keyword{Submission}
