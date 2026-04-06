# synGetProvenance

Retrieve provenance information for a Synapse Entity.

## Usage

``` r
synGetProvenance(entity, version=NULL)
```

## Arguments

- entity:

  An Entity or Synapse ID to lookup  

- version:

  The version of the Entity to retrieve.  
  Gets the most recent version if omitted

## Value

An Activity object or raises exception if no provenance record exists

## Examples

``` r
if (FALSE) { # \dontrun{
activity<-synGetProvenance("syn11678572")
} # }
```
