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

Arguments:
    uri: URI on which get is performed
    body: The payload to be delivered.
    endpoint: Server endpoint, defaults to self.repoEndpoint
    headers: Dictionary of headers to use.
    retry_policy: A retry policy that matches the arguments of
        [synapseclient.core.retry.with_retry_time_based_async][].
    requests_session_async_synapse: The async client to use when making this
        specific call.
    kwargs: Any other arguments taken by a
        [request](https://www.python-httpx.org/api/) method

Returns
    JSON encoding of response
}
\usage{
synRestPutAsync(uri, body=NULL, endpoint=NULL, headers=NULL, retry_policy=list(), requests_session_async_synapse=NULL)
}
\arguments{
\item{uri}{}
\item{body}{}
\item{endpoint}{}
\item{headers}{}
\item{retry_policy}{}
\item{requests_session_async_synapse}{}
}
\value{

}


