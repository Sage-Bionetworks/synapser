# Team : invite

Invites a user to a team given the ID field on the Team instance.

## Usage

``` r
synInviteToTeam(instance, user, message, force=TRUE, synapse_client=NULL)
```

## Arguments

- instance:

  (Team) The Team instance to operate on.

- user:

  The username or ID of the user to invite.

- message:

  (character) The message to send.

- force:

  (logical) If TRUE, will send the invite even if the user is already a
  member or has an open invitation. If FALSE, will not send the invite
  if the user is already a member or has an open invitation. Defaults to
  TRUE.

- synapse_client:

  (Optional\[Synapse\]) If not provided, the last created instance from
  the Synapse class constructor will be used.

## Value

The invite response or NULL if an invite was not sent.

## Examples

``` r
if (FALSE) { # \dontrun{
## Invite a user to a team
    library(synapser)
    synLogin()

    team = Team() |> synGetFromId(id = 123456L)
    team |> synInviteToTeam(user = "my_username", message = "Please join my team!")
} # }
```
