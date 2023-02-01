\name{synRestPUT}
\alias{synRestPUT}
\docType{methods}
\title{
synRestPUT
}
\description{
Sends an HTTP PUT request to the Synapse server.
}
\usage{
synRestPUT(uri, body=NULL, endpoint=NULL, headers=NULL, retryPolicy=list(), ...)
}
\arguments{
\item{uri}{      URI on which get is performed\cr
}
\item{body}{     The payload to be delivered\cr
}
\item{endpoint}{ Server endpoint.  The required endpoint is shown in each service's page in the REST API doc's (http://docs.synapse.org/rest).
 Options are: 'https://repo-prod.prod.sagebase.org/repo/v1' (the default), 'https://file-prod.prod.sagebase.org/file/v1'
 or 'https://file-prod.prod.sagebase.org/auth/v1'.\cr
}
\item{headers}{  named list of headers to use rather than the API-key-signed default set of headers\cr
}
\item{retryPolicy}{}
\item{...}{Any other arguments taken by a \href{http://docs.python-requests.org}{http://docs.python-requests.org} method}
}
\value{
 JSON encoding of response
}




