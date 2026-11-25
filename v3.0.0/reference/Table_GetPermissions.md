# Table : get_permissions

Get the
[permissions](https://python-docs.synapse.org/reference/permissions/)
that the caller has on an Entity.

## Usage

``` r
synGetPermissions(instance, synapse_client=NULL)
```

## Arguments

- instance:

  (Table) The Table instance to operate on.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

A Permissions object

## Examples

``` r
if (FALSE) { # \dontrun{
## Using this function:
    # Getting permissions for a Synapse Entity
    library(synapser)
    synLogin()

    permissions = Table(id = "syn123") |> synGetPermissions()

    # Getting access types list from the Permissions object
    permissions$access_types
} # }
```
