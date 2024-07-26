%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synCreateTeam}
\alias{synCreateTeam}
\docType{methods}
\title{
synCreateTeam
}
\description{
Creates a new team.

Arguments:
    name: The name of the team to create.
    description: A description of the team.
    icon: The FileHandleID of the icon to be used for the team.
    canPublicJoin: Whether the team can be joined by anyone. Defaults to False.
    canRequestMembership: Whether the team can request membership. Defaults to True.

Returns:
    An object of type [synapseclient.team.Team][]
}
\usage{
synCreateTeam(name, description=NULL, icon=NULL, can_public_join=FALSE, can_request_membership=TRUE)
}
\arguments{
\item{name}{}
\item{description}{}
\item{icon}{}
\item{can_public_join}{}
\item{can_request_membership}{}
}
\value{

}


