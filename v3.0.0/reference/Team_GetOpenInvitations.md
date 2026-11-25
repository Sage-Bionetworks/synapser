# Team : open_invitations

Gets all open invitations for a team given the ID field on the Team
instance.

## Usage

``` r
synGetOpenInvitations(instance, synapse_client=NULL)
```

## Arguments

- instance:

  (Team) The Team instance to operate on.

- synapse_client:

  (Optional\[Synapse\]) If not provided, the last created instance from
  the Synapse class constructor will be used.

## Value

List\[dict\]: A list of invitations.

## Examples

``` r
if (FALSE) { # \dontrun{
## List the open invitations for a team
    library(synapser)
    synLogin()

    team = Team() |> synGetFromId(id = 123456L)
    open_invitations = team |> synGetOpenInvitations()
} # }
```
