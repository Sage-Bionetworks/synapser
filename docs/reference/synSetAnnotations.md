# synSetAnnotations

Update annotations for an Entity in the Synapse Repository. This
function will replace all the existing annotations with the given
annotations.

## Usage

``` r
synSetAnnotations(entity, annotations=list(), ...)
```

## Arguments

- entity:

  The Entity or Synapse Entity ID whose annotations are to be updated  

- annotations:

  A named list of annotation names and values  

- ...:

  optional annotation name / value pairs

## Value

the updated annotations for the entity

## Examples

``` r
if (FALSE) { # \dontrun{
synSetAnnotations("syn1234567", annotations=list(foo="bar", baz=1))
} # }
```
