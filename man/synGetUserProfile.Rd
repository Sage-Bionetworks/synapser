\name{synGetUserProfile}
\alias{synGetUserProfile}
\docType{methods}
\title{
synGetUserProfile
}
\description{
Get the details about a Synapse user.
Retrieves information on the current user if 'id' is omitted.
}
\usage{
synGetUserProfile(id=NULL, sessionToken=NULL, refresh=NULL)
}
\arguments{
\item{id}{optional named parameter:            The 'userId' (aka 'ownerId') of a user or the userName\cr
}
\item{sessionToken}{optional named parameter:  The session token to use to find the user profile\cr
}
\item{refresh}{optional named parameter:   If set to TRUE will always fetch the data from Synape otherwise\cr
                 will use cached information}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
 The user profile for the user of interest.
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
}



