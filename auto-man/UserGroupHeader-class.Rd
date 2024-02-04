%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{UserGroupHeader-class}
\alias{UserGroupHeader-class}
\docType{class}
\title{
UserGroupHeader
}
\format{An R6 class object.}
\description{
Select metadata about a Synapse principal.
In practice the constructor is not called directly by the client.

Attributes:
    ownerId A foreign key to the ID of the 'principal' object for the user.
    firstName: First Name
    lastName: Last Name
    userName: A name chosen by the user that uniquely identifies them.
    email: User's current email address
    isIndividual: True if this is a user, false if it is a group
}
\section{Methods}{
\itemize{
\item \code{UserGroupHeader()}: Constructor for \code{\link{UserGroupHeader}}
}
}

