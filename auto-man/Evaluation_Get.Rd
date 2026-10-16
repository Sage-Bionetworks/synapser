%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGet}
\alias{Evaluation_synGet}
\docType{methods}
\title{
Evaluation :  get
}
\description{
Get this Evaluation from Synapse by its ID or name.
}
\usage{
synGet(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Evaluation) The Evaluation instance to operate on.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The retrieved Evaluation object.
}
\section{Errors}{
ValueError: If neither id nor name is set.
    SynapseHTTPError: If the service rejects the request or an HTTP error occurs.
}
\examples{
\dontrun{
## Get an evaluation by ID and by name

    from synapseclient.models import Evaluation
    from synapseclient import Synapse
    import asyncio

    syn = Synapse()
    syn.login()

    async def get_evaluations():
        # Get an evaluation by ID
        evaluation_by_id = await Evaluation(id="9999999").get_async()

        # Get an evaluation by name
        evaluation_by_name = await Evaluation(name="My Challenge Evaluation").get_async()

        return evaluation_by_id, evaluation_by_name

    evaluation_by_id, evaluation_by_name = asyncio.run(get_evaluations())
}
}
\keyword{Evaluation}
