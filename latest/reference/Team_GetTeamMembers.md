# Team : members

Gets the TeamMembers associated with a team given the ID field on the
Team instance.

## Usage

``` r
synGetTeamMembers(instance, synapse_client=NULL)
```

## Arguments

- instance:

  (Team) The Team instance to operate on.

- synapse_client:

  (Optional\[Synapse\]) If not provided, the last created instance from
  the Synapse class constructor will be used.

## Value

List\[TeamMember\]: A List of TeamMember objects.

## Examples

``` r
if (FALSE) { # \dontrun{
## List the members of a team
    library(synapser)
    synLogin()

    team = Team() |> synGetFromId(id = 123456L)
    members = team |> synGetTeamMembers()
    for (member in members) {
        cat(sprintf("%s (admin: %s)\n", member$member$user_name, member$is_admin))
    }
} # }
```
