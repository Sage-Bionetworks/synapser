%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synSetEndpoints}
\alias{synSetEndpoints}
\docType{methods}
\title{
synSetEndpoints
}
\description{
Sets the locations for each of the Synapse services (mostly useful for testing).
}
\usage{
synSetEndpoints(repoEndpoint=NULL, authEndpoint=NULL, fileHandleEndpoint=NULL, portalEndpoint=NULL, skip_checks=FALSE)
}
\arguments{
\item{repoEndpoint}{(str) Location of synapse repository}
\item{authEndpoint}{(str) Location of authentication service}
\item{fileHandleEndpoint}{(str) Location of file service}
\item{portalEndpoint}{(str) Location of the website}
\item{skip_checks}{(bool) Skip version and endpoint checks}
}
\value{
NULL
}
\examples{
\dontrun{
## Switching endpoints
    To switch between staging and production endpoints

        syn.setEndpoints(**synapseclient.client.STAGING_ENDPOINTS)
        syn.setEndpoints(**synapseclient.client.PRODUCTION_ENDPOINTS)
}
}
\keyword{}
