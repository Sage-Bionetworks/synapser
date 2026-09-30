\name{synRestDelete}
\alias{synRestDelete}
\docType{methods}
\title{
synRestDelete
}
\description{
Sends an HTTP DELETE request to the Synapse server.
}
\usage{
synRestDelete(uri, endpoint=NULL, headers=NULL, retry_policy=list(), requests_session_async_synapse=NULL, kwargs=NULL)
}
\arguments{
\item{uri}{(str) URI of resource to be deleted}
\item{endpoint}{(str) Server endpoint, defaults to the client's configured repository endpoint (see \code{\link[=synSetEndpoints]{synSetEndpoints}()}).}
\item{headers}{(Headers) Named list of headers to use.}
\item{retry_policy}{(dict[str, Any]) A retry policy (named list) whose keys should match the parameters of \href{https://python-docs.synapse.org/reference/core/}{with_retry_time_based_async}, the underlying Python client's retry mechanism.}
\item{requests_session_async_synapse}{(AsyncClient) The async client to use when making this specific call}
\item{kwargs}{optional named parameter: Any other arguments taken by a \href{https://www.python-httpx.org/api/}{request} method}
}
\value{
NULL
}
\note{
This wraps synapseclient's \code{rest_delete_async()}, which is a Python
\code{async} coroutine method. Calling \code{synRestDelete()} does not run
that coroutine -- it returns an unresolved Python coroutine object, since
reticulate does not automatically await coroutines. To get the actual
result, resolve the returned coroutine yourself with Python's
\code{asyncio.run()} via reticulate, as shown in the example below.
}
\examples{
\dontrun{
## Using this function
    # For ordinary entity deletion, prefer the higher-level synDelete()
    # function instead -- e.g. synDelete("syn123456"). Reach for
    # synRestDelete() only for REST endpoints that don't have a
    # higher-level model wrapper.
    library(synapser)
    synLogin()

    asyncio = reticulate::import("asyncio")

    coro = synRestDelete(uri = "/entity/syn123456")
    response = asyncio$run(coro)
    response
}
}
