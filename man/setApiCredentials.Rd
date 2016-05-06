\name{setApiCredentials}
\alias{setApiCredentials}
\title{
setApiCredentials
}
\description{
Sets the user name and secret key used to sign authenticated web requests to Synapse.
}
\usage{
setApiCredentials(username, secretKey)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{username}{
The user's name, i.e. email address
}
  \item{secretKey}{
The secret key, retrieved from a previously authenticated session using hmacSecretKey().
}
}
\details{
Setting the user name and secret key provide an alternative to logging in with a password.
This authentication method does not use an expiring token (rather each request has a time-limited 
digital signature based on the non-expiring secret key) and is therefore useful for long running jobs.
}
\author{
Bruce Hoff
}

\seealso{
\code{\link{synapseLogin}}
\code{\link{hmacSecretKey}}
}
\examples{
\dontrun{
	synapseLogin("user.name@sagebase.org", "foo", mode="hmac")
	key <- hmacSecretKey()
	synapseLogout()
	setApiCredentials("user.name@sagebase.org", key)
	# you may now make authenticated requests to Synapse
}
}

