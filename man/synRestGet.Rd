\name{synRestGet}
\alias{synRestGet}
\docType{methods}
\title{
synRestGet
}
\description{
Sends an HTTP GET request to the Synapse server.
}
\usage{
synRestGet(uri, endpoint=NULL, headers=NULL, retry_policy=list(), requests_session_async_synapse=NULL, kwargs=NULL)
}
\arguments{
\item{uri}{(str) URI on which get is performed}
\item{endpoint}{(str) Server endpoint, defaults to the client's configured repository endpoint (see \code{\link[=synSetEndpoints]{synSetEndpoints}()}).}
\item{headers}{(Headers) Named list of headers to use.}
\item{retry_policy}{(dict[str, Any]) A retry policy (named list) whose keys should match the parameters of \href{https://python-docs.synapse.org/reference/core/}{with_retry_time_based_async}, the underlying Python client's retry mechanism.}
\item{requests_session_async_synapse}{(AsyncClient) The async client to use when making this specific call.}
\item{kwargs}{optional named parameter: Any other arguments taken by a \href{https://www.python-httpx.org/api/}{request} method}
}
\value{
JSON encoding of response
}
\examples{
\dontrun{
## Using this function
    library(synapser)
    synLogin()

    # Low-level REST access to an entity's raw JSON, bypassing the synGet() model wrapper
    response = synRestGet(uri = "/entity/syn123456")
    response
}
}
