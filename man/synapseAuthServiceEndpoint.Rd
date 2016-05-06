\name{synapseAuthServiceEndpoint}
\alias{synapseAuthServiceEndpoint}
\alias{synapseRepoServiceEndpoint}
\alias{synapseFileServiceEndpoint}
\alias{synapsePortalEndpoint}
\alias{synapseResetEndpoints}
\title{
Synapse Endpoints
}
\description{
Manage the Synapse endpoints
}
\usage{
synapseAuthServiceEndpoint(endpoint)
synapseRepoServiceEndpoint(endpoint)
synapseFileServiceEndpoint(endpoint)
synapsePortalEndpoint(endpoint)
synapseResetEndpoints()
}
\arguments{
  \item{endpoint}{
The desired service endpoint
}
}
\details{
If called with no arguments, get the desired endpoint. Otherwise, set the endpoint to the value provided.

synapseResetEndpoints sets the four endpoints to their default values.
}
\value{
If called with no arguments, all but synapseResetEndpoints return the value of the endpoint.
}
\author{
Matt Furia
}

\seealso{
\code{\link{synapseLogin}}
}
