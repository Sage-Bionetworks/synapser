# synSetProvenance

Stores a record of the code and data used to derive a Synapse entity.

## Usage

``` r
synSetProvenance(entity, activity)
```

## Arguments

- entity:

  An Entity or Synapse ID to modify  

- activity:

  an Activity

## Value

An updated Activity object

## See also

[`Activity`](https://r-docs.synapse.org/reference/Activity.md)

## Examples

``` r
if (FALSE) { # \dontrun{
act <- Activity(name='clustering', description='whizzy clustering')
act$used(c('syn12345', 'syn12346'))
file<-synGet("syn1234567")
synSetProvenance(file, act)
} # }
```
