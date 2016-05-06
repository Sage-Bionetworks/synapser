\name{UserProfile}
\alias{UserProfile}
\docType{methods}
\title{
Constructor for UserProfile
}
\description{
Constructor for UserProfile
}
\usage{UserProfile()}
\details{
This constructor is not called directly, rather an instance is returned by synGetUserProfile(principalId).
}
\examples{
\dontrun{
# get my own user profile
profile<-synGetUserProfile()
# get someone else's profile
principalId<-"123456"
profile<-synGetUserProfile(principalId)
}
}
\seealso{
\code{\link{synGetUserProfile}}
}
