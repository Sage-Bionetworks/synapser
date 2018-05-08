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
\item{sessionToken}{ A previously obtained session token\cr
}
\item{rememberMe}{ Whether the authentication information should be cached \cr
                                                locally for usage across sessions and clients.\cr
}
\item{silent}{     Defaults to FALSE.  Suppresses the "Welcome ...!" message.\cr
}
\item{forced}{     Defaults to FALSE.  Bypass the credential cache if set.}
}
\details{
Authenticates the user using the given credentials (in order of preference):\cr
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
synLogin('me@somewhere.com', 'secret-password', rememberMe=TRUE)
}
}



