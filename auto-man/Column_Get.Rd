%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGet}
\alias{Column_synGet}
\docType{methods}
\title{
Column :  get
}
\description{
Get a column by its ID.
}
\usage{
synGet(instance, synapse_client=NULL)
}
\arguments{
\item{instance}{(Column) The Column instance to operate on.}
\item{synapse_client}{(Optional[ForwardRef('Synapse')]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
The Column instance.
}
\examples{
\dontrun{
## Getting a column by ID
    Getting a column by ID

        import asyncio
        from synapseclient import Synapse
        from synapseclient.models import Column

        syn = Synapse()
        syn.login()

        async def get_column():
            column = await Column(id="123").get_async()
            print(column.name)

        asyncio.run(get_column())
}
}
\keyword{Column}
