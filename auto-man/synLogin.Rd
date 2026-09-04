%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
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
synLogin(email=NULL, silent=FALSE, authToken=NULL, profile="default")
}
\arguments{
\item{email}{(str) Synapse user name (or an email address associated with a Synapse account)}
\item{silent}{(bool) Defaults to False.  Suppresses the "Welcome ...!" message.}
\item{authToken}{(str) A bearer authorization token, e.g. a \href{https://python-docs.synapse.org/tutorials/authentication/}{personal access token}.}
\item{profile}{(str) Profile to use from .synapseConfig (default: "default").}
}
\value{
NULL
}
\examples{
\dontrun{
## Logging in
- Logging in using a specific profile:
        import synapseclient
        syn = synapseclient.login(profile="user1)
        > Welcome, username! You are using the user1 profile

- Logging in with an authentication token:
    import synapseclient
    syn = synapseclient.login(authToken = "your_auth_token"))
    > Welcome, username!
}
}
\keyword{}
