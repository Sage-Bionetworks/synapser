\name{synRestPut}
\alias{synRestPut}
\docType{methods}
\title{
synRestPut
}
\description{
Sends an HTTP PUT request to the Synapse server.
}
\usage{
synRestPut(uri, body=NULL, endpoint=NULL, headers=NULL, retry_policy=list(), requests_session_async_synapse=NULL, kwargs=NULL)
}
\arguments{
\item{uri}{(str) URI on which the request is performed}
\item{body}{(Any) The payload to be delivered, as a JSON-encoded string (e.g. via \code{rjson::toJSON()}). This is passed straight through to the underlying HTTP client's \code{content} argument, which only accepts a string or raw bytes -- passing a named list/dict directly will fail with \code{TypeError: Unexpected type for 'content'}.}
\item{endpoint}{(str) Server endpoint, defaults to the client's configured repository endpoint (see \code{\link[=synSetEndpoints]{synSetEndpoints}()}).}
\item{headers}{(Headers) Named list of headers to use.}
\item{retry_policy}{(dict[str, Any]) A retry policy (named list) whose keys should match the parameters of \href{https://python-docs.synapse.org/reference/core/}{with_retry_time_based_async}, the underlying Python client's retry mechanism.}
\item{requests_session_async_synapse}{(AsyncClient) The async client to use when making this specific call.}
\item{kwargs}{optional named parameter: Any other arguments taken by a \href{https://www.python-httpx.org/api/}{request} method}
}
\value{
JSON encoding of response
}
\note{
This wraps synapseclient's \code{rest_put_async()}, which is a Python
\code{async} coroutine method. Calling \code{synRestPut()} does not run
that coroutine -- it returns an unresolved Python coroutine object, since
reticulate does not automatically await coroutines. To get the actual
response, resolve the returned coroutine yourself with Python's
\code{asyncio.run()} via reticulate, as shown in the example below.
}
\examples{
\dontrun{
## Using this function
    # For ordinary entity updates, prefer the higher-level synSetProperties()
    # / synStore() functions instead -- they handle this fetch-modify-store
    # cycle for you. Reach for synRestPut() only for REST endpoints that
    # don't have a higher-level model wrapper.
    library(synapser)
    synLogin()

    asyncio = reticulate::import("asyncio")

    # Fetch the entity's current properties first
    get_coro = synRestGet(uri = "/entity/syn123456")
    entity_properties = asyncio$run(get_coro)

    # Modify the field(s) you want to change
    entity_properties$name = "New Name"

    # The body must be a JSON-encoded string, not a named list -- it is passed
    # straight through to the underlying HTTP client's `content` argument,
    # which only accepts a string or raw bytes.
    put_coro = synRestPut(uri = "/entity/syn123456", body = rjson::toJSON(entity_properties))
    response = asyncio$run(put_coro)
    response
}
}
