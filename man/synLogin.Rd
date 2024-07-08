\name{synLogin}
\alias{synLogin}
\docType{methods}
\title{
synLogin
}
\description{
Logs the user in.

If no login arguments are provided or only username is provided, login() will attempt to log in using
 information from these sources (in order of preference):
\enumerate{
\item synapseConfig file (in user home folder unless configured otherwise)\cr
\item User defined arguments during a CLI session\cr
\item User's Personal Access Token (aka: Synapse Auth Token) from the environment variable: SYNAPSE_AUTH_TOKEN\cr
\item Retrieves user's authentication token from AWS SSM Parameter store (if configured)\cr
}
}
\usage{
synLogin(email=NULL, silent=FALSE, authToken=NULL, cache_client=TRUE)
}
\arguments{
\item{email}{      Synapse user name (or an email address associated with a Synapse account). Defaults to NULL.\cr
}
\item{silent}{    Suppresses the "Welcome ...!" message. Defaults to FALSE.  \cr
}
\item{authToken}{  A bearer authorization token, e.g. a personal access token, can be used in lieu of a\cr
                        password or apiKey}
\item{cache_client}{Whether to cache the Synapse client object in the Synapse module. Defaults to TRUE. When set to TRUE anywhere a Synapse object is optional you do not need to pass an instance of Synapse to that function, method, or class.}
\item{rememberMe}{ Whether the authentication information should be cached in your operating system's credential storage.\cr
**GNOME Keyring** (recommended) or **KWallet** is recommonded to be installed for credential storage on **Linux** systems.\cr
If it is not installed/setup, credentials will be stored as PLAIN-TEXT file with read and write permissions for the current user only (chmod 600).\cr
On Windows and Mac OS, a default credentials storage exists so it will be preferred over the plain-text file.\cr
}
\item{password}{   \bold{DEPRECATED}. password. Please use authToken (Synapse personal access token)\cr
}
\item{apiKey}{     \bold{DEPRECATED}. Base64 encoded Synapse API key\cr
}
\item{sessionToken}{ \bold{DEPRECATED}. User's current session token. Using this field will ignore the following fields: email, password, apiKey\cr
}
\item{forced}{     \bold{DEPRECATED}. Defaults to FALSE. Bypass the credential cache if set.}


}
%
% Verified that the following works on 2024June28.
%
\examples{
\dontrun{

# with a token, e.g. an access obtained from your Synapse profile
synLogin(authToken=token)

}
}



