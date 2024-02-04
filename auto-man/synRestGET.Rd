%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synRestGET}
\alias{synRestGET}
\docType{methods}
\title{
synRestGET
}
\description{
Sends an HTTP GET request to the Synapse server.

Arguments:
    uri: URI on which get is performed
    endpoint: Server endpoint, defaults to self.repoEndpoint
    headers: Dictionary of headers to use rather than the API-key-signed default set of headers
    requests_session: An external [requests.Session object](https://requests.readthedocs.io/en/latest/user/advanced/) to use when making this specific call
    kwargs: Any other arguments taken by a [request](http://docs.python-requests.org/en/latest/) method

Returns:
    JSON encoding of response
}
\usage{
synRestGET(uri, endpoint=NULL, headers=NULL, retryPolicy=list(), requests_session=NULL)
}
\arguments{
\item{uri}{}
\item{endpoint}{}
\item{headers}{}
\item{retryPolicy}{}
\item{requests_session}{}
}
\value{

}


