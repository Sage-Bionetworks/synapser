%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetUserMembershipStatus}
\alias{synGetUserMembershipStatus}
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
\item{synapse_client}{(Optional[Synapse]) If not passed in and caching was not disabled by \code{Synapse.allow_client_caching(False)} this will use the last created instance from the Synapse class constructor.}
}
\value{
TeamMembershipStatus object
}
\examples{
\dontrun{
## Check if a user is a member of a team
# This example shows how to check a user's membership status in a team.

import asyncio
from synapseclient import Synapse
from synapseclient.models import Team

syn = Synapse()
syn.login()

async def check_membership():
    # Get a team by ID
    team = await Team.from_id_async(123456)

    # Check membership status for a specific user
    user_id = "3350396"  # Replace with actual user ID
    status = await team.get_user_membership_status_async(user_id)

    print(f"User ID: {status.user_id}")
    print(f"Is member: {status.is_member}")
    print(f"Can join: {status.can_join}")
    print(f"Has open invitation: {status.has_open_invitation}")
    print(f"Has open request: {status.has_open_request}")
    print(f"Membership approval required: {status.membership_approval_required}")

asyncio.run(check_membership())
}
}
\keyword{Team}
