%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synRestDeleteAsync}
\alias{synRestDeleteAsync}
\docType{methods}
\title{
synRestDeleteAsync
}
\description{
Sends an HTTP DELETE request to the Synapse server.
}
\usage{
synRestDeleteAsync(uri, endpoint=NULL, headers=NULL, retry_policy=list(), requests_session_async_synapse=NULL, kwargs=NULL)
}
\arguments{
\item{uri}{(str) URI of resource to be deleted}
\item{endpoint}{(str) Server endpoint, defaults to self.repoEndpoint}
\item{headers}{(Headers) Dictionary of headers to use.}
\item{retry_policy}{(dict[str, Any]) A retry policy that matches the arguments of \code{\link[=synWithRetryTimeBased]{synWithRetryTimeBased}}.}
\item{requests_session_async_synapse}{(AsyncClient) The async client to use when making this specific call}
\item{kwargs}{optional named parameter: Any other arguments taken by a \href{https://www.python-httpx.org/api/}{request} method}
}
\value{
NULL
}
\keyword{}
