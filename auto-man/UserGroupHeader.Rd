%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
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
\item{isIndividual}{optional named parameter:  True if this is a user, false if it is a group}
}
\value{
An object of type UserGroupHeader
}


