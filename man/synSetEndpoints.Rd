\name{synSetEndpoints}
\alias{synSetEndpoints}
\title{
synSetEndpoints
}

\usage{
synSetEndpoints()
synSetEndpoints(repoEndpoint, authEndpoint, fileEndpoint, portalEndpoint)
}
\arguments{
  \item{repoEndpoint}{
	The repository services endpoint.
  }
  \item{authEndpoint}{
	The authentication services endpoint.
  }
  \item{fileEndpoint}{
	The file services endpoint.
  }
  \item{portalEndpoint}{
	The portal (web client) endpoint.
  }

}
\details{
If called with no arguments, sets to the default values. Otherwise, set the endpoints to the values provided.
}
\seealso{
\code{\link{synGetEndpoints}}
}
