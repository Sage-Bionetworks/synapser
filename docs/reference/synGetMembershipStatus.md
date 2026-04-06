# synGetMembershipStatus

Retrieve a user's Team Membership Status bundle.
https://docs.synapse.org/rest/GET/team/id/member/principalId/membershipStatus.html

## Usage

``` r
synGetMembershipStatus(userid, team, user=NULL)
```

## Arguments

- userid:

- team:

  A Team object or a  
  team's ID.

- user:

  optional named parameter: Synapse user ID  

## Value

dict of TeamMembershipStatus

## Examples

``` r
if (FALSE) { # \dontrun{
synGetMembershipStatus(user_id, team_id)$isMember

} # }
```
