\name{synLogin}
\alias{synLogin}
\docType{methods}
\title{
synLogin
}
\description{
Valid combinations of synLogin() arguments:

- authToken\cr
- Profile-based authentication (from .synapseConfig)

If no login arguments are provided or only username is provided, synLogin() will attempt to log in using
 information from these sources (in order of preference):

1. .synapseConfig file (supports multiple profiles)(in user home folder unless configured otherwise)\cr
2. User defined arguments during a CLI session\cr
3. User's Personal Access Token (aka: Synapse Auth Token)
    from the environment variable: SYNAPSE_AUTH_TOKEN\cr
4. Retrieves user's authentication token from AWS SSM Parameter store (if configured)
}
\usage{
synLogin(email=NULL, silent=FALSE, authToken=NULL, profile="default")
}
\arguments{
\item{email}{(str) Synapse user name (or an email address associated with a Synapse account)}
\item{silent}{(bool) Defaults to FALSE. Suppresses the "Welcome ...!" message.}
\item{authToken}{(str) A bearer authorization token, e.g. a \href{https://python-docs.synapse.org/tutorials/authentication/}{personal access token}.}
\item{profile}{(str) Profile to use from .synapseConfig (default: "default").}
}
\value{
NULL
}
\examples{
\dontrun{
## Logging in
    library(synapser)

    # Logging in using a specific profile:
    synLogin(profile = "user1")
    # Prints: Welcome, username! You are using the user1 profile

    # Logging in with an authentication token:
    synLogin(authToken = "your_auth_token")
    # Prints: Welcome, username!
}
}
