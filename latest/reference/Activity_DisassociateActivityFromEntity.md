# Activity : disassociate_from_entity

Disassociate the Activity from the parent entity. This is the first step
in deleting the Activity. If you have other entities that are associated
with this Activity you must disassociate them by calling this method on
them as well.

## Usage

``` r
synDisassociateActivityFromEntity(cls, parent, synapse_client=NULL)
```

## Arguments

- cls:

  (Activity) The Activity class (or an existing Activity instance) to
  dispatch this call to.

- parent:

  (Union\[Table, File, str\]) The parent entity this activity is
  associated with.

- synapse_client:

  (Optional\[Synapse\]) If not passed in, the last created instance from
  the Synapse class constructor will be used.

## Value

NULL

## Errors

An error is raised if the parent does not have an ID.

## Examples

``` r
if (FALSE) { # \dontrun{
## Using this function
    # Remove the Activity from the entity it is associated with. The Activity
    # itself is deleted once it is no longer associated with any entity.
    library(synapser)
    synLogin()

    Activity() |> synDisassociateActivityFromEntity(parent = "syn123")
} # }
```
