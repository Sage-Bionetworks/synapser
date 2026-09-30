\name{synRestPost}
\alias{synRestPost}
\docType{methods}
\title{
synRestPost
}
\description{
Sends an HTTP POST request to the Synapse server.
}
\usage{
synRestPost(uri, body=NULL, endpoint=NULL, headers=NULL, retry_policy=list(), requests_session_async_synapse=NULL, kwargs=NULL)
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
This wraps synapseclient's \code{rest_post_async()}, which is a Python
\code{async} coroutine method. Calling \code{synRestPost()} does not run
that coroutine -- it returns an unresolved Python coroutine object, since
reticulate does not automatically await coroutines. To get the actual
response, resolve the returned coroutine yourself with Python's
\code{asyncio.run()} via reticulate, as shown in the example below.
}
\examples{
\dontrun{
## Using this function
    # For ordinary entity creation, prefer the higher-level constructors
    # and synStore() instead -- e.g. Folder(...) |> synStore(). Reach for
    # synRestPost() only for REST endpoints that don't have a higher-level
    # model wrapper.
    library(synapser)
    synLogin()

    asyncio = reticulate::import("asyncio")

    new_folder_properties = list(
        name = "My New Folder",
        parentId = "syn123456",
        concreteType = "org.sagebionetworks.repo.model.Folder"
    )
    post_coro = synRestPost(uri = "/entity", body = rjson::toJSON(new_folder_properties))
    response = asyncio$run(post_coro)
    response
}
}
