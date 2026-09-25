\name{synGetUserMembershipStatus}
\alias{Team_synGetUserMembershipStatus}
\docType{methods}
\title{
Team :  get_user_membership_status
}
\description{
Retrieve a user's Team Membership Status bundle for this team.
}
\usage{
synGetUserMembershipStatus(instance, user_id, synapse_client=NULL)
}
\arguments{
\item{instance}{(Team) The Team instance to operate on.}
\item{user_id}{(character) Synapse user ID}
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
TeamMembershipStatus object
}
\examples{
\dontrun{
## Check if a user is a member of a team
    # This example shows how to check a user's membership status in a team.
    library(synapser)
    synLogin()

    team = Team() |> synFromId(id = 123456L)

    # Check membership status for a specific user
    user_id = "3350396"  # Replace with actual user ID
    status = team |> synGetUserMembershipStatus(user_id = user_id)

    cat("User ID:", status$user_id, "\n")
    cat("Is member:", status$is_member, "\n")
    cat("Can join:", status$can_join, "\n")
    cat("Has open invitation:", status$has_open_invitation, "\n")
    cat("Has open request:", status$has_open_request, "\n")
    cat("Membership approval required:", status$membership_approval_required, "\n")
}
}
\keyword{Team}
