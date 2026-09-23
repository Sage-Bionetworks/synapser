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
\item{user_id}{(str) Synapse user ID}
\item{synapse_client}{(Optional[Synapse]) If not passed in, the last created instance from the Synapse class constructor will be used.}
}
\value{
A named list representing a \href{https://rest-docs.synapse.org/rest/org/sagebionetworks/repo/model/TeamMembershipStatus.html}{TeamMembershipStatus}, with fields such as \code{user_id}, \code{is_member}, \code{can_join}, \code{has_open_invitation}, \code{has_open_request}, and \code{membership_approval_required}.
}
\examples{
\dontrun{
## Check if a user is a member of a team
    # This example shows how to check a user's membership status in a team.
    library(synapser)
    synLogin()

    # Get a team by ID
    team = Team |> synFromId(id = 123456L)

    # Check membership status for a specific user
    user_id = "3350396"  # Replace with actual user ID
    status = team |> synGetUserMembershipStatus(user_id = user_id)

    cat(sprintf("User ID: \%s\n", status$user_id))
    cat(sprintf("Is member: \%s\n", status$is_member))
    cat(sprintf("Can join: \%s\n", status$can_join))
    cat(sprintf("Has open invitation: \%s\n", status$has_open_invitation))
    cat(sprintf("Has open request: \%s\n", status$has_open_request))
    cat(sprintf("Membership approval required: \%s\n", status$membership_approval_required))
}
}
\keyword{Team}
