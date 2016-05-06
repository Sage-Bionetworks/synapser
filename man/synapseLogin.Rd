\name{synapseLogin}
\alias{synapseLogin}
\alias{synapseLogout}
\alias{invalidateAPIKey}
\title{
Authentication
}
\description{
Functions for handling Synapse authentication.
}
\usage{
synapseLogin(username, password, rememberMe=F)
synapseLogin(username = ..., apiKey = ..., rememberMe=F)
synapseLogin(sessionToken = ..., rememberMe=F)
synapseLogin(username = ..., rememberMe=F)
synapseLogin()
synapseLogout(localOnly=FALSE)
invalidateAPIKey()
}

\arguments{
  \item{username}{Synapse username, usually an email}
  \item{password}{Password associated with the username}
  \item{apiKey}{Can be found online by logging in and going to the Settings tab of your profile page at www.synapse.org}
  \item{sessionToken}{Usage not recommended}
  \item{rememberMe}{Boolean indicated whether login should store session information on the local machine.  Defaults to FALSE}
  \item{localOnly}{Boolean controlling whether logout is done locally only, or propagated to Synapse}
}
\details{
If insufficient arguments are provided to login, either cached or configuration information may be used to supplement.
The configuration file is by default located in ``~/.synapseConfig''.  

If logout is propagated to Synapse (ie. localOnly = FALSE), 
it is likely that the user will be logged out for all web clients currently in use.
To logout globally across all analytical clients, use invalidateAPIKey().
}
\examples{
\dontrun{
  # Logging into Synapse with the rememberMe flag
  synapseLogin(username, password, rememberMe=TRUE)
  
  # ... Do things ...
  # Restart the session ...
  
  # Login with remembered credentials
  synapseLogin()
}
}
\seealso{
  \code{\link{Config}}
}

\author{Matt Furia, Joseph Wu}