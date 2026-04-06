# synInviteToTeam

Invite user to a Synapse team via Synapse username or email (choose one
or the other)

## Usage

``` r
synInviteToTeam(team, user=NULL, inviteeEmail=NULL, message=NULL, force=FALSE, syn=NULL)
```

## Arguments

- team:

  A Team object or a  
  team's ID.  

- user:

  Synapse username or profile id of user  

- inviteeEmail:

  Email of user  

- message:

  Additional message for the user getting invited to the  
  team. Default to None.  

- force:

  If an open invitation exists for the invitee,  
  the old invite will be cancelled. Default to False.

- syn:

  optional named parameter: Synapse object  

## Value

MembershipInvitation or None if user is already a member
