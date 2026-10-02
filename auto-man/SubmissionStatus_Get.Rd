%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGet}
\alias{SubmissionStatus_synGet}
\docType{methods}
\title{
SubmissionStatus :  get
}
\description{
Retrieve a SubmissionStatus from Synapse.
}
\usage{
synGet(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(SubmissionStatus) The SubmissionStatus instance to operate on.}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The SubmissionStatus instance retrieved from Synapse.
}
\section{Errors}{
ValueError: If the submission status does not have an ID to get.
}
\examples{
\dontrun{
## Retrieving a submission status by ID
    import asyncio
    from synapseclient import Synapse
    from synapseclient.models import SubmissionStatus

    syn = Synapse()
    syn.login()

    async def main():
        status = await SubmissionStatus(id="9999999").get_async()
        print(status)

    asyncio.run(main())
}
}
\keyword{SubmissionStatus}
