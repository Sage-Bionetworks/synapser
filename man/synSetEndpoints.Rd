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
    # To switch between staging and production endpoints
    library(synapser)

    synSetEndpoints(
        repoEndpoint = "https://repo-staging.prod.sagebase.org/repo/v1",
        authEndpoint = "https://auth-staging.prod.sagebase.org/auth/v1",
        fileHandleEndpoint = "https://file-staging.prod.sagebase.org/file/v1",
        portalEndpoint = "https://staging.synapse.org/"
    )

    synSetEndpoints(
        repoEndpoint = "https://repo-prod.prod.sagebase.org/repo/v1",
        authEndpoint = "https://auth-prod.prod.sagebase.org/auth/v1",
        fileHandleEndpoint = "https://file-prod.prod.sagebase.org/file/v1",
        portalEndpoint = "https://www.synapse.org/"
    )
}
}
