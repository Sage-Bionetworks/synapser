# Team : from_name

Gets Team object using its string name.

**Note:** You will be unable to retrieve a team by name immediately
after its creation because the fragment service is eventually
consistent. If you need to retrieve a team immediately following
creation you should use the
[`synGetFromId()`](https://r-docs.synapse.org/v3.0.0/reference/Team_GetFromId.md)
function instead.

## Usage

``` r
synGetFromName(cls, name, synapse_client=NULL)
```

## Arguments

- cls:

  (Team) The Team class (or an existing Team instance) to dispatch this
  call to.

- name:

  (character) The name of the team.

- synapse_client:

  (Optional\[Synapse\]) If not provided, the last created instance from
  the Synapse class constructor will be used.

## Value

Team: The Team object.

## Examples

``` r
if (FALSE) { # \dontrun{
## Get a team by its name
    library(synapser)
    synLogin()

    team = Team() |> synGetFromName(name = "My Uniquely Named Team")
} # }
```
