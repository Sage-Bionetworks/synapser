# synGetAnnotations

Retrieve annotations for an Entity from the Synapse Repository as a
named list.

Note that collapsing annotations from the native Synapse format to a
named list may involve some loss of information. See \_getRawAnnotations
to get annotations in the native format.

## Usage

``` r
synGetAnnotations(entity, version=NULL)
```

## Arguments

- entity:

  An Entity or Synapse ID to lookup  

- version:

  The version of the Entity to retrieve.

## Value

a named list whose names are annotation names and whose values are
annotation values

## Examples

``` r
if (FALSE) { # \dontrun{
file<-synGet("syn11705401")
synSetAnnotations(file, list(a="A", b="B", c=101))
synGetAnnotations(file)
} # }
```
