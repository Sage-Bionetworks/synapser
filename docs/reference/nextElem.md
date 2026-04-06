# nextElem

Gets the next value from an iterator.

## Usage

``` r
nextElem(iterator)
```

## Arguments

- iterator:

  The iterator whose next value is to be retrieved.

## Details

Certain functions return iterators rather than returning a list of all
values. This is because the list may be large and/or expensive to
generate in its entirety, while generating just the next value is not
expensive. The `nextElem` function returns just the next value or raises
an exception if there are no more values to return. The related function
[`as.list`](https://r-docs.synapse.org/reference/as.list.md) will
retrieve all the values from the iterator and return them as a list.

## Value

The next value from the iterator or an exception if there are no more
values.

## See also

[`synGetChildren`](https://r-docs.synapse.org/reference/synGetChildren.md)
`synChunkedQuery`
[`synGetEvaluationByContentSource`](https://r-docs.synapse.org/reference/synGetEvaluationByContentSource.md)
[`synGetTeamMembers`](https://r-docs.synapse.org/reference/synGetTeamMembers.md)
[`synGetSubmissions`](https://r-docs.synapse.org/reference/synGetSubmissions.md)
[`synGetSubmissionBundles`](https://r-docs.synapse.org/reference/synGetSubmissionBundles.md)
[`synGetColumns`](https://r-docs.synapse.org/reference/synGetColumns.md)
[`synGetTableColumns`](https://r-docs.synapse.org/reference/synGetTableColumns.md)
[`as.list`](https://r-docs.synapse.org/reference/as.list.md)

## Examples

``` r
if (FALSE) { # \dontrun{
iterator<-synGetTeamMembers(3324324)
more<-TRUE
while (more) {
  tryCatch(
    {
      member<-nextElem(iterator)
        print(member)
    },
      error=function(e) {
        print("No more members.")
        more<<-FALSE
    }
  )
}
} # }
```
