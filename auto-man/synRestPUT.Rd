%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synRestPUT}
\alias{synRestPUT}
\docType{methods}
\title{
synRestPUT
}
\description{
Sends an HTTP PUT request to the Synapse server.

Arguments:
    uri: URI on which get is performed
    endpoint: Server endpoint, defaults to self.repoEndpoint
    body: The payload to be delivered
    headers: Dictionary of headers to use rather than the API-key-signed default set of headers
    requests_session: An external [requests.Session object](https://requests.readthedocs.io/en/latest/user/advanced/) to use when making this specific call
    kwargs: Any other arguments taken by a [request](http://docs.python-requests.org/en/latest/) method

Returns
    JSON encoding of response
}
\usage{
synRestPUT(uri, body=NULL, endpoint=NULL, headers=NULL, retryPolicy=list(), requests_session=NULL)
}
\arguments{
\item{uri}{}
\item{body}{}
\item{endpoint}{}
\item{headers}{}
\item{retryPolicy}{}
\item{requests_session}{}
}
\value{

}


