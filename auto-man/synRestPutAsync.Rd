%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synRestPutAsync}
\alias{synRestPutAsync}
\docType{methods}
\title{
synRestPutAsync
}
\description{
Sends an HTTP PUT request to the Synapse server.
}
\usage{
synRestPutAsync(uri, body=NULL, endpoint=NULL, headers=NULL, retry_policy=list(), requests_session_async_synapse=NULL, kwargs=NULL)
}
\arguments{
\item{uri}{(str) URI on which get is performed}
\item{body}{(Any) The payload to be delivered.}
\item{endpoint}{(str) Server endpoint, defaults to self.repoEndpoint}
\item{headers}{(Headers) Dictionary of headers to use.}
\item{retry_policy}{(dict[str, Any]) A retry policy that matches the arguments of \code{\link[=synWithRetryTimeBased]{synWithRetryTimeBased}}.}
\item{requests_session_async_synapse}{(AsyncClient) The async client to use when making this specific call.}
\item{kwargs}{optional named parameter: Any other arguments taken by a \href{https://www.python-httpx.org/api/}{request} method\cr
\cr
Returns JSON encoding of response}
}
\value{
NULL
}
\keyword{}
