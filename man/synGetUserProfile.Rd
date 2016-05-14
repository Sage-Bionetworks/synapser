\name{synGetUserProfile}
\alias{synGetUserProfile}
\docType{methods}
\title{
synGetUserProfile
}
\description{}
\usage{
	synGetUserProfile(...)
}
\arguments{
\item{...}{Extra parameters, passed by argument name.}
}
\details{
Get the details about a Synapse user.
Retrieves information on the current user if 'id' is omitted.

:param id:           The 'userId' (aka 'ownerId') of a user or the userName
:param sessionToken: The session token to use to find the user profile
:param refresh:  If set to True will always fetch the data from Synape otherwise
                 will used cached information

:returns: JSON-object

Example::

    my_profile = syn.getUserProfile()

    freds_profile = syn.getUserProfile('fredcommo')
}

