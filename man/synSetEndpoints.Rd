\name{synSetEndpoints}
\alias{synSetEndpoints}
\docType{methods}
\title{
synSetEndpoints
}
\description{}
\usage{
	synSetEndpoints(repoEndpoint=NULL, authEndpoint=NULL, fileHandleEndpoint=NULL, portalEndpoint=NULL, skip_checks=FALSE)
}
\arguments{
\item{repoEndpoint=NULL}{}
\item{authEndpoint=NULL}{}
\item{fileHandleEndpoint=NULL}{}
\item{portalEndpoint=NULL}{}
\item{skip_checks=FALSE}{}
}
\details{
Sets the locations for each of the Synapse services (mostly useful for testing).

:param repoEndpoint:          Location of synapse repository
:param authEndpoint:          Location of authentication service
:param fileHandleEndpoint:    Location of file service
:param portalEndpoint:        Location of the website
:param skip_checks:           Skip version and endpoint checks

To switch between staging and production endpoints::

    syn.setEndpoints(**synapseclient.client.STAGING_ENDPOINTS)
    syn.setEndpoints(**synapseclient.client.PRODUCTION_ENDPOINTS)
}

