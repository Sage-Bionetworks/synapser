\name{synLogin}
\alias{synLogin}
\docType{methods}
\title{
synLogin
}
\description{
Logs the user in.
}
\usage{
synLogin(email=NULL, password=NULL, apiKey=NULL, sessionToken=NULL, rememberMe=FALSE, silent=FALSE, forced=FALSE)
}
\arguments{
\item{email}{      Synapse user name (or an email address associated with a Synapse account)\cr
}
\item{password}{   password\cr
}
\item{apiKey}{     Base64 encoded Synapse API key\cr
}
\item{sessionToken}{ **!!DEPRECATED FIELD!!** User's current session token. Using this field will ignore the following fields: email, password, apiKey\cr
}
\item{rememberMe}{ Whether the authentication information should be cached in your operating system's credential storage.\cr
**GNOME Keyring** (recommended) or **KWallet** is recommonded to be installed for credential storage on **Linux** systems.\cr
If it is not installed/setup, credentials will be stored as PLAIN-TEXT file with read and write permissions for the current user only (chmod 600).\cr
On Windows and Mac OS, a default credentials storage exists so it will be preferred over the plain-text file.\cr
}
\item{silent}{     Defaults to FALSE.  Suppresses the "Welcome ...!" message.\cr
}
\item{forced}{     Defaults to FALSE.  Bypass the credential cache if set.}

\item{authToken}{  A bearer authorization token, e.g. a personal access token, can be used in lieu of a\cr
                        password or apiKey}
}
\details{
Valid combinations of login() arguments:\cr
\cr
- email/username and password\cr
- email/username and apiKey (Base64 encoded string)\cr
- sessionToken (**DEPRECATED**)\cr
If no login arguments are provided or only username is provided, login() will attempt to log in using information from these sources (in order of preference):\cr
- .synapseConfig file (in user home folder unless configured otherwise)\cr
- cached credentials from previous `login()` where `rememberMe=True` was passed as a parameter\cr
}
\value{

}
\references{
% A section with references to the literature. Use \url{} or \href{}{} for web pointers.
}
\note{
% Use this for a special note you want to have pointed out. 
}
\seealso{
% Pointers to related R objects, using \code{\link{...}} to refer to them.
}
\examples{ 
\dontrun{

# with username/pass
synLogin('myUsername', 'secretPassword')

# with a token, e.g. an access obtained from your Synapse profile
synLogin(authToken=token)

}
}



