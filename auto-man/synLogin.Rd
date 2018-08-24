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

- email/username and password

- email/username and apiKey (Base64 encoded string)

- sessionToken (**DEPRECATED**)

If no login arguments are provided or only username is provided, login() will attempt to log in using
 information from these sources (in order of preference):

#. .synapseConfig file (in user home folder unless configured otherwise)

#. cached credentials from previous `login()` where `rememberMe=True` was passed as a parameter
}
\usage{
synLogin(email=NULL, password=NULL, apiKey=NULL, sessionToken=NULL, rememberMe=FALSE, silent=FALSE, forced=FALSE)
}
\arguments{
\item{email}{        Synapse user name (or an email address associated with a Synapse account)\cr
}
\item{password}{     password\cr
}
\item{apiKey}{       Base64 encoded Synapse API key\cr
}
\item{sessionToken}{ **!!DEPRECATED FIELD!!** User's current session token. Using this field will ignore the\cr
                     following fields: email, password, apiKey\cr
}
\item{rememberMe}{   Whether the authentication information should be cached in your operating system's\cr
                     credential storage.\cr
**GNOME Keyring** (recommended) or **KWallet** is recommended to be installed for credential storage on\cr
**Linux** systems.\cr
If it is not installed/setup, credentials will be stored as PLAIN-TEXT file with read and write permissions for\cr
the current user only (chmod 600).\cr
On Windows and Mac OS, a default credentials storage exists so it will be preferred over the plain-text file.\cr
To install GNOME Keyring on Ubuntu::}
\item{silent}{     Defaults to False.  Suppresses the "Welcome ...!" message.\cr
}
\item{forced}{     Defaults to False.  Bypass the credential cache if set.}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
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
% Examples of how to use the function. 
% Examples are not only useful for documentation purposes, but also provide test code used for diagnostic checking of R code. 
% By default, text will be displayed in the output of the help page and run by example() and by R CMD check. 
% You can use \dontrun{} for text that should only be shown, but not run, and \dontshow{} for extra commands 
% for testing that should not be shown to users, but will be run by example(). 
\examples{
%\dontrun{
%    syn.login('my-username', 'secret-password', rememberMe=True)
%    #> Welcome, Me!
%}
}



