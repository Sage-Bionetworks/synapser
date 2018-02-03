%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{UserProfile}
\alias{UserProfile}
\docType{methods}
\title{
Constructor for objects of type UserProfile
}
\description{
Information about a Synapse user.  In practice the constructor is not called directly by the client.
}
\usage{
UserProfile(ownerId=NULL, uri=NULL, etag=NULL, firstName=NULL, lastName=NULL, emails=NULL, userName=NULL, summary=NULL, position=NULL, location=NULL, industry=NULL, company=NULL, profilePicureFileHandleId=NULL, url=NULL, notificationSettings=NULL)
}
\arguments{
\item{ownerId}{optional named parameter:  A foreign key to the ID of the 'principal' object for the user.\cr
}
\item{uri}{optional named parameter:  The Uniform Resource Identifier (URI) for this entity.\cr
}
\item{etag}{optional named parameter:  Synapse employs an Optimistic Concurrency Control (OCC) scheme to handle concurrent updates. Since the E-Tag changes every time an entity is updated it is used to detect when a client's current representation of an entity is out-of-date.\cr
}
\item{firstName}{optional named parameter:  This person's given name (forename)\cr
}
\item{lastName}{optional named parameter:  This person's family name (surname)\cr
}
\item{emails}{optional named parameter:  The list of user email addresses registered to this user.\cr
}
\item{userName}{optional named parameter:  A name chosen by the user that uniquely identifies them.\cr
}
\item{summary}{optional named parameter:  A summary description about this person\cr
}
\item{position}{optional named parameter:  This person's current position title\cr
}
\item{location}{optional named parameter:  This person's location\cr
}
\item{industry}{optional named parameter:  "The industry/discipline that this person is associated with\cr
}
\item{company}{optional named parameter:  This person's current affiliation\cr
}
\item{profilePicureFileHandleId}{optional named parameter:  The File Handle ID of the user's profile picture.\cr
}
\item{url}{optional named parameter:  A link to more information about this person\cr
}
\item{notificationSettings}{optional named parameter:  An object of type Settings containing the user's preferences regarding when email notifications should be sent}
}
\details{
% A detailed if possible precise description of the functionality provided, extending the basic information in the \description slot.
}
\value{
An object of type UserProfile
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

}



