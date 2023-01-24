%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synRestDELETE}
\alias{synRestDELETE}
\docType{methods}
\title{
synRestDELETE
}
\description{
Sends an HTTP DELETE request to the Synapse server.
}
\usage{
synRestDELETE(uri, endpoint=NULL, headers=NULL, retryPolicy=list(), requests_session=NULL, kwargs=NULL)
}
\arguments{
\item{uri}{                 URI of resource to be deleted\cr
}
\item{endpoint}{            Server endpoint, defaults to self.repoEndpoint\cr
}
\item{headers}{             Dictionary of headers to use rather than the API-key-signed default set of headers\cr
}
\item{retryPolicy}{}
\item{requests_session}{    an external requests.session object to use when making this specific call\cr
}
\item{kwargs}{optional named parameter:               Any other arguments taken by a\cr
                            \href{http://docs.python-requests.org/en/latest/}{requests} method}
}
\value{

}


