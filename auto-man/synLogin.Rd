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

If no login arguments are provided or only username is provided, login() will attempt to log in using
 information from these sources (in order of preference):

1. User defined arguments during a CLI session
2. User's Personal Access Token (aka: Synapse Auth Token)
    from the environment variable: SYNAPSE_AUTH_TOKEN
3. .synapseConfig file (in user home folder unless configured otherwise)
4. Retrieves user's authentication token from AWS SSM Parameter store (if configured)

Arguments:
    email:        Synapse user name (or an email address associated with a Synapse account)
    authToken:    A bearer authorization token, e.g. a
        [personal access token](https://python-docs.synapse.org/tutorials/authentication/).
    silent:       Defaults to False.  Suppresses the "Welcome ...!" message.
}
\usage{
synLogin(email=NULL, silent=FALSE, authToken=NULL)
}
\arguments{
\item{email}{}
\item{silent}{}
\item{authToken}{}
}
\value{

}


