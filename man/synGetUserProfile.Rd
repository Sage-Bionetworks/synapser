\name{synGetUserProfile}
\alias{synGetUserProfile}
\title{
synGetUserProfile
}
\description{
Function which retrieves a user profile.
}
\usage{
synGetUserProfile
synGetUserProfile(principalId)
}
\details{
synGetUserProfile() returns the profile of the logged in user.  synGetUserProfile(principalId) returns the profile of the
specified user.  User profiles have public and private fields.  For example, first name and last name are public fields,
while email address is private.  When retrieving ones own user profile, all fields are returned.  When retrieving
another's profile, only the public fields are returned.
}
\examples{
\dontrun{
# get my own user profile
profile<-synGetUserProfile()
propertyValue(profile, "position")<-"Imperial Vice Duke of all Engineering"
profile<-synStore(profile)
# get someone else's profile
principalId<-"123456"
profile<-synGetUserProfile(principalId)
}
}
\seealso{
\code{\link{UserProfile}}
}