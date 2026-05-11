\name{synLogin}
\alias{synLogin}
\docType{methods}
\title{
synLogin
}
\description{
Valid combinations of login() arguments:

- authToken
- Profile-based authentication (from .synapseConfig)


If no login arguments are provided or only username is provided, login() will attempt to log in using
 information from these sources (in order of preference):

1. .synapseConfig file (supports multiple profiles)(in user home folder unless configured otherwise)
2. User defined arguments during a CLI session
3. User's Personal Access Token (aka: Synapse Auth Token)
    from the environment variable: SYNAPSE_AUTH_TOKEN
4. Retrieves user's authentication token from AWS SSM Parameter store (if configured)

}
\usage{
synLogin(email=NULL, silent=FALSE, authToken=NULL)
}
\arguments{
\item{email}{optional named parameter: Synapse user name (or an email address associated with a Synapse account)}
\item{silent}{optional named parameter: Suppresses the "Welcome ...!" message (default: FALSE)}
\item{authToken}{optional named parameter: A bearer authorization token, e.g. a personal access token}
\item{profile}{optional named parameter: Profile to use from .synapseConfig (default: "default")}
}
\value{

}


