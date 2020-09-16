%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synRestPOST}
\alias{synRestPOST}
\docType{methods}
\title{
synRestPOST
}
\description{
Sends an HTTP POST request to the Synapse server.
}
\usage{
synRestPOST(uri, body, endpoint=NULL, headers=NULL, retryPolicy=list(), requests_session=NULL, kwargs=NULL)
}
\arguments{
\item{uri}{                 URI on which get is performed\cr
}
\item{body}{                The payload to be delivered\cr
}
\item{endpoint}{            Server endpoint, defaults to self.repoEndpoint\cr
}
\item{headers}{             Dictionary of headers to use rather than the API-key-signed default set of headers\cr
}
\item{retryPolicy}{}
\item{requests_session}{    an external requests.Session object to use when making this specific call\cr
}
\item{kwargs}{optional named parameter:               Any other arguments taken by a\cr
                            \href{http://docs.python-requests.org/en/latest/}{requests} method}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
 JSON encoding of response
}
\references{
% A section with references to the literature. Use \url{} or \href{}{} for web pointers.
}
\note{
% Use this for a special note you want to have pointed out. 
}
\seealso{
% Pointers to related R objects, using \code{\link{...}} to refer to them.
}
% Examples of how to use the function. 
% Examples are not only useful for documentation purposes, but also provide test code used for diagnostic checking of R code. 
% By default, text will be displayed in the output of the help page and run by example() and by R CMD check. 
% You can use \dontrun{} for text that should only be shown, but not run, and \dontshow{} for extra commands 
% for testing that should not be shown to users, but will be run by example(). 
\examples{

}



