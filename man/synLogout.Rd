\name{synLogout}
\alias{synLogout}
\docType{methods}
\title{
synLogout
}
\description{
Removes authentication information from the Synapse client.
}
\usage{
synLogout(forgetMe=FALSE)
}
\arguments{
\item{forgetMe}{ Set as TRUE to clear any local storage of authentication information.\cr
                 See the flag "rememberMe" in synLogin.}
}
\examples{
\dontrun{
synLogout()
}
}


