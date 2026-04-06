# synDelete

Removes an object from Synapse.

## Usage

``` r
synDelete(obj, version=NULL)
```

## Arguments

- obj:

  An existing object stored on Synapse  
  such as Evaluation, File, Project, or Wiki

- version:

  For entities, specify a particular version to delete.

## Examples

``` r
if (FALSE) { # \dontrun{
file<-synGet("syn12345")
synDelete(file)
} # }
```
