%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synRestGetAsync}
\alias{synRestGetAsync}
\docType{methods}
\title{
synRestGetAsync
}
\description{
Sends an HTTP GET request to the Synapse server.

Arguments:
    uri: URI on which get is performed
    endpoint: Server endpoint, defaults to self.repoEndpoint
    headers: Dictionary of headers to use.
    retry_policy: A retry policy that matches the arguments of
        [synapseclient.core.retry.with_retry_time_based_async][].
    requests_session_async_synapse: The async client to use when making this
        specific call.
    kwargs: Any other arguments taken by a
        [request](https://www.python-httpx.org/api/) method

Returns:
    JSON encoding of response
}
\usage{
synRestGetAsync(uri, endpoint=NULL, headers=NULL, retry_policy=list(), requests_session_async_synapse=NULL)
}
\arguments{
\item{uri}{}
\item{endpoint}{}
\item{headers}{}
\item{retry_policy}{}
\item{requests_session_async_synapse}{}
}
\value{

}


