\name{UserGroupHeader}
\alias{UserGroupHeader}
\docType{methods}
\title{
Constructor for objects of type UserGroupHeader
}
\description{
Select metadata about a Synapse principal.  In practice the constructor is not called directly by the client.
}
\usage{
UserGroupHeader(ownerId=NULL, firstName=NULL, lastName=NULL, userName=NULL, email=NULL, isIndividual=NULL)
}
\arguments{
\item{ownerId}{optional named parameter:  A foreign key to the ID of the 'principal' object for the user.\cr
}
\item{firstName}{optional named parameter:  First Name\cr
}
\item{lastName}{optional named parameter:  Last Name\cr
}
\item{userName}{optional named parameter:  A name chosen by the user that uniquely identifies them.\cr
}
\item{email}{optional named parameter:    User's current email address\cr
}
\item{isIndividual}{optional named parameter:  TRUE if this is a user, false if it is a group}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
An object of type UserGroupHeader
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
%
%}
}



