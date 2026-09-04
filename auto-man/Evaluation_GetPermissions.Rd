%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetPermissions}
\alias{synGetPermissions}
\docType{methods}
\title{
Evaluation :  get_permissions
}
\description{
Get the user permissions for this evaluation.
}
\usage{
synGetPermissions(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Evaluation) The Evaluation instance to operate on.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
dict: The permissions for the specified user.
}
\section{Errors}{
ValueError: If evaluation_id is not set.
    SynapseHTTPError: If the service rejects the request or an HTTP error occurs.
}
\examples{
\dontrun{
## Get permissions for the current user

    from synapseclient.models import Evaluation
    from synapseclient import Synapse
    import asyncio

    syn = Synapse()
    syn.login()

    async def get_evaluation_permissions():
        # Get the evaluation first
        evaluation = await Evaluation(id="9999999").get_async()

        # Get the permissions for the current user
        my_permissions = await evaluation.get_permissions_async()
        return my_permissions

    my_permissions = asyncio.run(get_evaluation_permissions())
}
}
\keyword{Evaluation}
