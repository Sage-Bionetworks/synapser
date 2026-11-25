# Team : create

Creates a new team on Synapse.

## Usage

``` r
synCreate(instance, synapse_client=NULL)
```

## Arguments

- instance:

  (Team) The Team instance to operate on.

- synapse_client:

  (Optional\[Synapse\]) If not provided, the last created instance from
  the Synapse class constructor will be used.

## Value

Team: The Team object.

## Examples

``` r
if (FALSE) { # \dontrun{
## Create a new team
    library(synapser)
    synLogin()

    team = Team(
        name = "My Uniquely Named Team",
        description = "A team for my project collaborators",
        can_public_join = FALSE
    ) |> synCreate()
} # }
```
