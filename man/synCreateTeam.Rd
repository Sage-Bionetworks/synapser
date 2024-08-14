\name{synCreateTeam}
\alias{synCreateTeam}
\docType{methods}
\title{
synCreateTeam
}
\description{
Creates a new team
}
\usage{
synCreateTeam(name, description=NULL, icon=NULL, can_public_join=FALSE, can_request_membership=TRUE)
}
\arguments{
\item{name}{The name of the team to create.}
\item{description}{A description of the team.}
\item{icon}{The FileHandleID of the icon to be used for the team.}
\item{can_public_join}{Whether the team can be joined by anyone. Defaults to FALSE.}
\item{can_request_membership}{Whether the team can request membership. Defaults to TRUE.}
}
\value{
An Team object
}
%
% Verified that the following works on 2024July1.
%
\examples{
\dontrun{
synCreateTeam('your_team_name')
}
}
