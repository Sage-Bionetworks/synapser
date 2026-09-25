\name{synInviteToTeam}
\alias{Team_synInviteToTeam}
\docType{methods}
\title{
Team :  invite
}
\description{
Invites a user to a team given the ID field on the Team instance.
}
\usage{
synInviteToTeam(instance, user, message, force=TRUE, synapse_client=NULL)
}
\arguments{
\item{instance}{(Team) The Team instance to operate on.}
\item{user}{The username or ID of the user to invite.}
\item{message}{(character) The message to send.}
\item{force}{(logical) If TRUE, will send the invite even if the user is already a member or has an open invitation. If FALSE, will not send the invite if the user is already a member or has an open invitation. Defaults to TRUE.}
\item{synapse_client}{(Optional[Synapse]) If not provided, the last created instance from the Synapse class constructor will be used.}
}
\value{
The invite response or NULL if an invite was not sent.
}
\examples{
\dontrun{
## Invite a user to a team
    library(synapser)
    synLogin()

    team = Team() |> synFromId(id = 123456L)
    team |> synInviteToTeam(user = "my_username", message = "Please join my team!")
}
}
\keyword{Team}
