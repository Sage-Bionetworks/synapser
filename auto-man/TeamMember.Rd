%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{TeamMember}
\alias{TeamMember}
\docType{methods}
\title{
Constructor for objects of type TeamMember
}
\description{
Contains information about a user's membership in a Team.
In practice the constructor is not called directly by the client.

Attributes:
    teamId: The ID of the team
    member: An object of type [org.sagebionetworks.repo.model.UserGroupHeader](https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/UserGroupHeader.html)
            describing the member
    isAdmin: Whether the given member is an administrator of the team
}
\usage{
TeamMember()
}
\arguments{

}
\value{
An object of type TeamMember
}


