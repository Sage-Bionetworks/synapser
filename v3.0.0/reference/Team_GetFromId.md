# Team : from_id

Gets Team object using its integer id.

## Usage

``` r
synGetFromId(cls, id, synapse_client=NULL)
```

## Arguments

- cls:

  (Team) The Team class (or an existing Team instance) to dispatch this
  call to.

- id:

  (integer) The id of the team.

- synapse_client:

  (Optional\[Synapse\]) If not provided, the last created instance from
  the Synapse class constructor will be used.

## Value

Team: The Team object.

## Examples

``` r
if (FALSE) { # \dontrun{
## Get a team by its ID
    library(synapser)
    synLogin()

    team = Team() |> synGetFromId(id = 123456L)
} # }
```
