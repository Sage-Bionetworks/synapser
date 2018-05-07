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
- supplied synapse user name (or email) and password\cr
- supplied email and API key (base 64 encoded)\cr
- supplied session token\cr
- supplied email and cached API key\cr
- most recent cached email and API key\cr
- email in the configuration file and cached API key\cr
- email and API key in the configuration file\cr
- email and password in the configuraton file\cr
- session token in the configuration file}
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



