%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetAcl}
\alias{synGetAcl}
\docType{methods}
\title{
Evaluation :  get_acl
}
\description{
Get the access control list (ACL) governing this evaluation.
}
\usage{
synGetAcl(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Evaluation) The Evaluation instance to operate on.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The AccessControlList response object as a raw JSON dict.
}
\section{Errors}{
ValueError: If evaluation_id is not set.
    SynapseHTTPError: If the service rejects the request or an HTTP error occurs.
}
\examples{
\dontrun{
## Get the ACL for an evaluation

    from synapseclient.models import Evaluation
    from synapseclient import Synapse
    import asyncio

    syn = Synapse()
    syn.login()

    async def get_evaluation_acl():
        # Get the evaluation first
        evaluation = await Evaluation(id="9999999").get_async()

        # Get the ACL for the evaluation
        acl = await evaluation.get_acl_async()
        return acl

    acl = asyncio.run(get_evaluation_acl())
}
}
\keyword{Evaluation}
