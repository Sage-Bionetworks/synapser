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
synRestDELETE(uri, endpoint=NULL, headers=NULL, retryPolicy=list(), ...)
}
\arguments{
\item{uri}{      URI of resource to be deleted\cr
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




