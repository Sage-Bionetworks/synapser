# synSendMembershipInvitation

Create a membership invitation and send an email notification to the
invitee.

## Usage

``` r
synSendMembershipInvitation(teamId, inviteeId=NULL, inviteeEmail=NULL, message=NULL)
```

## Arguments

- teamId:

  Synapse teamId  

- inviteeId:

  Synapse username or profile id of user  

- inviteeEmail:

  Email of user  

- message:

  Additional message for the user getting invited to the  
  team. Default to None.

## Value

MembershipInvitation

## Examples

``` r
if (FALSE) { # \dontrun{
synSendMembershipInviation(teamId, inviteeEmail='john.doe@example.com', message='You should join this Synapse team!')

} # }
```
