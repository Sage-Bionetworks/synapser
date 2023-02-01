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
\item{repoEndpoint}{          Location of synapse repository\cr
}
\item{authEndpoint}{          Location of authentication service\cr
}
\item{fileHandleEndpoint}{    Location of file service\cr
}
\item{portalEndpoint}{        Location of the website\cr
}
\item{skip_checks}{           Skip version and endpoint checks}
}




