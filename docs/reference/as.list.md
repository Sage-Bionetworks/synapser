# as.list

Gets all the values from an iterator

## Usage

``` r
as.list(iterator)
```

## Arguments

- iterator:

  The iterator whose next value is to be retrieved.

## Details

Certain functions return iterators rather than returning a list of all
values. This is because the list may be large and/or expensive to
generate in its entirety. The `as.list` function generates all the
values from the iterator and returns them as a list. It is the
responsibility of the caller to determine that the list is not too big
to fit in memory or too expensive to generate in its entirety. The
related function
[`nextElem`](https://r-docs.synapse.org/reference/nextElem.md) retrieves
just one element of the iterator at a time and therefore is safer.

## Value

A list of values returned by the iterator.

## See also

[`synGetChildren`](https://r-docs.synapse.org/reference/synGetChildren.md)
`synChunkedQuery`
[`synGetEvaluationByContentSource`](https://r-docs.synapse.org/reference/synGetEvaluationByContentSource.md)
[`synGetTeamMembers`](https://r-docs.synapse.org/reference/synGetTeamMembers.md)
[`synGetSubmissions`](https://r-docs.synapse.org/reference/synGetSubmissions.md)
[`synGetSubmissionBundles`](https://r-docs.synapse.org/reference/synGetSubmissionBundles.md)
[`synGetColumns`](https://r-docs.synapse.org/reference/synGetColumns.md)
[`synGetTableColumns`](https://r-docs.synapse.org/reference/synGetTableColumns.md)
[`nextElem`](https://r-docs.synapse.org/reference/nextElem.md)

## Examples

``` r
if (FALSE) { # \dontrun{
iterator<-synGetTeamMembers(3324324)
members<-as.list(iterator)
} # }
```
