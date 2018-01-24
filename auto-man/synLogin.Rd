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
Authenticates the user using the given credentials (in order of preference):

- supplied synapse user name (or email) and password
- supplied email and API key (base 64 encoded)
- supplied session token
- supplied email and cached API key
- most recent cached email and API key
- email in the configuration file and cached API key
- email and API key in the configuration file
- email and password in the configuraton file
- session token in the configuration file
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
\item{sessionToken}{}
\item{rememberMe}{ Whether the authentication information should be cached locally\cr
                   for usage across sessions and clients.\cr
}
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
\examples{
% Examples of how to use the function. 
% Examples are not only useful for documentation purposes, but also provide test code used for diagnostic checking of R code. 
% By default, text will be displayed in the output of the help page and run by example() and by R CMD check. 
% You can use \dontrun{} for text that should only be shown, but not run, and \dontshow{} for extra commands 
% for testing that should not be shown to users, but will be run by example(). 
%\dontrun{
%    syn.login('me@somewhere.com', 'secret-password', rememberMe=True)
%    #> Welcome, Me!
%}
}



