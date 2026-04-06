# synGetChildren

Retrieves all of the entities stored within a parent such as folder or
project.

## Usage

``` r
synGetChildren(parent, includeTypes=list("folder", "file", "table", "link", "entityview", "dockerrepo"), sortBy = 'NAME', sortDirection = 'ASC')
```

## Arguments

- parent:

  An id or an object of a Synapse container or NULL to retrieve all
  projects

- includeTypes:

  Must be a list of entity types (ie. list("folder","file") which can be
  found here:  
  http://docs.synapse.org/rest/org/sagebionetworks/repo/model/EntityType.html

- sortBy:

  How results should be sorted. Can be 'NAME', or 'CREATED_ON'.

- sortDirection:

  The direction of the result sort. Can be 'ASC', or 'DESC'

## Value

An iterator that shows all the children of the container. Use
[`nextElem`](https://r-docs.synapse.org/reference/nextElem.md) or
[`as.list`](https://r-docs.synapse.org/reference/as.list.md) to access
the values.

## See also

[`nextElem`](https://r-docs.synapse.org/reference/nextElem.md)
[`as.list`](https://r-docs.synapse.org/reference/as.list.md)

## Examples

``` r
if (FALSE) { # \dontrun{
iterator <- synGetChildren("syn123456", includeTypes = list("file"), sortBy = "CREATED_ON")
} # }
```
