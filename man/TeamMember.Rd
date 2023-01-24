\name{TeamMember}
\alias{TeamMember}
\docType{methods}
\title{
Constructor for objects of type TeamMember
}
\description{
Contains information about a user's membership in a Team.  In practice the constructor is not called directly by the client.
}
\usage{
TeamMember(teamId=NULL, member=NULL, isAdmin=NULL)
}
\arguments{
\item{teamId}{optional named parameter:   the ID of the team\cr
}
\item{member}{optional named parameter:  An object of type UserGroupHeader describing the member\cr
}
\item{isAdmin}{optional named parameter:  Whether the given member is an administrator of the team}
}
\value{
An object of type TeamMember
}




